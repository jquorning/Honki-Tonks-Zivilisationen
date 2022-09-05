pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Ada.Streams.Stream_IO; use Ada.Streams.Stream_IO;

with RassenDatentypen; use RassenDatentypen;

private with SystemRecords;
private with SpielVariablen;

package Speichern is

   procedure Speichern
     (AutospeichernExtern : in Boolean);

   procedure AutoSpeichern;

private

   SpielstandVorhanden : Boolean;

   AutospeichernWert : Positive := 1;

   DateiSpeichern : File_Type;

   NameSpielstand : SystemRecords.TextEingabeRecord;

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
                 SpielVariablen.RassenImSpiel (RasseExtern) /= RassenDatentypen.Leer_Spieler_Enum
              );



   function SpielstandNameFestlegen
     (AutospeichernExtern : in Boolean)
      return SystemRecords.TextEingabeRecord;

   function NameAutoSpeichern
     return SystemRecords.TextEingabeRecord;

   function NameNutzer
     return SystemRecords.TextEingabeRecord;

end Speichern;
