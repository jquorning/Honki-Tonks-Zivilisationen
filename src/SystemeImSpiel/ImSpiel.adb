pragma SPARK_Mode (On);

with Ada.Calendar;
use Ada.Calendar;

with GlobaleVariablen, GlobaleKonstanten;

with Wachstum, InDerStadtBauen, Karte, BefehleImSpiel, Optionen, Sichtbarkeit, EinheitenDatenbank, Verbesserungen, ForschungsDatenbank, KI, Ladezeiten, Speichern, Laden, KIZuruecksetzen, StadtProduktion;

package body ImSpiel is

   function ImSpiel
     return Integer
   is begin
      
      SpielSchleife:
      loop         
         RassenSchleife:
         for RasseSchleifenwert in GlobaleDatentypen.Rassen'Range loop
            
            if
              GlobaleVariablen.RasseAmZugNachLaden = 0
              or
                RasseSchleifenwert = GlobaleVariablen.RasseAmZugNachLaden
            then
               GlobaleVariablen.RasseAmZugNachLaden := 0;
               case
                 GlobaleVariablen.RassenImSpiel (RasseSchleifenwert)
               is -- Einmal muss am Anfang die Sichtbarkeit geprüft werden, sonst crasht das Spiel
                  when 0 =>
                     null;
                  
                  when others =>
                     Sichtbarkeit.SichtbarkeitsprüfungFürRasse (RasseExtern => RasseSchleifenwert);
               end case;
            
               case
                 GlobaleVariablen.RassenImSpiel (RasseSchleifenwert)
               is -- 0 = Nicht belegt, 1 = Menschlicher Spieler, 2 = KI
                  when 0 =>
                     null;
                     
                  when 1 =>
                     RückgabeWert := MenschlicherSpieler (RasseExtern => RasseSchleifenwert);
                     if
                       RückgabeWert = GlobaleKonstanten.SpielBeendenKonstante
                       or
                         RückgabeWert = GlobaleKonstanten.HauptmenüKonstante
                     then
                        return RückgabeWert;

                     elsif
                       RückgabeWert = -300
                     then
                        exit RassenSchleife;
                        
                     else
                        null;
                     end if;
                  
                  when others =>
                     KI.KI (RasseExtern => RasseSchleifenwert);
               end case;

            else
               null;
            end if;
            
         end loop RassenSchleife;
               
         case
           GlobaleVariablen.RasseAmZugNachLaden
         is
            when 0 =>   
               BerechnungenNachZugendeAllerSpieler;
               
            when others =>
               null;
         end case;
            
      end loop SpielSchleife;
            
   end ImSpiel;



   function MenschlicherSpieler
     (RasseExtern : in GlobaleDatentypen.Rassen)
      return Integer
   is begin
      
      SpielerSchleife:
      loop
         
         Karte.AnzeigeKarte (RasseExtern => RasseExtern);
         AktuellerBefehlSpieler := BefehleImSpiel.Befehle (RasseExtern => RasseExtern);
         case
           AktuellerBefehlSpieler
         is
            when GlobaleKonstanten.StartNormalKonstante =>
               null;

            when GlobaleKonstanten.SpeichernKonstante => -- Speichern
               GlobaleVariablen.RasseAmZugNachLaden := RasseExtern;
               Speichern.SpeichernNeu (AutospeichernExtern => False);
               
            when GlobaleKonstanten.LadenKonstante => -- Laden
               if
                 Laden.LadenNeu = True
               then
                  return -300;

               else
                  null;
               end if;
               
            when GlobaleKonstanten.OptionenKonstante => -- Optionen
               RückgabeOptionen := Optionen.Optionen;
               if
                 RückgabeOptionen = GlobaleKonstanten.SpielBeendenKonstante
                 or
                   RückgabeOptionen = GlobaleKonstanten.HauptmenüKonstante
               then
                  return RückgabeOptionen;
                                    
               else
                  null;
               end if;
               
            when GlobaleKonstanten.SpielBeendenKonstante | GlobaleKonstanten.HauptmenüKonstante => -- Spiel beenden oder Hauptmenü
               return AktuellerBefehlSpieler;

            when -1_000 => -- Runde beenden
               return GlobaleKonstanten.StartNormalKonstante;      
                  
            when others =>
               Sichtbarkeit.SichtbarkeitsprüfungFürRasse (RasseExtern => RasseExtern);
         end case;
                     
      end loop SpielerSchleife;
      
   end MenschlicherSpieler;



   procedure BerechnungenNachZugendeAllerSpieler
   is begin
            
      Ladezeiten.BerechnungenNachZugendeAllerSpielerZeiten (1, 1) := Clock;
      EinheitenDatenbank.HeilungBewegungspunkteNeueRundeErmitteln;
      Verbesserungen.VerbesserungFertiggestellt;
      Wachstum.Wachstum;
      InDerStadtBauen.BauzeitAlle;
      StadtProduktion.StadtProduktionPrüfen ((0, 0));
      ForschungsDatenbank.ForschungFortschritt;
      GlobaleVariablen.RundenAnzahl := GlobaleVariablen.RundenAnzahl + 1;

      case
        GlobaleVariablen.AnzahlAutosave
      is
         when 0 =>
            null;

         when others =>
            Speichern.AutoSpeichern;
      end case;
      
      KIZuruecksetzen.KIZurücksetzenAmRundenende;
      Ladezeiten.BerechnungenNachZugendeAllerSpielerZeiten (2, 1) := Clock;
      Ladezeiten.BerechnungenNachZugendeAllerSpieler (WelcheZeitExtern => 1);
      
   end BerechnungenNachZugendeAllerSpieler;

end ImSpiel;
