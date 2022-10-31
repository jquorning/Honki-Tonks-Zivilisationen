pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

private with Sf.System.Vector2;
private with Sf.Graphics.Color;

with MenueDatentypen;

private with GrafikRecordKonstanten;

package DoppelmenueGrafik is
   pragma Elaborate_Body;

   procedure Doppelmenü
     (WelchesMenüExtern : in MenueDatentypen.Menü_Doppelt_Enum;
      AktuelleAuswahlExtern : in Natural);
   
private
   
   Auswahlbereich : constant Positive := 1;
   Zusatzbereich : constant Positive := 2;
   
   Textbreite : Float;
   
   Textposition : Sf.System.Vector2.sfVector2f;
   
   type ViewflächenArray is array (GrafikRecordKonstanten.MenüDoppelbereich'Range) of Sf.System.Vector2.sfVector2f;
   Viewfläche : ViewflächenArray := (others => GrafikRecordKonstanten.StartgrößeView);
   
   Farbe : Sf.Graphics.Color.sfColor;

   procedure FarbenFestlegen
     (AktuellerTextExtern : in Positive;
      AktuelleAuswahlExtern : in Natural;
      WelchesMenüExtern : in MenueDatentypen.Menü_Doppelt_Enum);
   
   
   
   function TextpositionFestlegen
     (WelchesMenüExtern : in MenueDatentypen.Menü_Doppelt_Enum;
      ViewflächeExtern : in Sf.System.Vector2.sfVector2f;
      AktuelleAuswahlExtern : in Natural)
      return Sf.System.Vector2.sfVector2f
     with
       Post => (
                  TextpositionFestlegen'Result.x >= 0.00
                and
                  TextpositionFestlegen'Result.y >= 0.00
               );

end DoppelmenueGrafik;
