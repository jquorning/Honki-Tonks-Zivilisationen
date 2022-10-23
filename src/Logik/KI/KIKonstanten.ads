pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with SpielDatentypen;

with KIDatentypen; use KIDatentypen;
with KIRecords;

package KIKonstanten is

   UnmöglichAufgabenbewertung : constant KIDatentypen.AufgabenWichtigkeitKlein := KIDatentypen.AufgabenWichtigkeitKlein'First;
   LeerAufgabenbewertung : constant KIDatentypen.AufgabenWichtigkeitKlein := 0;
   NichtsTunBewertung : constant KIDatentypen.AufgabenWichtigkeitKlein := LeerAufgabenbewertung + 1;
   PlatzFreiMachen : constant KIDatentypen.AufgabenWichtigkeitKlein := NichtsTunBewertung + 1;

   LeerEinheitIDBewertung : constant KIRecords.EinheitIDBewertungRecord := (0, 0);
   LeerGebäudeIDBewertung : constant KIRecords.GebäudeIDBewertungRecord := (0, 0);

   BewertungBewegungNullwert : constant KIDatentypen.BewegungBewertung := KIDatentypen.BewegungBewertung'First;
   BewertungBewegungZielpunkt : constant KIDatentypen.BewegungBewertung := KIDatentypen.BewegungBewertung'Last;

   BewegungAngriff : constant KIDatentypen.Bewegung_Enum := KIDatentypen.Belegt_Angriff_Enum;
   BewegungNormal : constant KIDatentypen.Bewegung_Enum := KIDatentypen.Unbelegt_Enum;
   KeineBewegung : constant KIDatentypen.Bewegung_Enum := KIDatentypen.Belegt_Kein_Angriff_Enum;

   type SchwierigkeitsgradArray is array (SpielDatentypen.Schwierigkeitsgrad_Enum'Range) of KIDatentypen.KINotAus;
   Schwierigkeitsgrad : constant SchwierigkeitsgradArray := (
                                                             SpielDatentypen.Schwierigkeitsgrad_Leicht_Enum => 1,
                                                             SpielDatentypen.Schwierigkeitsgrad_Mittel_Enum => 2,
                                                             SpielDatentypen.Schwierigkeitsgrad_Schwer_Enum => 5
                                                            );

end KIKonstanten;
