pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with RassenDatentypen; use RassenDatentypen;
with KartenDatentypen; use KartenDatentypen;
with EinheitStadtRecords;
with SpielVariablen;
with KartenRecords;
with KartengrundDatentypen;
with SonstigeVariablen;

with Karten;

package Sichtbarkeit is

   procedure SichtbarkeitsprüfungFürEinheit
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RasseEinheitnummerRecord)
     with
       Pre =>
         (EinheitRasseNummerExtern.Nummer in SpielVariablen.EinheitenGebautArray'First (2) .. SpielVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
          and
            SonstigeVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) /= RassenDatentypen.Leer_Spieler_Enum);

   procedure SichtbarkeitsprüfungFürStadt
     (StadtRasseNummerExtern : in EinheitStadtRecords.RasseEinheitnummerRecord)
     with
       Pre =>
         (StadtRasseNummerExtern.Nummer in SpielVariablen.StadtGebautArray'First (2) .. SpielVariablen.Grenzen (StadtRasseNummerExtern.Rasse).Städtegrenze
          and
            SonstigeVariablen.RassenImSpiel (StadtRasseNummerExtern.Rasse) /= RassenDatentypen.Leer_Spieler_Enum);

   procedure SichtbarkeitSetzen
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord)
     with
       Pre =>
         (KoordinatenExtern.YAchse in Karten.WeltkarteArray'First (2) .. Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).YAchse
          and
            KoordinatenExtern.XAchse in Karten.WeltkarteArray'First (3) .. Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).XAchse
          and
            SonstigeVariablen.RassenImSpiel (RasseExtern) /= RassenDatentypen.Leer_Spieler_Enum);

private

   BereitsGetestet : KartenDatentypen.UmgebungsbereichZwei;
   Umgebung : KartenDatentypen.UmgebungsbereichDrei;

   SichtweiteObjekt : KartenDatentypen.Sichtweite;

   AktuellerGrund : KartengrundDatentypen.Kartengrund_Vorhanden_Enum;

   Wert : Integer;

   FremdeEinheitStadt : EinheitStadtRecords.RasseEinheitnummerRecord;

   KartenWert : KartenRecords.AchsenKartenfeldPositivRecord;
   KartenQuadrantWert : KartenRecords.AchsenKartenfeldPositivRecord;
   KartenBlockadeWert : KartenRecords.AchsenKartenfeldPositivRecord;
   KoordinatenEinheit : KartenRecords.AchsenKartenfeldPositivRecord;

   procedure SichtbarkeitsprüfungOhneBlockade
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RasseEinheitnummerRecord;
      SichtweiteExtern : in KartenDatentypen.Sichtweite)
     with
       Pre =>
         (EinheitRasseNummerExtern.Nummer in SpielVariablen.EinheitenGebautArray'First (2) .. SpielVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
          and
            SonstigeVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) /= RassenDatentypen.Leer_Spieler_Enum);

   procedure QuadrantenDurchlaufen
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RasseEinheitnummerRecord);

   procedure QuadrantEins
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RasseEinheitnummerRecord;
      SichtweiteYRichtungExtern : in KartenDatentypen.SichtweiteMitNullwert;
      SichtweiteXRichtungExtern : in KartenDatentypen.SichtweiteMitNullwert;
      SichtweiteMaximalExtern : in KartenDatentypen.Sichtweite);

   procedure QuadrantZwei
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RasseEinheitnummerRecord;
      SichtweiteYRichtungExtern : in KartenDatentypen.SichtweiteMitNullwert;
      SichtweiteXRichtungExtern : in KartenDatentypen.SichtweiteMitNullwert;
      SichtweiteMaximalExtern : in KartenDatentypen.Sichtweite);

   procedure QuadrantDrei
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RasseEinheitnummerRecord;
      SichtweiteYRichtungExtern : in KartenDatentypen.SichtweiteMitNullwert;
      SichtweiteXRichtungExtern : in KartenDatentypen.SichtweiteMitNullwert;
      SichtweiteMaximalExtern : in KartenDatentypen.Sichtweite);

   procedure QuadrantVier
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RasseEinheitnummerRecord;
      SichtweiteYRichtungExtern : in KartenDatentypen.SichtweiteMitNullwert;
      SichtweiteXRichtungExtern : in KartenDatentypen.SichtweiteMitNullwert;
      SichtweiteMaximalExtern : in KartenDatentypen.Sichtweite);



   function SichtweiteErmitteln
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RasseEinheitnummerRecord)
      return KartenDatentypen.Sichtweite
     with
       Pre =>
         (EinheitRasseNummerExtern.Nummer in SpielVariablen.EinheitenGebautArray'First (2) .. SpielVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
          and
            SonstigeVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) /= RassenDatentypen.Leer_Spieler_Enum);

   function SichtbarkeitBlockadeTesten
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      YÄnderungExtern : in KartenDatentypen.UmgebungsbereichZwei;
      XÄnderungExtern : in KartenDatentypen.UmgebungsbereichZwei;
      SichtweiteExtern : in KartenDatentypen.UmgebungsbereichDrei)
      return Boolean
     with
       Pre =>
         (KoordinatenExtern.YAchse in Karten.WeltkarteArray'First (2) .. Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).YAchse
          and
            KoordinatenExtern.XAchse in Karten.WeltkarteArray'First (3) .. Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).XAchse);

end Sichtbarkeit;