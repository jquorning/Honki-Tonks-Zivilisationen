pragma SPARK_Mode (On);

package body EinstellungenSFML is

   procedure StandardGrafikEinstellungenLaden
   is begin
      
      FensterEinstellungen := FensterStandardEinstellungen;
      Schriftfarben := SchriftfarbenStandard;
      RassenFarben := RassenFarbenStandard;
      
   end StandardGrafikEinstellungenLaden;

end EinstellungenSFML;
