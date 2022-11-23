with SchreibeEinheitenGebaut;
with LeseWeltkarte;
with LeseEinheitenGebaut;
with SchreibeCursor;

with SichtbarkeitsberechnungssystemLogik;
with KennenlernenLogik;
with TransporterLadungsverschiebungLogik;
with BewegungspunkteBerechnenLogik;
with TransporterBeladenEntladenLogik;

package body BewegungsberechnungEinheitenLogik is

   procedure Bewegungsberechnung
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      NeueKoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      EinheitentauschExtern : in Boolean)
   is
      use type EinheitenDatentypen.Bewegungspunkte;
   begin
      
      BewegungspunkteAbzug := BewegungspunkteBerechnenLogik.Bewegungspunkte (NeueKoordinatenExtern    => NeueKoordinatenExtern,
                                                                             EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      
      -- Hier noch eine Erschöpfung einbauen? äöü
      if
        BewegungspunkteAbzug = EinheitenKonstanten.LeerBewegungspunkte
      then
         SchreibeEinheitenGebaut.Bewegungspunkte (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                  BewegungspunkteExtern    => EinheitenKonstanten.LeerBewegungspunkte,
                                                  RechnenSetzenExtern      => False);
         return;
         
      else
         SchreibeEinheitenGebaut.Bewegungspunkte (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                  BewegungspunkteExtern    => -BewegungspunkteAbzug,
                                                  RechnenSetzenExtern      => True);
         
         IstLadung := LeseEinheitenGebaut.WirdTransportiert (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      end if;
      
      case
        LeseRassenbelegung.Belegung (RasseExtern => EinheitRasseNummerExtern.Rasse)
      is
         when RassenDatentypen.Mensch_Spieler_Enum =>
            SchreibeCursor.EAchseAktuell (RasseExtern  => EinheitRasseNummerExtern.Rasse,
                                          EAchseExtern => NeueKoordinatenExtern.EAchse);
            
         when others =>
            null;
      end case;

      case
        IstLadung
      is
         when EinheitenKonstanten.LeerWirdTransportiert =>
            null;
            
         when others =>
            TransporterBeladenEntladenLogik.EinheitAusladen (TransporterExtern => (EinheitRasseNummerExtern.Rasse, IstLadung),
                                                             LadungExtern      => EinheitRasseNummerExtern.Nummer);
      end case;
      
      SchreibeEinheitenGebaut.Koordinaten (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                           KoordinatenExtern        => NeueKoordinatenExtern,
                                           EinheitentauschExtern    => EinheitentauschExtern);
      
      TransporterLadungsverschiebungLogik.LadungVerschieben (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                             NeueKoordinatenExtern    => NeueKoordinatenExtern);
      
      NachBewegung (NeueKoordinatenExtern    => NeueKoordinatenExtern,
                    EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      
   end Bewegungsberechnung;
   
   
   
   procedure NachBewegung
     (NeueKoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
   is
      use type RassenDatentypen.Rassen_Enum;
   begin
      
      SichtbarkeitsberechnungssystemLogik.SichtbarkeitsprüfungFürEinheit (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      
      -- Prüft ob die Einheit jetzt auf einem Feld steht welches von einer fremden Rasse bereits aufgedeckt wurde und stellt entsprechend Kontakt her.
      -- Anders als die Berechnung in SichtbarkeitLogik, wo geprüft wird ob eine fremde Stadt oder Einheit auf einem neu aufgedecktem Feld steht.
      KontaktSchleife:
      for FremdeSichtbarkeitSchleifenwert in RassenDatentypen.Rassen_Verwendet_Enum'Range loop
         
         if
           FremdeSichtbarkeitSchleifenwert = EinheitRasseNummerExtern.Rasse
           or
             LeseRassenbelegung.Belegung (RasseExtern => FremdeSichtbarkeitSchleifenwert) = RassenDatentypen.Leer_Spieler_Enum
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
