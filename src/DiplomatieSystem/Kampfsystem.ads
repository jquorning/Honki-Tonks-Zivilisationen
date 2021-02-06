pragma SPARK_Mode (On);

with Ada.Numerics.Float_Random;
use Ada.Numerics.Float_Random;

with GlobaleDatentypen;
use GlobaleDatentypen;

package Kampfsystem is

   function KampfsystemNahkampf (RasseAngriff, RasseVerteidigung : in GlobaleDatentypen.Rassen; GegnerStadtNummer, EinheitenNummerAngriff, EinheitenNummerVerteidigung : in Integer) return Boolean with
     Pre => RasseAngriff /= RasseVerteidigung;

private

   Ergebnis : Boolean;

   Gewählt : Generator;

   VerteidigungBonusDurchStadt : Float;
   VerteidigerBonus : constant Float := 1.25;
   VerteidigungVerteidigungWert : Float;
   VerteidigungAngriffWert : Float;
   AngriffAngriffWert : Float;
   AngriffVerteidigungWert : Float;
   Wert : Float;

   procedure KampfBerechnung (RasseVerteidigung : in GlobaleDatentypen.Rassen; EinheitNummerVerteidigung : in Positive; AngriffWert, VerteidigungWert : in Float);

   function Kampf (RasseAngriff, RasseVerteidigung : in GlobaleDatentypen.Rassen; EinheitenNummerAngriff, EinheitenNummerVerteidigung : in Positive; VerteidigungBonus : in Float) return Boolean with
     Pre => RasseAngriff /= RasseVerteidigung;

   function Prüfen return Boolean;

end Kampfsystem;
