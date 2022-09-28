pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with EinheitenDatentypen; use EinheitenDatentypen;
with StadtDatentypen; use StadtDatentypen;
with KartenRecords; use KartenRecords;
with EinheitenKonstanten;
with KartenKonstanten;
with StadtKonstanten;

with LeseEinheitenGebaut;
with LeseEinheitenDatenbank;

with EinheitSuchenLogik;
with PassierbarkeitspruefungLogik;
with BewegungsberechnungEinheitenLogik;
with DiplomatischerZustandLogik;
with LadungsbewegungLogik;
with KampfsystemEinheitenLogik;
with StadtSuchenLogik;
with KampfsystemStadtLogik;
with EinheitentransporterLogik;
with KartenkoordinatenberechnungssystemLogik;

package body EinheitenbewegungLogik is
   
   -- Hier wird True zurückgegeben wenn keine Bewegung stattfindet, damit klar ist dass noch eine weitere Bewegung stattfinden kann.
   function BewegungPrüfen
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      PositionÄnderungExtern : in KartenRecords.AchsenKartenfeldRecord)
      return Boolean
   is begin
      
      NeueKoordinaten := KartenkoordinatenberechnungssystemLogik.Kartenkoordinatenberechnungssystem (KoordinatenExtern => LeseEinheitenGebaut.Koordinaten (EinheitRasseNummerExtern => EinheitRasseNummerExtern),
                                                                                                     ÄnderungExtern    => PositionÄnderungExtern,
                                                                                                     LogikGrafikExtern => True);
      
      case
        NeueKoordinaten.XAchse
      is
         when KartenKonstanten.LeerXAchse =>
            return True;
            
         when others =>
            null;
      end case;
      
      FeldPassierbar := PassierbarkeitspruefungLogik.PassierbarkeitPrüfenNummer (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                                                  NeueKoordinatenExtern       => NeueKoordinaten);
      
      EinheitAufFeld := EinheitSuchenLogik.KoordinatenEinheitOhneRasseSuchen (KoordinatenExtern => NeueKoordinaten,
                                                                              LogikGrafikExtern => True);
      StadtAufFeld := StadtSuchenLogik.KoordinatenStadtOhneSpezielleRasseSuchen (RasseExtern       => EinheitRasseNummerExtern.Rasse,
                                                                                 KoordinatenExtern => NeueKoordinaten);
      BewegungDurchführen := False;
      
      if
        FeldPassierbar = False
        and
          EinheitAufFeld.Nummer = EinheitenKonstanten.LeerNummer
      then
         return True;
         
      elsif
        EinheitAufFeld.Rasse = EinheitRasseNummerExtern.Rasse
      then
         BewegungDurchführen := EigeneEinheitAufFeld (BewegendeEinheitExtern     => EinheitRasseNummerExtern,
                                                       FeldBelegendeEinheitExtern => EinheitAufFeld);
         
      elsif
        EinheitAufFeld.Rasse /= EinheitRasseNummerExtern.Rasse
        and
          EinheitAufFeld.Rasse /= EinheitenKonstanten.LeerRasse
      then
         if
           FeldPassierbar
           and
             (True = FremderAufFeld (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                     FremdeEinheitExtern      => EinheitAufFeld))
         then
            BewegungDurchführen := True;
            
         else
            null;
         end if;
         
      elsif
        StadtAufFeld.Nummer /= StadtKonstanten.LeerNummer
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
            BewegungsberechnungEinheitenLogik.Bewegungsberechnung (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                                   NeueKoordinatenExtern    => NeueKoordinaten,
                                                                   EinheitentauschExtern    => False);
            
         when False =>
            null;
      end case;
      
      return NochBewegungspunkte (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      
   end BewegungPrüfen;
   
   
   
   -- Wird auch in KIEinheitHandlungen verwendet.
   function NochBewegungspunkte
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return Boolean
   is begin
      
      if
        LeseEinheitenGebaut.Bewegungspunkte (EinheitRasseNummerExtern => EinheitRasseNummerExtern) = EinheitenKonstanten.LeerBewegungspunkte
        or
          LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => EinheitRasseNummerExtern) = EinheitenKonstanten.LeerID
      then
         return False;
            
      else
         return True;
      end if;
      
   end NochBewegungspunkte;
   
   
   
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
            null;
      end case;
      
      if
        True = KampfsystemEinheitenLogik.KampfsystemNahkampf (AngreiferExtern    => EinheitRasseNummerExtern,
                                                              VerteidigerExtern => FremdeEinheitExtern)
      then
         case
           EinheitAufFeld.Nummer
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
   
   
   
   -- Das hier noch einmal überarbeiten, vermutlich muss ich dazu auch die BewegungsberechnungLogik überarbeien. äöü 
   function EigeneEinheitAufFeld
     (BewegendeEinheitExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      FeldBelegendeEinheitExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return Boolean
   is begin
      
      case
        EinheitentransporterLogik.KannTransportiertWerden (LadungExtern      => BewegendeEinheitExtern,
                                                           TransporterExtern => EinheitAufFeld)
      is
         when True =>
            if
              True = LadungsbewegungLogik.TransporterBeladen (TransporterExtern => FeldBelegendeEinheitExtern,
                                                              LadungExtern      => BewegendeEinheitExtern.Nummer)
            then
               return False;
               
            else
               null;
            end if;
            
         when False =>
            null;
      end case;
      
      Tauschkoordinaten := LeseEinheitenGebaut.Koordinaten (EinheitRasseNummerExtern => BewegendeEinheitExtern);
      
      if
        False = PassierbarkeitspruefungLogik.PassierbarkeitPrüfenNummer (EinheitRasseNummerExtern => FeldBelegendeEinheitExtern,
                                                                          NeueKoordinatenExtern    => Tauschkoordinaten)
      then
         return False;
         
      elsif
        ((EinheitenDatentypen.Kein_Transport_Enum /= LeseEinheitenDatenbank.KannTransportieren (RasseExtern => FeldBelegendeEinheitExtern.Rasse,
                                                                                                IDExtern    => LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => FeldBelegendeEinheitExtern))
          and
            StadtKonstanten.LeerNummer /= StadtSuchenLogik.KoordinatenStadtMitRasseSuchen (RasseExtern       => FeldBelegendeEinheitExtern.Rasse,
                                                                                           KoordinatenExtern => Tauschkoordinaten))
         and then
         False = PassierbarkeitspruefungLogik.InStadtEntladbar (TransporterExtern     => FeldBelegendeEinheitExtern,
                                                                NeueKoordinatenExtern => Tauschkoordinaten))
        or
          ((EinheitenDatentypen.Kein_Transport_Enum /= LeseEinheitenDatenbank.KannTransportieren (RasseExtern => BewegendeEinheitExtern.Rasse,
                                                                                                  IDExtern    => LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => BewegendeEinheitExtern))
            and
              StadtKonstanten.LeerNummer /= StadtSuchenLogik.KoordinatenStadtMitRasseSuchen (RasseExtern       => FeldBelegendeEinheitExtern.Rasse,
                                                                                             KoordinatenExtern => Tauschkoordinaten))
           and then
           False = PassierbarkeitspruefungLogik.InStadtEntladbar (TransporterExtern     => BewegendeEinheitExtern,
                                                                  NeueKoordinatenExtern => Tauschkoordinaten))
      then
         return False;
         
      elsif
        LeseEinheitenGebaut.Bewegungspunkte (EinheitRasseNummerExtern => FeldBelegendeEinheitExtern) < BewegungsberechnungEinheitenLogik.AbzugDurchBewegung (NeueKoordinatenExtern    => Tauschkoordinaten,
                                                                                                                                                             EinheitRasseNummerExtern => FeldBelegendeEinheitExtern)
      then
         return False;
         
      else
         BewegungsberechnungEinheitenLogik.Bewegungsberechnung (EinheitRasseNummerExtern => FeldBelegendeEinheitExtern,
                                                                NeueKoordinatenExtern    => Tauschkoordinaten,
                                                                EinheitentauschExtern    => True);
      
         return True;
      end if;
      
   end EigeneEinheitAufFeld;
   
   
   
   function PositionÄndern
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      ÄnderungExtern : in KartenRecords.AchsenKartenfeldRecord)
      return Boolean
   is begin
      
      if
        ÄnderungExtern = KeineÄnderung
      then
         return NochBewegungspunkte (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
            
      else
         return BewegungPrüfen (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                 PositionÄnderungExtern   => ÄnderungExtern);
      end if;
      
   end PositionÄndern;

end EinheitenbewegungLogik;