pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with StadtDatentypen; use StadtDatentypen;
with EinheitenDatentypen; use EinheitenDatentypen;
with EinheitenKonstanten;
with StadtKonstanten;

with SchreibeEinheitenGebaut;
with LeseWeltkarte;
with LeseEinheitenGebaut;
with LeseEinheitenDatenbank;

with SichtbarkeitsberechnungssystemLogik;
with KennenlernenLogik;
with LadungsbewegungLogik;
with StadtSuchenLogik;
with PassierbarkeitspruefungLogik;
with BewegungspunkteBerechnenLogik;

package body BewegungsberechnungEinheitenLogik is

   procedure Bewegungsberechnung
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      NeueKoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      EinheitentauschExtern : in Boolean)
   is begin
      
      LadungVerschieben := False;

      -- Immer berücksichtigen dass in EinheitenbewegungLogik.BewegungPrüfen bereits geprüft wird ob der Transporter die Einheit transportieren kann und ein freier Platz vorhanden ist.
      if
        EinheitenKonstanten.LeerKannTransportieren = LeseEinheitenDatenbank.KannTransportieren (RasseExtern => EinheitRasseNummerExtern.Rasse,
                                                                                                IDExtern    => LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => EinheitRasseNummerExtern))
      then
         null;
         
      elsif
        StadtKonstanten.LeerNummer = StadtSuchenLogik.KoordinatenStadtMitRasseSuchen (RasseExtern       => EinheitRasseNummerExtern.Rasse,
                                                                                      KoordinatenExtern => NeueKoordinatenExtern)
      then
         -- Die Ladungsverschiebung muss mit dem neuen Karten/Einheitenkoordinatensystem immer am Schluss erfolgen.
         -- Theoretisch hätte das auch immer im alten System passieren müssen, um zu verhindern dass die Ladung verschoben wird ohne dass das Schiff verschoben werden kann.
         -- Kam nur nie zu einem Problem weil es keinen Bewegungsabzug für Schiffe gab.
         LadungVerschieben := True;

      else
         case
           PassierbarkeitspruefungLogik.InStadtEntladbar (TransporterExtern     => EinheitRasseNummerExtern,
                                                          NeueKoordinatenExtern => NeueKoordinatenExtern)
         is
            when False =>
               return;
               
            when True =>
               -- Das hier am Ende von InStadtEntladbar aufrufen? äöü
               LadungsbewegungLogik.TransporterStadtEntladen (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                              NeueKoordinatenExtern    => NeueKoordinatenExtern);
         end case;
      end if;

      BewegungspunkteAbzug := BewegungspunkteBerechnenLogik.AbzugDurchBewegung (NeueKoordinatenExtern    => NeueKoordinatenExtern,
                                                                                EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      
      if
        BewegungspunkteAbzug = EinheitenKonstanten.EinheitUnbewegbar
      then
         SchreibeEinheitenGebaut.Bewegungspunkte (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                  BewegungspunkteExtern    => EinheitenKonstanten.LeerBewegungspunkte,
                                                  RechnenSetzenExtern      => 0);
         return;
         
      else
         SchreibeEinheitenGebaut.Bewegungspunkte (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                  BewegungspunkteExtern    => BewegungspunkteAbzug,
                                                  RechnenSetzenExtern      => -1);
      end if;

      case
        LeseEinheitenGebaut.WirdTransportiert (EinheitRasseNummerExtern => EinheitRasseNummerExtern)
      is
         when EinheitenKonstanten.LeerWirdTransportiert =>
            null;
            
         when others =>
            LadungsbewegungLogik.EinheitAusTransporterEntfernen (TransporterExtern => (EinheitRasseNummerExtern.Rasse, LeseEinheitenGebaut.WirdTransportiert (EinheitRasseNummerExtern => EinheitRasseNummerExtern)),
                                                                 LadungExtern      => EinheitRasseNummerExtern.Nummer);
      end case;
      
      case
        SpielVariablen.Rassenbelegung (EinheitRasseNummerExtern.Rasse).Belegung
      is
         when RassenDatentypen.KI_Spieler_Enum =>
            null;
            
         when others =>
            SpielVariablen.CursorImSpiel (EinheitRasseNummerExtern.Rasse).KoordinatenAktuell := NeueKoordinatenExtern;
      end case;
      
      SchreibeEinheitenGebaut.Koordinaten (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                           KoordinatenExtern        => NeueKoordinatenExtern,
                                           EinheitentauschExtern    => EinheitentauschExtern);
      
      case
        LadungVerschieben
      is
         when True =>
            LadungsbewegungLogik.TransporterladungVerschieben (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                               NeueKoordinatenExtern    => NeueKoordinatenExtern);
            
         when False =>
            null;
      end case;
      
      NachBewegung (NeueKoordinatenExtern    => NeueKoordinatenExtern,
                    EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      
   end Bewegungsberechnung;
   
   
   
   procedure NachBewegung
     (NeueKoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
   is begin
      
      SichtbarkeitsberechnungssystemLogik.SichtbarkeitsprüfungFürEinheit (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      
      -- Prüft ob die Einheit jetzt auf einem Feld steht welches von einer fremden Rasse bereits aufgedeckt wurde und stellt entsprechend Kontakt her.
      -- Anders als die Berechnung in SichtbarkeitLogik, wo geprüft wird ob eine fremde Stadt oder Einheit auf einem neu aufgedecktem Feld steht.
      KontaktSchleife:
      for FremdeSichtbarkeitSchleifenwert in SpielVariablen.RassenbelegungArray'Range loop
         
         if
           FremdeSichtbarkeitSchleifenwert = EinheitRasseNummerExtern.Rasse
           or
             SpielVariablen.Rassenbelegung (FremdeSichtbarkeitSchleifenwert).Belegung = RassenDatentypen.Leer_Spieler_Enum
         then
            null;
            
         elsif
           True = LeseWeltkarte.Sichtbar (KoordinatenExtern => NeueKoordinatenExtern,
                                          RasseExtern       => FremdeSichtbarkeitSchleifenwert)
         then
            KennenlernenLogik.Erstkontakt (EigeneRasseExtern => EinheitRasseNummerExtern.Rasse,
                                           FremdeRasseExtern => FremdeSichtbarkeitSchleifenwert);
            
         else
            null;
         end if;
         
      end loop KontaktSchleife;
      
   end NachBewegung;

end BewegungsberechnungEinheitenLogik;
