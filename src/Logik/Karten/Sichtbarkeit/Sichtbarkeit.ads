pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with RassenDatentypen; use RassenDatentypen;
with KartenDatentypen; use KartenDatentypen;
with EinheitStadtRecords;
with SpielVariablen;
with KartenRecords;
with KartenGrundDatentypen;
with SonstigeVariablen;

with Karten;

package Sichtbarkeit is

   procedure SichtbarkeitsprüfungFürEinheit
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
     with
       Pre =>
         (EinheitRasseNummerExtern.Platznummer in SpielVariablen.EinheitenGebautArray'First (2) .. SpielVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
          and
            SonstigeVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) /= RassenDatentypen.Leer_Spieler_Enum);

   procedure SichtbarkeitsprüfungFürStadt
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
     with
       Pre =>
         (StadtRasseNummerExtern.Platznummer in SpielVariablen.StadtGebautArray'First (2) .. SpielVariablen.Grenzen (StadtRasseNummerExtern.Rasse).Städtegrenze
          and
            SonstigeVariablen.RassenImSpiel (StadtRasseNummerExtern.Rasse) /= RassenDatentypen.Leer_Spieler_Enum);

   procedure SichtbarkeitSetzen
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord)
     with
       Pre =>
         (KoordinatenExtern.YAchse in Karten.WeltkarteArray'First (2) .. Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).YAchsenGröße
          and
            KoordinatenExtern.XAchse in Karten.WeltkarteArray'First (3) .. Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).XAchsenGröße
          and
            SonstigeVariablen.RassenImSpiel (RasseExtern) /= RassenDatentypen.Leer_Spieler_Enum);

private

   BereitsGetestet : KartenDatentypen.UmgebungsbereichZwei;
   Umgebung : KartenDatentypen.UmgebungsbereichDrei;

   SichtweiteObjekt : KartenDatentypen.Sichtweite;

   AktuellerGrund : KartenGrundDatentypen.Karten_Grund_Alle_Felder_Enum;

   Wert : Integer;

   FremdeEinheitStadt : EinheitStadtRecords.RassePlatznummerRecord;

   KartenWert : KartenRecords.AchsenKartenfeldPositivRecord;
   KartenQuadrantWert : KartenRecords.AchsenKartenfeldPositivRecord;
   KartenBlockadeWert : KartenRecords.AchsenKartenfeldPositivRecord;
   KoordinatenEinheit : KartenRecords.AchsenKartenfeldPositivRecord;

   procedure SichtbarkeitsprüfungOhneBlockade
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      SichtweiteExtern : in KartenDatentypen.Sichtweite)
     with
       Pre =>
         (EinheitRasseNummerExtern.Platznummer in SpielVariablen.EinheitenGebautArray'First (2) .. SpielVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
          and
            SonstigeVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) /= RassenDatentypen.Leer_Spieler_Enum);

   procedure QuadrantenDurchlaufen
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord);

   procedure QuadrantEins
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      SichtweiteYRichtungExtern : in KartenDatentypen.SichtweiteMitNullwert;
      SichtweiteXRichtungExtern : in KartenDatentypen.SichtweiteMitNullwert;
      SichtweiteMaximalExtern : in KartenDatentypen.Sichtweite);

   procedure QuadrantZwei
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      SichtweiteYRichtungExtern : in KartenDatentypen.SichtweiteMitNullwert;
      SichtweiteXRichtungExtern : in KartenDatentypen.SichtweiteMitNullwert;
      SichtweiteMaximalExtern : in KartenDatentypen.Sichtweite);

   procedure QuadrantDrei
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      SichtweiteYRichtungExtern : in KartenDatentypen.SichtweiteMitNullwert;
      SichtweiteXRichtungExtern : in KartenDatentypen.SichtweiteMitNullwert;
      SichtweiteMaximalExtern : in KartenDatentypen.Sichtweite);

   procedure QuadrantVier
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      SichtweiteYRichtungExtern : in KartenDatentypen.SichtweiteMitNullwert;
      SichtweiteXRichtungExtern : in KartenDatentypen.SichtweiteMitNullwert;
      SichtweiteMaximalExtern : in KartenDatentypen.Sichtweite);



   function SichtweiteErmitteln
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
      return KartenDatentypen.Sichtweite
     with
       Pre =>
         (EinheitRasseNummerExtern.Platznummer in SpielVariablen.EinheitenGebautArray'First (2) .. SpielVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
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
         (KoordinatenExtern.YAchse in Karten.WeltkarteArray'First (2) .. Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).YAchsenGröße
          and
            KoordinatenExtern.XAchse in Karten.WeltkarteArray'First (3) .. Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).XAchsenGröße);

end Sichtbarkeit;
