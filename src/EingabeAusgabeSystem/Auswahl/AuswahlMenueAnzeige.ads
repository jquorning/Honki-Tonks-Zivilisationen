pragma SPARK_Mode (On);

with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

with Sf.System.Vector2;
with Sf.Graphics;
with Sf.Graphics.Text;
with Sf.Graphics.Color;

with SystemDatentypen;

package AuswahlMenueAnzeige is

   procedure AnzeigeSFMLAnfang;
   
private
   
   WelchesMenü : SystemDatentypen.Welches_Menü_Enum;
   
   Anfang : Positive;
   Ende : Positive;
   AktuelleAuswahl : Positive;
   RassenBelegt : Positive;
   RassenBelegtZähler : Positive;
   ErstesZeichen : Positive;

   AnzeigeStartwert : Natural;
   
   StartPositionYAchse : constant Float := 10.00;
   StartPositionXAchse : constant Float := 10.00;
   YPosition : Float;
   ZeilenAbstand : Float;
   
   AktuellerText : Unbounded_Wide_Wide_String;
   
   AktuellePosition : Sf.System.Vector2.sfVector2f;
   
   AktuelleFarbe : Sf.Graphics.Color.sfColor;
   
   TextZugriff : Sf.Graphics.sfText_Ptr := Sf.Graphics.Text.create;
   
   procedure AnzeigeMenüSFML;
   procedure Überschrift;
   procedure WeiterenTextAnzeigen;
   
   procedure AnzeigeFarbeBestimmen
     (TextZeileExtern : in Positive);

end AuswahlMenueAnzeige;
