pragma SPARK_Mode (On);

with Ada.Wide_Wide_Text_IO; use Ada.Wide_Wide_Text_IO;
with Ada.Characters.Wide_Wide_Latin_9; use Ada.Characters.Wide_Wide_Latin_9;

with GlobaleVariablen;
with SystemKonstanten;
with SystemDatentypen;
with GlobaleTexte;

with Auswahl;
with ZufallGeneratorenSpieleinstellungen;

package body SpielEinstellungenSonstiges is

   function SchwierigkeitsgradFestlegen
     return Integer
   is begin
      
      SpieleranzahlSchleife:
      loop

         SchwierigkeitAuswahl := Auswahl.Auswahl (FrageDateiExtern  => GlobaleTexte.Spiel_Einstellungen,
                                                  TextDateiExtern   => GlobaleTexte.Spiel_Einstellungen,
                                                  FrageZeileExtern  => 64,
                                                  ErsteZeileExtern  => 65,
                                                  LetzteZeileExtern => 71);
         
         case
           SchwierigkeitAuswahl
         is
            when 1 .. 3 =>
               GlobaleVariablen.Schwierigkeitsgrad := SystemDatentypen.Schwierigkeitsgrad_Verwendet_Enum'Val (SchwierigkeitAuswahl);
               return SystemKonstanten.AuswahlFertig;

            when 4 =>
               GlobaleVariablen.Schwierigkeitsgrad := ZufallGeneratorenSpieleinstellungen.ZufälligerSchwiewrigkeitsgrad;
               return SystemKonstanten.AuswahlFertig;
               
            when SystemKonstanten.ZurückKonstante =>
               return SystemKonstanten.AuswahlBelegung;

            when SystemKonstanten.SpielBeendenKonstante | SystemKonstanten.HauptmenüKonstante =>
               return SchwierigkeitAuswahl;
               
            when others =>
               null;
         end case;

         Put (Item => CSI & "2J" & CSI & "H");
         
      end loop SpieleranzahlSchleife;
      
   end SchwierigkeitsgradFestlegen;

end SpielEinstellungenSonstiges;
