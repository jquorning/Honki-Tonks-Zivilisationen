pragma SPARK_Mode (On);

with KartenRecords; use KartenRecords;
with SonstigeDatentypen; use SonstigeDatentypen;
with KartenDatentypen; use KartenDatentypen;
with SystemDatentypen;
with EinheitStadtRecords;
with GlobaleVariablen;

with Karten;

package GrafischeAnzeige is

   procedure Sichtbarkeit
     (InDerStadtExtern : in Boolean;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
     with
       Pre =>
         (KoordinatenExtern.YAchse <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße
          and
            KoordinatenExtern.XAchse <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße
          and
            GlobaleVariablen.RassenImSpiel (RasseExtern) = SonstigeDatentypen.Spieler_Mensch);

private

   EinheitStadtRasseNummer : EinheitStadtRecords.RassePlatznummerRecord;

   procedure IstSichtbar
     (InDerStadtExtern : in Boolean;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum);

   procedure AnzeigeLandschaft
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum);



   function AnzeigeStadt
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
      return Boolean;

   function AnzeigeEinheit
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
      return Boolean;

   function AnzeigeCursor
     (InDerStadtExtern : in Boolean;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
      return Boolean;

end GrafischeAnzeige;
