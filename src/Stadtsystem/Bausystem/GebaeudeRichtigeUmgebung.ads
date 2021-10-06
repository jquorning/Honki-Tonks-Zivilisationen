pragma SPARK_Mode (On);

with SonstigeDatentypen; use SonstigeDatentypen;
with EinheitStadtRecords;
with EinheitStadtDatentypen;
with GlobaleVariablen;
with KartenRecords;

package GebaeudeRichtigeUmgebung is

   function RichtigeUmgebungVorhanden
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      GebäudeIDExtern : in EinheitStadtDatentypen.GebäudeID)
      return Boolean
     with
       Pre =>
         (StadtRasseNummerExtern.Platznummer in GlobaleVariablen.StadtGebautArray'First (2) .. GlobaleVariablen.Grenzen (StadtRasseNummerExtern.Rasse).Städtegrenze
          and
            GlobaleVariablen.RassenImSpiel (StadtRasseNummerExtern.Rasse) /= SonstigeDatentypen.Leer);
   
private
   
   KartenWert : KartenRecords.AchsenKartenfeldPositivRecord;
   
   function UmgebungPrüfen
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      GebäudeIDExtern : in EinheitStadtDatentypen.GebäudeID)
      return Boolean;

end GebaeudeRichtigeUmgebung;
