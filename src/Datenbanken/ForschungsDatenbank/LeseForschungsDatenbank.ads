pragma SPARK_Mode (On);

with GlobaleDatentypen, GlobaleVariablen;
use GlobaleDatentypen;

with DatenbankRecords;

package LeseForschungsDatenbank is

   function PreisForschung
     (RasseExtern : in SonstigeDatentypen.Rassen_Verwendet_Enum;
      IDExtern : in EinheitStadtDatentypen.ForschungID)
      return EinheitStadtDatentypen.KostenLager
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) /= GlobaleDatentypen.Leer);

   function AnforderungForschung
     (RasseExtern : in SonstigeDatentypen.Rassen_Verwendet_Enum;
      IDExtern : in EinheitStadtDatentypen.ForschungID;
      WelcheAnforderungExtern : in Positive)
      return EinheitStadtDatentypen.ForschungIDMitNullWert
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) /= GlobaleDatentypen.Leer);
   
   function GanzerEintrag
     (RasseExtern : in SonstigeDatentypen.Rassen_Verwendet_Enum;
      IDExtern : in EinheitStadtDatentypen.ForschungID)
      return DatenbankRecords.ForschungListeRecord
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) /= GlobaleDatentypen.Leer);

end LeseForschungsDatenbank;
