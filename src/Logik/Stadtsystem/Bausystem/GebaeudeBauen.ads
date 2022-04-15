pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with SystemDatentypen; use SystemDatentypen;
with EinheitStadtRecords;
with GlobaleVariablen;

package GebaeudeBauen is

   procedure AnzeigeGebäude
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
     with
       Pre =>
         (StadtRasseNummerExtern.Platznummer in GlobaleVariablen.StadtGebautArray'First (2) .. GlobaleVariablen.Grenzen (StadtRasseNummerExtern.Rasse).Städtegrenze
          and
            GlobaleVariablen.RassenImSpiel (StadtRasseNummerExtern.Rasse) = RassenDatentypen.Spieler_Mensch_Enum);
   
private
   
   PermanenteGebäudeWerte : Boolean;
   
   procedure PermanenteKostenGebäude
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum);

   procedure PreisGebäude
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum);
   
   procedure BauzeitGebäude
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord);

end GebaeudeBauen;
