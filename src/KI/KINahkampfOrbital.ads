pragma SPARK_Mode (On);

with GlobaleDatentypen, GlobaleRecords, GlobaleVariablen;
use GlobaleDatentypen;

package KINahkampfOrbital is

   procedure KINahkampfOrbital
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
     with
       Pre =>
         (EinheitRasseNummerExtern.Platznummer >= GlobaleVariablen.EinheitenGebautArray'First (2)
          and
            GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) = 2);

end KINahkampfOrbital;
