pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Sf.Graphics.Color;
with Sf.System.Vector2;

private with Sf.Graphics.RectangleShape;
private with Sf.Graphics.CircleShape;

-- Die Contracts so anpassen dass die Abmessungen/Größen immer > 0.00 sind? äöü
-- Dann könnte ich natürlich keine Objekte mit negativen Größenangaben zeichnen, aber ist das wirklich wichtig? äöü
package ObjekteZeichnenSFML is
   
   procedure RechteckZeichnen
     (AbmessungExtern : in Sf.System.Vector2.sfVector2f;
      PositionExtern : in Sf.System.Vector2.sfVector2f;
      FarbeExtern : in Sf.Graphics.Color.sfColor)
     with
       Pre => (
                 PositionExtern.x >= 0.00
               and
                 PositionExtern.y >= 0.00
               and
                 AbmessungExtern.x /= 0.00
               and
                 AbmessungExtern.y /= 0.00
              );
   
   procedure KreisZeichnen
     (RadiusExtern : in Float;
      PositionExtern : in Sf.System.Vector2.sfVector2f;
      FarbeExtern : in Sf.Graphics.Color.sfColor)
     with
       Pre => (
                 PositionExtern.x >= 0.00
               and
                 PositionExtern.y >= 0.00
               and
                 RadiusExtern /= 0.00
              );

   procedure PolygonZeichnen
     (RadiusExtern : in Float;
      PositionExtern : in Sf.System.Vector2.sfVector2f;
      AnzahlEckenExtern : in Sf.sfSize_t;
      FarbeExtern : in Sf.Graphics.Color.sfColor)
     with
       Pre => (
                 PositionExtern.x >= 0.00
               and
                 PositionExtern.y >= 0.00
               and
                 RadiusExtern /= 0.00
              );
   
   procedure RahmenZeichnen
         (PositionExtern : in Sf.System.Vector2.sfVector2f;
          FarbeExtern : in Sf.Graphics.Color.sfColor;
          GrößeExtern : in Sf.System.Vector2.sfVector2f;
          RahmendickeExtern : in Float)
     with
       Pre => (
                 PositionExtern.x >= 0.00
               and
                 PositionExtern.y >= 0.00
               and
                 GrößeExtern.x > 0.00
               and
                 GrößeExtern.y > 0.00
               and
                 RahmendickeExtern > 0.00
              );
   
private
   
   RechteckAccess : constant Sf.Graphics.sfRectangleShape_Ptr := Sf.Graphics.RectangleShape.create;
   RahmenAccess : constant Sf.Graphics.sfRectangleShape_Ptr := Sf.Graphics.RectangleShape.create;
   
   KreisAccess : constant Sf.Graphics.sfCircleShape_Ptr := Sf.Graphics.CircleShape.create;
   
   PolygonAccess : constant Sf.Graphics.sfCircleShape_Ptr := Sf.Graphics.CircleShape.create;

end ObjekteZeichnenSFML;
