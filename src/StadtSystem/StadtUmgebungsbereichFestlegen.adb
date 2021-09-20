pragma SPARK_Mode (On);

with GlobaleKonstanten;

with SchreibeStadtGebaut;
with LeseStadtGebaut, LeseWichtiges;

package body StadtUmgebungsbereichFestlegen is

   procedure StadtUmgebungsbereichFestlegen
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
   is begin
      
      case
        StadtRasseNummerExtern.Rasse
      is
         when GlobaleDatentypen.Leer =>
            -- Dieser Fall sollte niemals eintreten, muss aber mitgenommen werden wegen dem Record.
            raise Program_Error;
            
         when others =>
            StadtUmgebungErmitteln (StadtRasseNummerExtern => StadtRasseNummerExtern);
      end case;
      
   end StadtUmgebungsbereichFestlegen;
   
   
   
   procedure StadtUmgebungErmitteln
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
   is begin
      
      if
        LeseWichtiges.Erforscht (RasseExtern             => StadtRasseNummerExtern.Rasse,
                                 WelcheTechnologieExtern => TechnologieUmgebungsgröße (StadtRasseNummerExtern.Rasse, GlobaleDatentypen.Endwert))
          = True
        and
          LeseStadtGebaut.EinwohnerArbeiter (StadtRasseNummerExtern  => StadtRasseNummerExtern,
                                             EinwohnerArbeiterExtern => True)
        >= GlobaleKonstanten.StadtUmgebungWachstum (GlobaleDatentypen.Endwert, StadtRasseNummerExtern.Rasse)
      then
         Umgebung := 3;
         
      elsif
        LeseWichtiges.Erforscht (RasseExtern             => StadtRasseNummerExtern.Rasse,
                                 WelcheTechnologieExtern => TechnologieUmgebungsgröße (StadtRasseNummerExtern.Rasse, GlobaleDatentypen.Anfangswert))
          = True
        and
          LeseStadtGebaut.EinwohnerArbeiter (StadtRasseNummerExtern  => StadtRasseNummerExtern,
                                             EinwohnerArbeiterExtern => True)
        >= GlobaleKonstanten.StadtUmgebungWachstum (GlobaleDatentypen.Anfangswert, StadtRasseNummerExtern.Rasse)
      then
         Umgebung := 2;      
                  
      else
         Umgebung := 1;
      end if;
      
      SchreibeStadtGebaut.UmgebungGröße (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                           UmgebungGrößeExtern    => Umgebung,
                                           ÄndernSetzenExtern     => False);
      
   end StadtUmgebungErmitteln;

end StadtUmgebungsbereichFestlegen;
