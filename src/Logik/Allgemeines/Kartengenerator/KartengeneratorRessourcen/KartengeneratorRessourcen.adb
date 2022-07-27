pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KartenDatentypen; use KartenDatentypen;
with KartengrundDatentypen;
with LadezeitenDatentypen;

with LeseKarten;

with KartengeneratorVariablen;
with KartengeneratorRessourcenOberflaecheLand;
with KartengeneratorRessourcenOberflaecheWasser;
with KartengeneratorRessourcenUnterflaecheLand;
with KartengeneratorRessourcenUnterflaecheWasser;
with Ladezeiten;

package body KartengeneratorRessourcen is
   
   procedure AufteilungRessourcengenerierung
   is begin
      
      Multiplikator := (others => 1);
      GenerierungRessourcen;
      Ladezeiten.FortschrittSpielweltSchreiben (WelcheBerechnungenExtern => LadezeitenDatentypen.Generiere_Ressourcen_Enum);
      
   end AufteilungRessourcengenerierung;
   
   

   procedure GenerierungRessourcen
   is
   
      -- Später noch Ressourcen für weitere Ebenen einbauen. äöü
      task RessourcenUnterfläche;
      task RessourcenKern;
      
      task body RessourcenUnterfläche
      is begin
         
         RessourcenGenerierung (EbeneExtern => -1);
         
      end RessourcenUnterfläche;
      
      
      
      task body RessourcenKern
      is begin
         
         RessourcenGenerierung (EbeneExtern => -2);
         
      end RessourcenKern;
   
   begin

      RessourcenGenerierung (EbeneExtern => 0);
      
   end GenerierungRessourcen;
   
   
   
   procedure RessourcenGenerierung
     (EbeneExtern : in KartenDatentypen.EbenePlanet)
   is begin
      
      YAchseSchleife:
      for YAchseSchleifenwert in KartengeneratorVariablen.SchleifenanfangOhnePolbereich.YAchse .. KartengeneratorVariablen.SchleifenendeOhnePolbereich.YAchse loop
         XAchseSchleife:
         for XAchseSchleifenwert in KartengeneratorVariablen.SchleifenanfangOhnePolbereich.XAchse .. KartengeneratorVariablen.SchleifenendeOhnePolbereich.XAchse loop
            
            -- Ist aktuell nur vorhanden, da noch keine Ressourcen für den Kern vorhanden sind aber Werte für die Ladezeiten benötigt werden.
            case
              EbeneExtern
            is
               when -2 =>
                  exit XAchseSchleife;
                  
               when others =>
                  null;
            end case;
            
            case
              LeseKarten.AktuellerGrund (KoordinatenExtern => (EbeneExtern, YAchseSchleifenwert, XAchseSchleifenwert))
            is
               when KartengrundDatentypen.Kartengrund_Oberfläche_Wasser_Enum'Range =>
                  KartengeneratorRessourcenOberflaecheWasser.KartengeneratorRessourcenOberflächeWasser (KoordinatenExtern => (0, YAchseSchleifenwert, XAchseSchleifenwert));
                  
               when KartengrundDatentypen.Kartengrund_Oberfläche_Land_Enum'Range =>
                  KartengeneratorRessourcenOberflaecheLand.KartengeneratorRessourcenOberflächeLand (KoordinatenExtern => (0, YAchseSchleifenwert, XAchseSchleifenwert));
                  
               when KartengrundDatentypen.Kartengrund_Unterfläche_Wasser_Enum'Range =>
                  KartengeneratorRessourcenUnterflaecheWasser.KartengeneratorRessourcenUnterflächeWasser (KoordinatenExtern => (-1, YAchseSchleifenwert, XAchseSchleifenwert));
                  
               when KartengrundDatentypen.Kartengrund_Unterfläche_Land_Enum'Range =>
                  KartengeneratorRessourcenUnterflaecheLand.KartengeneratorRessourcenUnterflächeLand (KoordinatenExtern => (-1, YAchseSchleifenwert, XAchseSchleifenwert));
                  
               when others =>
                  null;
            end case;
            
         end loop XAchseSchleife;
            
         if
           ZahlenDatentypen.EigenesPositive (YAchseSchleifenwert) >= Multiplikator (EbeneExtern) * ZahlenDatentypen.EigenesPositive (KartengeneratorVariablen.SchleifenendeOhnePolbereich.YAchse) / 33
         then
            Ladezeiten.FortschrittSpielweltSchreiben (WelcheBerechnungenExtern => LadezeitenDatentypen.Generiere_Ressourcen_Enum);
            Multiplikator (EbeneExtern) := Multiplikator (EbeneExtern) + 1;
               
         else
            null;
         end if;
         
      end loop YAchseSchleife;
      
   end RessourcenGenerierung;

end KartengeneratorRessourcen;
