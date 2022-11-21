with WichtigesRecordKonstanten;
with EinheitenKonstanten;
with StadtKonstanten;
with GrafikDatentypen;

with SchreibeStadtGebaut;
with SchreibeEinheitenGebaut;
with LeseEinheitenGebaut;
with LeseStadtGebaut;
with SchreibeWichtiges;
with LeseGrenzen;

with LadezeitenLogik;
with NachGrafiktask;

package body RasseEntfernenLogik is

   procedure RasseEntfernen
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
   is
      use type RassenDatentypen.Rassen_Enum;
   begin
      
      EinheitenSchleife:
      for EinheitSchleifenwert in SpielVariablen.EinheitenGebautArray'First (2) .. LeseGrenzen.Einheitengrenze (RasseExtern => RasseExtern) loop
         
         SchreibeEinheitenGebaut.Nullsetzung (EinheitRasseNummerExtern => (RasseExtern, EinheitSchleifenwert));
         
      end loop EinheitenSchleife;
      
      StadtSchleife:
      for StadtSchleifenwert in SpielVariablen.StadtGebautArray'First (2) .. LeseGrenzen.Städtegrenzen (RasseExtern => RasseExtern) loop
         
         case
           LeseStadtGebaut.ID (StadtRasseNummerExtern => (RasseExtern, StadtSchleifenwert))
         is
            when StadtKonstanten.LeerID =>
               null;
               
            when others =>
               SchreibeStadtGebaut.Nullsetzung (StadtRasseNummerExtern => (RasseExtern, StadtSchleifenwert));
         end case;
         
      end loop StadtSchleife;
            
      DiplomatieSchleife:
      for DiplomatieSchleifenwert in RassenDatentypen.Rassen_Verwendet_Enum'Range loop
         
         SpielVariablen.Diplomatie (RasseExtern, DiplomatieSchleifenwert) := WichtigesRecordKonstanten.LeerDiplomatie;
         SpielVariablen.Diplomatie (DiplomatieSchleifenwert, RasseExtern) := WichtigesRecordKonstanten.LeerDiplomatie;
         
      end loop DiplomatieSchleife;
      
      if
        RasseExtern = NachGrafiktask.AktuelleRasse
      then
         NachGrafiktask.AktuelleDarstellung := GrafikDatentypen.Grafik_Pause_Enum;
         
      else
         null;
      end if;
      
      SpielVariablen.CursorImSpiel (RasseExtern) := WichtigesRecordKonstanten.LeerCursor;
      SchreibeWichtiges.LeerEintrag (RasseExtern => RasseExtern);
      
      SpielVariablen.Rassenbelegung (RasseExtern).Besiegt := True;
      
   end RasseEntfernen;
   
   
   
   procedure RasseExistenzPrüfen
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
   is begin
            
      EinheitenSchleife:
      for EinheitSchleifenwert in SpielVariablen.EinheitenGebautArray'First (2) .. LeseGrenzen.Einheitengrenze (RasseExtern => RasseExtern) loop
         
         case
           LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => (RasseExtern, EinheitSchleifenwert))
         is
            when EinheitenKonstanten.LeerID =>
               null;
               
            when others =>
               return;
         end case;
         
      end loop EinheitenSchleife;
      
      StadtSchleife:
      for StadtSchleifenwert in SpielVariablen.StadtGebautArray'First (2) .. LeseGrenzen.Städtegrenzen (RasseExtern => RasseExtern) loop
         
         case
           LeseStadtGebaut.ID (StadtRasseNummerExtern => (RasseExtern, StadtSchleifenwert))
         is
            when StadtKonstanten.LeerID =>
               null;
               
            when others =>
               return;
         end case;
         
      end loop StadtSchleife;
      
      RasseEntfernen (RasseExtern => RasseExtern);
      
   end RasseExistenzPrüfen;
   
   
   
   procedure RasseAufKISetzen
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      SpielVariablen.Rassenbelegung (RasseExtern).Belegung := RassenDatentypen.KI_Spieler_Enum;
      LadezeitenLogik.SpielweltNullsetzen;
      
   end RasseAufKISetzen;

end RasseEntfernenLogik;
