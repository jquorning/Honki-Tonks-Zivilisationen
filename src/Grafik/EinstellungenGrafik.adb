with TexteinstellungenGrafik;
with SpezieseinstellungenGrafik;

package body EinstellungenGrafik is

   procedure StandardeinstellungenLaden
   is begin
      
      FensterEinstellungen := FensterStandardEinstellungen;
      Grafikeinstellungen := GrafikeinstellungenStandard;
            
      TexteinstellungenGrafik.StandardLaden;
      SpezieseinstellungenGrafik.StandardLaden;
      
   end StandardeinstellungenLaden;

end EinstellungenGrafik;
