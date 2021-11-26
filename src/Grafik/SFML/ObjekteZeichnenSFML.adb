pragma SPARK_Mode (On);

with Sf.Graphics.RectangleShape;
with Sf.Graphics.RenderWindow;
with Sf.Graphics.CircleShape;

with Fehler;
with GrafikEinstellungen;

package body ObjekteZeichnenSFML is

   procedure RechteckZeichnen
     (AbmessungExtern : in Sf.System.Vector2.sfVector2f;
      PositionExtern : in Sf.System.Vector2.sfVector2f;
      FarbeExtern : in Sf.Graphics.Color.sfColor;
      RechteckAccessExtern : in Sf.Graphics.sfRectangleShape_Ptr)
   is begin
      
      -- Diese Prüfungen als Pre? Müsste bei einem Fehler auch direkt das Programm stoppen?
      if
        AbmessungExtern.y = 0.00
        or
          AbmessungExtern.x = 0.00
      then
         Fehler.GrafikStopp (FehlermeldungExtern => "ObjekteZeichnenSFML.RechteckZeichnen - Rechteck ist ein Strich");
         
      elsif
        AbmessungExtern.y > Float (GrafikEinstellungen.AktuelleFensterEinstellungen.AktuelleFensterHöhe)
        or
          AbmessungExtern.x > Float (GrafikEinstellungen.AktuelleFensterEinstellungen.AktuelleFensterBreite)
      then
         Fehler.GrafikStopp (FehlermeldungExtern => "ObjekteZeichnenSFML.RechteckZeichnen - Rechteck ist größer als das Fenster");
         
      else
         Sf.Graphics.RectangleShape.setSize (shape => RechteckAccessExtern,
                                             size  => AbmessungExtern);
         Sf.Graphics.RectangleShape.setPosition (shape    => RechteckAccessExtern,
                                                 position => PositionExtern);
         Sf.Graphics.RectangleShape.setFillColor (shape => RechteckAccessExtern,
                                                  color => FarbeExtern);
         Sf.Graphics.RenderWindow.drawRectangleShape (renderWindow => GrafikEinstellungen.Fenster,
                                                      object       => RechteckAccessExtern);
      end if;
      
   end RechteckZeichnen;
   
   
   
   procedure KreisZeichnen
     (RadiusExtern : in Float;
      PositionExtern : in Sf.System.Vector2.sfVector2f;
      FarbeExtern : in Sf.Graphics.Color.sfColor;
      KreisAccessExtern : in Sf.Graphics.sfCircleShape_Ptr)
   is begin
            
      if
        RadiusExtern = 0.00
      then
         Fehler.GrafikStopp (FehlermeldungExtern => "ObjekteZeichnenSFML.KreisZeichnen - Der Radius ist 0.");
         
      else
         Sf.Graphics.CircleShape.setRadius (shape  => KreisAccessExtern,
                                            radius => RadiusExtern);
         Sf.Graphics.CircleShape.setPosition (shape    => KreisAccessExtern,
                                              position => PositionExtern);
         Sf.Graphics.CircleShape.setFillColor (shape => KreisAccessExtern,
                                               color => FarbeExtern);
         Sf.Graphics.RenderWindow.drawCircleShape (renderWindow => GrafikEinstellungen.Fenster,
                                                   object       => KreisAccessExtern);
      end if;
      
   end KreisZeichnen;
   
   
   
   procedure PolygonZeichnen
     (RadiusExtern : in Float;
      PositionExtern : in Sf.System.Vector2.sfVector2f;
      AnzahlEckenExtern : in Sf.sfSize_t;
      FarbeExtern : in Sf.Graphics.Color.sfColor;
      PolygonAccessExtern : in Sf.Graphics.sfCircleShape_Ptr)
   is begin
            
      if
        RadiusExtern = 0.00
      then
         Fehler.GrafikStopp (FehlermeldungExtern => "ObjekteZeichnenSFML.PolygonZeichnen - Der Radius ist 0.");
         
      else
         Sf.Graphics.CircleShape.setRadius (shape  => PolygonAccessExtern,
                                            radius => RadiusExtern);
         Sf.Graphics.CircleShape.setPointCount (shape => PolygonAccessExtern,
                                                count => AnzahlEckenExtern);
         Sf.Graphics.CircleShape.setPosition (shape    => PolygonAccessExtern,
                                              position => PositionExtern);
         Sf.Graphics.CircleShape.setFillColor (shape => PolygonAccessExtern,
                                               color => FarbeExtern);
         Sf.Graphics.RenderWindow.drawCircleShape (renderWindow => GrafikEinstellungen.Fenster,
                                                   object       => PolygonAccessExtern);
      end if;
      
   end PolygonZeichnen;

end ObjekteZeichnenSFML;
