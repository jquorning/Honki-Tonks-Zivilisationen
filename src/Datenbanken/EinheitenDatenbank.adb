pragma SPARK_Mode (On);

with GlobaleKonstanten;

with Auswahl, Anzeige, Sortieren;

package body EinheitenDatenbank is

   procedure Beschreibung (ID : in GlobaleDatentypen.EinheitenID) is
   begin
      
      Anzeige.AnzeigeOhneAuswahlNeu (ÜberschriftDatei => GlobaleDatentypen.Leer,
                                     TextDatei        => GlobaleDatentypen.Beschreibungen_Einheiten_Kurz,
                                     ÜberschriftZeile => 0,
                                     ErsteZeile       => Positive (ID),
                                     LetzteZeile      => Positive (ID),
                                     AbstandAnfang    => GlobaleDatentypen.Keiner,
                                     AbstandMitte     => GlobaleDatentypen.Keiner,
                                     AbstandEnde      => GlobaleDatentypen.Keiner);
      
   end Beschreibung;



   procedure LebenspunkteBewegungspunkteAufMaximumSetzen (EinheitRasseNummer : in GlobaleRecords.RassePlatznummerRecord) is
   begin
      
      GlobaleVariablen.EinheitenGebaut (EinheitRasseNummer.Rasse, EinheitRasseNummer.Platznummer).AktuelleLebenspunkte
        := EinheitenListe (EinheitRasseNummer.Rasse, GlobaleVariablen.EinheitenGebaut (EinheitRasseNummer.Rasse, EinheitRasseNummer.Platznummer).ID).MaximaleLebenspunkte;
      GlobaleVariablen.EinheitenGebaut (EinheitRasseNummer.Rasse, EinheitRasseNummer.Platznummer).AktuelleBewegungspunkte
        := EinheitenListe (EinheitRasseNummer.Rasse, GlobaleVariablen.EinheitenGebaut (EinheitRasseNummer.Rasse, EinheitRasseNummer.Platznummer).ID).MaximaleBewegungspunkte;
      
   end LebenspunkteBewegungspunkteAufMaximumSetzen;



   procedure HeilungBewegungspunkteFürNeueRundeSetzen is
   begin
      
      RassenSchleife:
      for RasseIntern in GlobaleVariablen.EinheitenGebautArray'Range (1) loop
         EinheitenSchleife:
         for EinheitNummer in GlobaleVariablen.EinheitenGebautArray'Range (2) loop
            
            if GlobaleVariablen.EinheitenGebaut (RasseIntern, EinheitNummer).ID = 0 then
               exit EinheitenSchleife;

            else
               null;
            end if;

            if GlobaleVariablen.EinheitenGebaut (RasseIntern, EinheitNummer).AktuelleBeschäftigung = 0 then
               GlobaleVariablen.EinheitenGebaut (RasseIntern, EinheitNummer).AktuelleBewegungspunkte := EinheitenListe (RasseIntern, GlobaleVariablen.EinheitenGebaut (RasseIntern, EinheitNummer).ID).MaximaleBewegungspunkte;

            else
               GlobaleVariablen.EinheitenGebaut (RasseIntern, EinheitNummer).AktuelleBewegungspunkte := 0.00;
            end if;

            if GlobaleVariablen.EinheitenGebaut (RasseIntern, EinheitNummer).AktuelleBeschäftigung = 7
              and GlobaleVariablen.EinheitenGebaut (RasseIntern, EinheitNummer).AktuelleLebenspunkte + Heilungsrate
              >= EinheitenListe (RasseIntern, GlobaleVariablen.EinheitenGebaut (RasseIntern, EinheitNummer).ID).MaximaleLebenspunkte then
               GlobaleVariablen.EinheitenGebaut (RasseIntern, EinheitNummer).AktuelleLebenspunkte := EinheitenListe (RasseIntern, GlobaleVariablen.EinheitenGebaut (RasseIntern, EinheitNummer).ID).MaximaleLebenspunkte;
               GlobaleVariablen.EinheitenGebaut (RasseIntern, EinheitNummer).AktuelleBeschäftigung := 0;
               GlobaleVariablen.EinheitenGebaut (RasseIntern, EinheitNummer).AktuelleBeschäftigungszeit := 0;
                  
            elsif GlobaleVariablen.EinheitenGebaut (RasseIntern, EinheitNummer).AktuelleBeschäftigung = 7
              and GlobaleVariablen.EinheitenGebaut (RasseIntern, EinheitNummer).AktuelleLebenspunkte + Heilungsrate
              < EinheitenListe (RasseIntern, GlobaleVariablen.EinheitenGebaut (RasseIntern, EinheitNummer).ID).MaximaleLebenspunkte then
               GlobaleVariablen.EinheitenGebaut (RasseIntern, EinheitNummer).AktuelleLebenspunkte := GlobaleVariablen.EinheitenGebaut (RasseIntern, EinheitNummer).AktuelleLebenspunkte + Heilungsrate;
               
            else
               null;
            end if;
            
         end loop EinheitenSchleife;
      end loop RassenSchleife;
      
   end HeilungBewegungspunkteFürNeueRundeSetzen;
   


   procedure EinheitErzeugen (StadtRasseNummer : GlobaleRecords.RassePlatznummerRecord; ID : in Positive) is -- Kann Einheiten nur in Städten erzeugen und funktioniert nicht richtig
   begin

      Position := (GlobaleVariablen.StadtGebaut (StadtRasseNummer.Rasse, StadtRasseNummer.Platznummer).AchsenPosition.EAchse,
                   GlobaleVariablen.StadtGebaut (StadtRasseNummer.Rasse, StadtRasseNummer.Platznummer).AchsenPosition.YAchse,
                   GlobaleVariablen.StadtGebaut (StadtRasseNummer.Rasse, StadtRasseNummer.Platznummer).AchsenPosition.XAchse);
      EinheitenPosition := 0;
            
      EinheitenSchleife:
      for EinheitNummer in GlobaleVariablen.EinheitenGebautArray'Range (2) loop
            
         if GlobaleVariablen.EinheitenGebaut (StadtRasseNummer.Rasse, EinheitNummer).ID = 0 then
            EinheitenPosition := EinheitNummer;
            exit EinheitenSchleife;

         elsif GlobaleVariablen.EinheitenGebaut (StadtRasseNummer.Rasse, EinheitNummer).AchsenPosition = GlobaleVariablen.StadtGebaut (StadtRasseNummer.Rasse, StadtRasseNummer.Platznummer).AchsenPosition then
            return;
            
         else
            null;
         end if;
            
      end loop EinheitenSchleife;

      case EinheitenPosition is
         when 0 =>
            return;
            
         when others =>
            GlobaleVariablen.EinheitenGebaut (StadtRasseNummer.Rasse, EinheitenPosition).ID := GlobaleDatentypen.EinheitenID (ID);
            GlobaleVariablen.EinheitenGebaut (StadtRasseNummer.Rasse, EinheitenPosition).AchsenPosition := Position;
            LebenspunkteBewegungspunkteAufMaximumSetzen (EinheitRasseNummer => (StadtRasseNummer.Rasse, EinheitenPosition));
            GlobaleVariablen.StadtGebaut (StadtRasseNummer.Rasse, StadtRasseNummer.Platznummer).VerbleibendeBauzeit := 0;
            GlobaleVariablen.StadtGebaut (StadtRasseNummer.Rasse, StadtRasseNummer.Platznummer).AktuelleRessourcen := 0;
            GlobaleVariablen.StadtGebaut (StadtRasseNummer.Rasse, StadtRasseNummer.Platznummer).AktuellesBauprojekt := 0;
      end case;
            
   end EinheitErzeugen;



   procedure EinheitEntfernenMitSortieren (EinheitRasseNummer : in GlobaleRecords.RassePlatznummerRecord) is
   begin
      
      GlobaleVariablen.EinheitenGebaut (EinheitRasseNummer.Rasse, EinheitRasseNummer.Platznummer) := GlobaleVariablen.LeererWertEinheit;
      Sortieren.EinheitenSortieren (RasseExtern => EinheitRasseNummer.Rasse);

      if GlobaleVariablen.EinheitenGebaut (EinheitRasseNummer.Rasse, 1).ID = 0 and GlobaleVariablen.StadtGebaut (EinheitRasseNummer.Rasse, 1).ID = 0 then
         GlobaleVariablen.RassenImSpiel (EinheitRasseNummer.Rasse) := 0;
         
      else
         null;
      end if;
      
   end EinheitEntfernenMitSortieren;



   procedure EinheitEntfernenOhneSortieren (EinheitRasseNummer : in GlobaleRecords.RassePlatznummerRecord) is
   begin

      GlobaleVariablen.EinheitenGebaut (EinheitRasseNummer.Rasse, EinheitRasseNummer.Platznummer) := GlobaleVariablen.LeererWertEinheit;

      if GlobaleVariablen.EinheitenGebaut (EinheitRasseNummer.Rasse, 1).ID = 0 and GlobaleVariablen.StadtGebaut (EinheitRasseNummer.Rasse, 1).ID = 0 then
         GlobaleVariablen.RassenImSpiel (EinheitRasseNummer.Rasse) := 0;
         
      else
         null;
      end if;
      
   end EinheitEntfernenOhneSortieren;
   
   

   procedure Beschäftigung (Arbeit : in Natural) is
   begin
      
      case Arbeit is
         when 0 =>
            Anzeige.AnzeigeOhneAuswahlNeu (ÜberschriftDatei => GlobaleDatentypen.Leer,
                                           TextDatei        => GlobaleDatentypen.Beschreibungen_Beschäftigung_Kurz,
                                           ÜberschriftZeile => 0,
                                           ErsteZeile       => 9,
                                           LetzteZeile      => 9,
                                           AbstandAnfang    => GlobaleDatentypen.Keiner,
                                           AbstandMitte     => GlobaleDatentypen.Keiner,
                                           AbstandEnde      => GlobaleDatentypen.Keiner);
            
         when others =>
            Anzeige.AnzeigeOhneAuswahlNeu (ÜberschriftDatei => GlobaleDatentypen.Leer,
                                           TextDatei        => GlobaleDatentypen.Beschreibungen_Beschäftigung_Kurz,
                                           ÜberschriftZeile => 0,
                                           ErsteZeile       => Arbeit,
                                           LetzteZeile      => Arbeit,
                                           AbstandAnfang    => GlobaleDatentypen.Keiner,
                                           AbstandMitte     => GlobaleDatentypen.Keiner,
                                           AbstandEnde      => GlobaleDatentypen.Keiner);
      end case;
      
   end Beschäftigung;
   


   function BeschäftigungAbbrechenVerbesserungErsetzenBrandschatzenEinheitAuflösen (WelcheAuswahl : in Natural) return Boolean is
   begin
      
      Wahl := Auswahl.AuswahlJaNein (FrageZeile => 7);
      case Wahl is
         when GlobaleKonstanten.JaKonstante =>
            return True;
                     
         when others =>
            return False;
      end case;
      
   end BeschäftigungAbbrechenVerbesserungErsetzenBrandschatzenEinheitAuflösen;

end EinheitenDatenbank;
