pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Ada.Streams.Stream_IO; use Ada.Streams.Stream_IO;

with SystemRecords;
with SonstigesKonstanten;

package Laden is

   function LadenNeu
     return Boolean;

private

   VersionsnummerPrüfung : Wide_Wide_String (SonstigesKonstanten.Versionsnummer'Range);

   DateiLadenNeu : File_Type;

   NameSpielstand : SystemRecords.TextEingabeRecord;

   procedure SonstigesLaden;
   procedure KarteLaden;
   procedure RassenGrenzenLaden;
   procedure EinheitenLaden;
   procedure StädteLaden;
   procedure WichtigesLaden;
   procedure DiplomatieLaden;
   procedure CursorLaden;

end Laden;
