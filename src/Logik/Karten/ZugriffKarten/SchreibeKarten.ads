pragma SPARK_Mode (On);

with KartenDatentypen; use KartenDatentypen;
with SystemDatentypen; use SystemDatentypen;
with GlobaleVariablen;
with KartenRecords;
with SystemKonstanten;

with Karten;

package SchreibeKarten is

   procedure Grund
     (PositionExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      GrundExtern : in KartenDatentypen.Karten_Grund_Enum)
     with
       Pre =>
         (PositionExtern.YAchse <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße
          and
            PositionExtern.XAchse <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße
          and
            GrundExtern /= KartenDatentypen.Leer);
   
   procedure Hügel
     (PositionExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      HügelExtern : in Boolean)
     with
       Pre =>
         (PositionExtern.YAchse <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße
          and
            PositionExtern.XAchse <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße);
   
   procedure Sichtbar
     (PositionExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum;
      SichtbarExtern : in Boolean)
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) /= SystemKonstanten.LeerSpielerKonstante
          and
            PositionExtern.YAchse <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße
          and
            PositionExtern.XAchse <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße);

   procedure Fluss
     (PositionExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      FlussExtern : in KartenDatentypen.Karten_Grund_Enum)
     with
       Pre =>
         (PositionExtern.YAchse <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße
          and
            PositionExtern.XAchse <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße
          and
            (FlussExtern = KartenDatentypen.Leer
             or
               FlussExtern in KartenDatentypen.Karten_Fluss_Enum));

   procedure VerbesserungWeg
     (PositionExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      WegExtern : in KartenDatentypen.Karten_Verbesserung_Enum)
     with
       Pre =>
         (PositionExtern.YAchse <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße
          and
            PositionExtern.XAchse <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße
          and
            (WegExtern = KartenDatentypen.Leer
             or
               WegExtern in KartenDatentypen.Karten_Weg_Enum));

   procedure VerbesserungGebiet
     (PositionExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      VerbesserungExtern : in KartenDatentypen.Karten_Verbesserung_Enum)
     with
       Pre =>
         (PositionExtern.YAchse <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße
          and
            PositionExtern.XAchse <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße
          and
            VerbesserungExtern not in KartenDatentypen.Karten_Weg_Enum);

   procedure Ressource
     (PositionExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      RessourceExtern : in KartenDatentypen.Karten_Grund_Enum)
     with
       Pre =>
         (PositionExtern.YAchse <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße
          and
            PositionExtern.XAchse <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße
          and
            RessourceExtern in KartenDatentypen.Karten_Grund_Ressourcen_Enum);

   procedure BelegterGrund
     (PositionExtern : KartenRecords.AchsenKartenfeldPositivRecord;
      BelegterGrundExtern : in KartenRecords.BelegterGrundRecord)
     with
       Pre =>
         (PositionExtern.YAchse <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße
          and
            PositionExtern.XAchse <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße);

   procedure Bewertung
     (PositionExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum;
      BewertungExtern : in KartenDatentypen.GesamtbewertungFeld)
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) /= SystemKonstanten.LeerSpielerKonstante
          and
            PositionExtern.YAchse <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße
          and
            PositionExtern.XAchse <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße);

end SchreibeKarten;