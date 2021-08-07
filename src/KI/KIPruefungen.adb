pragma SPARK_Mode (On);

with GlobaleKonstanten;

with KIKonstanten, KIDatentypen;

with KartePositionPruefen, EinheitSuchen, BewegungPassierbarkeitPruefen, KIAufgabenVerteilt, RassenAllgemein, Verbesserungen;

package body KIPruefungen is
   
   function StadtUmgebungPrüfen
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
      return GlobaleRecords.AchsenKartenfeldPositivRecord
   is begin
      
      VerbesserungAnlegen := KIKonstanten.NullKoordinate;      
      
      StadtSchleife:
      for StadtNummerSchleifenwert in GlobaleVariablen.StadtGebautArray'First (2) .. GlobaleVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Städtegrenze loop
         
         if
           GlobaleVariablen.StadtGebaut (EinheitRasseNummerExtern.Rasse, StadtNummerSchleifenwert).ID /= GlobaleDatentypen.Leer
         then
            VerbesserungAnlegen := StadtUmgebungUnverbessert (StadtRasseNummerExtern => (EinheitRasseNummerExtern.Rasse, StadtNummerSchleifenwert),
                                                              EinheitNummerExtern    => EinheitRasseNummerExtern.Platznummer);
            
         else
            null;
         end if;
         
         case
           VerbesserungAnlegen.XAchse
         is
            when GlobaleKonstanten.LeerYXKartenWert =>
               null;
               
            when others =>
               return VerbesserungAnlegen;
         end case;
         
      end loop StadtSchleife;
      
      return VerbesserungAnlegen;
      
   end StadtUmgebungPrüfen;
   
   
   
   function StadtUmgebungUnverbessert
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      EinheitNummerExtern : in GlobaleDatentypen.MaximaleEinheiten)
      return GlobaleRecords.AchsenKartenfeldPositivRecord
   is begin
      
      YAchseSchleife:
      for YÄnderungSchleifenwert in GlobaleDatentypen.LoopRangeMinusEinsZuEins'Range loop
         XAchseSchleife:
         for XÄnderungSchleifenwert in GlobaleDatentypen.LoopRangeMinusEinsZuEins'Range loop
            
            StadtVerbesserungUmgebungKoordinaten
              := KartePositionPruefen.KartenPositionBestimmen (KoordinatenExtern => GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Position,
                                                               ÄnderungExtern    => (0, YÄnderungSchleifenwert, XÄnderungSchleifenwert));
            
            case
              StadtVerbesserungUmgebungKoordinaten.XAchse
            is
               when GlobaleKonstanten.LeerYXKartenWert =>
                  null;
                  
               when others =>
                  EinheitAufFeld := EinheitSuchen.KoordinatenEinheitOhneRasseSuchen (KoordinatenExtern => StadtVerbesserungUmgebungKoordinaten);
            
                  if
                    BewegungPassierbarkeitPruefen.PassierbarkeitPrüfenNummer (EinheitRasseNummerExtern => (StadtRasseNummerExtern.Rasse, EinheitNummerExtern),
                                                                               NeuePositionExtern       => StadtVerbesserungUmgebungKoordinaten)
                    = True
                    and
                      Verbesserungen.BeliebigeVerbesserungHierAnlegbar (RasseExtern       => StadtRasseNummerExtern.Rasse,
                                                                        KoordinatenExtern => StadtVerbesserungUmgebungKoordinaten) = True
                    and
                      (Karten.Weltkarte (StadtVerbesserungUmgebungKoordinaten.EAchse,
                                         StadtVerbesserungUmgebungKoordinaten.YAchse,
                                         StadtVerbesserungUmgebungKoordinaten.XAchse).VerbesserungGebiet = GlobaleDatentypen.Leer
                       or
                         Karten.Weltkarte (StadtVerbesserungUmgebungKoordinaten.EAchse,
                                           StadtVerbesserungUmgebungKoordinaten.YAchse,
                                           StadtVerbesserungUmgebungKoordinaten.XAchse).VerbesserungWeg = GlobaleDatentypen.Leer)
                    and
                      (EinheitAufFeld.Platznummer = GlobaleKonstanten.LeerEinheitStadtNummer
                       or
                         EinheitAufFeld.Platznummer = EinheitNummerExtern)
                    and
                      Karten.Weltkarte (StadtVerbesserungUmgebungKoordinaten.EAchse, StadtVerbesserungUmgebungKoordinaten.YAchse, StadtVerbesserungUmgebungKoordinaten.XAchse).DurchStadtBelegterGrund
                  in
                    RassenAllgemein.RassenBelegungAnfang (RasseExtern => StadtRasseNummerExtern.Rasse) .. RassenAllgemein.RassenBelegungEnde (RasseExtern => StadtRasseNummerExtern.Rasse)
                  then               
                     case
                       KIAufgabenVerteilt.EinheitAufgabeZiel (AufgabeExtern         => KIDatentypen.Verbesserung_Anlegen,
                                                              RasseExtern           => StadtRasseNummerExtern.Rasse,
                                                              ZielKoordinatenExtern => StadtVerbesserungUmgebungKoordinaten)
                     is
                        when False =>
                           return StadtVerbesserungUmgebungKoordinaten;
                  
                        when True =>
                           null;
                     end case;
               
                  else
                     null;
                  end if;
            end case;
            
         end loop XAchseSchleife;
      end loop YAchseSchleife;
      
      return KIKonstanten.NullKoordinate;
      
   end StadtUmgebungUnverbessert;
   
   
   
   function UmgebungStadtBauenPrüfen     
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      MindestBewertungFeldExtern : in GlobaleDatentypen.GesamtproduktionStadt)
      return GlobaleRecords.AchsenKartenfeldPositivRecord
   is begin
      
      FeldGutUndFrei := KartenfeldUmgebungPrüfen (EinheitRasseNummerExtern   => EinheitRasseNummerExtern,
                                                   KoordinatenExtern          => GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Position,
                                                   MindestBewertungFeldExtern => MindestBewertungFeldExtern);
      
      case
        FeldGutUndFrei
      is
         when False =>
            null;
            
         when True =>
            return KIKonstanten.NullKoordinate;
      end case;
      
      YAchseKoordinatePrüfen := 1;
      XAchseKoordinatePrüfen := 1;
      YAchseKoordinatenSchonGeprüft := YAchseKoordinatePrüfen - 1;
      XAchseKoordinatenSchonGeprüft := XAchseKoordinatePrüfen - 1;
      
      KartenfeldSuchenSchleife:
      loop
         YAchseKartenfeldSuchenSchleife:
         for YAchseSchleifenwert in -YAchseKoordinatePrüfen .. YAchseKoordinatePrüfen loop
            XAchseKartenfeldSuchenSchleife:
            for XAchseSchleifenwert in -XAchseKoordinatePrüfen .. XAchseKoordinatePrüfen loop
               
               StadtBauenUmgebungKoordinaten := KartePositionPruefen.KartenPositionBestimmen (KoordinatenExtern    => GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, 
                                                                                              EinheitRasseNummerExtern.Platznummer).Position,
                                                                                              ÄnderungExtern       => (0, YAchseSchleifenwert, XAchseSchleifenwert));
            
                                         
               if
                 (YAchseKoordinatenSchonGeprüft >= abs YAchseSchleifenwert
                  and
                    XAchseKoordinatenSchonGeprüft >= abs XAchseSchleifenwert)
                 or
                   StadtBauenUmgebungKoordinaten.XAchse = GlobaleKonstanten.LeerYXKartenWert
               then
                  FeldGutUndFrei := False;
               
               else
                  FeldGutUndFrei := KartenfeldUmgebungPrüfen (EinheitRasseNummerExtern   => EinheitRasseNummerExtern,
                                                               KoordinatenExtern          => StadtBauenUmgebungKoordinaten,
                                                               MindestBewertungFeldExtern => MindestBewertungFeldExtern);
               end if;
               
               case
                 FeldGutUndFrei
               is
                  when False =>
                     null;
                     
                  when True =>
                     if
                       KIAufgabenVerteilt.EinheitAufgabeZiel (AufgabeExtern         => KIDatentypen.Stadt_Bauen,
                                                              RasseExtern           => EinheitRasseNummerExtern.Rasse,
                                                              ZielKoordinatenExtern => StadtBauenUmgebungKoordinaten)
                       = False
                     then
                        return StadtBauenUmgebungKoordinaten;
                  
                     else
                        null;
                     end if;
               end case;
            
            end loop XAchseKartenfeldSuchenSchleife;
         end loop YAchseKartenfeldSuchenSchleife;
         
         if
           YAchseKoordinatePrüfen >= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße
           and
             XAchseKoordinatePrüfen > Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße
         then
            exit KartenfeldSuchenSchleife;
            
         else
            null;
         end if;
         
         if
           YAchseKoordinatePrüfen < Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße
         then
            YAchseKoordinatePrüfen := YAchseKoordinatePrüfen + 1;
            YAchseKoordinatenSchonGeprüft := YAchseKoordinatePrüfen - 1;
            
         else
            null;
         end if;
            
         if
           XAchseKoordinatePrüfen <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße
         then
            XAchseKoordinatePrüfen := XAchseKoordinatePrüfen + 1;
            XAchseKoordinatenSchonGeprüft := XAchseKoordinatePrüfen - 1;
            
         else
            null;
         end if;
         
      end loop KartenfeldSuchenSchleife;
      
      return GlobaleKonstanten.LeerKartenPosition;
      
   end UmgebungStadtBauenPrüfen;
   
   
   
   function KartenfeldUmgebungPrüfen
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      KoordinatenExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord;
      MindestBewertungFeldExtern : in GlobaleDatentypen.GesamtproduktionStadt)
      return Boolean
   is begin
      
      EinheitAufFeld := EinheitSuchen.KoordinatenEinheitOhneRasseSuchen (KoordinatenExtern => KoordinatenExtern);
      
      if
        EinheitAufFeld.Platznummer = GlobaleKonstanten.LeerEinheitStadtNummer
        or
          EinheitAufFeld = EinheitRasseNummerExtern
      then
         null;
            
      else
         return False;
      end if;
      
      case
        Karten.Weltkarte (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse).DurchStadtBelegterGrund
      is
         when 0 =>
            null;
            
         when others =>
            return False;
      end case;
      
      if
        Karten.Weltkarte (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse).Felderwertung (EinheitRasseNummerExtern.Rasse) >= MindestBewertungFeldExtern
      then
         null;
         
      else
         return False;
      end if;
      
      case
        Karten.Weltkarte (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse).Grund
      is
         when GlobaleDatentypen.Eis | GlobaleDatentypen.Wasser | GlobaleDatentypen.Küstengewässer =>
            return False;
         
         when others =>
            null;
      end case;
      
      YAchseUmgebungSchleife:
      for YAchseUmgebungSchleifenwert in GlobaleDatentypen.LoopRangeMinusDreiZuDrei'Range loop
         XAchseUmgebungSchleife:
         for XAchseUmgebungSchleifenwert in GlobaleDatentypen.LoopRangeMinusDreiZuDrei'Range loop
            
            KartenWert := KartePositionPruefen.KartenPositionBestimmen (KoordinatenExtern => KoordinatenExtern,
                                                                        ÄnderungExtern    => (0, YAchseUmgebungSchleifenwert, XAchseUmgebungSchleifenwert));
            
            if
              KartenWert.XAchse = GlobaleKonstanten.LeerYXKartenWert
            then
               null;
               
            elsif
              Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).DurchStadtBelegterGrund > 0
            then
               return False;
               
            else
               null;
            end if;
            
         end loop XAchseUmgebungSchleife;
      end loop YAchseUmgebungSchleife;
      
      return True;
      
   end KartenfeldUmgebungPrüfen;

end KIPruefungen;
