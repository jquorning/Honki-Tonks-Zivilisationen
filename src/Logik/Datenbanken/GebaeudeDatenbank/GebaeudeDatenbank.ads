pragma SPARK_Mode (On);

with SystemDatentypen;
with EinheitStadtDatentypen;

with DatenbankRecords;

package GebaeudeDatenbank is

   type GebäudeListeArray is array (SystemDatentypen.Rassen_Verwendet_Enum'Range, EinheitStadtDatentypen.GebäudeID'Range) of DatenbankRecords.GebäudeListeRecord;
   GebäudeListe : GebäudeListeArray;
   
   procedure StandardGebaeudeDatenbankLaden;
   
end GebaeudeDatenbank;