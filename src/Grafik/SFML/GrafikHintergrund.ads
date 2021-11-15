pragma SPARK_Mode (On);

with Sf.Graphics;
with Sf.Graphics.Sprite;

with SystemDatentypen;

package GrafikHintergrund is

   procedure HintergrundMenü
     (WelchesMenüExtern : in SystemDatentypen.Welches_Menü_Enum);
     
private
   
   WelchesBild : Positive;

   Sprite : Sf.Graphics.sfSprite_Ptr := Sf.Graphics.Sprite.create;
      
   procedure HintergrundbildLaden
     (WelchesMenüExtern : in SystemDatentypen.Welches_Menü_Enum);

end GrafikHintergrund;