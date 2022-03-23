pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with GlobaleTexte;
with EinheitenKonstanten;
with TastenbelegungDatentypen;

with SchreibeEinheitenGebaut;

package body AufgabenAllgemein is

   function BeschreibungVerbesserung
     (KartenVerbesserungExtern : in KartenVerbesserungDatentypen.Karten_Verbesserung_Vorhanden_Enum)
      return Wide_Wide_String
   is begin
      
      --------------- Text direkt returnen anstelle erst zuzuweisen? Auch bei den anderen Beschreibungen so anpassen?
      AktuelleVerbesserung := 2 * KartenVerbesserungDatentypen.Karten_Verbesserung_Vorhanden_Enum'Pos (KartenVerbesserungExtern) - 1;
               
      BeschreibungText := GlobaleTexte.Verbesserungen (AktuelleVerbesserung);
      
      return To_Wide_Wide_String (Source => BeschreibungText);
      
   end BeschreibungVerbesserung;
   
   

   function BeschreibungWeg
     (KartenWegExtern : in KartenVerbesserungDatentypen.Karten_Weg_Vorhanden_Enum)
      return Wide_Wide_String
   is begin
      
      AktuelleVerbesserung := 2 * KartenVerbesserungDatentypen.Karten_Weg_Vorhanden_Enum'Pos (KartenWegExtern) - 1;
               
      BeschreibungText := GlobaleTexte.Wege (AktuelleVerbesserung);
      
      return To_Wide_Wide_String (Source => BeschreibungText);
      
   end BeschreibungWeg;
   
   
   
   procedure Nullsetzung
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
   is begin
      
      SchreibeEinheitenGebaut.Beschäftigung (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                              BeschäftigungExtern     => TastenbelegungDatentypen.Leer_Tastenbelegung_Enum);
      SchreibeEinheitenGebaut.Beschäftigungszeit (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                   ZeitExtern               => EinheitenKonstanten.LeerEinheit.Beschäftigungszeit,
                                                   RechnenSetzenExtern      => 0);
      SchreibeEinheitenGebaut.BeschäftigungNachfolger (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                        BeschäftigungExtern     => TastenbelegungDatentypen.Leer_Tastenbelegung_Enum);
      SchreibeEinheitenGebaut.BeschäftigungszeitNachfolger (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                             ZeitExtern               => EinheitenKonstanten.LeerEinheit.BeschäftigungszeitNachfolger,
                                                             RechnenSetzenExtern      => 0);
      
   end Nullsetzung;

end AufgabenAllgemein;
