pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Ada.Streams.Stream_IO; use Ada.Streams.Stream_IO;

with SystemRecords;

package Speichern is

   procedure SpeichernNeu
     (AutospeichernExtern : in Boolean);

   procedure AutoSpeichern;

private

   SpielstandVorhanden : Boolean;

   AutospeichernWert : Positive := 1;

   DateiSpeichernNeu : File_Type;

   NameSpielstand : SystemRecords.TextEingabeRecord;

   procedure SonstigesSpeichern;
   procedure KarteSpeichern;
   procedure RassenGrenzenSpeichern;
   procedure EinheitenSpeichern;
   procedure StädteSpeichern;
   procedure WichtigesSpeichern;
   procedure DiplomatieSpeichern;
   procedure CursorSpeichern;



   function NameAutoSpeichern
     return SystemRecords.TextEingabeRecord;

   function SpielstandNameFestlegen
     (AutospeichernExtern : in Boolean)
      return SystemRecords.TextEingabeRecord;

   function NameNutzer
     return SystemRecords.TextEingabeRecord;

end Speichern;
