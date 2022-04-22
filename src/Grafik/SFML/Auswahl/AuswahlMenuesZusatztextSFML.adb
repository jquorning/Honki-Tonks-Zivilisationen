pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with AnzeigeZusatztextRassenmenueSFML;
with AnzeigeZusatztextKartengroesseSFML;

package body AuswahlMenuesZusatztextSFML is

   procedure MenüsZusatztextAufteilung
     (WelchesMenüExtern : in MenueDatentypen.Menü_Zusatztext_Enum;
      AktuelleAuswahlExtern : in Natural)
   is begin
      
      case
        WelchesMenüExtern
      is
         when MenueDatentypen.Rassen_Menü_Enum =>
            if
              ---------------------- Das 1 .. 18 mal für alle Fälle in eine GloaleKonstante mit ErsteRasse .. LetzteRasse umwandeln?
              AktuelleAuswahlExtern in 1 .. 18
            then
               AnzeigeZusatztextRassenmenueSFML.AnzeigeZusatztextRassenmenü (AktuelleAuswahlExtern => AktuelleAuswahlExtern);
         
            else
               null;
            end if;
            
         when MenueDatentypen.Kartengröße_Menü_Enum =>
            if
              AktuelleAuswahlExtern > AnzahlKartengrößen
            then
               AnzeigeZusatztextKartengroesseSFML.AnzeigeZusatztextKartengröße (AktuelleAuswahlExtern => 0);
               
            else
               AnzeigeZusatztextKartengroesseSFML.AnzeigeZusatztextKartengröße (AktuelleAuswahlExtern => AktuelleAuswahlExtern);
            end if;
      end case;
      
   end MenüsZusatztextAufteilung;
   
   
   
   procedure MenüsZusatztextZurücksetzen
   is begin
      
      null;
      
   end MenüsZusatztextZurücksetzen;

end AuswahlMenuesZusatztextSFML;
