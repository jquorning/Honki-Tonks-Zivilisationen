pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Sf.Graphics;
with Sf.Graphics.Sprite;
with Sf.System.Vector2;

with MenueDatentypen;
with GrafikDatentypen;

package HintergrundSFML is

   procedure StandardHintergrund
     (StandardHintergrundExtern : in GrafikDatentypen.Standard_Texturen_Enum);

   procedure MenüHintergrund
     (WelchesMenüExtern : in MenueDatentypen.Welches_Menü_Vorhanden_Enum;
      SpriteAccessExtern : in Sf.Graphics.sfSprite_Ptr);

private

   Nullposition : constant Sf.System.Vector2.sfVector2f := (0.00, 0.00);

   StandardspriteAccess : constant Sf.Graphics.sfSprite_Ptr := Sf.Graphics.Sprite.create;

end HintergrundSFML;