pragma SPARK_Mode (On);

with GlobaleTexte, GlobaleKonstanten;

with SchreibeWichtiges, SchreibeStadtGebaut;
with LeseStadtGebaut, LeseGebaeudeDatenbank;

with Anzeige, GebaeudeRichtigeUmgebung;

package body GebaeudeAllgemein is

   procedure Beschreibung
     (IDExtern : in GebäudeID)
   is begin
      
      Anzeige.EinzeiligeAnzeigeOhneAuswahl (TextDateiExtern => GlobaleTexte.Beschreibungen_Gebäude_Kurz,
                                            TextZeileExtern => Positive (IDExtern));

      -- Hier wichtige Werte einfügen
      -- Hier dann eine lange Textanzeige für eine Beschreibung des Gebäudes? Das auch für die Einheiten/Verbesserungen machen?
      
   end Beschreibung;
   
   

   procedure GebäudeProduktionBeenden
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      IDExtern : in GebäudeID)
   is begin     
      
      SchreibeStadtGebaut.Bauzeit (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                   BauzeitExtern          => GlobaleKonstanten.LeerStadt.Bauzeit,
                                   ÄndernSetzenExtern     => False);
      SchreibeStadtGebaut.Ressourcen (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                      RessourcenExtern       => GlobaleKonstanten.LeerStadt.Ressourcen,
                                      ÄndernSetzenExtern     => False);
      SchreibeStadtGebaut.Bauprojekt (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                      BauprojektExtern       => GlobaleKonstanten.LeerBauprojekt);
      SchreibeStadtGebaut.GebäudeVorhanden (StadtRasseNummerExtern     => StadtRasseNummerExtern,
                                             WelchesGebäudeExtern       => IDExtern,
                                             HinzufügenEntfernenExtern  => True);
      
      PermanenteKostenDurchGebäudeÄndern (StadtRasseNummerExtern  => StadtRasseNummerExtern,
                                            IDExtern                => IDExtern,
                                            VorzeichenWechselExtern => 1);
                  
   end GebäudeProduktionBeenden;
   
   
   
   procedure GebäudeEntfernen     
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      WelchesGebäudeExtern : in GlobaleDatentypen.GebäudeID)
   is begin
      
      SchreibeWichtiges.Geldmenge (RasseExtern         => StadtRasseNummerExtern.Rasse,
                                   GeldZugewinnExtern  => Integer (LeseGebaeudeDatenbank.PreisGeld (RasseExtern => StadtRasseNummerExtern.Rasse,
                                                                                                    IDExtern    => WelchesGebäudeExtern)) / 2,
                                   RechnenSetzenExtern => True);
      SchreibeStadtGebaut.GebäudeVorhanden (StadtRasseNummerExtern     => StadtRasseNummerExtern,
                                             WelchesGebäudeExtern      => WelchesGebäudeExtern,
                                             HinzufügenEntfernenExtern => False);
      
      PermanenteKostenDurchGebäudeÄndern (StadtRasseNummerExtern  => StadtRasseNummerExtern,
                                            IDExtern                => WelchesGebäudeExtern,
                                            VorzeichenWechselExtern => -1);
      
   end GebäudeEntfernen;
   
   

   procedure PermanenteKostenDurchGebäudeÄndern
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      IDExtern : in GlobaleDatentypen.GebäudeID;
      -- Der Vorzeichenwechsel wird benötigt um auch bei Entfernung von Gebäuden die permanenten Kosten korrekt zu ändern
      VorzeichenWechselExtern : in GlobaleDatentypen.LoopRangeMinusEinsZuEins)
   is begin
      
      PermanenteKostenSchleife:
      for PermanenteKostenSchleifenwert in GlobaleRecords.PermanenteKostenArray'Range loop
         
         SchreibeStadtGebaut.PermanenteKostenPosten (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                                     WelcherPostenExtern    => PermanenteKostenSchleifenwert,
                                                     KostenExtern           => GesamtePermanenteKosten (VorzeichenWechselExtern)
                                                     * LeseGebaeudeDatenbank.PermanenteKosten (RasseExtern        => StadtRasseNummerExtern.Rasse,
                                                                                               IDExtern           => IDExtern,
                                                                                               WelcheKostenExtern => PermanenteKostenSchleifenwert),
                                                     ÄndernSetzenExtern    => True);
         
      end loop PermanenteKostenSchleife;
      
   end PermanenteKostenDurchGebäudeÄndern;
   
   
   
   -- Hier vielleicht noch Prüfungen einbauen um zu testen ob das Gebäude für diese Rasse überhaupt existiert?
   function GebäudeAnforderungenErfüllt
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      IDExtern : in GlobaleDatentypen.GebäudeID)
      return Boolean
   is begin
      
      case
        LeseStadtGebaut.GebäudeVorhanden (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                           WelchesGebäudeExtern  => IDExtern)
      is
         when True =>
            return False;
            
         when False =>
            null;
      end case;
      
      case
        GebaeudeRichtigeUmgebung.RichtigeUmgebungVorhanden (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                                            GebäudeIDExtern        => IDExtern)
      is
         when False =>
            return False;
            
         when True =>
            null;
      end case;
      
      if
        LeseGebaeudeDatenbank.Anforderungen (RasseExtern => StadtRasseNummerExtern.Rasse,
                                             IDExtern    => IDExtern)
        = GlobaleKonstanten.LeerForschungAnforderung
        or else
          GlobaleVariablen.Wichtiges (StadtRasseNummerExtern.Rasse).Erforscht (LeseGebaeudeDatenbank.Anforderungen (RasseExtern => StadtRasseNummerExtern.Rasse,
                                                                                                                    IDExtern    => IDExtern))
        = True
      then
         return True;
      
      else
         return False;
      end if;
      
   end GebäudeAnforderungenErfüllt;

end GebaeudeAllgemein;
