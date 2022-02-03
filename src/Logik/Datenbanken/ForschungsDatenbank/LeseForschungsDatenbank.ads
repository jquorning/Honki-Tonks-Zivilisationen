pragma SPARK_Mode (On);

with SystemDatentypen; use SystemDatentypen;
with GlobaleVariablen;
with EinheitStadtDatentypen;
with SystemKonstanten;

with DatenbankRecords;

package LeseForschungsDatenbank is

   function PreisForschung
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum;
      IDExtern : in EinheitStadtDatentypen.ForschungID)
      return EinheitStadtDatentypen.KostenLager
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) /= SystemKonstanten.LeerSpielerKonstante);

   function AnforderungForschung
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum;
      IDExtern : in EinheitStadtDatentypen.ForschungID;
      WelcheAnforderungExtern : in Positive)
      return EinheitStadtDatentypen.ForschungIDNichtMöglich
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) /= SystemKonstanten.LeerSpielerKonstante);
   
   function GanzerEintrag
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum;
      IDExtern : in EinheitStadtDatentypen.ForschungID)
      return DatenbankRecords.ForschungListeRecord
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) /= SystemKonstanten.LeerSpielerKonstante);

end LeseForschungsDatenbank;
