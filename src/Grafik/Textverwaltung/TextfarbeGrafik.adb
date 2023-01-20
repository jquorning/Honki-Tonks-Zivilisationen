with KartenartDatentypen;
with SystemKonstanten;
with SpielDatentypen;
with SpeziesKonstanten;
with SpeziesDatentypen;

with LeseAllgemeines;
with LeseSpeziesbelegung;

with KartengeneratorVariablenLogik;
with TexteinstellungenGrafik;

package body TextfarbeGrafik is

   function AuswahlfarbeFestlegen
     (TextnummerExtern : in Natural;
      AuswahlExtern : in Integer)
      return Sf.Graphics.Color.sfColor
   is begin
      
      if
        AuswahlExtern = TextnummerExtern
      then
         return TexteinstellungenGrafik.Schriftfarben.FarbeAusgewähltText;
            
      else
         return Standardfarbe;
      end if;
      
   end AuswahlfarbeFestlegen;
   
   
   
   function Standardfarbe
     return Sf.Graphics.Color.sfColor
   is begin
      
      return TexteinstellungenGrafik.Schriftfarben.FarbeStandardText;
      
   end Standardfarbe;
   
   
   
   function FarbeEinfachmenü
     (WelchesMenüExtern : in MenueDatentypen.Menü_Einfach_Enum;
      AktuelleAuswahlExtern : in Natural;
      AktuellerTextExtern : in Positive)
      return Sf.Graphics.Color.sfColor
   is begin
            
      case
        WelchesMenüExtern
      is
         when MenueDatentypen.Kartenart_Menü_Enum =>
            AktuelleEinstellung := SystemKonstanten.StandardArrayanpassung + KartenartDatentypen.Kartenart_Enum'Pos (KartengeneratorVariablenLogik.Kartenparameter.Kartenart);
            
         when MenueDatentypen.Kartentemperatur_Menü_Enum =>
            AktuelleEinstellung := SystemKonstanten.StandardArrayanpassung + KartenartDatentypen.Kartentemperatur_Enum'Pos (KartengeneratorVariablenLogik.Kartenparameter.Kartentemperatur);
            
         when MenueDatentypen.Kartenressourcen_Menü_Enum =>
            AktuelleEinstellung := SystemKonstanten.StandardArrayanpassung + KartenartDatentypen.Kartenressourcenmenge_Enum'Pos (KartengeneratorVariablenLogik.Kartenparameter.Kartenressourcen);
            
         when MenueDatentypen.Schwierigkeitsgrad_Menü_Enum =>
            AktuelleEinstellung := SystemKonstanten.StandardArrayanpassung + SpielDatentypen.Schwierigkeitsgrad_Enum'Pos (LeseAllgemeines.Schwierigkeitsgrad);
            
         when others =>
            AktuelleEinstellung := 0;
      end case;
      
      if
        AktuellerTextExtern = AktuelleAuswahlExtern
      then
         return TexteinstellungenGrafik.Schriftfarben.FarbeAusgewähltText;
         
      elsif
        AktuelleEinstellung = AktuellerTextExtern
      then
         return TexteinstellungenGrafik.Schriftfarben.FarbeMenschText;
      
      else
         return Standardfarbe;
      end if;
      
   end FarbeEinfachmenü;
   
   
   
   function FarbeDoppelmenü
     (AktuellerTextExtern : in Positive;
      AktuelleAuswahlExtern : in Natural)
      return Sf.Graphics.Color.sfColor
   is begin
      
      if
        AktuelleAuswahlExtern = AktuellerTextExtern
      then
         return TexteinstellungenGrafik.Schriftfarben.FarbeAusgewähltText;
         
      elsif
        AktuellerTextExtern - 1 in SpeziesKonstanten.Speziesanfang .. SpeziesKonstanten.Speziesende
      then
         case
           LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesDatentypen.Spezies_Verwendet_Enum'Val (AktuellerTextExtern - 1))
         is
            when SpeziesDatentypen.Mensch_Spieler_Enum =>
               return TexteinstellungenGrafik.Schriftfarben.FarbeMenschText;
               
            when SpeziesDatentypen.KI_Spieler_Enum =>
               return TexteinstellungenGrafik.Schriftfarben.FarbeKIText;
               
            when others =>
               null;
         end case;
               
      else
         null;
      end if;
      
      return Standardfarbe;
      
   end FarbeDoppelmenü;

end TextfarbeGrafik;
