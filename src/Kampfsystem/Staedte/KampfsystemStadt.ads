pragma SPARK_Mode (On);

with GlobaleRecords, GlobaleVariablen, GlobaleDatentypen;
use GlobaleDatentypen;

package KampfsystemStadt is

   function KampfsystemStadt
     (AngreifendeEinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      VerteidigendeStadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
      return Boolean
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (AngreifendeEinheitRasseNummerExtern.Rasse) /= GlobaleDatentypen.Leer
          and
            GlobaleVariablen.RassenImSpiel (VerteidigendeStadtRasseNummerExtern.Rasse) /= GlobaleDatentypen.Leer
          and
            AngreifendeEinheitRasseNummerExtern.Rasse /= VerteidigendeStadtRasseNummerExtern.Rasse
          and
            AngreifendeEinheitRasseNummerExtern.Platznummer in GlobaleVariablen.EinheitenGebautArray'First (2) .. GlobaleVariablen.Grenzen (AngreifendeEinheitRasseNummerExtern.Rasse).Einheitengrenze
          and
            VerteidigendeStadtRasseNummerExtern.Platznummer in GlobaleVariablen.StadtGebautArray'First (2) .. GlobaleVariablen.Grenzen (VerteidigendeStadtRasseNummerExtern.Rasse).Städtegrenze);
   
private
   
   GesundheitStadt : GlobaleDatentypen.ProduktionFeld;
   AngerichteterSchaden : GlobaleDatentypen.ProduktionFeld;
   
   Kampfglück : Float;
   
   KampfwerteVerteidiger : GlobaleRecords.KampfwerteRecord;
   KampfwerteAngreifer : GlobaleRecords.KampfwerteRecord;
   
   type Kampf_Unterschiede_Enum is (Gleich, Stärker, Extrem_Stärker, Schwächer, Extrem_Schwächer);

   WelcherFall : Kampf_Unterschiede_Enum;

   type SchadenAngerichtetArray is array (Kampf_Unterschiede_Enum'Range, GlobaleDatentypen.ProduktionFeld (1) .. 3) of Float;
   SchadenAngerichtet : constant SchadenAngerichtetArray := (
                                                             Gleich           =>
                                                               (1 => 0.40,
                                                                2 => 0.75,
                                                                3 => 0.90),
                                                             Stärker          =>
                                                               (1 => 0.30,
                                                                2 => 0.65,
                                                                3 => 0.80),
                                                             Extrem_Stärker   =>
                                                               (1 => 0.20,
                                                                2 => 0.50,
                                                                3 => 0.70),
                                                             Schwächer        =>
                                                               (1 => 0.55,
                                                                2 => 0.85,
                                                                3 => 0.95),
                                                             Extrem_Schwächer =>
                                                               (1 => 0.70,
                                                                2 => 0.90,
                                                                3 => 0.98)
                                                            );
   
   procedure SchadenStadtBerechnen
     (AngriffExtern : in GlobaleDatentypen.ProduktionFeld;
      VerteidigungExtern : in GlobaleDatentypen.ProduktionFeld);
   
   
   
   function Kampfverlauf
     (AngreifendeEinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
      return Boolean;
   
   function Kampf
     (AngreifendeEinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      VerteidigendeStadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
      return Boolean;

end KampfsystemStadt;
