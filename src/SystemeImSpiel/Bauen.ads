with Ada.Wide_Wide_Text_IO, Ada.Strings.Wide_Wide_Unbounded, Ada.Wide_Wide_Characters.Handling, Ada.Characters.Wide_Wide_Latin_9, Einlesen, GebaeudeDatenbank, GlobaleVariablen, EinheitenDatenbank, Anzeige;
use Ada.Wide_Wide_Text_IO, Ada.Strings.Wide_Wide_Unbounded, Ada.Wide_Wide_Characters.Handling, Ada.Characters.Wide_Wide_Latin_9;

package Bauen is

   procedure Bauen (Rasse, StadtPositionInListe : in Integer);
   procedure ProduktionDurchführen;
   procedure Bauzeit (Rasse : in Integer);

private

   Taste : Wide_Wide_Character;

   WasGebautWerdenSoll : Integer;
   Ende : Integer;
   AktuelleAuswahl : Integer := 1;

   function AuswahlStadt (Rasse, WelcheStadt : in Integer) return Integer;

end Bauen;
