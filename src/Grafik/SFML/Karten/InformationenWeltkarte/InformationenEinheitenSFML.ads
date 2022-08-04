pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

private with Ada.Characters.Wide_Wide_Latin_1;

with Sf.System.Vector2;

with RassenDatentypen; use RassenDatentypen;
with EinheitenRecords;
with SpielVariablen;

private with EinheitenDatentypen;
private with ProduktionDatentypen;
private with KampfDatentypen;
private with TextaccessVariablen;
private with StadtDatentypen;

private with UmwandlungenAdaNachEigenes;

package InformationenEinheitenSFML is

   function Einheiten
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      TextpositionExtern : in Sf.System.Vector2.sfVector2f)
      return Sf.System.Vector2.sfVector2f
     with
       Pre => (
                 EinheitRasseNummerExtern.Nummer in SpielVariablen.EinheitenGebautArray'First (2) .. SpielVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
               and
                 SpielVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) /= RassenDatentypen.Leer_Spieler_Enum
               and
                 SpielVariablen.RassenImSpiel (RasseExtern) /= RassenDatentypen.Leer_Spieler_Enum
              );
   
private
   
   VolleInformation : Boolean;
   Beladen : Boolean;
   
   IDEinheit : EinheitenDatentypen.EinheitenID;
   
   Stadtnummer : StadtDatentypen.MaximaleStädteMitNullWert;
   
   Ladungsnummer : EinheitenDatentypen.MaximaleEinheitenMitNullWert;
   
   TextbreiteAktuell : Float;
   TextbreiteNeu : Float;
      
   Trennzeichen : constant Wide_Wide_String (1 .. 1) := "/";
   Ladungsabstand : constant Wide_Wide_String (1 .. 5) := Ada.Characters.Wide_Wide_Latin_1.LF & "    ";
   
   Ladungstext : Unbounded_Wide_Wide_String;
      
   EinheitRasseNummer : EinheitenRecords.RasseEinheitnummerRecord;
   
   Textposition : Sf.System.Vector2.sfVector2f;
   
   type FestzulegenderTextArray is array (TextaccessVariablen.EinheitenInformationenAccessArray'Range) of Unbounded_Wide_Wide_String;
   FestzulegenderText : FestzulegenderTextArray;
   
   procedure Debuginformationen
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
     with
       Pre => (
                 EinheitRasseNummerExtern.Nummer in SpielVariablen.EinheitenGebautArray'First (2) .. SpielVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
               and
                 SpielVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) /= RassenDatentypen.Leer_Spieler_Enum
              );
   
   
   
   function Heimatstadt
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return Unbounded_Wide_Wide_String
     with
       Pre => (
                 EinheitRasseNummerExtern.Nummer in SpielVariablen.EinheitenGebautArray'First (2) .. SpielVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
               and
                 SpielVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) /= RassenDatentypen.Leer_Spieler_Enum
              );
   
   function Ladung
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return Unbounded_Wide_Wide_String
     with
       Pre => (
                 EinheitRasseNummerExtern.Nummer in SpielVariablen.EinheitenGebautArray'First (2) .. SpielVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
               and
                 SpielVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) /= RassenDatentypen.Leer_Spieler_Enum
              );
      
   -- Diese Sachen überall mal ein wenig kürzer benennen. äöü
   function ZahlAlsStringMaximaleEinheitenMitNullWert is new UmwandlungenAdaNachEigenes.ZahlAlsStringLeerzeichenEntfernen (GanzeZahl => EinheitenDatentypen.MaximaleEinheitenMitNullWert);
   
   function ZahlAlsStringProduktionFeld is new UmwandlungenAdaNachEigenes.ZahlAlsStringLeerzeichenEntfernen (GanzeZahl => ProduktionDatentypen.Feldproduktion);
   
   function ZahlAlsStringGesamtproduktionStadt is new UmwandlungenAdaNachEigenes.ZahlAlsStringLeerzeichenEntfernen (GanzeZahl => ProduktionDatentypen.Stadtproduktion);
   
   function ZahlAlsStringLebenspunkte is new UmwandlungenAdaNachEigenes.ZahlAlsStringLeerzeichenEntfernen (GanzeZahl => EinheitenDatentypen.Lebenspunkte);
   
   function ZahlAlsStringKampfwerte is new UmwandlungenAdaNachEigenes.ZahlAlsStringLeerzeichenEntfernen (GanzeZahl => KampfDatentypen.Kampfwerte);
   
   function ZahlAlsStringArbeitszeit is new UmwandlungenAdaNachEigenes.ZahlAlsStringLeerzeichenEntfernen (GanzeZahl => ProduktionDatentypen.ArbeitszeitVorhanden);

end InformationenEinheitenSFML;
