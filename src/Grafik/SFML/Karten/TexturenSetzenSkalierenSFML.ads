pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Sf.Graphics; use Sf.Graphics;
with Sf.System.Vector2;

package TexturenSetzenSkalierenSFML is

   function TexturenSetzenSkalierenWeltkarte
     (SpriteAccessExtern : in Sf.Graphics.sfSprite_Ptr;
      TextureAccessExtern : in Sf.Graphics.sfTexture_Ptr)
      return Sf.System.Vector2.sfVector2f
     with
       Pre => (
                 SpriteAccessExtern /= null
               and
                 TextureAccessExtern /= null
              ),
         
       Post => (
                  TexturenSetzenSkalierenWeltkarte'Result.x >= 0.00
                and
                  TexturenSetzenSkalierenWeltkarte'Result.y >= 0.00
               );

   function TexturenSetzenSkalierenStadtkarte
     (SpriteAccessExtern : in Sf.Graphics.sfSprite_Ptr;
      TextureAccessExtern : in Sf.Graphics.sfTexture_Ptr)
      return Sf.System.Vector2.sfVector2f
     with
       Pre => (
                 SpriteAccessExtern /= null
               and
                 TextureAccessExtern /= null
              ),
         
       Post => (
                  TexturenSetzenSkalierenStadtkarte'Result.x >= 0.00
                and
                  TexturenSetzenSkalierenStadtkarte'Result.y >= 0.00
               );
   
   function TexturenSetzenSkalierenGesamteStadtkarte
     (SpriteAccessExtern : in Sf.Graphics.sfSprite_Ptr;
      TextureAccessExtern : in Sf.Graphics.sfTexture_Ptr)
      return Sf.System.Vector2.sfVector2f
     with
       Pre => (
                 SpriteAccessExtern /= null
               and
                 TextureAccessExtern /= null
              ),
         
       Post => (
                  TexturenSetzenSkalierenGesamteStadtkarte'Result.x >= 0.00
                and
                  TexturenSetzenSkalierenGesamteStadtkarte'Result.y >= 0.00
               );
   
   function TexturenSetzenSkalierenGesamtesBild
     (SpriteAccessExtern : in Sf.Graphics.sfSprite_Ptr;
      TextureAccessExtern : in Sf.Graphics.sfTexture_Ptr)
      return Sf.System.Vector2.sfVector2f
     with
       Pre => (
                 SpriteAccessExtern /= null
               and
                 TextureAccessExtern /= null
              ),
         
       Post => (
                  TexturenSetzenSkalierenGesamtesBild'Result.x >= 0.00
                and
                  TexturenSetzenSkalierenGesamtesBild'Result.y >= 0.00
               );
   
   function TexturenSetzenSkalierenTeilBild
     (SpriteAccessExtern : in Sf.Graphics.sfSprite_Ptr;
      TextureAccessExtern : in Sf.Graphics.sfTexture_Ptr;
      VerhältnisExtern : in Sf.System.Vector2.sfVector2f)
      return Sf.System.Vector2.sfVector2f
     with
       Pre => (
                 SpriteAccessExtern /= null
               and
                 TextureAccessExtern /= null
              ),
         
       Post => (
                  TexturenSetzenSkalierenTeilBild'Result.x >= 0.00
                and
                  TexturenSetzenSkalierenTeilBild'Result.y >= 0.00
               );
   
private
   
   SkalierungKartenfeld : Sf.System.Vector2.sfVector2f;
   SkalierungBild : Sf.System.Vector2.sfVector2f;
   
   GrößeTextur : Sf.System.Vector2.sfVector2f;
   KartenfelderAbmessung : Sf.System.Vector2.sfVector2f;
   StadtfelderAbmessung : Sf.System.Vector2.sfVector2f;
   StadtAbmessung : Sf.System.Vector2.sfVector2f;
   GrößeGesamtbild : Sf.System.Vector2.sfVector2f;

end TexturenSetzenSkalierenSFML;
