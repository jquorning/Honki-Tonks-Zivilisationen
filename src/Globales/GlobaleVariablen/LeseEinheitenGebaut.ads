pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with RassenDatentypen; use RassenDatentypen;
with EinheitStadtDatentypen; use EinheitStadtDatentypen;
with KartenDatentypen;
with EinheitStadtRecords;
with SpielVariablen;
with KartenRecords;
with AufgabenDatentypen;
with SonstigeVariablen;
with EinheitenRecords;

with KIDatentypen;

package LeseEinheitenGebaut is

   function ID
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RasseEinheitnummerRecord)
      return EinheitStadtDatentypen.EinheitenIDMitNullWert
     with
       Pre =>
         (EinheitRasseNummerExtern.Nummer in SpielVariablen.EinheitenGebautArray'First (2) .. SpielVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
          and
            SonstigeVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) /= RassenDatentypen.Leer_Spieler_Enum);

   function Koordinaten
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RasseEinheitnummerRecord)
      return KartenRecords.AchsenKartenfeldPositivRecord
     with
       Pre =>
         (EinheitRasseNummerExtern.Nummer in SpielVariablen.EinheitenGebautArray'First (2) .. SpielVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
          and
            SonstigeVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) /= RassenDatentypen.Leer_Spieler_Enum);
   
   function Heimatstadt
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RasseEinheitnummerRecord)
      return EinheitStadtDatentypen.MaximaleStädteMitNullWert
     with
       Pre =>
         (EinheitRasseNummerExtern.Nummer in SpielVariablen.EinheitenGebautArray'First (2) .. SpielVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
          and
            SonstigeVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) /= RassenDatentypen.Leer_Spieler_Enum);
      
   function Lebenspunkte
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RasseEinheitnummerRecord)
      return EinheitStadtDatentypen.Lebenspunkte
     with
       Pre =>
         (EinheitRasseNummerExtern.Nummer in SpielVariablen.EinheitenGebautArray'First (2) .. SpielVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
          and
            SonstigeVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) /= RassenDatentypen.Leer_Spieler_Enum);
   
   function Bewegungspunkte
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RasseEinheitnummerRecord)
      return EinheitStadtDatentypen.VorhandeneBewegungspunkte
     with
       Pre =>
         (EinheitRasseNummerExtern.Nummer in SpielVariablen.EinheitenGebautArray'First (2) .. SpielVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
          and
            SonstigeVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) /= RassenDatentypen.Leer_Spieler_Enum);
   
   function Erfahrungspunkte
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RasseEinheitnummerRecord)
      return EinheitStadtDatentypen.Kampfwerte
     with
       Pre =>
         (EinheitRasseNummerExtern.Nummer in SpielVariablen.EinheitenGebautArray'First (2) .. SpielVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
          and
            SonstigeVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) /= RassenDatentypen.Leer_Spieler_Enum);
   
   function Rang
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RasseEinheitnummerRecord)
      return EinheitStadtDatentypen.Kampfwerte
     with
       Pre =>
         (EinheitRasseNummerExtern.Nummer in SpielVariablen.EinheitenGebautArray'First (2) .. SpielVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
          and
            SonstigeVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) /= RassenDatentypen.Leer_Spieler_Enum);
      
   function Beschäftigung
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RasseEinheitnummerRecord)
      return AufgabenDatentypen.Einheiten_Aufgaben_Enum
     with
       Pre =>
         (EinheitRasseNummerExtern.Nummer in SpielVariablen.EinheitenGebautArray'First (2) .. SpielVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
          and
            SonstigeVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) /= RassenDatentypen.Leer_Spieler_Enum);
   
   function BeschäftigungNachfolger
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RasseEinheitnummerRecord)
      return AufgabenDatentypen.Einheiten_Aufgaben_Enum
     with
       Pre =>
         (EinheitRasseNummerExtern.Nummer in SpielVariablen.EinheitenGebautArray'First (2) .. SpielVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
          and
            SonstigeVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) /= RassenDatentypen.Leer_Spieler_Enum);
      
   function Beschäftigungszeit
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RasseEinheitnummerRecord)
      return EinheitStadtDatentypen.MaximaleStädteMitNullWert
     with
       Pre =>
         (EinheitRasseNummerExtern.Nummer in SpielVariablen.EinheitenGebautArray'First (2) .. SpielVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
          and
            SonstigeVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) /= RassenDatentypen.Leer_Spieler_Enum);
   
   function BeschäftigungszeitNachfolger
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RasseEinheitnummerRecord)
      return EinheitStadtDatentypen.MaximaleStädteMitNullWert
     with
       Pre =>
         (EinheitRasseNummerExtern.Nummer in SpielVariablen.EinheitenGebautArray'First (2) .. SpielVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
          and
            SonstigeVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) /= RassenDatentypen.Leer_Spieler_Enum);
      
   function KIZielKoordinaten
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RasseEinheitnummerRecord)
      return KartenRecords.AchsenKartenfeldPositivRecord
     with
       Pre =>
         (EinheitRasseNummerExtern.Nummer in SpielVariablen.EinheitenGebautArray'First (2) .. SpielVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
          and
            SonstigeVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) /= RassenDatentypen.Leer_Spieler_Enum);
   
   function KIBeschäftigt
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RasseEinheitnummerRecord)
      return KIDatentypen.Einheit_Aufgabe_Enum
     with
       Pre =>
         (EinheitRasseNummerExtern.Nummer in SpielVariablen.EinheitenGebautArray'First (2) .. SpielVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
          and
            SonstigeVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) /= RassenDatentypen.Leer_Spieler_Enum);
   
   function KIBewegungPlan
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RasseEinheitnummerRecord;
      PlanschrittExtern : in KartenDatentypen.Stadtfeld)
      return KartenRecords.AchsenKartenfeldPositivRecord
     with
       Pre =>
         (EinheitRasseNummerExtern.Nummer in SpielVariablen.EinheitenGebautArray'First (2) .. SpielVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
          and
            SonstigeVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) /= RassenDatentypen.Leer_Spieler_Enum);
      
   function Transportiert
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RasseEinheitnummerRecord;
      PlatzExtern : in EinheitStadtDatentypen.Transportplätze)
      return EinheitStadtDatentypen.MaximaleEinheitenMitNullWert
     with
       Pre =>
         (EinheitRasseNummerExtern.Nummer in SpielVariablen.EinheitenGebautArray'First (2) .. SpielVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
          and
            SonstigeVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) /= RassenDatentypen.Leer_Spieler_Enum);
   
   function WirdTransportiert
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RasseEinheitnummerRecord)
      return EinheitStadtDatentypen.MaximaleEinheitenMitNullWert
     with
       Pre =>
         (EinheitRasseNummerExtern.Nummer in SpielVariablen.EinheitenGebautArray'First (2) .. SpielVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
          and
            SonstigeVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) /= RassenDatentypen.Leer_Spieler_Enum);
      
   function Meldungen
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RasseEinheitnummerRecord;
      WelcheMeldungExtern : in EinheitStadtDatentypen.Einheit_Meldung_Art_Enum)
      return EinheitStadtDatentypen.Einheit_Meldung_Enum
     with
       Pre =>
         (EinheitRasseNummerExtern.Nummer in SpielVariablen.EinheitenGebautArray'First (2) .. SpielVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
          and
            SonstigeVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) /= RassenDatentypen.Leer_Spieler_Enum);
   
   function GanzerEintrag
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RasseEinheitnummerRecord)
      return EinheitenRecords.EinheitenGebautRecord
     with
       Pre =>
         (EinheitRasseNummerExtern.Nummer in SpielVariablen.EinheitenGebautArray'First (2) .. SpielVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
          and
            SonstigeVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) /= RassenDatentypen.Leer_Spieler_Enum);

end LeseEinheitenGebaut;
