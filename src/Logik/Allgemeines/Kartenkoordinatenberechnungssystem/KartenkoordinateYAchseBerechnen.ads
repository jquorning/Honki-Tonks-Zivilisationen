pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KartenDatentypen; use KartenDatentypen;

with Karten;

package KartenkoordinateYAchseBerechnen is
   
   type WelcheVerschiebungYAchseArray is array (Boolean'Range, KartenDatentypen.EbeneVorhanden'Range) of KartenDatentypen.Kartenform_Y_Einstellbar_Enum;
   WelcheVerschiebungYAchse : WelcheVerschiebungYAchseArray;

   function KartenkoordinateYAchseBerechnen
     (YAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      ÄnderungYAchseExtern : in KartenDatentypen.Kartenfeld;
      ArrayPositionExtern : in KartenDatentypen.EbeneVorhanden;
      LogikGrafikExtern : in Boolean)
      return KartenDatentypen.KartenfeldPositivMitNullwert
     with
       Pre =>
         (YAchseExtern <= Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).YAchse),
           
         Post =>
           (KartenkoordinateYAchseBerechnen'Result <= Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).YAchse);
   
   function YAchseVerschieben
     (YAchseExtern : in KartenDatentypen.KartenfeldPositiv)
      return KartenDatentypen.KartenfeldPositiv
     with
       Pre =>
         (YAchseExtern <= Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).YAchse),
           
         Post =>
           (YAchseVerschieben'Result <= Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).YAchse);
   
private
   
   --------------------- Achsenverschiebung einstellbar machen?
   HalberWert : constant Float := 0.50;
   
   type ÜberhangArray is array (Boolean'Range, KartenDatentypen.EbeneVorhanden'Range) of Integer;
   ÜberhangYAchse : ÜberhangArray;
   
   function ÜbergangNorden
     (YAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      ÄnderungYAchseExtern : in KartenDatentypen.Kartenfeld;
      ArrayPositionExtern : in KartenDatentypen.EbeneVorhanden;
      LogikGrafikExtern : in Boolean)
      return KartenDatentypen.KartenfeldPositivMitNullwert
     with
       Pre =>
         (YAchseExtern <= Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).YAchse),
           
         Post =>
           (ÜbergangNorden'Result <= Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).YAchse);
   
   function ÜbergangNordenNormal
     (YAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      ÄnderungYAchseExtern : in KartenDatentypen.Kartenfeld;
      ArrayPositionExtern : in KartenDatentypen.EbeneVorhanden;
      LogikGrafikExtern : in Boolean)
      return KartenDatentypen.KartenfeldPositiv
     with
       Pre =>
         (YAchseExtern <= Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).YAchse),
           
         Post =>
           (ÜbergangNordenNormal'Result <= Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).YAchse);
   
   function ÜbergangNordenRückwärts
     (YAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      ÄnderungYAchseExtern : in KartenDatentypen.Kartenfeld)
      return KartenDatentypen.KartenfeldPositiv
     with
       Pre =>
         (YAchseExtern <= Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).YAchse),
           
         Post =>
           (ÜbergangNordenRückwärts'Result <= Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).YAchse);
   
   function ÜbergangSüden
     (YAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      ÄnderungYAchseExtern : in KartenDatentypen.Kartenfeld;
      ArrayPositionExtern : in KartenDatentypen.EbeneVorhanden;
      LogikGrafikExtern : in Boolean)
      return KartenDatentypen.KartenfeldPositivMitNullwert
     with
       Pre =>
         (YAchseExtern <= Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).YAchse),
           
         Post =>
           (ÜbergangSüden'Result <= Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).YAchse);
   
   function ÜbergangSüdenNormal
     (YAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      ÄnderungYAchseExtern : in KartenDatentypen.Kartenfeld;
      ArrayPositionExtern : in KartenDatentypen.EbeneVorhanden;
      LogikGrafikExtern : in Boolean)
      return KartenDatentypen.KartenfeldPositiv
     with
       Pre =>
         (YAchseExtern <= Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).YAchse),
           
         Post =>
           (ÜbergangSüdenNormal'Result <= Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).YAchse);
   
   function ÜbergangSüdenRückwärts
     (YAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      ÄnderungYAchseExtern : in KartenDatentypen.KartenfeldPositiv)
      return KartenDatentypen.KartenfeldPositiv
     with
       Pre =>
         (YAchseExtern <= Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).YAchse),
           
         Post =>
           (ÜbergangSüdenRückwärts'Result <= Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).YAchse);

end KartenkoordinateYAchseBerechnen;
