pragma SPARK_Mode (On);

with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

with SystemDatentypen; use SystemDatentypen;
with KartenDatentypen; use KartenDatentypen;
with GlobaleVariablen;
with EinheitStadtDatentypen;
with EinheitStadtRecords;
with SystemKonstanten;

package GebaeudeAllgemein is
   
   procedure GebäudeProduktionBeenden
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      IDExtern : in EinheitStadtDatentypen.GebäudeID)
     with
       Pre =>
         (StadtRasseNummerExtern.Platznummer in GlobaleVariablen.StadtGebautArray'First (2) .. GlobaleVariablen.Grenzen (StadtRasseNummerExtern.Rasse).Städtegrenze
          and
            GlobaleVariablen.RassenImSpiel (StadtRasseNummerExtern.Rasse) /= SystemKonstanten.LeerSpielerKonstante);
   
   procedure GebäudeEntfernen
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      WelchesGebäudeExtern : in EinheitStadtDatentypen.GebäudeID)
     with
       Pre =>
         (StadtRasseNummerExtern.Platznummer in GlobaleVariablen.StadtGebautArray'First (2) .. GlobaleVariablen.Grenzen (StadtRasseNummerExtern.Rasse).Städtegrenze
          and
            GlobaleVariablen.RassenImSpiel (StadtRasseNummerExtern.Rasse) /= SystemKonstanten.LeerSpielerKonstante);
   
   

   function BeschreibungKurz
     (IDExtern : in EinheitStadtDatentypen.GebäudeIDMitNullwert)
      return Wide_Wide_String;
   
   function BeschreibungLang
     (IDExtern : in EinheitStadtDatentypen.GebäudeIDMitNullwert)
      return Wide_Wide_String;
   
   function GebäudeAnforderungenErfüllt
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      IDExtern : in EinheitStadtDatentypen.GebäudeID)
      return Boolean
     with
       Pre =>
         (StadtRasseNummerExtern.Platznummer in GlobaleVariablen.StadtGebautArray'First (2) .. GlobaleVariablen.Grenzen (StadtRasseNummerExtern.Rasse).Städtegrenze
          and
            GlobaleVariablen.RassenImSpiel (StadtRasseNummerExtern.Rasse) /= SystemKonstanten.LeerSpielerKonstante);
   
private
   
   AktuellerText : Positive;
   
   BeschreibungText : Unbounded_Wide_Wide_String;
   
   procedure PermanenteKostenDurchGebäudeÄndern
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      IDExtern : in EinheitStadtDatentypen.GebäudeID;
      VorzeichenWechselExtern : in KartenDatentypen.LoopRangeMinusEinsZuEins)
     with
       Pre =>
         (VorzeichenWechselExtern /= 0);

end GebaeudeAllgemein;