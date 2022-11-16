with RassenDatentypen;
with StadtDatentypen;
with GebaeudedatenbankRecord;

package GebaeudeDatenbank is
   pragma Preelaborate;

   type GebäudelisteArray is array (RassenDatentypen.Rassen_Verwendet_Enum'Range, StadtDatentypen.GebäudeID'Range) of GebaeudedatenbankRecord.GebäudelisteRecord;
   GebäudeListe : GebäudelisteArray;
   
end GebaeudeDatenbank;
