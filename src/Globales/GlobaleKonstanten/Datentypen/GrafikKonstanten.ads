pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Sf;

package GrafikKonstanten is

   Undurchsichtig : constant Sf.sfUint8 := Sf.sfUint8'Last;
   Durchsichtig : constant Sf.sfUint8 := Sf.sfUint8'First;
   
   Wolkentransparents : constant Sf.sfUint8 := 240;
   Wassertransparents : constant Sf.sfUint8 := 215;
   Weltraumtransparents : constant Sf.sfUint8 := 220;
   VerschiedenerGrundtransparents : constant Sf.sfUint8 := 180;

end GrafikKonstanten;
