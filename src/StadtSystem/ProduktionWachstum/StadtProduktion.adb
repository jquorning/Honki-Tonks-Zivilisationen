pragma SPARK_Mode (On);

with GlobaleKonstanten;

with SchreibeStadtGebaut;
with LeseStadtGebaut;

with KartePositionPruefen, GesamtwerteFeld, Wachstum;

package body StadtProduktion is
   
   procedure StadtProduktion
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
   is begin
      
      case
        StadtRasseNummerExtern.Rasse
      is
         when GlobaleDatentypen.Leer =>
            StadtProduktionAlle;
            
         when others =>
            StadtProduktionBerechnung (StadtRasseNummerExtern => StadtRasseNummerExtern);
            Wachstum.WachstumWichtiges (RasseExtern => StadtRasseNummerExtern.Rasse);
      end case;
      
   end StadtProduktion;
   
   
   
   procedure StadtProduktionAlle
   is begin
      
      RassenSchleife:
      for RasseSchleifenwert in GlobaleDatentypen.Rassen_Verwendet_Enum'Range loop
               
         case
           GlobaleVariablen.RassenImSpiel (RasseSchleifenwert)
         is
            when GlobaleDatentypen.Leer =>
               null;
                     
            when others =>
               StadtSchleife:
               for StadtNummerSchleifenwert in GlobaleVariablen.StadtGebautArray'First (2) .. GlobaleVariablen.Grenzen (RasseSchleifenwert).Städtegrenze loop
                  
                  case
                    LeseStadtGebaut.ID (StadtRasseNummerExtern => (RasseSchleifenwert, StadtNummerSchleifenwert))
                  is
                     when GlobaleDatentypen.Leer =>
                        null;
                  
                     when others =>
                        StadtProduktionBerechnung (StadtRasseNummerExtern => (RasseSchleifenwert, StadtNummerSchleifenwert));
                  end case;
               
               end loop StadtSchleife;
               
               Wachstum.WachstumWichtiges (RasseExtern => RasseSchleifenwert);
         end case;
               
      end loop RassenSchleife;
      
   end StadtProduktionAlle;
   


   procedure StadtProduktionBerechnung
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
   is begin
      
      StadtProduktionNullSetzen (StadtRasseNummerExtern => StadtRasseNummerExtern);
      FelderProduktionBerechnen (StadtRasseNummerExtern => StadtRasseNummerExtern);
      
      WeitereNahrungsproduktionÄnderungen (StadtRasseNummerExtern => StadtRasseNummerExtern);
      WeitereProduktionrateÄnderungen (StadtRasseNummerExtern => StadtRasseNummerExtern);
      -- Geldgewinnung muss immer nach der Produktionsrate ausgeführt werden, da bei keinem Bauprojekt sonst die Ressourcenumwandlung nach Geld nicht korrekt ist.
      WeitereGeldgewinnungÄnderungen (StadtRasseNummerExtern => StadtRasseNummerExtern);
      WeitereForschungsrateÄnderungen (StadtRasseNummerExtern => StadtRasseNummerExtern);
      
   end StadtProduktionBerechnung;
   
   
   
   procedure FelderProduktionBerechnen
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
   is begin
            
      NutzbarerBereich := LeseStadtGebaut.UmgebungGröße (StadtRasseNummerExtern => StadtRasseNummerExtern);
      
      YAchseSchleife:
      for YÄnderungSchleifenwert in -NutzbarerBereich .. NutzbarerBereich loop
         XAchseSchleife:
         for XÄnderungSchleifenwert in -NutzbarerBereich .. NutzbarerBereich loop
            
            KartenWert := KartePositionPruefen.KartenPositionBestimmen (KoordinatenExtern => LeseStadtGebaut.Position (StadtRasseNummerExtern => StadtRasseNummerExtern),
                                                                        ÄnderungExtern    => (0, YÄnderungSchleifenwert, XÄnderungSchleifenwert));
            
            if
              KartenWert.XAchse = GlobaleKonstanten.LeerYXKartenWert
            then
               null;
               
            elsif
              LeseStadtGebaut.UmgebungBewirtschaftung (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                                       YPositionExtern        => YÄnderungSchleifenwert,
                                                       XPositionExtern        => XÄnderungSchleifenwert)
              = False
            then
               null;
               
            else
               SchreibeStadtGebaut.Nahrungsproduktion (StadtRasseNummerExtern   => StadtRasseNummerExtern,
                                                       NahrungsproduktionExtern => GesamtwerteFeld.FeldNahrung (KoordinatenExtern => KartenWert,
                                                                                                                RasseExtern       => StadtRasseNummerExtern.Rasse),
                                                       ÄndernSetzenExtern       => True);
               SchreibeStadtGebaut.Produktionrate (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                                   ProduktionrateExtern   => GesamtwerteFeld.FeldProduktion (KoordinatenExtern => KartenWert,
                                                                                                             RasseExtern       => StadtRasseNummerExtern.Rasse),
                                                   ÄndernSetzenExtern     => True);
               SchreibeStadtGebaut.Geldgewinnung (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                                  GeldgewinnungExtern    => GesamtwerteFeld.FeldGeld (KoordinatenExtern => KartenWert,
                                                                                                      RasseExtern       => StadtRasseNummerExtern.Rasse),
                                                  ÄndernSetzenExtern     => True);
               SchreibeStadtGebaut.Forschungsrate (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                                   ForschungsrateExtern   => GesamtwerteFeld.FeldWissen (KoordinatenExtern => KartenWert,
                                                                                                         RasseExtern       => StadtRasseNummerExtern.Rasse),
                                                   ÄndernSetzenExtern     => True);
            end if;
                           
         end loop XAchseSchleife;
      end loop YAchseSchleife;
      
   end FelderProduktionBerechnen;
   
   
   
   procedure StadtProduktionNullSetzen
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
   is begin
      
      SchreibeStadtGebaut.Nahrungsproduktion (StadtRasseNummerExtern   => StadtRasseNummerExtern,
                                              NahrungsproduktionExtern => GlobaleKonstanten.LeerStadt.Nahrungsproduktion,
                                              ÄndernSetzenExtern       => False);
      SchreibeStadtGebaut.Produktionrate (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                          ProduktionrateExtern   => GlobaleKonstanten.LeerStadt.Produktionrate,
                                          ÄndernSetzenExtern     => False);
      SchreibeStadtGebaut.Geldgewinnung (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                         GeldgewinnungExtern    => GlobaleKonstanten.LeerStadt.Geldgewinnung,
                                         ÄndernSetzenExtern     => False);
      SchreibeStadtGebaut.Forschungsrate (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                          ForschungsrateExtern   => GlobaleKonstanten.LeerStadt.Forschungsrate,
                                          ÄndernSetzenExtern     => False);
      SchreibeStadtGebaut.Korruption (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                      KorruptionExtern       => GlobaleKonstanten.LeerStadt.Korruption,
                                      ÄndernSetzenExtern     => False);
      
   end StadtProduktionNullSetzen;
   
   
   
   procedure WeitereNahrungsproduktionÄnderungen
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
   is begin
      
      SchreibeStadtGebaut.Nahrungsproduktion (StadtRasseNummerExtern   => StadtRasseNummerExtern,
                                              NahrungsproduktionExtern => -LeseStadtGebaut.PermanenteKostenPosten (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                                                                                                   WelcherPostenExtern    => GlobaleDatentypen.Nahrung),
                                              ÄndernSetzenExtern       => True);
      VorhandeneEinwohner := LeseStadtGebaut.EinwohnerArbeiter (StadtRasseNummerExtern  => StadtRasseNummerExtern,
                                                                EinwohnerArbeiterExtern => True);
      case
        VorhandeneEinwohner
      is
         -- Den Multiplikator immer Minus setzen, damit er später direkt einen negativen Wert übergibt, eventuelle für mehr nutzen, wenn Gebäude bestimmte Werte entsprechend beeinflussen.
         when 0 .. 3 =>
            NahrungsverbrauchEinwohnerMultiplikator := -0;
            
         when 4 .. 9 =>
            NahrungsverbrauchEinwohnerMultiplikator := -0;
            
         when 10 .. 19 =>
            NahrungsverbrauchEinwohnerMultiplikator := -0;
            
         when others =>
            NahrungsverbrauchEinwohnerMultiplikator := -0;
      end case;
      
      SchreibeStadtGebaut.Nahrungsproduktion (StadtRasseNummerExtern   => StadtRasseNummerExtern,
                                              NahrungsproduktionExtern => VorhandeneEinwohner * NahrungsverbrauchEinwohnerMultiplikator,
                                              ÄndernSetzenExtern      => True);
      
   end WeitereNahrungsproduktionÄnderungen;



   procedure WeitereProduktionrateÄnderungen
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
   is begin
      
      SchreibeStadtGebaut.Produktionrate (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                          ProduktionrateExtern   => -LeseStadtGebaut.PermanenteKostenPosten (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                                                                                             WelcherPostenExtern    => GlobaleDatentypen.Ressourcen),
                                          ÄndernSetzenExtern    => True);
            
      case
        -- Diesen Wert an der Bevölkerung und nicht an der Korruption messen?
        LeseStadtGebaut.Korruption (StadtRasseNummerExtern => StadtRasseNummerExtern)
      is
         -- Den Multiplikator immer Minus setzen, damit er später direkt einen negativen Wert übergibt, eventuelle für mehr nutzen, wenn Gebäude bestimmte Werte entsprechend beeinflussen.
         when 0 =>
            RessourcenverbrauchKorruptionMultiplikator := -0;
            
         when 1 .. 4 =>
            RessourcenverbrauchKorruptionMultiplikator := -0;
            
         when 5 .. 7 =>
            RessourcenverbrauchKorruptionMultiplikator := -0;
            
         when 8 .. 10 =>
            RessourcenverbrauchKorruptionMultiplikator := -0;
            
         when others =>
            RessourcenverbrauchKorruptionMultiplikator := -0;
      end case;
      
      SchreibeStadtGebaut.Produktionrate (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                          ProduktionrateExtern   => LeseStadtGebaut.EinwohnerArbeiter (StadtRasseNummerExtern  => StadtRasseNummerExtern,
                                                                                                       EinwohnerArbeiterExtern => True) * RessourcenverbrauchKorruptionMultiplikator,
                                          ÄndernSetzenExtern     => True);
      
   end WeitereProduktionrateÄnderungen;



   procedure WeitereGeldgewinnungÄnderungen
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
   is begin
      
      SchreibeStadtGebaut.Geldgewinnung (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                         GeldgewinnungExtern    => -LeseStadtGebaut.PermanenteKostenPosten (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                                                                                            WelcherPostenExtern    => GlobaleDatentypen.Geld),
                                         ÄndernSetzenExtern     => True);
      
      case
        LeseStadtGebaut.Bauprojekt (StadtRasseNummerExtern => StadtRasseNummerExtern)
      is
         when GlobaleKonstanten.LeerBauprojekt =>
            SchreibeStadtGebaut.Geldgewinnung (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                               GeldgewinnungExtern    => LeseStadtGebaut.Produktionrate (StadtRasseNummerExtern => StadtRasseNummerExtern) / 5,
                                               ÄndernSetzenExtern     => True);
            
         when others =>
            null;
      end case;

      case
        -- Diesen Wert an der Bevölkerung und nicht an der Korruption messen?
        LeseStadtGebaut.Korruption (StadtRasseNummerExtern => StadtRasseNummerExtern)
      is
         -- Den Multiplikator immer Minus setzen, damit er später direkt einen negativen Wert übergibt, eventuelle für mehr nutzen, wenn Gebäude bestimmte Werte entsprechend beeinflussen.
         when 0 =>
            GeldverbrauchKorruptionMultiplikator := -0;
            
         when 1 .. 4 =>
            GeldverbrauchKorruptionMultiplikator := -0;
            
         when 5 .. 7 =>
            GeldverbrauchKorruptionMultiplikator := -0;
            
         when 8 .. 10 =>
            GeldverbrauchKorruptionMultiplikator := -0;
            
         when others =>
            GeldverbrauchKorruptionMultiplikator := -0;
      end case;
      
      SchreibeStadtGebaut.Geldgewinnung (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                         GeldgewinnungExtern    => LeseStadtGebaut.EinwohnerArbeiter (StadtRasseNummerExtern  => StadtRasseNummerExtern,
                                                                                                      EinwohnerArbeiterExtern => True) * GeldverbrauchKorruptionMultiplikator,
                                         ÄndernSetzenExtern     => True);
      
   end WeitereGeldgewinnungÄnderungen;



   procedure WeitereForschungsrateÄnderungen
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
   is begin

      case
        -- Diesen Wert an der Bevölkerung und nicht an der Korruption messen?
        LeseStadtGebaut.Korruption (StadtRasseNummerExtern => StadtRasseNummerExtern)
      is
         -- Den Multiplikator immer Minus setzen, damit er später direkt einen negativen Wert übergibt, eventuelle für mehr nutzen, wenn Gebäude bestimmte Werte entsprechend beeinflussen.
         when 0 =>
            ForschungsverbrauchKorruptionMultiplikator := -0;
            
         when 1 .. 4 =>
            ForschungsverbrauchKorruptionMultiplikator := -0;
            
         when 5 .. 7 =>
            ForschungsverbrauchKorruptionMultiplikator := -0;
            
         when 8 .. 10 =>
            ForschungsverbrauchKorruptionMultiplikator := -0;
            
         when others =>
            ForschungsverbrauchKorruptionMultiplikator := -0;
      end case;
      
      SchreibeStadtGebaut.Forschungsrate (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                          ForschungsrateExtern   => LeseStadtGebaut.EinwohnerArbeiter (StadtRasseNummerExtern  => StadtRasseNummerExtern,
                                                                                                       EinwohnerArbeiterExtern => True) * ForschungsverbrauchKorruptionMultiplikator,
                                          ÄndernSetzenExtern     => True);
      
   end WeitereForschungsrateÄnderungen;

end StadtProduktion;