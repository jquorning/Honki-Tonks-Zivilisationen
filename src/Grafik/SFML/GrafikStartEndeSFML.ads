pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

package GrafikStartEndeSFML is
   
   procedure FensterErzeugen;
   procedure FensterEntfernen;

   procedure FensterLeeren;
   procedure FensterAnzeigen;
   
private
     
   -- Das hier so lassen oder durch die erste Zeile der Textdatei - Hauptmenü ersetzen?
   -- Oder durch eine andere Textzeile ersetzen? Wobei sich der Spielenamen ja nicht ändert.
   Name : constant Wide_Wide_String := "Honki Tonk´s Zivilisation";
   
   procedure FensterErzeugenErweitert;

end GrafikStartEndeSFML;
