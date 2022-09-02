pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Ada.Calendar;

with NachGrafiktask;

package body MeldungFestlegenLogik is

   procedure MeldungFestlegen
     (MeldungExtern : in Positive)
   is begin
      
      -- Hier sollte immer erst die Zeit festgelegt werden, da die Grafik ja die Meldung auf 0 setzen kann.
      NachGrafiktask.StartzeitSpielmeldung := Ada.Calendar.Clock;
      NachGrafiktask.Spielmeldung := MeldungExtern;
      
   end MeldungFestlegen;
   
   
   
   procedure SpielermeldungFestlegen
     (MeldungExtern : in Positive;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      case
        SpielVariablen.RassenImSpiel (RasseExtern)
      is
         when RassenDatentypen.Mensch_Spieler_Enum =>
            MeldungFestlegen (MeldungExtern => MeldungExtern);
            
         when others =>
            null;
      end case;
      
   end SpielermeldungFestlegen;

end MeldungFestlegenLogik;