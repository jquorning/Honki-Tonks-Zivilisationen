pragma SPARK_Mode (On);

with GlobaleRecords, GlobaleVariablen, GlobaleDatentypen;
use GlobaleDatentypen, GlobaleRecords;

with Karten;

package KIBewegungBerechnen is
   
   function BewegungPlanen
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
      return Boolean
     with
       Pre =>
         (EinheitRasseNummerExtern.Platznummer >= GlobaleVariablen.EinheitenGebautArray'First (2)
          and
            GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) = 2);
   
private
   
   PlanungErfolgreich : Boolean;
   
   BewertungPosition : Positive;
   
   ZielKoordinaten : GlobaleRecords.AchsenKartenfeldPositivRecord;
   
   KartenWert : GlobaleRecords.AchsenKartenfeldPositivRecord;
   KartenWertVereinfachung : GlobaleRecords.AchsenKartenfeldPositivRecord;
   
   type FeldBewertungArray is array (GlobaleDatentypen.LoopRangeMinusEinsZuEins'Range, GlobaleDatentypen.LoopRangeMinusEinsZuEins'Range) of Natural;
   FeldBewertung : FeldBewertungArray;
   
   type BewertungRecord is new GlobaleRecords.AchsenKartenfeldPositivRecord with record
      
      Bewertung : Natural;
      
   end record;
   
   Sortieren : BewertungRecord;
   
   type BewertungArray is array (1 .. 9) of BewertungRecord;
   Bewertung : BewertungArray;
   
   procedure VorhandenenPlanVereinfachen
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
     with
       Pre =>
         (EinheitRasseNummerExtern.Platznummer >= GlobaleVariablen.EinheitenGebautArray'First (2)
          and
            GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) = 2);
   
   procedure VorhandenenPlanVereinfachenPrüfen
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      ErsterZugExtern, ÜberNächsterZugExtern : in Positive)
     with
       Pre =>
         (EinheitRasseNummerExtern.Platznummer >= GlobaleVariablen.EinheitenGebautArray'First (2)
          and
            GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) = 2
          and
            ErsterZugExtern <= GlobaleRecords.KIBewegungPlanArray'Last
          and
            ÜberNächsterZugExtern <= GlobaleRecords.KIBewegungPlanArray'Last);
   
   
   
   function PlanenRekursiv
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      AktuelleKoordinatenExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord;
      AktuellePlanpositionExtern : in Positive)
      return Boolean
     with
       Pre =>
         (EinheitRasseNummerExtern.Platznummer >= GlobaleVariablen.EinheitenGebautArray'First (2)
          and
            AktuelleKoordinatenExtern.YAchse <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße
          and
            AktuelleKoordinatenExtern.XAchse <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße
          and
            GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) = 2);
   
   function BewertungFeldposition
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      KoordinatenExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord;
      YÄnderungExtern, XÄnderungExtern : in GlobaleDatentypen.LoopRangeMinusEinsZuEins)
      return Natural
     with
       Pre =>
         (EinheitRasseNummerExtern.Platznummer >= GlobaleVariablen.EinheitenGebautArray'First (2)
          and
            KoordinatenExtern.YAchse <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße
          and
            KoordinatenExtern.XAchse <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße
          and
            GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) = 2);
   
   function FeldBereitsBetreten
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      KoordinatenExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord)
      return Boolean
     with
       Pre =>
         (EinheitRasseNummerExtern.Platznummer >= GlobaleVariablen.EinheitenGebautArray'First (2)
          and
            KoordinatenExtern.YAchse <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße
          and
            KoordinatenExtern.XAchse <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße
          and
            GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) = 2);

end KIBewegungBerechnen;