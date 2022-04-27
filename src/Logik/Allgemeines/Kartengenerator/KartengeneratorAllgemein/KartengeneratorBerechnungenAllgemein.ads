pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KartenRecords;
with KartenDatentypen;
with KartengrundDatentypen;

package KartengeneratorBerechnungenAllgemein is
   
   type AnzahlGleicherFelder is range 0 .. 8;
   AnzahlGleicherGrundBestimmen : AnzahlGleicherFelder;

   function GleicherGrundAnzahlBestimmen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      GrundExtern : in KartengrundDatentypen.Kartengrund_Vorhanden_Enum;
      EbeneExtern : in KartenDatentypen.EbeneVorhanden)
      return AnzahlGleicherFelder;
   
private
   
   KartenWert : KartenRecords.AchsenKartenfeldPositivRecord;

end KartengeneratorBerechnungenAllgemein;