pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with GlobaleVariablen;
with GrafikTonDatentypen;

with EingabeKonsole;
with EingabeSFML;
with Fehler;

package body Eingabe is

   function GanzeZahl
     (ZeileExtern : in Positive;
      ZahlenMinimumExtern : in SystemDatentypen.Grenzen;
      ZahlenMaximumExtern : in SystemDatentypen.Grenzen)
      return SystemRecords.ZahlenEingabeRecord
   is begin
      
      -- TextDateiExtern später auch in Konsole entfernen. Und alle Fragen nach Fragen verschieben, sonst funktioniert das hier nicht so richtig. Ist auch sinnvollder aufgeteilt dann.
      case
        GlobaleVariablen.AnzeigeArt
      is
         when GrafikTonDatentypen.Grafik_Konsole_Enum =>
            return EingabeKonsole.GanzeZahl (ZahlenMinimumExtern => ZahlenMinimumExtern,
                                             ZahlenMaximumExtern => ZahlenMaximumExtern,
                                             WelcheFrageExtern   => ZeileExtern);
            
         when GrafikTonDatentypen.Grafik_SFML_Enum =>
            return EingabeSFML.GanzeZahl (ZahlenMinimumExtern => ZahlenMinimumExtern,
                                          ZahlenMaximumExtern => ZahlenMaximumExtern,
                                          WelcheFrageExtern   => ZeileExtern);
      end case;
      
   end GanzeZahl;

   

   function StadtName
     return SystemRecords.TextEingabeRecord
   is begin
      
      case
        GlobaleVariablen.AnzeigeArt
      is
         when GrafikTonDatentypen.Grafik_Konsole_Enum =>
            return EingabeKonsole.StadtName;
            
         when GrafikTonDatentypen.Grafik_SFML_Enum =>
            return EingabeSFML.StadtName;
      end case;
      
   end StadtName;



   function SpielstandName
     return SystemRecords.TextEingabeRecord
   is begin
      
      case
        GlobaleVariablen.AnzeigeArt
      is
         when GrafikTonDatentypen.Grafik_Konsole_Enum =>
            return EingabeKonsole.SpielstandName;
            
         when GrafikTonDatentypen.Grafik_SFML_Enum =>
            return EingabeSFML.SpielstandName;
      end case;
      
   end SpielstandName;



   procedure WartenEingabe
   is begin
      
      case
        GlobaleVariablen.AnzeigeArt
      is
         when GrafikTonDatentypen.Grafik_Konsole_Enum =>
            EingabeKonsole.WartenEingabe;
            
         when GrafikTonDatentypen.Grafik_SFML_Enum =>
            Fehler.LogikFehler (FehlermeldungExtern => "Eingabe.WartenEingabe - Nur bei Konsole so nötig.");
      end case;
      
   end WartenEingabe;
   
   
   
   function Tastenwert
     return TastenbelegungDatentypen.Tastenbelegung_Enum
   is begin
      
      case
        GlobaleVariablen.AnzeigeArt
      is
         when GrafikTonDatentypen.Grafik_Konsole_Enum =>
            return EingabeKonsole.Tastenwert;
            
         when GrafikTonDatentypen.Grafik_SFML_Enum =>
            return EingabeSFML.Tastenwert;
      end case;
      
   end Tastenwert;
   
   
   
   procedure StandardTastenbelegungLaden
   is begin
      
      case
        GlobaleVariablen.AnzeigeArt
      is
         when GrafikTonDatentypen.Grafik_Konsole_Enum =>
            EingabeKonsole.StandardTastenbelegungLaden;
            
         when GrafikTonDatentypen.Grafik_SFML_Enum =>
            EingabeSFML.StandardTastenbelegungLaden;
      end case;
      
   end StandardTastenbelegungLaden;

end Eingabe;
