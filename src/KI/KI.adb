pragma SPARK_Mode (On);

with KIDatentypen;
use KIDatentypen;

with EinheitenDatenbank, KISiedler, KINahkampfLandEinheit, KIFernkampfLandEinheit, KINahkampfSeeEinheit, KIFernkampfSeeEinheit, KINahkampfLuftEinheit, KIFernkampfLuftEinheit, KINahkampfUnterirdisch,
     KIFernkampfUnterirdisch, KINahkampfOrbital, KIFernkampfOrbital, EinheitSuchen;

package body KI is

   procedure KI
     (RasseExtern : in GlobaleDatentypen.Rassen)
   is begin
      
      EinheitenSchleife:
      for EinheitNummerEinsSchleifenwert in GlobaleVariablen.EinheitenGebautArray'Range (2) loop
                     
         if
           GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummerEinsSchleifenwert).AktuelleBeschäftigung /= GlobaleDatentypen.Keine
           and
             GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummerEinsSchleifenwert).ID > 0
           and
             GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummerEinsSchleifenwert).AktuelleBewegungspunkte > 0.00
         then
            AKtivitätEinheitAbbrechen (EinheitRasseNummerExtern => (RasseExtern, EinheitNummerEinsSchleifenwert));

         elsif
           GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummerEinsSchleifenwert).AktuelleBeschäftigung /= GlobaleDatentypen.Keine
           or
             GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummerEinsSchleifenwert).ID = 0
           or
             GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummerEinsSchleifenwert).AktuelleBewegungspunkte = 0.00
         then
            null;
               
         else
            AKtivitätEinheit (EinheitRasseNummerExtern => (RasseExtern, EinheitNummerEinsSchleifenwert));
         end if;
            
      end loop EinheitenSchleife;
      
      StadtSchleife:
      for StadtNummerEinsSchleifenwert in GlobaleVariablen.StadtGebautArray'Range (2) loop
            
         if
           GlobaleVariablen.StadtGebaut (RasseExtern, StadtNummerEinsSchleifenwert).ID > 0
           and
             GlobaleVariablen.StadtGebaut (RasseExtern, StadtNummerEinsSchleifenwert).KIAktuelleBeschäftigung /= KIDatentypen.Keine_Aufgabe
         then
            AktivitätStadtAbbrechen (StadtRasseNummerExtern => (RasseExtern, StadtNummerEinsSchleifenwert));

         elsif
           GlobaleVariablen.StadtGebaut (RasseExtern, StadtNummerEinsSchleifenwert).ID = 0
           or
             GlobaleVariablen.StadtGebaut (RasseExtern, StadtNummerEinsSchleifenwert).KIAktuelleBeschäftigung /= KIDatentypen.Keine_Aufgabe
         then
            null;
               
         else
            AktivitätStadt (StadtRasseNummerExtern => (RasseExtern, StadtNummerEinsSchleifenwert));
         end if;

      end loop StadtSchleife;
      
   end KI;
      
   

   -- Von hier aus dann die einzelnen Tätigkeiten aufrufen
   procedure AKtivitätEinheit
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
   is begin

      EinheitTyp := EinheitenDatenbank.EinheitenListe (EinheitRasseNummerExtern.Rasse, GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).ID).EinheitTyp;
      
      -- 1 = Siedler, 2 = Bauarbeiter, 3 = NahkampfLand, 4 = FernkampfLand, 5 = NahkampfSee, 6 = FernkampfSee, 7 = NahkampfLuft, 8 = FernkampfLuft, 9 = NahkampfUnterirdisch, 10 = FernkampfUnterirdisch,
      -- 11 = NahkampfOrbital, 12 = FernkampfOrbital
      case
        EinheitTyp
      is
         when 1 =>
            KISiedler.KISiedler (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
            
         when 2 => -- Bauarbeiter kommt vielleicht später
            null;
            
         when 3 =>
            KINahkampfLandEinheit.KINahkampfLandEinheit (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
            
         when 4 =>
            KIFernkampfLandEinheit.KIFernkampfLandEinheit (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
            
         when 5 =>
            KINahkampfSeeEinheit.KINahkampfSeeEinheit (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
            
         when 6 =>
            KIFernkampfSeeEinheit.KIFernkampfSeeEinheit (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
            
         when 7 =>
            KINahkampfLuftEinheit.KINahkampfLuftEinheit (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
            
         when 8 =>
            KIFernkampfLuftEinheit.KIFernkampfLuftEinheit (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
            
         when 9 =>
            KINahkampfUnterirdisch.KINahkampfUnterirdisch (EinheitRasseNummerExtern => EinheitRasseNummerExtern);

         when 10 =>
            KIFernkampfUnterirdisch.KIFernkampfUnterirdisch (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
            
         when 11 =>
            KINahkampfOrbital.KINahkampfOrbital (EinheitRasseNummerExtern => EinheitRasseNummerExtern);

         when 12 =>
            KIFernkampfOrbital.KIFernkampfOrbital (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      end case;
      
   end AKtivitätEinheit;



   -- Aufrufen um den Abbruch der aktuellen Tätigkeit zu prüfen
   procedure AKtivitätEinheitAbbrechen
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
   is begin
      
      null;
      
   end AKtivitätEinheitAbbrechen;
   
   
               
   procedure AktivitätStadt
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
   is begin
            
      SiedlerVorhanden := EinheitSuchen.MengeEinesEinheitenTypsSuchen (RasseExtern      => StadtRasseNummerExtern.Rasse,
                                                                       EinheitTypExtern => 1);
      
      if
        SiedlerVorhanden < 1
      then
         GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).KIAktuelleBeschäftigung := KIDatentypen.Einheit_Bauen;
         GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).AktuellesBauprojekt := 10_001;
         
      else
         null;
      end if;
      
   end AktivitätStadt;



   -- Aufrufen um den Abbruch der aktuellen Tätigkeit zu prüfen
   procedure AktivitätStadtAbbrechen
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
   is begin
            
      null;
            
   end AktivitätStadtAbbrechen;

end KI;
