pragma SPARK_Mode (On);

with EinheitStadtDatentypen; use EinheitStadtDatentypen;
with EinheitenKonstanten;
with KartenKonstanten;

with LeseEinheitenGebaut;

with EinheitSuchen;
with BewegungPassierbarkeitPruefen;
with BewegungBerechnen;
with DiplomatischerZustand;
with BewegungLadenEntladen;
with KampfsystemEinheiten;
with StadtSuchen;
with KampfsystemStadt;
with EinheitenTransporter;
with KartePositionPruefen;

package body BewegungEinheiten is
   
   -- Hier wird True zurückgegeben wenn keine Bewegung stattfindet, damit klar ist dass noch eine weitere Bewegung stattfinden kann.
   function BewegungPrüfen
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      PositionÄnderungExtern : in KartenRecords.AchsenKartenfeldRecord)
      return Boolean
   is begin
      
      NeuePosition := KartePositionPruefen.KartenPositionBestimmen (KoordinatenExtern => LeseEinheitenGebaut.Position (EinheitRasseNummerExtern => EinheitRasseNummerExtern),
                                                                    ÄnderungExtern    => PositionÄnderungExtern,
                                                                    LogikGrafikExtern => True);
      
      case
        NeuePosition.XAchse
      is
         when KartenKonstanten.LeerXAchse =>
            return True;
            
         when others =>
            null;
      end case;
      
      FeldPassierbar := BewegungPassierbarkeitPruefen.PassierbarkeitPrüfenNummer (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                                                   NeuePositionExtern       => NeuePosition);
      
      EinheitAufFeld := EinheitSuchen.KoordinatenEinheitOhneRasseSuchen (KoordinatenExtern => NeuePosition);
      StadtAufFeld := StadtSuchen.KoordinatenStadtOhneSpezielleRasseSuchen (RasseExtern       => EinheitRasseNummerExtern.Rasse,
                                                                            KoordinatenExtern => NeuePosition);
      BewegungDurchführen := False;
      
      if
        FeldPassierbar = False
        and
          EinheitAufFeld.Platznummer = EinheitenKonstanten.LeerNummer
      then
         return True;
         
      elsif
        EinheitAufFeld.Rasse = EinheitRasseNummerExtern.Rasse
        and then
          EinheitenTransporter.KannTransportiertWerden (LadungExtern      => EinheitRasseNummerExtern,
                                                        TransporterExtern => EinheitAufFeld)
        = False
      then
         return True;
         
      elsif
        EinheitAufFeld.Rasse = EinheitRasseNummerExtern.Rasse
        and then
          EinheitenTransporter.KannTransportiertWerden (LadungExtern      => EinheitRasseNummerExtern,
                                                        TransporterExtern => EinheitAufFeld)
        = True
      then
         EigeneEinheitAufFeld (BewegendeEinheitExtern     => EinheitRasseNummerExtern,
                               FeldBelegendeEinheitExtern => EinheitAufFeld);
         
      elsif
        EinheitAufFeld.Rasse /= EinheitRasseNummerExtern.Rasse
        and
          EinheitAufFeld.Rasse /= EinheitenKonstanten.LeerRasse
      then
         if
           (FremderAufFeld (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                            FremdeEinheitExtern      => EinheitAufFeld)
            = True)
           and
             FeldPassierbar
         then
            BewegungDurchführen := True;
            
         else
            null;
         end if;
         
      elsif
        StadtAufFeld.Platznummer /= EinheitenKonstanten.LeerNummer
        and
          FeldPassierbar
      then
         case
           FremdeStadtAufFeld (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                               FremdeStadtExtern        => StadtAufFeld)
         is
            when False =>
               null;
               
            when True =>
               BewegungDurchführen := True;
         end case;
         
      else
         BewegungDurchführen := True;
      end if;
      
      case
        BewegungDurchführen
      is
         when True =>
            BewegungBerechnen.BewegungEinheitenBerechnung (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                           NeuePositionExtern       => NeuePosition);
            
         when False =>
            null;
      end case;
      
      return NochBewegungspunkte (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      
   end BewegungPrüfen;
   
   
   
   function NochBewegungspunkte
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
      return Boolean
   is begin
      
      if
        LeseEinheitenGebaut.Bewegungspunkte (EinheitRasseNummerExtern => EinheitRasseNummerExtern) = EinheitenKonstanten.LeerEinheit.Bewegungspunkte
        or
          LeseEinheitenGebaut.Lebenspunkte (EinheitRasseNummerExtern => EinheitRasseNummerExtern) = EinheitenKonstanten.LeerEinheit.Lebenspunkte
      then
         return False;
            
      else
         return True;
      end if;
      
   end NochBewegungspunkte;
   
   
   
   function FremderAufFeld
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      FremdeEinheitExtern : in EinheitStadtRecords.RassePlatznummerRecord)
      return Boolean
   is begin
            
      case
        DiplomatischerZustand.GegnerAngreifen (EigeneRasseExtern      => EinheitRasseNummerExtern.Rasse,
                                               GegnerischeRasseExtern => FremdeEinheitExtern.Rasse)
      is
         when False =>
            return False;
            
         when True =>
            null;
      end case;
      
      if
        KampfsystemEinheiten.KampfsystemNahkampf (AngreiferExtern    => EinheitRasseNummerExtern,
                                                  VerteidigerExtern => FremdeEinheitExtern)
        = True
      then
         case
           StadtAufFeld.Platznummer
         is
            when EinheitenKonstanten.LeerNummer =>
               return True;
                     
            when others =>
               null;
         end case;
               
      else
         null;
      end if;
      
      return False;
      
   end FremderAufFeld;
   
   
   
   function FremdeStadtAufFeld
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      FremdeStadtExtern : in EinheitStadtRecords.RassePlatznummerRecord)
      return Boolean
   is begin
      
      case
        DiplomatischerZustand.GegnerAngreifen (EigeneRasseExtern      => EinheitRasseNummerExtern.Rasse,
                                               GegnerischeRasseExtern => FremdeStadtExtern.Rasse)
      is
         when True =>
            return KampfsystemStadt.KampfsystemStadt (AngreifendeEinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                      VerteidigendeStadtRasseNummerExtern => FremdeStadtExtern);
            
         when False =>
            return False;
      end case;
      
   end FremdeStadtAufFeld;
   
   
   
   -- Hier vielleicht später mehr einbauen? Beispielsweise Plätzetauschen?
   procedure EigeneEinheitAufFeld
     (BewegendeEinheitExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      FeldBelegendeEinheitExtern : in EinheitStadtRecords.RassePlatznummerRecord)
   is begin
      
      BewegungLadenEntladen.TransporterBeladen (TransporterExtern => FeldBelegendeEinheitExtern,
                                                LadungExtern      => BewegendeEinheitExtern.Platznummer);
      
   end EigeneEinheitAufFeld;

end BewegungEinheiten;
