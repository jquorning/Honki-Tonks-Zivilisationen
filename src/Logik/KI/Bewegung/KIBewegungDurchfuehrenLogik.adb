with EinheitenDatentypen;
with EinheitenKonstanten;
with KartenRecordKonstanten;

with SchreibeEinheitenGebaut;
with LeseEinheitenGebaut;
with LeseWeltkarte;
with LeseAllgemeines;

with BewegungsberechnungEinheitenLogik;
with EinheitSuchenLogik;
with KampfsystemEinheitenLogik;
with StadtSuchenLogik;
with KampfsystemStadtLogik;
with PassierbarkeitspruefungLogik;
with EinheitenbewegungLogik;

with KIKonstanten;
with KIDatentypen;

with KIBewegungsplanBerechnenLogik;
with KIBewegungAllgemeinLogik;
with KIBewegungsplanVereinfachenLogik;

package body KIBewegungDurchfuehrenLogik is
   
   procedure KIBewegung
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
   is
      use type KartenRecords.AchsenKartenfeldNaturalRecord;
      use type EinheitenDatentypen.Bewegungspunkte;
   begin
      
      Zielkoordinaten := LeseEinheitenGebaut.KIZielKoordinaten (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      
      BewegungSchleife:
      for BewegungSchleifenwert in KIDatentypen.KINotAus'First .. KIKonstanten.SchwierigkeitsgradBewegung (LeseAllgemeines.Schwierigkeitsgrad) loop
         
         case
           LeseEinheitenGebaut.Bewegungspunkte (EinheitRasseNummerExtern => EinheitRasseNummerExtern)
         is
            when EinheitenKonstanten.LeerBewegungspunkte =>
               if
                 LeseEinheitenGebaut.Koordinaten (EinheitRasseNummerExtern => EinheitRasseNummerExtern) = Zielkoordinaten
               then
                  SchreibeEinheitenGebaut.KIZielKoordinaten (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                             KoordinatenExtern        => KartenRecordKonstanten.LeerKoordinate);
                  SchreibeEinheitenGebaut.KIBewegungsplanLeeren (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
                  
               else
                  null;
               end if;
               
               return;
               
            when others =>
               null;
         end case;
            
         if
           LeseEinheitenGebaut.Koordinaten (EinheitRasseNummerExtern => EinheitRasseNummerExtern) = Zielkoordinaten
         then
            SchreibeEinheitenGebaut.KIZielKoordinaten (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                       KoordinatenExtern        => KartenRecordKonstanten.LeerKoordinate);
            SchreibeEinheitenGebaut.KIBewegungsplanLeeren (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
            return;
            
         elsif
           True = LeseWeltkarte.Sichtbar (KoordinatenExtern => Zielkoordinaten,
                                          RasseExtern       => EinheitRasseNummerExtern.Rasse)
           and
             False = PassierbarkeitspruefungLogik.PassierbarkeitPrüfenNummer (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                                               NeueKoordinatenExtern    => Zielkoordinaten)
         then
            SchreibeEinheitenGebaut.KIZielKoordinaten (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                       KoordinatenExtern        => KartenRecordKonstanten.LeerKoordinate);
            SchreibeEinheitenGebaut.KIBewegungsplanLeeren (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
            return;
            
         elsif
           KartenRecordKonstanten.LeerKoordinate = LeseEinheitenGebaut.KIBewegungPlan (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                                                       PlanschrittExtern        => 1)
         then
            case
              KIBewegungsplanBerechnenLogik.BewegungPlanen (EinheitRasseNummerExtern => EinheitRasseNummerExtern)
            is
               when True =>
                  null;
                  
               when False =>
                  return;
            end case;
            
         else
            BewegungDurchführen (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
         end if;
         
      end loop BewegungSchleife;
      
   end KIBewegung;



   procedure BewegungDurchführen
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
   is begin
      
      NeueKoordinaten := LeseEinheitenGebaut.KIBewegungPlan (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                             PlanschrittExtern        => 1);
      
      case
        KIBewegungAllgemeinLogik.FeldBetreten (FeldKoordinatenExtern    => NeueKoordinaten,
                                               EinheitRasseNummerExtern => EinheitRasseNummerExtern)
      is
         when KIKonstanten.BewegungNormal =>
            BewegtSich (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
            
         when KIKonstanten.Tauschbewegung =>
            -- SchreibeEinheitenGebaut.KIBewegungsplanLeeren (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
            -- Hier noch einmal genauer nachprüfen ob es auch wirklich funktioniert. äöü
            EinheitTauschen (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                             NeueKoordinatenExtern    => NeueKoordinaten);
            
         when KIKonstanten.KeineBewegung =>
            SchreibeEinheitenGebaut.KIBewegungsplanLeeren (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
            
         when KIKonstanten.BewegungAngriff =>
            Blockiert (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      end case;
      
   end BewegungDurchführen;
   
   
   
   procedure EinheitTauschen
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      NeueKoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
   is
      use type EinheitenDatentypen.MaximaleEinheitenMitNullWert;
   begin
            
      Tauscheinheit := (EinheitRasseNummerExtern.Rasse, EinheitSuchenLogik.KoordinatenEinheitMitRasseSuchen (RasseExtern       => EinheitRasseNummerExtern.Rasse,
                                                                                                             KoordinatenExtern => NeueKoordinatenExtern,
                                                                                                             LogikGrafikExtern => True));
      
      if
        Tauscheinheit.Nummer = EinheitRasseNummerExtern.Nummer
      then
         SchreibeEinheitenGebaut.KIBewegungsplanLeeren (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
         return;
         
      else
         null;
      end if;
      
      case
        EinheitenbewegungLogik.Einheitentausch (BewegendeEinheitExtern => EinheitRasseNummerExtern,
                                                StehendeEinheitExtern  => Tauscheinheit)
      is
         when True =>
            SchreibeEinheitenGebaut.KIBewegungsplanLeeren (EinheitRasseNummerExtern => Tauscheinheit);
            BewegtSich (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
            
         when False =>
            SchreibeEinheitenGebaut.KIBewegungsplanLeeren (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      end case;
      
   end EinheitTauschen;
   
   
   
   procedure BewegtSich
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
   is begin
      
      BewegungsberechnungEinheitenLogik.Bewegungsberechnung (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                             NeueKoordinatenExtern    => LeseEinheitenGebaut.KIBewegungPlan (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                                                                                             PlanschrittExtern        => 1),
                                                             EinheitentauschExtern    => False);
      
      KIBewegungsplanVereinfachenLogik.BewegungsplanVerschieben (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      
   end BewegtSich;
   
   
   
   procedure Blockiert
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
   is
      use type RassenDatentypen.Rassen_Enum;
   begin
      
      FremdeEinheit := EinheitSuchenLogik.KoordinatenEinheitOhneRasseSuchen (KoordinatenExtern => NeueKoordinaten,
                                                                             LogikGrafikExtern => True);
      FremdeStadt := StadtSuchenLogik.KoordinatenStadtOhneRasseSuchen (KoordinatenExtern => NeueKoordinaten);
            
      if
        FremdeStadt.Rasse = EinheitenKonstanten.LeerRasse
      then
         case
           KampfsystemEinheitenLogik.KampfsystemNahkampf (AngreiferExtern   => EinheitRasseNummerExtern,
                                                          VerteidigerExtern => FremdeEinheit)
         is
            when True =>
               BewegtSich (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
               
            when False =>
               null;
         end case;
         
      else
         case
           KampfsystemStadtLogik.KampfsystemStadt (AngreifendeEinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                   VerteidigendeStadtRasseNummerExtern => FremdeStadt)
         is
            when True =>
               BewegtSich (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
               
            when False =>
               null;
         end case;
      end if;
         
   end Blockiert;

end KIBewegungDurchfuehrenLogik;
