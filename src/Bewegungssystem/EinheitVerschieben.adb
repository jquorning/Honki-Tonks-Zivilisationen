pragma SPARK_Mode (On);

with GlobaleVariablen, GlobaleKonstanten;

with SchreibeEinheitenGebaut;
with LeseEinheitenGebaut, LeseStadtGebaut, LeseKarten;

with EinheitSuchen, KartePositionPruefen, BewegungPassierbarkeitPruefen;

package body EinheitVerschieben is
   
   procedure VonEigenemLandWerfen
     (RasseExtern, KontaktierteRasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      case
        GlobaleVariablen.Diplomatie (RasseExtern, KontaktierteRasseExtern).AktuellerZustand
      is
         when GlobaleDatentypen.Nichtangriffspakt | GlobaleDatentypen.Neutral =>
            EinheitNummer := 0;
            
         when others =>
            return;
      end case;
      
      StadtSchleife:
      for StadtSchleifenwert in GlobaleVariablen.StadtGebautArray'First (2) .. GlobaleVariablen.Grenzen (RasseExtern).Städtegrenze loop
         
         case
           LeseStadtGebaut.ID (StadtRasseNummerExtern => (RasseExtern, StadtSchleifenwert))
         is
            when GlobaleKonstanten.LeerStadtID =>
               null;
               
            when others =>
               YAchseSchleife:
               for YAchseSchleifenwert in -LeseStadtGebaut.UmgebungGröße (StadtRasseNummerExtern => (RasseExtern, StadtSchleifenwert))
                 .. LeseStadtGebaut.UmgebungGröße (StadtRasseNummerExtern => (RasseExtern, StadtSchleifenwert)) loop
                  XAchseSchleife:
                  for XAchseSchleifenwert in -LeseStadtGebaut.UmgebungGröße (StadtRasseNummerExtern => (RasseExtern, StadtSchleifenwert))
                    .. LeseStadtGebaut.UmgebungGröße (StadtRasseNummerExtern => (RasseExtern, StadtSchleifenwert)) loop
               
                     KartenWert := KartePositionPruefen.KartenPositionBestimmen (KoordinatenExtern => LeseStadtGebaut.Position (StadtRasseNummerExtern => (RasseExtern, StadtSchleifenwert)),
                                                                                 ÄnderungExtern   => (LeseStadtGebaut.Position (StadtRasseNummerExtern => (RasseExtern, StadtSchleifenwert)).EAchse,
                                                                                                       YAchseSchleifenwert,
                                                                                                       XAchseSchleifenwert));
                     
                     if
                       KartenWert.XAchse = GlobaleKonstanten.LeerYXKartenWert
                     then
                        null;
                        
                     elsif
                       LeseKarten.BelegterGrund (RasseExtern       => RasseExtern,
                                                 KoordinatenExtern => KartenWert)
                       = False
                     then
                        null;
                  
                     else               
                        EinheitNummer := EinheitSuchen.KoordinatenEinheitMitRasseSuchen (RasseExtern       => KontaktierteRasseExtern,
                                                                                         KoordinatenExtern => KartenWert);
                     end if;
               
                     case
                       EinheitNummer
                     is
                        when GlobaleKonstanten.LeerEinheitStadtNummer =>
                           null;
                     
                        when others =>
                           EinheitVerschieben (RasseLandExtern          => RasseExtern,
                                               EinheitRasseNummerExtern => (KontaktierteRasseExtern, EinheitNummer));
                     end case;
         
                  end loop XAchseSchleife;
               end loop YAchseSchleife;
         end case;
         
      end loop StadtSchleife;
      
   end VonEigenemLandWerfen;
   
   

   procedure EinheitVerschieben
     (RasseLandExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum;
      EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
   is begin
      
      UmgebungPrüfen := GlobaleDatentypen.Sichtweite'First;
      BereitsGeprüft := UmgebungPrüfen - 1;
      
      BereichSchleife:
      loop
         YAchseSchleife:
         for YAchseSchleifenwert in -UmgebungPrüfen .. UmgebungPrüfen loop
            XAchseSchleife:
            for XAchseSchleifenwert in -UmgebungPrüfen .. UmgebungPrüfen loop
                     
               KartenWertVerschieben := KartePositionPruefen.KartenPositionBestimmen (KoordinatenExtern => LeseEinheitenGebaut.Position (EinheitRasseNummerExtern => EinheitRasseNummerExtern),
                                                                                      ÄnderungExtern    => (0, YAchseSchleifenwert, XAchseSchleifenwert));
            
               if
                 KartenWertVerschieben.XAchse = GlobaleKonstanten.LeerYXKartenWert
               then
                  null;
               
               elsif
                 BereitsGeprüft >= abs (YAchseSchleifenwert)
                 and
                   BereitsGeprüft >= abs (XAchseSchleifenwert)
               then
                  null;
            
               elsif
                 LeseKarten.BelegterGrund (RasseExtern       => RasseLandExtern,
                                           KoordinatenExtern => KartenWertVerschieben)
                 = False
                 and
                   BewegungPassierbarkeitPruefen.PassierbarkeitPrüfenNummer (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                                              NeuePositionExtern       => KartenWertVerschieben)
                 = True
                 and
                   EinheitSuchen.KoordinatenEinheitOhneRasseSuchen (KoordinatenExtern => KartenWertVerschieben).Platznummer = GlobaleKonstanten.LeerEinheitStadtNummer
               then
                  SchreibeEinheitenGebaut.Position (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                    PositionExtern           => KartenWertVerschieben);
                  return;
                  
               else
                  null;
               end if;
         
            end loop XAchseSchleife;
         end loop YAchseSchleife;
         
         case
           UmgebungPrüfen
         is
            when GlobaleDatentypen.Sichtweite'Last =>
               return;
               
            when others =>
               BereitsGeprüft := UmgebungPrüfen;
               UmgebungPrüfen := UmgebungPrüfen + 1;
         end case;
         
      end loop BereichSchleife;
      
   end EinheitVerschieben;

end EinheitVerschieben;
