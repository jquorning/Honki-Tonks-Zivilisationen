pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Ada.Streams.Stream_IO; use Ada.Streams.Stream_IO;
with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

with RassenDatentypen; use RassenDatentypen;

private with SpielVariablen;

package SpeichernLogik is

   procedure Speichern
     (AutospeichernExtern : in Boolean);

   procedure AutoSpeichern;

private

   AutospeichernWert : Positive := 1;

   DateiSpeichern : File_Type;

   Spielstandname : Unbounded_Wide_Wide_String;
   Autospeichernname : Unbounded_Wide_Wide_String;

   procedure Allgemeines
     (DateiSpeichernExtern : in File_Type);

   procedure Karte
     (DateiSpeichernExtern : in File_Type;
      AutospeichernExtern : in Boolean);

   procedure RassenwerteSpeichern
     (DateiSpeichernExtern : in File_Type);

   procedure FortschrittErhöhen
     (AutospeichernExtern : in Boolean);

   procedure Rassenwerte
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      DateiSpeichernExtern : in File_Type)
     with
       Pre => (
                 SpielVariablen.Rassenbelegung (RasseExtern).Belegung /= RassenDatentypen.Leer_Spieler_Enum
              );



   function NameAutoSpeichern
     return Unbounded_Wide_Wide_String;

end SpeichernLogik;