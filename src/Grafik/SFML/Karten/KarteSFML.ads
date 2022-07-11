pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Ada.Calendar; use Ada.Calendar;

private with Sf.System.Vector2;
private with Sf.Graphics.Color;
private with Sf.Graphics.RectangleShape;
private with Sf.Graphics.CircleShape;
private with Sf.Graphics.Sprite;

with KartenDatentypen; use KartenDatentypen;
with RassenDatentypen; use RassenDatentypen;
with SpielVariablen;
with EinheitenRecords;

private with KartengrundDatentypen;
private with KartenVerbesserungDatentypen;
private with StadtRecords;
private with EinheitenDatentypen;
private with KartenRecords;

private with Karten;

package KarteSFML is
   
   procedure KarteAnzeigen
     (RasseEinheitExtern : in EinheitenRecords.RasseEinheitnummerRecord)
     with
       Pre => (
                 SpielVariablen.RassenImSpiel (RasseEinheitExtern.Rasse) = RassenDatentypen.Mensch_Spieler_Enum
              );
   
private
   
   AusgewählteEinheitAnzeigen : Boolean := True;
   
   AktuelleRasse : RassenDatentypen.Rassen_Enum;
   
   YSichtAnfang : KartenDatentypen.Kartenfeld;
   YSichtEnde : KartenDatentypen.Kartenfeld;
   XSichtAnfang : KartenDatentypen.Kartenfeld;
   XSichtEnde : KartenDatentypen.Kartenfeld;
   
   SichtbereichAnfangEnde : KartenDatentypen.SichtbereichAnfangEndeArray;
   
   AktuellerKartengrund : KartengrundDatentypen.Kartengrund_Enum;
   BasisKartengrund : KartengrundDatentypen.Kartengrund_Enum;
   KartenfeldFluss : KartengrundDatentypen.Kartenfluss_Enum;
   KartenfeldRessource : KartengrundDatentypen.Kartenressourcen_Enum;
   
   Stadtart : KartenVerbesserungDatentypen.Karten_Verbesserung_Stadt_ID_Enum;
   Wegfeld : KartenVerbesserungDatentypen.Karten_Weg_Enum;
   Verbesserungsfeld : KartenVerbesserungDatentypen.Karten_Verbesserung_Enum;
   
   EinheitID : EinheitenDatentypen.EinheitenID;
   
   DickeRahmen : constant Float := 5.00;
   YMultiplikator : Float;
   XMultiplikator : Float;
   
   ------------------- Intervall durch Nutzer einstellen lassen?
   BlinkIntervall : constant Day_Duration := 0.50;
   
   ZeitEins : Time := Clock;
   ZeitZwei : Time := Clock;
         
   StadtRasseNummer : StadtRecords.RasseStadtnummerRecord;
   
   EinheitRasseNummer : EinheitenRecords.RasseEinheitnummerRecord;
   
   AktuelleFarbe : Sf.Graphics.Color.sfColor;
   
   Position : Sf.System.Vector2.sfVector2f;
   
   KartenWert : KartenRecords.AchsenKartenfeldNaturalRecord;
   KartenWertRahmen : KartenRecords.AchsenKartenfeldNaturalRecord;
   KartenWertStadtname : KartenRecords.AchsenKartenfeldNaturalRecord;
   CursorKoordinatenAlt : KartenRecords.AchsenKartenfeldNaturalRecord;
      
   SpriteAccess : constant Sf.Graphics.sfSprite_Ptr := Sf.Graphics.Sprite.create;

   RechteckAccess : constant Sf.Graphics.sfRectangleShape_Ptr := Sf.Graphics.RectangleShape.create;
   RechteckBelegtesFeldAccess : constant Sf.Graphics.sfRectangleShape_Ptr := Sf.Graphics.RectangleShape.create;
   RechteckRahmenAccess : constant Sf.Graphics.sfRectangleShape_Ptr := Sf.Graphics.RectangleShape.create;

   KreisAccess : constant Sf.Graphics.sfCircleShape_Ptr := Sf.Graphics.CircleShape.create;
   PolygonAccess : constant Sf.Graphics.sfCircleShape_Ptr := Sf.Graphics.CircleShape.create;
   
   type Umgebung_Enum is (Norden, Westen, Osten, Süden);
   
   type UmgebungArray is array (Umgebung_Enum'Range) of KartenRecords.AchsenKartenfeldRecord;
   Umgebung : constant UmgebungArray := (
                                         Norden => (0, -1, 0),
                                         Westen => (0, 0, -1),
                                         Osten  => (0, 0, 1),
                                         Süden  => (0, 1, 0)
                                        );
   
   procedure Sichtbarkeit
     (RasseEinheitExtern : in EinheitenRecords.RasseEinheitnummerRecord)
     with
       Pre => (
                 SpielVariablen.RassenImSpiel (RasseEinheitExtern.Rasse) = RassenDatentypen.Mensch_Spieler_Enum
              );
   
   -- Hier die Benennung von RasseEinheitExtern auf EinheitRasseNummerExtern umschreiben. äöü
   procedure IstSichtbar
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      RasseEinheitExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      PositionExtern : in Sf.System.Vector2.sfVector2f)
     with
       Pre => (
                 SpielVariablen.RassenImSpiel (RasseEinheitExtern.Rasse) = RassenDatentypen.Mensch_Spieler_Enum
               and
                 KoordinatenExtern.YAchse <= Karten.Karteneinstellungen.Kartengröße.YAchse
               and
                 KoordinatenExtern.XAchse <= Karten.Karteneinstellungen.Kartengröße.XAchse
              );

   procedure AnzeigeLandschaft
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      PositionExtern : in Sf.System.Vector2.sfVector2f)
     with
       Pre => (
                 KoordinatenExtern.YAchse <= Karten.Karteneinstellungen.Kartengröße.YAchse
               and
                 KoordinatenExtern.XAchse <= Karten.Karteneinstellungen.Kartengröße.XAchse
              );

   procedure AnzeigeStadt
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      PositionExtern : in Sf.System.Vector2.sfVector2f)
     with
       Pre => (
                 KoordinatenExtern.YAchse <= Karten.Karteneinstellungen.Kartengröße.YAchse
               and
                 KoordinatenExtern.XAchse <= Karten.Karteneinstellungen.Kartengröße.XAchse
              );

   procedure AnzeigeEinheit
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      RasseEinheitExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      PositionExtern : in Sf.System.Vector2.sfVector2f)
     with
       Pre => (
               -- Anders als die /= RassenDatentypen.Leer_Spieler_Enum weiter unten, funktioniert das hier mit der KI weil nur die Spielerrasse übergeben wird und die KIEinheit in der Prozedur selbst gesucht wird.
                 SpielVariablen.RassenImSpiel (RasseEinheitExtern.Rasse) = RassenDatentypen.Mensch_Spieler_Enum
               and
                 KoordinatenExtern.YAchse <= Karten.Karteneinstellungen.Kartengröße.YAchse
               and
                 KoordinatenExtern.XAchse <= Karten.Karteneinstellungen.Kartengröße.XAchse
              );

   procedure AnzeigeCursor
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      PositionExtern : in Sf.System.Vector2.sfVector2f)
     with
       Pre => (
                 SpielVariablen.RassenImSpiel (RasseExtern) = RassenDatentypen.Mensch_Spieler_Enum
               and
                 KoordinatenExtern.YAchse <= Karten.Karteneinstellungen.Kartengröße.YAchse
               and
                 KoordinatenExtern.XAchse <= Karten.Karteneinstellungen.Kartengröße.XAchse
              );
   
   procedure AnzeigeFeldbesitzer
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      PositionExtern : in Sf.System.Vector2.sfVector2f)
     with
       Pre => (
                 KoordinatenExtern.YAchse <= Karten.Karteneinstellungen.Kartengröße.YAchse
               and
                 KoordinatenExtern.XAchse <= Karten.Karteneinstellungen.Kartengröße.XAchse
              );
   
   procedure RahmenBesetztesFeld
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      PositionExtern : in Sf.System.Vector2.sfVector2f;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
     with
       Pre => (
                 SpielVariablen.RassenImSpiel (RasseExtern) /= RassenDatentypen.Leer_Spieler_Enum
               and
                 KoordinatenExtern.YAchse <= Karten.Karteneinstellungen.Kartengröße.YAchse
               and
                 KoordinatenExtern.XAchse <= Karten.Karteneinstellungen.Kartengröße.XAchse
              );
   
   procedure RahmenZeichnen
     (WelcheRichtungExtern : in Umgebung_Enum;
      PositionExtern : in Sf.System.Vector2.sfVector2f;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
     with
       Pre => (
                 SpielVariablen.RassenImSpiel (RasseExtern) /= RassenDatentypen.Leer_Spieler_Enum
              );
   
   procedure KartenfeldZeichnen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      PositionExtern : in Sf.System.Vector2.sfVector2f)
     with
       Pre => (
                 KoordinatenExtern.YAchse <= Karten.Karteneinstellungen.Kartengröße.YAchse
               and
                 KoordinatenExtern.XAchse <= Karten.Karteneinstellungen.Kartengröße.XAchse
              );
   
   procedure FlussZeichnen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      PositionExtern : in Sf.System.Vector2.sfVector2f)
     with
       Pre => (
                 KoordinatenExtern.YAchse <= Karten.Karteneinstellungen.Kartengröße.YAchse
               and
                 KoordinatenExtern.XAchse <= Karten.Karteneinstellungen.Kartengröße.XAchse
              );
   
   procedure RessourceZeichnen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      PositionExtern : in Sf.System.Vector2.sfVector2f)
     with
       Pre => (
                 KoordinatenExtern.YAchse <= Karten.Karteneinstellungen.Kartengröße.YAchse
               and
                 KoordinatenExtern.XAchse <= Karten.Karteneinstellungen.Kartengröße.XAchse
              );
   
   procedure WegZeichnen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      PositionExtern : in Sf.System.Vector2.sfVector2f)
     with
       Pre => (
                 KoordinatenExtern.YAchse <= Karten.Karteneinstellungen.Kartengröße.YAchse
               and
                 KoordinatenExtern.XAchse <= Karten.Karteneinstellungen.Kartengröße.XAchse
              );
   
   procedure VerbesserungZeichnen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      PositionExtern : in Sf.System.Vector2.sfVector2f)
     with
       Pre => (
                 KoordinatenExtern.YAchse <= Karten.Karteneinstellungen.Kartengröße.YAchse
               and
                 KoordinatenExtern.XAchse <= Karten.Karteneinstellungen.Kartengröße.XAchse
              );
   
   procedure StadtnameAnzeigen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      PositionExtern : in Sf.System.Vector2.sfVector2f)
     with
       Pre => (
                 KoordinatenExtern.YAchse <= Karten.Karteneinstellungen.Kartengröße.YAchse
               and
                 KoordinatenExtern.XAchse <= Karten.Karteneinstellungen.Kartengröße.XAchse
              );
   
   
   
   function SpriteGezeichnet
     (TexturAccessExtern : in Sf.Graphics.sfTexture_Ptr;
      PositionExtern : in Sf.System.Vector2.sfVector2f)
      return Boolean;

end KarteSFML;
