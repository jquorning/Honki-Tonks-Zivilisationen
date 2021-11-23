pragma SPARK_Mode (On);

with Sf.System.Vector2;
with Sf.Graphics.Color;
with Sf.Graphics.RectangleShape;
with Sf.Graphics.CircleShape;

with SystemDatentypen; use SystemDatentypen;
with KartenDatentypen;
with KartenRecords;
with GlobaleVariablen;
with EinheitStadtRecords;

package KarteSFML is
   
   procedure KarteAnzeigen
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) = SystemDatentypen.Spieler_Mensch);
   
   
   
   function FarbeErmitteln
     (GrundExtern : in KartenDatentypen.Karten_Grund_Enum)
      return Sf.Graphics.Color.sfColor;
   
private
   
   YSichtAnfang : KartenDatentypen.Kartenfeld;
   YSichtEnde : KartenDatentypen.Kartenfeld;
   XSichtAnfang : KartenDatentypen.Kartenfeld;
   XSichtEnde : KartenDatentypen.Kartenfeld;
   
   SichtbereichAnfangEnde : KartenDatentypen.SichtbereichAnfangEndeArray;
   
   YMultiplikator : Float;
   XMultiplikator : Float;
   
   EinheitStadtRasseNummer : EinheitStadtRecords.RassePlatznummerRecord;
   
   Position : Sf.System.Vector2.sfVector2f;
   
   KartenWert : KartenRecords.AchsenKartenfeldPositivRecord;

   RechteckZugriff : constant Sf.Graphics.sfRectangleShape_Ptr := Sf.Graphics.RectangleShape.create;

   KreisZugriff : constant Sf.Graphics.sfCircleShape_Ptr := Sf.Graphics.CircleShape.create;
   PolygonZugriff : constant Sf.Graphics.sfCircleShape_Ptr := Sf.Graphics.CircleShape.create;
   
   procedure Sichtbarkeit
     (InDerStadtExtern : in Boolean;
      RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) = SystemDatentypen.Spieler_Mensch);
   
   procedure IstSichtbar
     (InDerStadtExtern : in Boolean;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum);

   procedure AnzeigeLandschaft
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord);
   
   procedure KartenfeldZeichnen
     (FarbeExtern : in Sf.Graphics.Color.sfColor;
      PositionZeichnenExtern : in Sf.System.Vector2.sfVector2f;
      AbmessungExtern : in Sf.System.Vector2.sfVector2f);
   
   procedure KreisZeichnen
     (FarbeExtern : in Sf.Graphics.Color.sfColor;
      PositionZeichnenExtern : in Sf.System.Vector2.sfVector2f;
      RadiusExtern : in Float);
   
   procedure PolygonZeichnen
     (FarbeExtern : in Sf.Graphics.Color.sfColor;
      PositionZeichnenExtern : in Sf.System.Vector2.sfVector2f;
      RadiusExtern : in Float;
      AnzahlEckenExtern : in Sf.sfSize_t);

   procedure AnzeigeStadt
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord);

   procedure AnzeigeEinheit
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord);

   procedure AnzeigeCursor
     (InDerStadtExtern : in Boolean;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum);

end KarteSFML;
