package body BefehleImSpiel is

   function Befehle (RasseExtern : in Integer) return Integer is
   begin
            
      Get_Immediate (Item => Taste);

      case To_Lower (Item => Taste) is
         when 'w' | 's' | 'a' | 'd' | '1' | '2' | '3' | '4' | '6' | '7' | '8' | '9' =>
            BewegungssystemCursor.BewegungCursorRichtung (Karte       => True,
                                                          Richtung    => To_Lower (Item => Taste),
                                                          RasseExtern => RasseExtern);
            return 1;
            
         when 'e' | '5' => -- Einheit bewegen/Stadt betreten
            WertEinheit := SchleifenPruefungen.KoordinatenEinheitMitRasseSuchen (RasseExtern  => RasseExtern,
                                                                                 YAchse       => GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.YAchse,
                                                                                 XAchse       => GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.XAchse);
            WertStadt := SchleifenPruefungen.KoordinatenStadtMitRasseSuchen (RasseExtern  => RasseExtern,
                                                                             YAchse       => GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.YAchse,
                                                                             XAchse       => GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.XAchse);

            if WertEinheit /= 0 and WertStadt /= 0 then
               StadtOderEinheit := Auswahl.Auswahl (WelcheAuswahl => 15,
                                                    WelcherText => 18);

               EinheitOderStadt (RasseExtern         => RasseExtern,
                                 Auswahl             => StadtOderEinheit,
                                 Stadtnummer         => WertStadt,
                                 EinheitNummer       => WertEinheit);
               
               
            elsif WertStadt /= 0 then
               EinheitOderStadt (RasseExtern         => RasseExtern,
                                 Auswahl             => -3,
                                 Stadtnummer         => WertStadt,
                                 EinheitNummer       => WertEinheit);
               
            elsif WertEinheit /= 0 then
               EinheitOderStadt (RasseExtern         => RasseExtern,
                                 Auswahl             => 654, -- Hauptsache ungleich -3
                                 Stadtnummer         => WertStadt,
                                 EinheitNummer       => WertEinheit);
               
            else
               null;
            end if;
            return 1;
            
         when 'q' => -- Menüaufruf
            return Auswahl.Auswahl (WelcheAuswahl => 0,
                                    WelcherText => 8);

         when 'b' => -- Baue Stadt
            WertEinheit := SchleifenPruefungen.KoordinatenEinheitMitRasseSuchen (RasseExtern  => RasseExtern,
                                                                                 YAchse       => GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.YAchse,
                                                                                 XAchse       => GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.XAchse);
            case WertEinheit is
               when 0 =>
                  null;
                  
               when others =>
                  if EinheitenDatenbank.EinheitenListe (RasseExtern, GlobaleVariablen.EinheitenGebaut (RasseExtern, WertEinheit).ID).SiedlerLandeinheitSeeeinheitLufteinheit = 1 and
                    GlobaleVariablen.EinheitenGebaut (RasseExtern, WertEinheit).AktuelleBewegungspunkte > 0.00 then
                     Nullwert := InDerStadt.StadtBauen (RasseExtern   => RasseExtern,
                                                        EinheitNummer => WertEinheit);
                     
                  else
                     null;
                  end if;
            end case;               
            return 1;
            
         when 't' => -- Technologie/Forschung
            case GlobaleVariablen.Wichtiges (RasseExtern).AktuellesForschungsprojekt is
               when 0 =>
                  ForschungsDatenbank.Forschung (RasseExtern => RasseExtern);
                     
               when others =>
                  WahlForschung := Auswahl.Auswahl (WelcheAuswahl => 17,
                                                    WelcherText => 18);
                  case WahlForschung is
                     when -3 =>
                        ForschungsDatenbank.Forschung (RasseExtern => RasseExtern);
                     
                     when others =>
                        null;
                  end case;
            end case;            
            return 1;
            
         when '/' => -- Nächste Stadt
            NaechstesObjekt.NächsteStadt (RasseExtern => RasseExtern);
            return 1;
            
         when '.' => -- Einheiten mit Bewegungspunkten
            NaechstesObjekt.NächsteEinheitMitBewegungspunkten (RasseExtern => RasseExtern);
            return 1;
            
         when '*' => -- Alle Einheiten
            NaechstesObjekt.NächsteEinheit (RasseExtern => RasseExtern);
            return 1;
            
         when ',' => -- Einheiten ohne Bewegungspunkte
            NaechstesObjekt.NächsteEinheitOhneBewegungspunkte (RasseExtern => RasseExtern);
            return 1;
            
         when 'l' | 'm' | 'f' | 'u' | 'z' | 'p' | 'h' | 'v' | Space | DEL | 'j' => -- l/1 = Straße, m/2 = Mine, f/3 = Farm, u/4 = Festung, z/5 = Wald aufforsten, p/6 = /Roden-Trockenlegen,
                                                                                   -- h/7 = Heilen, v/8 = Verschanzen Space/9 = Runde aussetzen, DEL/10 = Einheit auflösen, j/11 = Plündern
            case To_Lower (Taste) is
               when 'l' =>
                  WelcherBefehl := 1;
                  
               when 'm' =>
                  WelcherBefehl := 2;
                  
               when 'f' =>
                  WelcherBefehl := 3;
                  
               when 'u' =>
                  WelcherBefehl := 4;
                  
               when 'z' =>
                  WelcherBefehl := 5;
                  
               when 'p' =>
                  WelcherBefehl := 6;
                  
               when 'h' =>
                  WelcherBefehl := 7;
                  
               when 'v' =>
                  WelcherBefehl := 8;

               when Space =>
                  WelcherBefehl := 9;
                  
               when DEL =>
                  WelcherBefehl := 10;

               when 'j' =>
                  WelcherBefehl := 11;
                  
               when others =>
                  WelcherBefehl := 0;
            end case;
               
            WertEinheit := SchleifenPruefungen.KoordinatenEinheitMitRasseSuchen (RasseExtern  => RasseExtern,
                                                                                 YAchse       => GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.YAchse,
                                                                                 XAchse       => GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.XAchse);
            case WertEinheit is
               when 0 =>
                  null;
                  
               when others =>
                  if GlobaleVariablen.EinheitenGebaut (RasseExtern, WertEinheit).ID /= 1 and WelcherBefehl > 0 and WelcherBefehl <= 6 then
                     Anzeige.Fehlermeldungen (WelcheFehlermeldung => 3);

                     elsif GlobaleVariablen.EinheitenGebaut (RasseExtern, WertEinheit).ID = 1 and WelcherBefehl = 11 then
                     Anzeige.Fehlermeldungen (WelcheFehlermeldung => 3);
                     
                  elsif GlobaleVariablen.EinheitenGebaut (RasseExtern, WertEinheit).AktuelleBewegungspunkte = 0.00 then
                     Anzeige.Fehlermeldungen (WelcheFehlermeldung => 8);
                     
                  else
                     Verbesserungen.Verbesserung (Befehl        => WelcherBefehl,
                                                  RasseExtern   => RasseExtern,
                                                  EinheitNummer => WertEinheit);
                  end if;
            end case;               
            return 1;
            
         when 'i' => -- Informationen für Einheiten, Verbesserungen, usw.
            return 1;

         when '#' => -- Diplomatie
            Diplomatie.DiplomatieAuswählen;            
            return 1;

         when 'g' => -- GeheZu Cursor
            BewegungssystemCursor.GeheZuCursor (RasseExtern => RasseExtern);
            return 1;
            
         when 'r' => -- Runde beenden            
            return -1_000;
            
         when '+' => -- Ebene hoch
            case GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.EAchse is
               when 2 =>
                  GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.EAchse := -2;
                  
               when others =>
                  GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.EAchse := GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.EAchse + 1;
            end case;
            return 1;
            
         when '-' => -- Ebene runter
            case GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.EAchse is
               when -2 =>
                  GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.EAchse := 2;
                  
               when others =>
                  GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.EAchse := GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.EAchse - 1;
            end case;          
            return 1;
            
         when 'c' => -- Kleine Cheattaste
            Cheat.Menü (RasseExtern => RasseExtern);         
            return 1;
            
         when others =>            
            return 1;
      end case;
      
   end Befehle;



   procedure EinheitOderStadt (RasseExtern, Auswahl, StadtNummer, EinheitNummer : in Integer) is
   begin
      
      case Auswahl is
         when -3 =>
            GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPositionStadt.YAchse := 1;
            GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPositionStadt.XAchse := 1;
            InDerStadt.InDerStadt (RasseExtern       => RasseExtern,
                                   StadtNummer       => StadtNummer);
                     
         when others =>
            if GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummer).AktuelleBeschäftigung /= 0 then
               Wahl := EinheitenDatenbank.BeschäftigungAbbrechenVerbesserungErsetzenBrandschatzenEinheitAuflösen (7);
               case Wahl is
                  when True =>
                     GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummer).AktuelleBeschäftigung := 0;
                           
                  when others =>
                     null;
               end case;
                  
            elsif GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummer).AktuelleBewegungspunkte = 0.00 then
               null;
                     
            else
               BewegungssystemEinheiten.BewegungEinheitenRichtung (RasseExtern   => RasseExtern,
                                                                   EinheitNummer => EinheitNummer);
               null;
            end if;
      end case;
      
   end EinheitOderStadt;   

end BefehleImSpiel;
