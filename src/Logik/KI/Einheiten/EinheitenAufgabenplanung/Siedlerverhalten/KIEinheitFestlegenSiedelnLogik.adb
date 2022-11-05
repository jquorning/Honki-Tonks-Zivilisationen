pragma Warnings (Off, "*array aggregate*");

with KartengrundDatentypen; use KartengrundDatentypen;
with KartenKonstanten;
with KartenRecordKonstanten;

with SchreibeEinheitenGebaut;
with LeseEinheitenGebaut;
with LeseWeltkarte;

with KartenkoordinatenberechnungssystemLogik;
with Vergleiche;

with KIDatentypen;

with KIKartenfeldbewertungModifizierenLogik;
with KIAufgabenVerteiltLogik;
with KIEinheitAllgemeinePruefungenLogik;

package body KIEinheitFestlegenSiedelnLogik is

   function StadtBauen
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return Boolean
   is begin
      
      NeueStadtKoordinaten := StadtfeldSuchen (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      
      case
        Vergleiche.KoordinateLeervergleich (KoordinateExtern => NeueStadtKoordinaten)
      is
         when True =>
            return False;
            
         when False =>
            SchreibeEinheitenGebaut.KIZielKoordinaten (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                       KoordinatenExtern        => NeueStadtKoordinaten);
            SchreibeEinheitenGebaut.KIBeschäftigt (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                    AufgabeExtern            => KIDatentypen.Stadt_Bauen_Enum);
            return True;
      end case;
      
   end StadtBauen;
   
    
   
   function StadtfeldSuchen
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return KartenRecords.AchsenKartenfeldNaturalRecord
   is begin
        
      UmgebungPrüfen := 0;
      BereitsGeprüft := 0;
            
      KartenfeldSuchenSchleife:
      loop
                  
         MöglichesFeld := NeuesStadtfeld (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                           UmgebungExtern           => UmgebungPrüfen,
                                           GeprüftExtern            => BereitsGeprüft);
         
         case
           MöglichesFeld.XAchse
         is
            when KartenKonstanten.LeerXAchse =>
               null;
               
            when others =>
               return MöglichesFeld;
         end case;
         
         -- Eventuell um die Einheit und dann um alle Städte herum prüfen? äöü
         if
           UmgebungPrüfen > 15
         then
            -- Dann hier um andere Städte/Einheiten herumloopen? äöü
            exit KartenfeldSuchenSchleife;
            
         else
            UmgebungPrüfen := UmgebungPrüfen + 1;
            BereitsGeprüft := UmgebungPrüfen - 1;
         end if;
         
      end loop KartenfeldSuchenSchleife;
      
      return KartenRecordKonstanten.LeerKoordinate;
      
   end StadtfeldSuchen;
     
   
   
   -- Hier die EAchse noch beim Suchen eines neuen Feldes berücksichtigen, da braucht es vermutlich zusätzliche Ausnahmeregeln da die oberen Bereiche ja nicht bewertet werden. äöü
   function NeuesStadtfeld
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      UmgebungExtern : in KartenDatentypen.KartenfeldNatural;
      GeprüftExtern : in KartenDatentypen.KartenfeldNatural)
      return KartenRecords.AchsenKartenfeldNaturalRecord
   is begin
      
      EinheitenKoordinaten := LeseEinheitenGebaut.Koordinaten (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
   
      EAchseSchleife:
      for EAchseSchleifenwert in KartenDatentypen.EbenenbereichEins loop
         YAchseSchleife:
         for YAchseSchleifenwert in -UmgebungExtern .. UmgebungExtern loop
            XAchseSchleife:
            for XAchseSchleifenwert in -UmgebungExtern .. UmgebungExtern loop
               
               if
                 GeprüftExtern > abs (YAchseSchleifenwert)
                 and
                   GeprüftExtern > abs (XAchseSchleifenwert)
               then
                  FeldGutUndFrei := False;
               
               else
                  MöglichesStadtfeld := KartenkoordinatenberechnungssystemLogik.Kartenkoordinatenberechnungssystem (KoordinatenExtern => EinheitenKoordinaten,
                                                                                                                     ÄnderungExtern    => (EAchseSchleifenwert, YAchseSchleifenwert, XAchseSchleifenwert),
                                                                                                                     LogikGrafikExtern => True);
               
                  if
                    MöglichesStadtfeld.XAchse = KartenKonstanten.LeerXAchse
                  then
                     FeldGutUndFrei := False;
                     
                  else
                     FeldGutUndFrei := KartenfeldUmgebungPrüfen (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                                  KoordinatenExtern        => MöglichesStadtfeld);
                  end if;
               end if;
            
               if
                 FeldGutUndFrei = False
               then
                  null;
               
               elsif
                 False = KIAufgabenVerteiltLogik.EinheitAufgabeZiel (AufgabeExtern         => KIDatentypen.Stadt_Bauen_Enum,
                                                                     RasseExtern           => EinheitRasseNummerExtern.Rasse,
                                                                     ZielKoordinatenExtern => MöglichesStadtfeld)
               then
                  return MöglichesStadtfeld;
               
               else
                  null;
               end if;
            
            end loop XAchseSchleife;
         end loop YAchseSchleife;
      end loop EAchseSchleife;
      
      return KartenRecordKonstanten.LeerKoordinate;
      
   end NeuesStadtfeld;
   
   
   
   function KartenfeldUmgebungPrüfen
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
      return Boolean
   is begin
      
      case
        KIEinheitAllgemeinePruefungenLogik.KartenfeldPrüfen (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                              KoordinatenExtern        => KoordinatenExtern)
      is
         when False =>
            return False;
            
         when True =>
            null;
      end case;
      
      -- Diese Prüfung hier mal rassenspezifisch erweitern? äöü
      if
        LeseWeltkarte.Basisgrund (KoordinatenExtern => KoordinatenExtern) = KartengrundDatentypen.Eis_Enum
      then
         return False;
         
      elsif
        False = KIKartenfeldbewertungModifizierenLogik.BewertungStadtBauen (KoordinatenExtern => KoordinatenExtern,
                                                                            RasseExtern       => EinheitRasseNummerExtern.Rasse)
      then
         return False;
         
      else
         return True;
      end if;
      
   end KartenfeldUmgebungPrüfen;

end KIEinheitFestlegenSiedelnLogik;
