pragma SPARK_Mode (On);

with EinheitenKonstanten;

with SchreibeEinheitenGebaut;
with LeseKarten;
with LeseEinheitenGebaut;
with LeseEinheitenDatenbank;

with Sichtbarkeit;
with KennenLernen;
with BewegungLadenEntladen;
with StadtSuchen;
with BewegungPassierbarkeitPruefen;

package body BewegungBerechnen is

   procedure BewegungEinheitenBerechnung
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      NeuePositionExtern : in KartenRecords.AchsenKartenfeldPositivRecord)
   is begin

      -- Immer berücksichtigen dass in BewegungssystemEinheiten.BewegungPrüfen bereits geprüft wird ob der Transporter die Einheit transportieren kann und ein freier Platz vorhanden ist.
      if
        LeseEinheitenDatenbank.KannTransportieren (RasseExtern => EinheitRasseNummerExtern.Rasse,
                                                   IDExtern    => LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => EinheitRasseNummerExtern))
          = EinheitenKonstanten.LeerKannTransportieren
      then
         null;
         
      elsif
        StadtSuchen.KoordinatenStadtMitRasseSuchen (RasseExtern       => EinheitRasseNummerExtern.Rasse,
                                                    KoordinatenExtern => NeuePositionExtern)
        = EinheitenKonstanten.LeerNummer
      then
         BewegungLadenEntladen.TransporterladungVerschieben (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                             NeuePositionExtern       => NeuePositionExtern);

      else
         case
           BewegungPassierbarkeitPruefen.InStadtEntladbar (TransporterExtern  => EinheitRasseNummerExtern,
                                                           NeuePositionExtern => NeuePositionExtern)
         is
            when False =>
               return;
               
            when True =>
               BewegungLadenEntladen.TransporterStadtEntladen (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                               NeuePositionExtern       => NeuePositionExtern);
         end case;
      end if;

      BewegungspunkteAbzug := AbzugDurchBewegung (NeuePositionExtern       => NeuePositionExtern,
                                                  EinheitRasseNummerExtern => EinheitRasseNummerExtern);
        
      if
        BewegungspunkteAbzug = EinheitUnbewegbar
      then
         SchreibeEinheitenGebaut.Bewegungspunkte (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                  BewegungspunkteExtern    => EinheitenKonstanten.LeerEinheit.Bewegungspunkte,
                                                  RechnenSetzenExtern      => 0);
         return;
         
      else
         SchreibeEinheitenGebaut.Bewegungspunkte (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                  BewegungspunkteExtern    => BewegungspunkteAbzug,
                                                  RechnenSetzenExtern      => -1);
      end if;
      -- Hier nicht return, da Bewegung zwar erfolgreich aber jetzt noch die Rechnungen durchlaufen müssen.

      case
        LeseEinheitenGebaut.WirdTransportiert (EinheitRasseNummerExtern => EinheitRasseNummerExtern)
      is
         when EinheitenKonstanten.LeerWirdTransportiert =>
            null;
            
         when others =>
            BewegungLadenEntladen.EinheitAusTransporterEntfernen (TransporterExtern => (EinheitRasseNummerExtern.Rasse, LeseEinheitenGebaut.WirdTransportiert (EinheitRasseNummerExtern => EinheitRasseNummerExtern)),
                                                                  LadungExtern      => EinheitRasseNummerExtern.Platznummer);
      end case;
      
      case
        GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse)
      is
         when SystemKonstanten.SpielerKIKonstante =>
            null;
            
         when others =>
            GlobaleVariablen.CursorImSpiel (EinheitRasseNummerExtern.Rasse).Position := NeuePositionExtern;
      end case;
      
      SchreibeEinheitenGebaut.Position (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                        PositionExtern           => NeuePositionExtern);
      NachBewegung (NeuePositionExtern       => NeuePositionExtern,
                    EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      
   end BewegungEinheitenBerechnung;
   
   
   
   procedure NachBewegung
     (NeuePositionExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
   is begin
      
      Sichtbarkeit.SichtbarkeitsprüfungFürEinheit (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      
      -- Prüft nur ob das Feld auf dass sich diese Einheit bewegt bereits von einer anderen Rasse aufgedeckt wurde und stellt entsprechend Kontakt her.
      KontaktSchleife:
      for FremdeSichtbarkeitSchleifenwert in SystemDatentypen.RassenImSpielArray'Range loop
         
         if
           FremdeSichtbarkeitSchleifenwert = EinheitRasseNummerExtern.Rasse
           or
             GlobaleVariablen.RassenImSpiel (FremdeSichtbarkeitSchleifenwert) = SystemKonstanten.LeerSpielerKonstante
         then
            null;
            
         elsif
           LeseKarten.Sichtbar (PositionExtern => NeuePositionExtern,
                                RasseExtern    => FremdeSichtbarkeitSchleifenwert)
           = True
         then
            KennenLernen.Erstkontakt (EigeneRasseExtern => EinheitRasseNummerExtern.Rasse,
                                      FremdeRasseExtern => FremdeSichtbarkeitSchleifenwert);
            
         else
            null;
         end if;
         
      end loop KontaktSchleife;
      
   end NachBewegung;
   
      
   
   function AbzugDurchBewegung
     (NeuePositionExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
         return EinheitStadtDatentypen.BewegungFloat
   is begin
      
      Welchen_Bonus := StraßeUndFlussPrüfen (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                               NeuePositionExtern       => NeuePositionExtern);

      case
        LeseKarten.Grund (PositionExtern => NeuePositionExtern)
      is
         when KartenDatentypen.Eis | KartenDatentypen.Gebirge | KartenDatentypen.Dschungel | KartenDatentypen.Sumpf =>
            if
              LeseEinheitenGebaut.Bewegungspunkte (EinheitRasseNummerExtern => EinheitRasseNummerExtern) < KleinerAbzug
            then
               return EinheitUnbewegbar;
      
            elsif
              MittlererAbzug - Bewegungsmodifikator (Welchen_Bonus) <= KeinAbzug
            then
               return KeinAbzug;
               
            else
               return MittlererAbzug - Bewegungsmodifikator (Welchen_Bonus);
            end if;
            
         when others =>
            if
              KleinerAbzug - Bewegungsmodifikator (Welchen_Bonus) <= KeinAbzug
            then
               return KeinAbzug;
            
            else
               return KleinerAbzug - Bewegungsmodifikator (Welchen_Bonus);
            end if;
      end case;
      
   end AbzugDurchBewegung;

   

   function StraßeUndFlussPrüfen
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      NeuePositionExtern : in KartenRecords.AchsenKartenfeldPositivRecord)
         return Bewegungsbonuse_Enum
   is begin

      if
        LeseEinheitenDatenbank.Passierbarkeit (RasseExtern          => EinheitRasseNummerExtern.Rasse,
                                               IDExtern             => LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => EinheitRasseNummerExtern),
                                               WelcheUmgebungExtern => EinheitStadtDatentypen.Luft)
        = False
        and
          LeseEinheitenDatenbank.Passierbarkeit (RasseExtern          => EinheitRasseNummerExtern.Rasse,
                                                 IDExtern             => LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => EinheitRasseNummerExtern),
                                                 WelcheUmgebungExtern => EinheitStadtDatentypen.Weltraum)
        = False
      then
         case
           LeseKarten.VerbesserungWeg (PositionExtern => NeuePositionExtern)
         is
            when KartenDatentypen.Karten_Verbesserung_Weg_Enum'Range =>
               return Straße_Fluss;
               
            when KartenDatentypen.Karten_Verbesserung_Schiene_Enum'Range =>
               return Schiene;
               
            when KartenDatentypen.Karten_Verbesserung_Tunnel_Enum =>
               return Straße_Fluss;
                  
            when others =>
               null;
         end case;

         case
           LeseKarten.Fluss (PositionExtern => NeuePositionExtern)
         is
            when KartenDatentypen.Leer =>
               null;

            when others =>
               return Straße_Fluss;
         end case;

      else
         null;
      end if;
      
      return Leer;
      
   end StraßeUndFlussPrüfen;

end BewegungBerechnen;