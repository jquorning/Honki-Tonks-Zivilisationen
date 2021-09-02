pragma SPARK_Mode (On);

with GlobaleKonstanten;

package body LeseWichtiges is

   function Geldmenge
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
      return Integer
   is begin

      return GlobaleVariablen.Wichtiges (RasseExtern).Geldmenge;

   end Geldmenge;
   


   function GeldZugewinnProRunde
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
      return GlobaleDatentypen.KostenLager
   is begin

      return GlobaleVariablen.Wichtiges (RasseExtern).GeldZugewinnProRunde;

   end GeldZugewinnProRunde;
   
   

   function GesamteForschungsrate
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
      return GlobaleDatentypen.KostenLager
   is begin

      if
        GlobaleVariablen.Wichtiges (RasseExtern).GesamteForschungsrate < GlobaleKonstanten.LeerWichtigesZeug.GesamteForschungsrate
      then
         GlobaleVariablen.Wichtiges (RasseExtern).GesamteForschungsrate := GlobaleKonstanten.LeerWichtigesZeug.GesamteForschungsrate;
         
      else
         null;
      end if;
      
      return GlobaleVariablen.Wichtiges (RasseExtern).GesamteForschungsrate;

   end GesamteForschungsrate;
   
   
   
   function Forschungsmenge
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
      return GlobaleDatentypen.KostenLager
   is begin

      if
        GlobaleVariablen.Wichtiges (RasseExtern).Forschungsmenge < GlobaleKonstanten.LeerWichtigesZeug.Forschungsmenge
      then
         GlobaleVariablen.Wichtiges (RasseExtern).Forschungsmenge := GlobaleKonstanten.LeerWichtigesZeug.Forschungsmenge;
         
      else
         null;
      end if;

      return GlobaleVariablen.Wichtiges (RasseExtern).Forschungsmenge;

   end Forschungsmenge;
   
   
   
   function VerbleibendeForschungszeit
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
      return GlobaleDatentypen.KostenLager
   is begin

      if
        GlobaleVariablen.Wichtiges (RasseExtern).VerbleibendeForschungszeit < GlobaleKonstanten.LeerWichtigesZeug.VerbleibendeForschungszeit
      then
         GlobaleVariablen.Wichtiges (RasseExtern).VerbleibendeForschungszeit := GlobaleKonstanten.LeerWichtigesZeug.VerbleibendeForschungszeit;
         
      else
         null;
      end if;

      return GlobaleVariablen.Wichtiges (RasseExtern).VerbleibendeForschungszeit;

   end VerbleibendeForschungszeit;
   
   
   
   function Forschungsprojekt
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
      return GlobaleDatentypen.ForschungIDMitNullWert
   is begin

      return GlobaleVariablen.Wichtiges (RasseExtern).Forschungsprojekt;

   end Forschungsprojekt;
   
   

   function Erforscht
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum;
      WelcheTechnologieExtern : in GlobaleDatentypen.ForschungID)
      return Boolean
   is begin

      return GlobaleVariablen.Wichtiges (RasseExtern).Erforscht (WelcheTechnologieExtern);

   end Erforscht;

end LeseWichtiges;