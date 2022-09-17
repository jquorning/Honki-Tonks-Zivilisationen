pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with TastenbelegungDatentypen;
with SpielVariablen;

with NachGrafiktask;
with TasteneingabeLogik;

package body AbspannLogik is

   procedure Abspann
     (AbspannExtern : in GrafikDatentypen.Abspann_Enum)
   is begin
      
      case
        AbspannExtern
      is
         when GrafikDatentypen.Planet_Vernichtet_Enum =>
            NachGrafiktask.AktuelleRasse := SpielVariablen.Allgemeines.PlanetVernichtet;
            
         when others =>
            null;
      end case;
      
      NachGrafiktask.Abspannart := AbspannExtern;
      NachGrafiktask.AktuelleDarstellung := GrafikDatentypen.Grafik_Abspann_Enum;
      
      AbspannSchleife:
      loop
         
         case
           TasteneingabeLogik.Tastenwert
         is
            when TastenbelegungDatentypen.Menü_Zurück_Enum | TastenbelegungDatentypen.Auswählen_Enum =>
               exit AbspannSchleife;
               
            when others =>
               null;
         end case;
         
      end loop AbspannSchleife;
      
      NachGrafiktask.AktuelleDarstellung := GrafikDatentypen.Grafik_Pause_Enum;
      NachGrafiktask.Abspannart := GrafikDatentypen.Leer_Hintergrund_Enum;
      
   end Abspann;

end AbspannLogik;