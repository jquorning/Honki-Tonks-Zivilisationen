pragma SPARK_Mode (On);

with EinheitenDatenbank, EinheitSuchen, StadtSuchen, KartenDatenbank, GlobaleKonstanten;

package body BewegungEinheitenMoeglichPruefen is

   -- 0 = Einheit kann sich auf das Feld bewegen
   -- -1 = Bewegung dahin nicht möglich und da ist keine Stadt/Transporter auf die die Einheit sich bewegen kann
   -- 1 = Da ist ein Transporter mit freiem Platz
   function FeldFürDieseEinheitPassierbarNeu (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
                                               NeuePositionExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord) return GlobaleDatentypen.LoopRangeMinusEinsZuEins is
   begin
      
      PassierbarkeitNummer := KartenDatenbank.KartenListe (Karten.Weltkarte (NeuePositionExtern.EAchse, NeuePositionExtern.YAchse, NeuePositionExtern.XAchse).Grund).Passierbarkeit;
      
      if
        EinheitenDatenbank.EinheitenListe (EinheitRasseNummerExtern.Rasse, GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).ID).Passierbarkeit (PassierbarkeitNummer)
        = True
      then
         return 0;
         
      else
         null;
      end if;
      
      case
        EinheitenDatenbank.EinheitenListe (EinheitRasseNummerExtern.Rasse, GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).ID).Passierbarkeit (2)
      is
         when True => -- Hier noch prüfen ob es ein Transporter ist und Einheiten zum Ausladen dabei hat. Siehe auskommentierten Code weiter unten.
            StadtNummer := StadtSuchen.KoordinatenStadtMitRasseSuchen (RasseExtern       => EinheitRasseNummerExtern.Rasse,
                                                                       KoordinatenExtern => NeuePositionExtern);
         
            case
              StadtNummer
            is
               when GlobaleKonstanten.RückgabeEinheitStadtNummerFalsch =>
                  return -1;
               
               when others =>
                  return 0;
            end case;

            -- if
            -- EinheitenDatenbank.EinheitenListe (EinheitRasseNummerExtern.Rasse, GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).ID).KannTransportieren /= 0
            -- then
            -- Transportplatz := 0;
            -- BelegterPlatzSchleife:
            -- for BelegterPlatzSchleifenwert in GlobaleRecords.TransporterArray'Range loop
                        
            -- case
            -- GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, TransporterNummer).Transportiert (BelegterPlatzSchleifenwert)
            -- is
            -- when 0 =>
            -- null;
                              
            -- when others =>
            -- Transportplatz := 1;
            -- exit BelegterPlatzSchleife;
            -- end case;
                  
            -- end loop BelegterPlatzSchleife;

            -- case
            -- Transportplatz
            -- is
            -- when 0 =>
            -- return -1;
                           
            -- when others =>
            -- return 0;
            -- end case;
                     
         when False =>
            null;
      end case;

      case
        EinheitenDatenbank.EinheitenListe (EinheitRasseNummerExtern.Rasse, GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).ID).Passierbarkeit (1)
      is
         when True =>
            TransporterNummer := EinheitSuchen.KoordinatenTransporterMitRasseSuchen (RasseExtern       => EinheitRasseNummerExtern.Rasse,
                                                                                     KoordinatenExtern => NeuePositionExtern);

            case
              TransporterNummer
            is
               when GlobaleKonstanten.RückgabeEinheitStadtNummerFalsch =>
                  return -1;
               
               when others =>
                  if
                    EinheitenDatenbank.EinheitenListe (EinheitRasseNummerExtern.Rasse, GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).ID).KannTransportiertWerden > 0
                    and
                      EinheitenDatenbank.EinheitenListe (EinheitRasseNummerExtern.Rasse, GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).ID).KannTransportiertWerden 
                        <= EinheitenDatenbank.EinheitenListe (EinheitRasseNummerExtern.Rasse, GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, TransporterNummer).ID).KannTransportieren
                  then
                     Transportplatz := 0;
                     FreierPlatzSchleife:
                     for FreierPlatzSchleifenwert in GlobaleRecords.TransporterArray'Range loop
                        
                        case
                          GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, TransporterNummer).Transportiert (FreierPlatzSchleifenwert)
                        is
                           when 0 =>
                              Transportplatz := FreierPlatzSchleifenwert;
                              exit FreierPlatzSchleife;
                              
                           when others =>
                              null;
                        end case;
                        
                     end loop FreierPlatzSchleife;

                     case
                       Transportplatz
                     is
                        when 0 =>
                           return -1;
                           
                        when others =>
                           return 1;
                     end case;

                  else
                     return -1;
                  end if;
            end case;

         when False =>
            null;
      end case;
      
      return -1;

   end FeldFürDieseEinheitPassierbarNeu;

end BewegungEinheitenMoeglichPruefen;
