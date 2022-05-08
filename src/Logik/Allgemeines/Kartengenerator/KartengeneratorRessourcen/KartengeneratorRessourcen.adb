pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with LeseKarten;

with Karten;
with KartengeneratorVariablen;
with KartengeneratorRessourcenOberflaecheLand;
with KartengeneratorRessourcenOberflaecheWasser;
with KartengeneratorRessourcenUnterflaecheLand;
with KartengeneratorRessourcenUnterflaecheWasser;

package body KartengeneratorRessourcen is
   
   procedure AufteilungRessourcengenerierung
   is begin
      
      case
        Karten.Kartenparameter.Kartenart
      is
         when KartenDatentypen.Kartenart_Chaotisch_Enum'Range =>
            return;
            
         when KartenDatentypen.Kartenart_Normal_Enum'Range | KartenDatentypen.Kartenart_Sonstiges_Enum'Range =>
            GenerierungRessourcen;
      end case;
            
   end AufteilungRessourcengenerierung;
   
   

   procedure GenerierungRessourcen
   is
   
      ----------------------- Später noch Ressourcen für weitere Ebenen einbauen.
      task RessourcenUnterfläche;
      task RessourcenKern;
      
      task body RessourcenUnterfläche
      is begin
         
         RessourcenGenerierung (EbeneExtern => -1);
         
      end RessourcenUnterfläche;
      
      
      
      task body RessourcenKern
      is begin
         
         null;
         
      end RessourcenKern;
   
   begin

      RessourcenGenerierung (EbeneExtern => 0);
      
   end GenerierungRessourcen;
   
   
   
   procedure RessourcenGenerierung
     (EbeneExtern : in KartenDatentypen.EbeneVorhanden)
   is begin
      
      YAchseSchleife:
      for YAchseSchleifenwert in KartengeneratorVariablen.SchleifenanfangOhnePolbereich.YAchse .. KartengeneratorVariablen.SchleifenendeOhnePolbereich.YAchse loop
         XAchseSchleife:
         for XAchseSchleifenwert in KartengeneratorVariablen.SchleifenanfangOhnePolbereich.XAchse .. KartengeneratorVariablen.SchleifenendeOhnePolbereich.XAchse loop
               
            case
              LeseKarten.Grund (KoordinatenExtern => (EbeneExtern, YAchseSchleifenwert, XAchseSchleifenwert))
            is
               when KartengrundDatentypen.Kartengrund_Oberfläche_Wasser_Enum'Range =>
                  KartengeneratorRessourcenOberflaecheWasser.KartengeneratorRessourcenOberflächeWasser (YAchseExtern => YAchseSchleifenwert,
                                                                                                         XAchseExtern => XAchseSchleifenwert);
                  
               when KartengrundDatentypen.Kartengrund_Oberfläche_Land_Enum'Range =>
                  KartengeneratorRessourcenOberflaecheLand.KartengeneratorRessourcenOberflächeLand (YAchseExtern => YAchseSchleifenwert,
                                                                                                     XAchseExtern => XAchseSchleifenwert);
                  
               when KartengrundDatentypen.Kartengrund_Unterfläche_Wasser_Enum'Range =>
                  KartengeneratorRessourcenUnterflaecheWasser.KartengeneratorRessourcenUnterflächeWasser (YAchseExtern => YAchseSchleifenwert,
                                                                                                           XAchseExtern => XAchseSchleifenwert);
                  
               when KartengrundDatentypen.Kartengrund_Unterfläche_Land_Enum'Range =>
                  KartengeneratorRessourcenUnterflaecheLand.KartengeneratorRessourcenUnterflächeLand (YAchseExtern => YAchseSchleifenwert,
                                                                                                       XAchseExtern => XAchseSchleifenwert);
                  
               when others =>
                  null;
            end case;
            
         end loop XAchseSchleife;
      end loop YAchseSchleife;
      
   end RessourcenGenerierung;

end KartengeneratorRessourcen;