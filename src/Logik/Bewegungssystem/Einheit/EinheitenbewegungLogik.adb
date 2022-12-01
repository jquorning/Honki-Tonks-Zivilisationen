with EinheitenDatentypen;
with StadtDatentypen;

with LeseEinheitenGebaut;

with EinheitSuchenLogik;
with PassierbarkeitspruefungLogik;
with DiplomatischerZustandLogik;
with KampfsystemEinheitenLogik;
with StadtSuchenLogik;
with KampfsystemStadtLogik;
with EinheitentransporterLogik;
with BewegungspunkteBerechnenLogik;
with TransporterBeladenEntladenLogik;

package body EinheitenbewegungLogik is
   
   function BewegungPrüfen
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
      return Boolean
   is
      use type EinheitenDatentypen.MaximaleEinheitenMitNullWert;
      use type StadtDatentypen.MaximaleStädteMitNullWert;
      use type RassenDatentypen.Rassen_Enum;
      use type KartenRecords.AchsenKartenfeldNaturalRecord;
   begin
            
      FeldPassierbar := PassierbarkeitspruefungLogik.PassierbarkeitPrüfenNummer (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                                                  NeueKoordinatenExtern    => KoordinatenExtern);
      EinheitAufFeld := EinheitSuchenLogik.KoordinatenEinheitOhneRasseSuchen (KoordinatenExtern => KoordinatenExtern,
                                                                              LogikGrafikExtern => True);
      
      Zielkoordinaten := LeseEinheitenGebaut.KIZielKoordinaten (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      
      if
        FeldPassierbar = False
        and
          EinheitAufFeld.Nummer = EinheitenKonstanten.LeerNummer
      then
         return False;
         
      elsif
        EinheitAufFeld.Rasse = EinheitRasseNummerExtern.Rasse
        and
          KoordinatenExtern = Zielkoordinaten
      then
         return Einheitentausch (BewegendeEinheitExtern => EinheitRasseNummerExtern,
                                 StehendeEinheitExtern  => EinheitAufFeld);
         
      elsif
        FeldPassierbar = False
      then
         return False;
         
      else
         StadtAufFeld := StadtSuchenLogik.KoordinatenStadtOhneSpezielleRasseSuchen (RasseExtern       => EinheitRasseNummerExtern.Rasse,
                                                                                    KoordinatenExtern => KoordinatenExtern);
      end if;
         
      if
        EinheitAufFeld.Rasse /= EinheitRasseNummerExtern.Rasse
        and
          EinheitAufFeld.Rasse /= EinheitenKonstanten.LeerRasse
          and
            StadtAufFeld.Nummer /= StadtKonstanten.LeerNummer              
      then
         if
           KoordinatenExtern /= Zielkoordinaten
         then
            return False;
            
         elsif
           False = FremderAufFeld (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                   FremdeEinheitExtern      => EinheitAufFeld)
         then
            return False;
               
         else
            BewegungDurchführen := FremdeStadtAufFeld (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                        FremdeStadtExtern        => StadtAufFeld);
         end if;
            
      elsif
        EinheitAufFeld.Rasse /= EinheitRasseNummerExtern.Rasse
        and
          EinheitAufFeld.Rasse /= EinheitenKonstanten.LeerRasse
      then
         if
           KoordinatenExtern /= Zielkoordinaten
         then
            return False;
         
         else  
            BewegungDurchführen := FremderAufFeld (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                    FremdeEinheitExtern      => EinheitAufFeld);
         end if;
      
      elsif
        StadtAufFeld.Nummer /= StadtKonstanten.LeerNummer
      then
         if
           KoordinatenExtern /= Zielkoordinaten
         then
            return False;
            
         else
            BewegungDurchführen := FremdeStadtAufFeld (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                        FremdeStadtExtern        => StadtAufFeld);
         end if;
         
      else
         BewegungDurchführen := True;
      end if;
      
      return BewegungDurchführen;
      
   end BewegungPrüfen;
   
   
   
   function FremderAufFeld
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      FremdeEinheitExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return Boolean
   is begin
            
      case
        DiplomatischerZustandLogik.GegnerAngreifen (EigeneRasseExtern      => EinheitRasseNummerExtern.Rasse,
                                                    GegnerischeRasseExtern => FremdeEinheitExtern.Rasse)
      is
         when False =>
            return False;
            
         when True =>
            return KampfsystemEinheitenLogik.KampfsystemNahkampf (AngreiferExtern    => EinheitRasseNummerExtern,
                                                                  VerteidigerExtern => FremdeEinheitExtern);
      end case;
      
   end FremderAufFeld;
   
   
   
   function FremdeStadtAufFeld
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      FremdeStadtExtern : in StadtRecords.RasseStadtnummerRecord)
      return Boolean
   is begin
      
      case
        DiplomatischerZustandLogik.GegnerAngreifen (EigeneRasseExtern      => EinheitRasseNummerExtern.Rasse,
                                                    GegnerischeRasseExtern => FremdeStadtExtern.Rasse)
      is
         when True =>
            return KampfsystemStadtLogik.KampfsystemStadt (AngreifendeEinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                           VerteidigendeStadtRasseNummerExtern => FremdeStadtExtern);
            
         when False =>
            return False;
      end case;
      
   end FremdeStadtAufFeld;
   
   
   
   function Einheitentausch
     (BewegendeEinheitExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      StehendeEinheitExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return Boolean
   is
      use type EinheitenDatentypen.Bewegungspunkte;
   begin
      
      if
        True = EinheitentransporterLogik.KannTransportiertWerden (LadungExtern      => BewegendeEinheitExtern,
                                                                  TransporterExtern => StehendeEinheitExtern)
        and then
          True = TransporterBeladenEntladenLogik.TransporterBeladen (TransporterExtern => StehendeEinheitExtern,
                                                                     LadungExtern      => BewegendeEinheitExtern.Nummer)
      then
         return False;
         
      else
         BewegendeKoordinaten := LeseEinheitenGebaut.Koordinaten (EinheitRasseNummerExtern => BewegendeEinheitExtern);
         StehendeKoordinaten := LeseEinheitenGebaut.Koordinaten (EinheitRasseNummerExtern => StehendeEinheitExtern);
      end if;
            
      if
        False = PassierbarkeitspruefungLogik.PassierbarkeitPrüfenNummer (EinheitRasseNummerExtern => StehendeEinheitExtern,
                                                                          NeueKoordinatenExtern    => BewegendeKoordinaten)
        or
          False = PassierbarkeitspruefungLogik.PassierbarkeitPrüfenNummer (EinheitRasseNummerExtern => BewegendeEinheitExtern,
                                                                            NeueKoordinatenExtern    => StehendeKoordinaten)
      then
         return False;
         
      elsif
        LeseEinheitenGebaut.Bewegungspunkte (EinheitRasseNummerExtern => StehendeEinheitExtern) < BewegungspunkteBerechnenLogik.Bewegungspunkte (NeueKoordinatenExtern    => BewegendeKoordinaten,
                                                                                                                                                 EinheitRasseNummerExtern => StehendeEinheitExtern)
        or
          LeseEinheitenGebaut.Bewegungspunkte (EinheitRasseNummerExtern => BewegendeEinheitExtern) < BewegungspunkteBerechnenLogik.Bewegungspunkte (NeueKoordinatenExtern    => StehendeKoordinaten,
                                                                                                                                                    EinheitRasseNummerExtern => BewegendeEinheitExtern)
      then
         return False;
         
      else
         -- BewegungsberechnungEinheitenLogik.Bewegungsberechnung (EinheitRasseNummerExtern => StehendeEinheitExtern,
         --                                                        NeueKoordinatenExtern    => BewegendeKoordinaten,
         --                                                        EinheitentauschExtern    => True);
         
         return True;
      end if;
      
   end Einheitentausch;

end EinheitenbewegungLogik;
