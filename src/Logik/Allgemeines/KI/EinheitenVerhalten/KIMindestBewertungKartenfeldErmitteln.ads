pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with RassenDatentypen; use RassenDatentypen;
with SonstigeVariablen;
with EinheitenRecords;
with KartenRecords;
with KartenDatentypen;
with SpielVariablen;

package KIMindestBewertungKartenfeldErmitteln is

   function MindestBewertungKartenfeldStadtBauen
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return KartenDatentypen.GesamteFeldbewertung
     with
       Pre =>
         (EinheitRasseNummerExtern.Nummer in SpielVariablen.EinheitenGebautArray'First (2) .. SpielVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
          and
            SonstigeVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) = RassenDatentypen.Spieler_KI_Enum);
   
private
   
   MindestBewertungKartenfeld : KartenDatentypen.GesamteFeldbewertung;
   
   KartenWert : KartenRecords.AchsenKartenfeldNaturalRecord;

end KIMindestBewertungKartenfeldErmitteln;
