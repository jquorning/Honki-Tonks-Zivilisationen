pragma SPARK_Mode (On);

with GlobaleTexte, EinheitenKonstanten;

with SchreibeEinheitenGebaut;

with Anzeige;

package body AufgabenAllgemein is

   procedure Beschreibung
     (KartenVerbesserungExtern : in GlobaleDatentypen.Karten_Verbesserung_Enum)
   is begin
      
      case
        KartenVerbesserungExtern
      is
         when GlobaleDatentypen.Leer =>
            null;
            
         when others =>
            Anzeige.EinzeiligeAnzeigeOhneAuswahl (TextDateiExtern => GlobaleTexte.Beschreibungen_Verbesserungen_Kurz,
                                                  TextZeileExtern => GlobaleDatentypen.Karten_Verbesserung_Enum'Pos (KartenVerbesserungExtern));
      end case;
      
   end Beschreibung;
   
   
   
   procedure Nullsetzung
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
   is begin
      
      SchreibeEinheitenGebaut.Beschäftigung (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                              BeschäftigungExtern     => GlobaleDatentypen.Leer);
      SchreibeEinheitenGebaut.Beschäftigungszeit (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                   ZeitExtern               => EinheitenKonstanten.LeerEinheit.Beschäftigungszeit,
                                                   RechnenSetzenExtern      => 0);
      SchreibeEinheitenGebaut.BeschäftigungNachfolger (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                        BeschäftigungExtern     => GlobaleDatentypen.Leer);
      SchreibeEinheitenGebaut.BeschäftigungszeitNachfolger (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                             ZeitExtern               => EinheitenKonstanten.LeerEinheit.BeschäftigungszeitNachfolger,
                                                             RechnenSetzenExtern      => 0);
      
   end Nullsetzung;

end AufgabenAllgemein;
