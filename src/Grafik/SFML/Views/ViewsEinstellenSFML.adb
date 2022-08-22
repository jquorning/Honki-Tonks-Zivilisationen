pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Sf.Graphics.View;
with Sf.Graphics.RenderWindow;

with GrafikEinstellungenSFML;

package body ViewsEinstellenSFML is
   
   procedure ViewEinstellen
     (ViewExtern : in Sf.Graphics.sfView_Ptr;
      GrößeExtern : in Sf.System.Vector2.sfVector2f;
      AnzeigebereichExtern : in Sf.Graphics.Rect.sfFloatRect)
   is begin
      
      Sf.Graphics.View.setSize (view => ViewExtern,
                                size => GrößeExtern);
      Sf.Graphics.View.setCenter (view   => ViewExtern,
                                  center => (GrößeExtern.x / 2.00, GrößeExtern.y / 2.00));
      Sf.Graphics.View.setViewport (view     => ViewExtern,
                                    viewport => AnzeigebereichExtern);
      
      Sf.Graphics.RenderWindow.setView (renderWindow => GrafikEinstellungenSFML.FensterAccess,
                                        view         => ViewExtern);
      
   end ViewEinstellen;
   
   
   
   function ViewflächeAuflösungAnpassen
     (ViewflächeExtern : in Sf.System.Vector2.sfVector2f)
      return Sf.System.Vector2.sfVector2f
   is begin
      
      if
        ViewflächeExtern.x < GrafikEinstellungenSFML.AktuelleFensterAuflösung.x
      then
         Viewfläche.x := GrafikEinstellungenSFML.AktuelleFensterAuflösung.x;
         
      else
         Viewfläche.x := ViewflächeExtern.x;
      end if;
      
      if
        ViewflächeExtern.y < GrafikEinstellungenSFML.AktuelleFensterAuflösung.y
      then
         Viewfläche.y := GrafikEinstellungenSFML.AktuelleFensterAuflösung.y;
         
      else
         Viewfläche.y := ViewflächeExtern.y;
      end if;
      
      return Viewfläche;
      
   end ViewflächeAuflösungAnpassen;
   
   
   
   function ViewflächeVariabelAnpassen
     (ViewflächeExtern : in Sf.System.Vector2.sfVector2f;
      VerhältnisExtern : in Sf.System.Vector2.sfVector2f)
      return Sf.System.Vector2.sfVector2f
   is begin
      
      if
        ViewflächeExtern.x < GrafikEinstellungenSFML.AktuelleFensterAuflösung.x * VerhältnisExtern.x
      then
         Viewfläche.x := GrafikEinstellungenSFML.AktuelleFensterAuflösung.x * VerhältnisExtern.x;
         
      else
         Viewfläche.x := ViewflächeExtern.x;
      end if;
      
      if
        ViewflächeExtern.y < GrafikEinstellungenSFML.AktuelleFensterAuflösung.y * VerhältnisExtern.y
      then
         Viewfläche.y := GrafikEinstellungenSFML.AktuelleFensterAuflösung.y * VerhältnisExtern.y;
         
      else
         Viewfläche.y := ViewflächeExtern.y;
      end if;
      
      return Viewfläche;
      
   end ViewflächeVariabelAnpassen;

end ViewsEinstellenSFML;
