pragma SPARK_Mode (On);

with Sf.Graphics.Text;

with GrafikEinstellungen;

package body AllgemeineTextBerechnungenSFML is

   function TextMittelPositionErmitteln
     (TextZugriffExtern : in Sf.Graphics.sfText_Ptr)
      return Float
   is begin
      
      TextHalbeBreite := TextHalbeBreiteErmitteln (TextZugriffExtern => TextZugriffExtern);
      Position := Float (GrafikEinstellungen.FensterBreite) / 2.00 - TextHalbeBreite;
      
      if
        Position in 0.00 .. Float (GrafikEinstellungen.FensterBreite)
      then
         return Position;
         
      else
         raise Program_Error;
      end if;
      
   end TextMittelPositionErmitteln;
   
   
   
   function TextViertelPositionErmitteln
     (TextZugriffExtern : in Sf.Graphics.sfText_Ptr;
      LinksRechtsExtern : in Boolean)
      return Float
   is begin
      
      Position := Float (GrafikEinstellungen.FensterBreite) / 4.00;
      TextHalbeBreite := TextHalbeBreiteErmitteln (TextZugriffExtern => TextZugriffExtern);
      
      case
        LinksRechtsExtern
      is
         when False =>
            Position := Position - TextHalbeBreite;
            
         when True =>
            Position := Position * 3.00 - TextHalbeBreite;
      end case;
      
      if
        Position in 0.00 .. Float (GrafikEinstellungen.FensterBreite)
      then
         return Position;
         
      else
         raise Program_Error;
      end if;
      
   end TextViertelPositionErmitteln;
   
   
   
   function TextHalbeBreiteErmitteln
     (TextZugriffExtern : in Sf.Graphics.sfText_Ptr)
      return Float
   is begin
      
      return Sf.Graphics.Text.getLocalBounds (text => TextZugriffExtern).width / 2.00;
      
   end TextHalbeBreiteErmitteln;

end AllgemeineTextBerechnungenSFML;
