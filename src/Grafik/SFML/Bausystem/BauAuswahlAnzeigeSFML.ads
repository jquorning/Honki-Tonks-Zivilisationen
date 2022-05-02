pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Sf.Graphics;
with Sf.Graphics.Text;
with Sf.Graphics.RectangleShape;
with Sf.System.Vector2;

with EinheitStadtDatentypen;
with EinheitStadtRecords;

with InDerStadtBauen;

package BauAuswahlAnzeigeSFML is

   procedure BauAuswahlAnzeige;

private

   SchriftartFestgelegt : Boolean := False;
   SchriftfarbeFestgelegt : Boolean := False;
   SchriftgrößeFestgelegt : Boolean := False;

   AktuelleAuswahl : EinheitStadtDatentypen.MinimimMaximumID;
   Ende : EinheitStadtDatentypen.MinimimMaximumID;

   WelcherTextKurz : Positive;
   WelcherTextLang : Positive;

   Zeilenabstand : Float;
   AbstandÜberschrift : Float;

   TextAccess : constant Sf.Graphics.sfText_Ptr := Sf.Graphics.Text.create;

   RechteckAccess : constant Sf.Graphics.sfRectangleShape_Ptr := Sf.Graphics.RectangleShape.create;

   MausZeigerPosition : Sf.System.Vector2.sfVector2i;

   StartPositionText : constant Sf.System.Vector2.sfVector2f := (5.00, 5.00);
   TextPosition : Sf.System.Vector2.sfVector2f;

   Bauliste : InDerStadtBauen.BaulisteArray;

   procedure WeiterenTextAnzeigen
     (WelcherTextExtern : in EinheitStadtRecords.BauprojektRecord);

end BauAuswahlAnzeigeSFML;
