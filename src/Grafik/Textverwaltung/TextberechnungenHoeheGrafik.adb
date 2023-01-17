with Sf.Graphics.Text;

with EinstellungenGrafik;

package body TextberechnungenHoeheGrafik is
   
   function KleinerZeilenabstandVariabel
     return Float
   is begin
      
      return 1.50 * EinstellungenGrafik.AktuelleFensterAuflösung.y / 100.00;
      
   end KleinerZeilenabstandVariabel;
   
   
   
   function ZeilenabstandVariabel
     return Float
   is begin
      
      return 3.50 * EinstellungenGrafik.AktuelleFensterAuflösung.y / 100.00;
      
   end ZeilenabstandVariabel;
   
   
   
   function NeueTextposition
     (PositionExtern : in Float;
      TextAccessExtern : in Sf.Graphics.sfText_Ptr;
      ZusatzwertExtern : in Float)
      return Float
   is begin
      
      return PositionExtern + ZusatzwertExtern + Sf.Graphics.Text.getLocalBounds (text => TextAccessExtern).height;
      
   end NeueTextposition;
   
end TextberechnungenHoeheGrafik;
