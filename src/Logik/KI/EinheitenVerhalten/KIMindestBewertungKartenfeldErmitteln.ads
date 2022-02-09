pragma SPARK_Mode (On);

with SystemDatentypen; use SystemDatentypen;
with GlobaleVariablen;
with EinheitStadtRecords;
with KartenRecords;
with KartenDatentypen;
with SystemKonstanten;

package KIMindestBewertungKartenfeldErmitteln is

   function MindestBewertungKartenfeldStadtBauen
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
      return KartenDatentypen.GesamtbewertungFeld
     with
       Pre =>
         (EinheitRasseNummerExtern.Platznummer in GlobaleVariablen.EinheitenGebautArray'First (2) .. GlobaleVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
          and
            GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) = SystemKonstanten.SpielerKIKonstante);
   
private
   
   MindestBewertungKartenfeld : KartenDatentypen.GesamtbewertungFeld;
   
   KartenWert : KartenRecords.AchsenKartenfeldPositivRecord;

end KIMindestBewertungKartenfeldErmitteln;