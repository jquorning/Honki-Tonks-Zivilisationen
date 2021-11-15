pragma SPARK_Mode (On);

with Sf.Graphics.RenderWindow;

with GrafikEinstellungen;
with EingeleseneTexturen;

package body GrafikHintergrund is

   procedure HintergrundMenü
     (WelchesMenüExtern : in SystemDatentypen.Welches_Menü_Enum)
   is begin
      
      HintergrundbildLaden (WelchesMenüExtern => WelchesMenüExtern);
      
      Sf.Graphics.Sprite.setTexture (sprite  => Sprite,
                                     texture => EingeleseneTexturen.Hintergrund (WelchesBild));
      Sf.Graphics.RenderWindow.drawSprite (renderWindow => GrafikEinstellungen.Fenster,
                                           object       => Sprite);
      
   end HintergrundMenü;
   
   
   
   procedure HintergrundbildLaden
     (WelchesMenüExtern : in SystemDatentypen.Welches_Menü_Enum)
   is begin
      
      case
        WelchesMenüExtern
      is
         when SystemDatentypen.Haupt_Menü =>
            WelchesBild := 1;
            
         when others =>
            WelchesBild := 2;
      end case;
      
   end HintergrundbildLaden;

end GrafikHintergrund;