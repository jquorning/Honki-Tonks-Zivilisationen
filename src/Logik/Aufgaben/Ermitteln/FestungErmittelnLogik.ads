pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with RassenDatentypen; use RassenDatentypen;
with KartenDatentypen; use KartenDatentypen;
with KartengrundDatentypen; use KartengrundDatentypen;
with EinheitenRecords;
with SpielVariablen;
with KartenRecords;

private with AufgabenDatentypen;
private with ProduktionDatentypen;

with Weltkarte;

package FestungErmittelnLogik is

   function FestungErmitteln
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      AnlegenTestenExtern : in Boolean;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
      return Boolean
     with
       Pre => (
                 KoordinatenExtern.YAchse <= Weltkarte.Karteneinstellungen.Kartengröße.YAchse
               and
                 KoordinatenExtern.XAchse <= Weltkarte.Karteneinstellungen.Kartengröße.XAchse
               and
                 EinheitRasseNummerExtern.Nummer in SpielVariablen.EinheitenGebautArray'First (2) .. SpielVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
               and
                 SpielVariablen.Rassenbelegung (EinheitRasseNummerExtern.Rasse).Belegung /= RassenDatentypen.Leer_Spieler_Enum
              );

private

   WelcheArbeit : AufgabenDatentypen.Einheiten_Aufgaben_Enum;

   Arbeitszeit : ProduktionDatentypen.Arbeitszeit;
   Grundzeit : ProduktionDatentypen.Arbeitszeit := 1;

   Arbeitswerte : EinheitenRecords.ArbeitRecord;

   VorhandenerGrund : KartenRecords.KartengrundRecord;

   function OberflächeLand
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      GrundExtern : in KartenRecords.KartengrundRecord)
      return EinheitenRecords.ArbeitRecord
     with
       Pre => (
                 SpielVariablen.Rassenbelegung (RasseExtern).Belegung /= RassenDatentypen.Leer_Spieler_Enum
               and
                 (GrundExtern.BasisGrund in KartengrundDatentypen.Kartengrund_Oberfläche_Basis_Enum'Range
                  or
                    GrundExtern.BasisGrund = KartengrundDatentypen.Eis_Enum)
               and
                 (GrundExtern.AktuellerGrund in KartengrundDatentypen.Kartengrund_Oberfläche_Land_Enum'Range
                  or
                    GrundExtern.BasisGrund = KartengrundDatentypen.Eis_Enum)
              );

   function UnterflächeLand
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      GrundExtern : in KartenRecords.KartengrundRecord)
      return EinheitenRecords.ArbeitRecord
     with
       Pre => (
                 SpielVariablen.Rassenbelegung (RasseExtern).Belegung /= RassenDatentypen.Leer_Spieler_Enum
               and
                 (GrundExtern.BasisGrund in KartengrundDatentypen.Kartengrund_Unterfläche_Landbasis_Enum'Range
                  or
                    GrundExtern.BasisGrund = KartengrundDatentypen.Untereis_Enum)
               and
                 (GrundExtern.AktuellerGrund in KartengrundDatentypen.Kartengrund_Unterfläche_Landbasis_Enum'Range
                  or
                    GrundExtern.BasisGrund = KartengrundDatentypen.Untereis_Enum)
              );

   function UnterflächeWasser
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      GrundExtern : in KartenRecords.KartengrundRecord)
      return EinheitenRecords.ArbeitRecord
     with
       Pre => (
                 SpielVariablen.Rassenbelegung (RasseExtern).Belegung /= RassenDatentypen.Leer_Spieler_Enum
               and
                 (GrundExtern.BasisGrund = KartengrundDatentypen.Küstengrund_Enum
                  or
                    GrundExtern.BasisGrund = KartengrundDatentypen.Meeresgrund_Enum)
               and
                 (GrundExtern.AktuellerGrund in KartengrundDatentypen.Kartengrund_Unterfläche_Wasserzusatz_Enum'Range
                  or
                    GrundExtern.BasisGrund = KartengrundDatentypen.Küstengrund_Enum
                  or
                    GrundExtern.BasisGrund = KartengrundDatentypen.Meeresgrund_Enum)
              );

   -- Später Festungen für den Kern einbauen. äöü

end FestungErmittelnLogik;
