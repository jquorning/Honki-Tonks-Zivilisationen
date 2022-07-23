pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with ForschungenDatentypen; use ForschungenDatentypen;
with ProduktionDatentypen; use ProduktionDatentypen;
with GlobaleTexte;
with StadtKonstanten;
with TextKonstanten;

with SchreibeWichtiges;
with SchreibeStadtGebaut;
with LeseStadtGebaut;
with LeseGebaeudeDatenbank;

with GebaeudeRichtigeUmgebung;
with StadtProduktion;
with ForschungAllgemein;

package body GebaeudeAllgemein is

   -- Um die Aufrufe der ganzen Beschreibungen mal ein wenig zu reduzieren die Nullprüfung vor den Aufruf verlegen (überall?). äöü
   function BeschreibungKurz
     (IDExtern : in StadtDatentypen.GebäudeIDMitNullwert)
     return Wide_Wide_String
   is begin
      
      case
        IDExtern
      is
         when StadtDatentypen.GebäudeIDMitNullwert'First =>
            BeschreibungText := TextKonstanten.LeerUnboundedString;
            
         when others =>
            AktuellerText := 2 * Positive (IDExtern) - 1;
            
            BeschreibungText := GlobaleTexte.Gebäude (AktuellerText);
      end case;
      
      return To_Wide_Wide_String (Source => BeschreibungText);
      
   end BeschreibungKurz;
   
   
   
   function BeschreibungLang
     (IDExtern : in StadtDatentypen.GebäudeIDMitNullwert)
      return Wide_Wide_String
   is begin
      
      case
        IDExtern
      is
         when StadtDatentypen.GebäudeIDMitNullwert'First =>
            BeschreibungText := TextKonstanten.LeerUnboundedString;
            
         when others =>
            AktuellerText := 2 * Positive (IDExtern);
            
            BeschreibungText := GlobaleTexte.Gebäude (AktuellerText);
      end case;
      
      return To_Wide_Wide_String (Source => BeschreibungText);
      
   end BeschreibungLang;
   
   

   procedure GebäudeProduktionBeenden
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord;
      IDExtern : in StadtDatentypen.GebäudeID)
   is begin
      
      SchreibeStadtGebaut.Ressourcen (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                      RessourcenExtern       => StadtKonstanten.LeerRessourcen,
                                      ÄndernSetzenExtern     => False);
      SchreibeStadtGebaut.Bauprojekt (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                      BauprojektExtern       => StadtKonstanten.LeerBauprojekt);
      SchreibeStadtGebaut.GebäudeVorhanden (StadtRasseNummerExtern     => StadtRasseNummerExtern,
                                             WelchesGebäudeExtern       => IDExtern,
                                             HinzufügenEntfernenExtern  => True);
      
      PermanenteKostenDurchGebäudeÄndern (StadtRasseNummerExtern  => StadtRasseNummerExtern,
                                            IDExtern                => IDExtern,
                                            VorzeichenWechselExtern => 1);
                  
   end GebäudeProduktionBeenden;
   
   
   
   procedure GebäudeEntfernen
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord;
      WelchesGebäudeExtern : in StadtDatentypen.GebäudeID)
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
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord;
      IDExtern : in StadtDatentypen.GebäudeID;
      -- Der Vorzeichenwechsel wird benötigt um auch bei Entfernung von Gebäuden die permanenten Kosten korrekt zu ändern
      VorzeichenWechselExtern : in KartenDatentypen.UmgebungsbereichEins)
   is begin
      
      PermanenteKostenSchleife:
      for PermanenteKostenSchleifenwert in StadtRecords.PermanenteKostenArray'Range loop
         
         SchreibeStadtGebaut.PermanenteKostenPosten (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                                     WelcherPostenExtern    => PermanenteKostenSchleifenwert,
                                                     KostenExtern           => ProduktionDatentypen.Stadtproduktion (VorzeichenWechselExtern)
                                                     * LeseGebaeudeDatenbank.PermanenteKosten (RasseExtern        => StadtRasseNummerExtern.Rasse,
                                                                                               IDExtern           => IDExtern,
                                                                                               WelcheKostenExtern => PermanenteKostenSchleifenwert),
                                                     ÄndernSetzenExtern    => True);
         
      end loop PermanenteKostenSchleife;
      
      StadtProduktion.StadtProduktion (StadtRasseNummerExtern => StadtRasseNummerExtern);
      
   end PermanenteKostenDurchGebäudeÄndern;
   
   
   
   -- Hier vielleicht noch Prüfungen einbauen um zu testen ob das Gebäude für diese Rasse überhaupt existiert?
   function GebäudeAnforderungenErfüllt
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord;
      IDExtern : in StadtDatentypen.GebäudeID)
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
            return ForschungAllgemein.TechnologieVorhanden (RasseExtern       => StadtRasseNummerExtern.Rasse,
                                                            TechnologieExtern => LeseGebaeudeDatenbank.Anforderungen (RasseExtern => StadtRasseNummerExtern.Rasse,
                                                                                                                      IDExtern    => IDExtern));
      end case;
      
   end GebäudeAnforderungenErfüllt;

end GebaeudeAllgemein;
