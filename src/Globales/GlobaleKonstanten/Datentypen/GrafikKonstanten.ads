with Sf;

package GrafikKonstanten is
   pragma Elaborate_Body;

   Undurchsichtig : constant Sf.sfUint8 := Sf.sfUint8'Last;
   Durchsichtig : constant Sf.sfUint8 := Sf.sfUint8'First;
   
   Wolkentransparents : constant Sf.sfUint8 := 240;
   Weltraumtransparents : constant Sf.sfUint8 := 220;
   Hintergrundtransparents : constant Sf.sfUint8 := 200;
   Wassertransparents : constant Sf.sfUint8 := 215;
   VerschiedenerGrundtransparents : constant Sf.sfUint8 := 180;
   Bewegungsfeldtransparents : constant Sf.sfUint8 := 120;
   Feldeffekttransparents : constant Sf.sfUint8 := 100;
   
   MinimaleAuflösungsbreite : constant Sf.sfUint32 := 320;
   MaximaleAuflösungsbreite : constant Sf.sfUint32 := 4_096;
   MinimaleAuflösunghöhe : constant Sf.sfUint32 := 240;
   MaximaleAuflösungshöhe : constant Sf.sfUint32 := 3_072;
   
   MinimaleBildrate : constant Sf.sfUint32 := 1;
   MaximaleBildrate : constant Sf.sfUint32 := 1_000;
   
   AnzahlStadtumgebungsfelder : constant Float := 7.00;
   Nullposition : constant Float := 0.00;
   MaximalerViewbereich : constant Float := 1.00;

end GrafikKonstanten;
