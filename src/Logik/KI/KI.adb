pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with EinheitenDatentypen; use EinheitenDatentypen;
with StadtDatentypen; use StadtDatentypen;
with EinheitenKonstanten;
with KartenVerbesserungDatentypen;
with LadezeitenDatentypen;

with LeseEinheitenGebaut;
with LeseStadtGebaut;

with Ladezeiten;

with KIStadt;
with KIForschung;
with KIDiplomatie;
with KIEinheit;

package body KI is

   procedure KI
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      EinheitenDurchgehen (RasseExtern => RasseExtern);
      StädteDurchgehen (RasseExtern => RasseExtern);
      KIForschung.Forschung (RasseExtern => RasseExtern);
      KIDiplomatie.Diplomatie (RasseExtern => RasseExtern);
            
   end KI;
   
   
   
   procedure EinheitenDurchgehen
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      if
        SpielVariablen.Grenzen (RasseExtern).Einheitengrenze / 100 < 1
      then
         Einheitenzeitwert := 1;
         
      else
         Einheitenzeitwert := SpielVariablen.Grenzen (RasseExtern).Einheitengrenze / 100;
      end if;
      
      EinheitenSchleife:
      for EinheitenSchleifenwert in SpielVariablen.EinheitenGebautArray'First (2) .. SpielVariablen.Grenzen (RasseExtern).Einheitengrenze loop
         
         case
           LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => (RasseExtern, EinheitenSchleifenwert))
         is
            when EinheitenKonstanten.LeerID =>
               null;
            
            when others =>
               KIEinheit.Einheit (EinheitRasseNummerExtern => (RasseExtern, EinheitenSchleifenwert));
         end case;
            
         case
           EinheitenSchleifenwert mod Einheitenzeitwert
         is
            when 0 =>
               Ladezeiten.FortschrittKISchreiben (WelcheBerechnungenExtern => LadezeitenDatentypen.Berechne_Einheiten_Enum);
               
            when others =>
               null;
         end case;
            
      end loop EinheitenSchleife;
      
      Ladezeiten.FortschrittKIMaximum (WelcheBerechnungenExtern => LadezeitenDatentypen.Berechne_Einheiten_Enum);
      
   end EinheitenDurchgehen;
   
   
   
   procedure StädteDurchgehen
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      if
        SpielVariablen.Grenzen (RasseExtern).Städtegrenze / 100 < 1
      then
         Städtezeitwert := 1;
         
      else
         Städtezeitwert := SpielVariablen.Grenzen (RasseExtern).Städtegrenze / 100;
      end if;
      
      StadtSchleife:
      for StadtSchleifenwert in SpielVariablen.StadtGebautArray'First (2) .. SpielVariablen.Grenzen (RasseExtern).Städtegrenze loop
            
         case
           LeseStadtGebaut.ID (StadtRasseNummerExtern => (RasseExtern, StadtSchleifenwert))
         is
            when KartenVerbesserungDatentypen.Leer_Verbesserung_Enum =>
               null;
               
            when others =>
               KIStadt.KIStadt (StadtRasseNummerExtern => (RasseExtern, StadtSchleifenwert));
         end case;
            
         case
           StadtSchleifenwert mod Städtezeitwert
         is
            when 0 =>
               Ladezeiten.FortschrittKISchreiben (WelcheBerechnungenExtern => LadezeitenDatentypen.Berechne_Städte_Enum);
               
            when others =>
               null;
         end case;
         
      end loop StadtSchleife;
      
      Ladezeiten.FortschrittKIMaximum (WelcheBerechnungenExtern => LadezeitenDatentypen.Berechne_Städte_Enum);
      
   end StädteDurchgehen;

end KI;
