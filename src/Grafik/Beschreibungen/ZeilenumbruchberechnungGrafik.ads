pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

package ZeilenumbruchberechnungGrafik is
   
   function Zeilenumbruchberechnung
     (TextExtern : in Wide_Wide_String;
      TextfeldbreiteExtern : in Float)
      return Wide_Wide_String
     with
       Pre => (
                 TextfeldbreiteExtern > 0.00
              );
   
private
   
   SchleifenAnfang : Positive;
   SchleifenEnde : Positive;

   Zwischenwert : Integer;
   
   NeuerText : Unbounded_Wide_Wide_String;

end ZeilenumbruchberechnungGrafik;
