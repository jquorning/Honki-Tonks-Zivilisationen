with Sf;

package GrafikKonstanten is
   pragma Elaborate_Body;

   Undurchsichtig : constant Sf.sfUint8 := Sf.sfUint8'Last;
   Durchsichtig : constant Sf.sfUint8 := Sf.sfUint8'First;
   
   Wolkentransparents : constant Sf.sfUint8 := 240;
   Wassertransparents : constant Sf.sfUint8 := 215;
   Weltraumtransparents : constant Sf.sfUint8 := 220;
   VerschiedenerGrundtransparents : constant Sf.sfUint8 := 180;
   Bewegungsfeldtransparents : constant Sf.sfUint8 := 120;
   Feldeffekttransparents : constant Sf.sfUint8 := 150;

end GrafikKonstanten;
