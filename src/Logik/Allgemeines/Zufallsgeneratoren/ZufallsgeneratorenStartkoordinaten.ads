pragma SPARK_Mode (Off);
pragma Warnings (Off, "*array aggregate*");

with Ada.Numerics.Discrete_Random;

with KartenDatentypen; use KartenDatentypen;
with RassenDatentypen; use RassenDatentypen;
with SonstigeVariablen;
with KartenRecords;

with Karten;

package ZufallsgeneratorenStartkoordinaten is
     
   function Startkoordinaten
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return KartenRecords.AchsenKartenfeldNaturalRecord
     with
       Pre =>
         (SonstigeVariablen.RassenImSpiel (RasseExtern) /= RassenDatentypen.Leer_Spieler_Enum),
           
         Post =>
           (Startkoordinaten'Result.EAchse in -1 .. 0
            and
              Startkoordinaten'Result.YAchse <= Karten.Kartenparameter.Kartengröße.YAchse
            and
              Startkoordinaten'Result.XAchse <= Karten.Kartenparameter.Kartengröße.XAchse);

private
   
   EAchse : KartenDatentypen.EbeneVorhanden;
   
   YAchse : KartenDatentypen.KartenfeldPositiv;
   XAchse : KartenDatentypen.KartenfeldPositiv;
   
   YXAchsen : KartenRecords.YXAchsenKartenfeldPositivRecord;
   
   -- Generatoren für Positionsbestimmung bei Spielstart, in Abhängigkeit der Kartengröße, da gibt es doch bestimmt eine bessere Lösung für
   ZufallsPunktKarte : KartenRecords.AchsenKartenfeldNaturalRecord;

   package WerteWählen1000 is new Ada.Numerics.Discrete_Random (KartenDatentypen.KartenfeldPositiv);

   PositionGewählt1000 : WerteWählen1000.Generator;
      
   function StartPunkteYXFestlegen
     return KartenRecords.YXAchsenKartenfeldPositivRecord
     with
       Post =>
         (StartPunkteYXFestlegen'Result.YAchse <= Karten.Kartenparameter.Kartengröße.YAchse
          and
            StartPunkteYXFestlegen'Result.XAchse <= Karten.Kartenparameter.Kartengröße.XAchse);

end ZufallsgeneratorenStartkoordinaten;
