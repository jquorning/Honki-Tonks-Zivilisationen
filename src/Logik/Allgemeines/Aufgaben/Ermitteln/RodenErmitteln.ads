pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with RassenDatentypen; use RassenDatentypen;
with EinheitStadtRecords;
with SonstigeVariablen;
with KartengrundDatentypen;
with SpielVariablen;
with EinheitStadtDatentypen;
with AufgabenDatentypen;
with EinheitenRecords;

package RodenErmitteln is

   function RodenErmitteln
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RasseEinheitnummerRecord;
      GrundExtern : in KartengrundDatentypen.Kartengrund_Vorhanden_Enum;
      AnlegenTestenExtern : in Boolean)
      return Boolean
     with
       Pre =>
         (EinheitRasseNummerExtern.Nummer in SpielVariablen.EinheitenGebautArray'First (2) .. SpielVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
          and
            SonstigeVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) /= RassenDatentypen.Leer_Spieler_Enum);

private

   WelcheArbeit : AufgabenDatentypen.Einheiten_Aufgaben_Enum;

   Arbeitszeit : EinheitStadtDatentypen.MaximaleStädteMitNullWert;
   Grundzeit : EinheitStadtDatentypen.MaximaleStädteMitNullWert := 1;

   Arbeitswerte : EinheitenRecords.ArbeitRecord;

   function OberflächeLand
     (GrundExtern : in KartengrundDatentypen.Kartengrund_Oberfläche_Enum)
      return EinheitenRecords.ArbeitRecord;

   function UnterflächeWasser
     (GrundExtern : in KartengrundDatentypen.Kartengrund_Unterfläche_Wasser_Enum)
      return EinheitenRecords.ArbeitRecord;

end RodenErmitteln;
