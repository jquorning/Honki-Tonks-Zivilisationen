pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Sf.Graphics;
with Sf.System.Vector2;

private with Sf.Graphics.Sprite;
private with Sf.Graphics.Color;

with RassenDatentypen; use RassenDatentypen;
with SpielVariablen;
with GrafikDatentypen;

package HintergrundGrafik is

   procedure Hintergrund
     (HintergrundExtern : in GrafikDatentypen.Hintergrund_Enum;
      AbmessungenExtern : in Sf.System.Vector2.sfVector2f)
     with
       Pre => (
                 AbmessungenExtern.x >= 0.00
               and
                 AbmessungenExtern.y >= 0.00
              );

   procedure Rassenhintergrund
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      HintergrundExtern : in GrafikDatentypen.Rassenhintergrund_Enum;
      AbmessungenExtern : in Sf.System.Vector2.sfVector2f)
     with
       Pre => (
                 AbmessungenExtern.x >= 0.00
               and
                 AbmessungenExtern.y >= 0.00
               and
                 SpielVariablen.RassenImSpiel (RasseExtern) /= RassenDatentypen.Leer_Spieler_Enum
              );

private

   HintergrundSpriteAccess : constant Sf.Graphics.sfSprite_Ptr := Sf.Graphics.Sprite.create;
   RassenhintergrundSpriteAccess : constant Sf.Graphics.sfSprite_Ptr := Sf.Graphics.Sprite.create;

   Farbe : Sf.Graphics.Color.sfColor;

end HintergrundGrafik;