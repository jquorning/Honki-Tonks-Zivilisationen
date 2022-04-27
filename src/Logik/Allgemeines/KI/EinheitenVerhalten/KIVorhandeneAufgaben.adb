pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with EinheitStadtDatentypen; use EinheitStadtDatentypen;
with SystemDatentypen; use SystemDatentypen;
with KartenKonstanten;
with EinheitenKonstanten;
with StadtKonstanten;
with KartenVerbesserungDatentypen;

with KIDatentypen;

with SchreibeEinheitenGebaut;
with LeseEinheitenGebaut;
with LeseEinheitenDatenbank;
with LeseWichtiges;
with LeseRassenDatenbank;
with LeseStadtGebaut;

with EinheitSuchen;
with DiplomatischerZustand;

with KIAufgabenVerteilt;
with KIPruefungen;

package body KIVorhandeneAufgaben is

   function SichHeilen
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
      return EinheitStadtDatentypen.ProduktionSonstiges
   is begin
      
      EinheitID := LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      
      if
        LeseEinheitenGebaut.Lebenspunkte (EinheitRasseNummerExtern => EinheitRasseNummerExtern)
        = LeseEinheitenDatenbank.MaximaleLebenspunkte (RasseExtern => EinheitRasseNummerExtern.Rasse,
                                                       IDExtern    => EinheitID)
      then
         return 0;
         
      elsif
        LeseEinheitenGebaut.Lebenspunkte (EinheitRasseNummerExtern => EinheitRasseNummerExtern)
        > LeseEinheitenDatenbank.MaximaleLebenspunkte (RasseExtern => EinheitRasseNummerExtern.Rasse,
                                                       IDExtern    => EinheitID)
        / 3 * 2
      then
         return 3;
         
      elsif
        LeseEinheitenGebaut.Lebenspunkte (EinheitRasseNummerExtern => EinheitRasseNummerExtern)
        > LeseEinheitenDatenbank.MaximaleLebenspunkte (RasseExtern => EinheitRasseNummerExtern.Rasse,
                                                       IDExtern    => EinheitID)
        / 2
      then
         return 5;
         
      elsif
        LeseEinheitenGebaut.Lebenspunkte (EinheitRasseNummerExtern => EinheitRasseNummerExtern) = 1
      then
         return 10;
         
      else
         return 8;
      end if;
      
   end SichHeilen;
   
   
   
   function SichVerbessern
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
      return EinheitStadtDatentypen.ProduktionSonstiges
   is begin
      
      NotwendigeTechnologie := LeseEinheitenDatenbank.WirdVerbessertZu (RasseExtern => EinheitRasseNummerExtern.Rasse,
                                                                        IDExtern    => LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => EinheitRasseNummerExtern));
      
      case
        NotwendigeTechnologie
      is
         when EinheitStadtDatentypen.EinheitenIDMitNullWert'First =>
            return 0;
            
         when others =>
            null;
      end case;
      
      if
        LeseWichtiges.Erforscht (RasseExtern             => EinheitRasseNummerExtern.Rasse,
                                 WelcheTechnologieExtern => NotwendigeTechnologie)
        = True
      then
         return 3;
            
      else
         return 0;
      end if;
      
   end SichVerbessern;
   


   function NeueStadtBauenGehen
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
      return EinheitStadtDatentypen.ProduktionSonstiges
   is begin
      
      VorhandeneStädte := LeseWichtiges.AnzahlStädte (RasseExtern => EinheitRasseNummerExtern.Rasse);
      
      if
        VorhandeneStädte = EinheitenKonstanten.LeerNummer
      then
         SchreibeEinheitenGebaut.KIBeschäftigt (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                 AufgabeExtern            => KIDatentypen.Stadt_Bauen_Enum);
         return 11;
         
      elsif
        SpielVariablen.RundenAnzahl
          > (Positive (VorhandeneStädte)
             + KIAufgabenVerteilt.AufgabenVerteilt (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                    AufgabeExtern            => KIDatentypen.Stadt_Bauen_Enum))
        * 20
      then
         SchreibeEinheitenGebaut.KIBeschäftigt (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                 AufgabeExtern            => KIDatentypen.Stadt_Bauen_Enum);
         return 5;
         
      else
         null;
      end if;
      
      if
        LeseRassenDatenbank.RassenExpansion (EinheitRasseNummerExtern.Rasse) > 10
      then
         return 3;
         
      else
         return 2;
      end if;
      
   end NeueStadtBauenGehen;



   function StadtUmgebungVerbessern
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
      return EinheitStadtDatentypen.ProduktionSonstiges
   is begin
      
      case
        KIPruefungen.StadtUmgebungPrüfen (EinheitRasseNummerExtern => EinheitRasseNummerExtern).XAchse
      is
         when KartenKonstanten.LeerXAchse =>
            return 0;
            
         when others =>
            return 5;
      end case;
            
   end StadtUmgebungVerbessern;
   
   
   
   function StadtBewachen
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
      return EinheitStadtDatentypen.ProduktionSonstiges
   is begin
      
      EinheitNummer := 1;
      
      StadtSchleife:
      for StadtNummerSchleifenwert in SpielVariablen.StadtGebautArray'First (2) .. SpielVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Städtegrenze loop
         
         case
           LeseStadtGebaut.ID (StadtRasseNummerExtern => (EinheitRasseNummerExtern.Rasse, StadtNummerSchleifenwert))
         is
            when KartenVerbesserungDatentypen.Leer_Verbesserung_Enum =>
               null;
               
            when others =>
               EinheitNummer := EinheitSuchen.KoordinatenEinheitMitRasseSuchen (RasseExtern       => EinheitRasseNummerExtern.Rasse,
                                                                                KoordinatenExtern => LeseStadtGebaut.Koordinaten (StadtRasseNummerExtern => (EinheitRasseNummerExtern.Rasse, StadtNummerSchleifenwert)));
         end case;
         
         if
           EinheitNummer = EinheitenKonstanten.LeerNummer
           and
             KIAufgabenVerteilt.EinheitAufgabeZiel (AufgabeExtern         => KIDatentypen.Stadt_Bewachen_Enum,
                                                    RasseExtern           => EinheitRasseNummerExtern.Rasse,
                                                    ZielKoordinatenExtern => LeseStadtGebaut.Koordinaten (StadtRasseNummerExtern => (EinheitRasseNummerExtern.Rasse, StadtNummerSchleifenwert)))
           = False
         then
            return 10;
               
         else
            null;
         end if;
         
      end loop StadtSchleife;
      
      return 0;
                                    
   end StadtBewachen;
   
   
   
   function StadtUmgebungZerstören
     return EinheitStadtDatentypen.ProduktionSonstiges
   is begin
      
      return 0;
      
   end StadtUmgebungZerstören;
   
   
   
   function Angreifen
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
      return EinheitStadtDatentypen.ProduktionSonstiges
   is begin
      
      RassenSchleife:
      for RasseSchleifenwert in RassenDatentypen.Rassen_Verwendet_Enum'Range loop
         
         if
           SonstigeVariablen.RassenImSpiel (RasseSchleifenwert) = RassenDatentypen.Leer_Spieler_Enum
           or
             RasseSchleifenwert = EinheitRasseNummerExtern.Rasse
         then
            null;
            
         elsif
           DiplomatischerZustand.DiplomatischenStatusPrüfen (EigeneRasseExtern => EinheitRasseNummerExtern.Rasse,
                                                              FremdeRasseExtern => RasseSchleifenwert)
           = SystemDatentypen.Krieg_Enum
         then
            return 5;
            
         else
            null;
         end if;
         
      end loop RassenSchleife;
      
      return 0;
      
   end Angreifen;
   
   
   
   function Erkunden
     return EinheitStadtDatentypen.ProduktionSonstiges
   is begin
      
      return 2;
      
   end Erkunden;
   
   
   
   function EinheitAuflösen
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
      return EinheitStadtDatentypen.ProduktionSonstiges
   is begin
      
      if
        18 + LeseWichtiges.AnzahlStädte (RasseExtern => EinheitRasseNummerExtern.Rasse)
        < LeseWichtiges.AnzahlEinheiten (RasseExtern => EinheitRasseNummerExtern.Rasse)
      then
         return 3;
         
      else
         null;
      end if;
              
      case
        LeseEinheitenGebaut.Heimatstadt (EinheitRasseNummerExtern => EinheitRasseNummerExtern)
      is
         when 0 =>
            return 0;

         when others =>
            null;
      end case;

      KostenSchleife:
      for KostenSchleifenwert in EinheitStadtDatentypen.Permanente_Kosten_Verwendet_Enum'Range loop
         
         if
           LeseEinheitenDatenbank.PermanenteKosten (RasseExtern        => EinheitRasseNummerExtern.Rasse,
                                                    IDExtern           => LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => EinheitRasseNummerExtern),
                                                    WelcheKostenExtern => KostenSchleifenwert)
           = StadtKonstanten.LeerPermanenteKosten
         then
            null;
            
         else
            return 1;
         end if;
         
      end loop KostenSchleife;
                     
      return 0;
      
   end EinheitAuflösen;
   
                                    
   
   function Fliehen
     return EinheitStadtDatentypen.ProduktionSonstiges
   is begin
      
      return 0;
                                    
   end Fliehen;
   
   
   
   function SichBefestigen
     return EinheitStadtDatentypen.ProduktionSonstiges
   is begin
      
      return 0;
      
   end SichBefestigen;
   
   

   function NichtsTun
     return EinheitStadtDatentypen.ProduktionSonstiges
   is begin
      
      return 1;
      
   end NichtsTun;

end KIVorhandeneAufgaben;