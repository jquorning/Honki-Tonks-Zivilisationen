pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with RassenDatentypen; use RassenDatentypen;
with KartenDatentypen; use KartenDatentypen;
with KartengrundDatentypen; use KartengrundDatentypen;
with EinheitenRecords;
with SpielVariablen;
with KartenRecords;

private with AufgabenDatentypen;
private with KartenverbesserungDatentypen;
private with ProduktionDatentypen;

with Weltkarte;

package WegErmittelnLogik is

   function WegErmitteln
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

   WegVorhanden : KartenverbesserungDatentypen.Karten_Weg_Enum;

   WelcherWeg : AufgabenDatentypen.Einheiten_Aufgaben_Enum;
   WelcheArbeit : AufgabenDatentypen.Einheiten_Aufgaben_Enum;

   Arbeitszeit : ProduktionDatentypen.Arbeitszeit;

   Arbeitswerte : EinheitenRecords.ArbeitRecord;

   Gesamtgrund : KartenRecords.KartengrundRecord;

   -- Benutze ich das mehrmals und wenn ja, kann ich es zusammenführen? äöü
   -- Bräuchte ich hier aber in verschiedenen Ausführungen. Vermutlich sinnvoll die alle anzulegen aber wahrscheinlich nicht sie auszulagern. äöü
   -- Benutze aber eine kleine Version davon im Wegeplatzierungssystem, eventuell ist da eine Zusammenführung sinnvoll? äöü
   type WelcheWegartArray is array (KartenverbesserungDatentypen.Karten_Weg_Enum'Range) of AufgabenDatentypen.Einheitenbefehle_Wege_Enum;
   WelcheWegart : constant WelcheWegartArray := (
                                                 KartenverbesserungDatentypen.Leer_Weg_Enum             => AufgabenDatentypen.Straße_Bauen_Enum,
                                                 KartenverbesserungDatentypen.Karten_Straße_Enum'Range  => AufgabenDatentypen.Schiene_Bauen_Enum,
                                                 KartenverbesserungDatentypen.Karten_Schiene_Enum'Range => AufgabenDatentypen.Schiene_Bauen_Enum,
                                                 KartenverbesserungDatentypen.Karten_Tunnel_Enum'Range  => AufgabenDatentypen.Tunnel_Bauen_Enum
                                                );



   function OberflächeLand
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      WegExtern : in KartenverbesserungDatentypen.Karten_Weg_Enum;
      GrundExtern : in KartenRecords.KartengrundRecord)
      return EinheitenRecords.ArbeitRecord
     with
       Pre => (
                 SpielVariablen.Rassenbelegung (RasseExtern).Belegung /= RassenDatentypen.Leer_Spieler_Enum
               and
                 (GrundExtern.Basisgrund in KartengrundDatentypen.Basisgrund_Oberfläche_Land_Enum'Range
                  or
                    GrundExtern.Basisgrund = KartengrundDatentypen.Eis_Enum)
              );

   function OberflächeWasser
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      WegExtern : in KartenverbesserungDatentypen.Karten_Weg_Enum;
      GrundExtern : in KartenRecords.KartengrundRecord)
      return EinheitenRecords.ArbeitRecord
     with
       Pre => (
                 SpielVariablen.Rassenbelegung (RasseExtern).Belegung /= RassenDatentypen.Leer_Spieler_Enum
               and
                 GrundExtern.Basisgrund in KartengrundDatentypen.Basisgrund_Oberfläche_Wasser_Enum'Range
              );

   function UnterflächeLand
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      WegExtern : in KartenverbesserungDatentypen.Karten_Weg_Enum;
      GrundExtern : in KartenRecords.KartengrundRecord)
      return EinheitenRecords.ArbeitRecord
     with
       Pre => (
                 SpielVariablen.Rassenbelegung (RasseExtern).Belegung /= RassenDatentypen.Leer_Spieler_Enum
               and
                 (GrundExtern.Basisgrund in KartengrundDatentypen.Basisgrund_Unterfläche_Land_Enum'Range
                  or
                    GrundExtern.Basisgrund = KartengrundDatentypen.Untereis_Enum)
              );

   function UnterflächeWasser
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      WegExtern : in KartenverbesserungDatentypen.Karten_Weg_Enum;
      GrundExtern : in KartenRecords.KartengrundRecord)
      return EinheitenRecords.ArbeitRecord
     with
       Pre => (
                 SpielVariablen.Rassenbelegung (RasseExtern).Belegung /= RassenDatentypen.Leer_Spieler_Enum
               and
                 GrundExtern.Basisgrund in KartengrundDatentypen.Basisgrund_Unterfläche_Wasser_Enum'Range
              );

   -- Später Wege für den Kern einbauen? äöü

end WegErmittelnLogik;
