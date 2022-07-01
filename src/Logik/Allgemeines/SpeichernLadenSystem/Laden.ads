pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Ada.Streams.Stream_IO; use Ada.Streams.Stream_IO;

with RassenDatentypen; use RassenDatentypen;

private with SystemRecords;
private with SonstigesKonstanten;
private with SpielVariablen;

package Laden is

   function Laden
     return Boolean;

private

   VersionsnummerPrüfung : Wide_Wide_String (SonstigesKonstanten.Versionsnummer'Range);

   DateiLaden : File_Type;

   NameSpielstand : SystemRecords.TextEingabeRecord;

   procedure Allgemeines;
   procedure KarteLaden;
   procedure RassenwerteLaden;

   procedure Rassenwerte
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
     with
       Pre => (
                 SpielVariablen.RassenImSpiel (RasseExtern) /= RassenDatentypen.Leer_Spieler_Enum
              );

end Laden;
