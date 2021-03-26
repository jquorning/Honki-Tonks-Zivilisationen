pragma SPARK_Mode (On);

with Ada.Wide_Wide_Text_IO, Ada.Strings.Wide_Wide_Unbounded, Ada.Wide_Wide_Characters.Handling, Ada.Characters.Wide_Wide_Latin_9;
use Ada.Wide_Wide_Text_IO, Ada.Strings.Wide_Wide_Unbounded, Ada.Wide_Wide_Characters.Handling, Ada.Characters.Wide_Wide_Latin_9;

with GebaeudeDatenbank, EinheitenDatenbank, Anzeige;

package body InDerStadtBauen is

   procedure Bauen (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord) is
   begin

      GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).AktuellesBauprojekt := 0;
      GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).AktuelleRessourcen := 0;
      
      BauSchleife:
      loop
      
         WasGebautWerdenSoll := BauobjektAuswählen (StadtRasseNummerExtern => StadtRasseNummerExtern);

         case WasGebautWerdenSoll is
            when 0 =>
               return;

            when 1_001 .. 99_999 => -- Gebäude - 1_000, Einheiten - 10_000
               GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).AktuellesBauprojekt := WasGebautWerdenSoll;
               GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).AktuelleRessourcen := 0;
               BauzeitEinzeln (StadtRasseNummerExtern => StadtRasseNummerExtern);
               return;
               
            when others =>
               null;
         end case;
         
      end loop BauSchleife;
      
   end Bauen;



   procedure BauzeitEinzeln (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord) is
   begin

      if GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).AktuelleProduktionrate = 0 then
         GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).VerbleibendeBauzeit := 10_000;

      elsif GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).AktuellesBauprojekt = 0 then
         GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).VerbleibendeBauzeit := 0;
            
      elsif GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).AktuellesBauprojekt < 10_000 then
         GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).VerbleibendeBauzeit
           := (GebaeudeDatenbank.GebäudeListe (StadtRasseNummerExtern.Rasse,
               GlobaleDatentypen.GebäudeID (GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).AktuellesBauprojekt - 1_000)).PreisRessourcen
               - GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).AktuelleRessourcen)
             / GlobaleDatentypen.KostenLager (GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).AktuelleProduktionrate);
               
      else
         GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).VerbleibendeBauzeit
           := (EinheitenDatenbank.EinheitenListe (StadtRasseNummerExtern.Rasse,
               GlobaleDatentypen.EinheitenID (GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).AktuellesBauprojekt - 10_000)).PreisRessourcen
               - GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).AktuelleRessourcen)
             / GlobaleDatentypen.KostenLager (GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).AktuelleProduktionrate);
      end if;
               
   end BauzeitEinzeln;



   procedure BauzeitAlle is
   begin
         
      RassenSchleife:
      for RasseSchleifenwert in GlobaleDatentypen.Rassen loop

         case GlobaleVariablen.RassenImSpiel (RasseSchleifenwert) is
            when 0 =>
               null;
               
            when others =>
               StadtSchleife:
               for StadtNummer in GlobaleVariablen.StadtGebautArray'Range (2) loop
      
                  case GlobaleVariablen.StadtGebaut (RasseSchleifenwert, StadtNummer).ID is
                     when 0 =>
                        null;
                        
                     when others =>
                        BauzeitEinzeln (StadtRasseNummerExtern => (RasseSchleifenwert, StadtNummer));
                  end case;
      
               end loop StadtSchleife;
         end case;
         
      end loop RassenSchleife;
      
   end BauzeitAlle;



   function BauobjektAuswählen (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord) return Natural is
   begin

      Ende := 1;
      Anzeige.TextBauenNeu := (others => (To_Unbounded_Wide_Wide_String (Source => "|"), 0));

      GebäudeSchleife:
      for GebäudeSchleifenwert in GlobaleDatentypen.GebäudeID'Range loop
         
         if To_Wide_Wide_String (Source => GlobaleVariablen.TexteEinlesenNeu (GlobaleDatentypen.WelcheDatei_Enum'Pos (Beschreibungen_Gebäude_Kurz),
                                 Positive (GebäudeSchleifenwert) + RassenAufschlagGebäude (StadtRasseNummerExtern.Rasse))) = "|" then
            exit GebäudeSchleife;

         elsif GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).GebäudeVorhanden (GebäudeSchleifenwert) = True then
            null;

         elsif GebaeudeDatenbank.GebäudeListe (StadtRasseNummerExtern.Rasse, GebäudeSchleifenwert).Anforderungen /= 0 then
            if GlobaleVariablen.Wichtiges (StadtRasseNummerExtern.Rasse).Erforscht (GebaeudeDatenbank.GebäudeListe (StadtRasseNummerExtern.Rasse, GebäudeSchleifenwert).Anforderungen) = False then 
               null;

            else
               Anzeige.TextBauenNeu (Ende).Text
                 := GlobaleVariablen.TexteEinlesenNeu (GlobaleDatentypen.WelcheDatei_Enum'Pos (Beschreibungen_Gebäude_Kurz), Positive (GebäudeSchleifenwert) + RassenAufschlagGebäude (StadtRasseNummerExtern.Rasse));
               Anzeige.TextBauenNeu (Ende).Nummer := 1_000 + Positive (GebäudeSchleifenwert);
               Ende := Ende + 1;
            end if;
            
         else
            Anzeige.TextBauenNeu (Ende).Text
              := GlobaleVariablen.TexteEinlesenNeu (GlobaleDatentypen.WelcheDatei_Enum'Pos (Beschreibungen_Gebäude_Kurz), Positive (GebäudeSchleifenwert) + RassenAufschlagGebäude (StadtRasseNummerExtern.Rasse));
            Anzeige.TextBauenNeu (Ende).Nummer := 1_000 + Positive (GebäudeSchleifenwert);
            Ende := Ende + 1;
         end if;
         
      end loop GebäudeSchleife;

      EinheitenSchleife:
      for EinheitSchleifenwert in GlobaleDatentypen.EinheitenID loop
         
         if To_Wide_Wide_String (Source => GlobaleVariablen.TexteEinlesenNeu (GlobaleDatentypen.WelcheDatei_Enum'Pos (Beschreibungen_Einheiten_Kurz),
                                 Positive (EinheitSchleifenwert) + RassenAufschlagEinheiten (StadtRasseNummerExtern.Rasse))) = "|" then
            exit EinheitenSchleife;

         elsif GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).AmWasser = False
           and EinheitenDatenbank.EinheitenListe (StadtRasseNummerExtern.Rasse, EinheitSchleifenwert).Passierbarkeit (2) = True then
            null;

         elsif EinheitenDatenbank.EinheitenListe (StadtRasseNummerExtern.Rasse, EinheitSchleifenwert).Anforderungen /= 0 then
            if GlobaleVariablen.Wichtiges (StadtRasseNummerExtern.Rasse).Erforscht (EinheitenDatenbank.EinheitenListe (StadtRasseNummerExtern.Rasse, EinheitSchleifenwert).Anforderungen) = False then
               null;
               
            else
               Anzeige.TextBauenNeu (Ende).Text
                 := GlobaleVariablen.TexteEinlesenNeu (GlobaleDatentypen.WelcheDatei_Enum'Pos (Beschreibungen_Einheiten_Kurz), Positive (EinheitSchleifenwert) + RassenAufschlagEinheiten (StadtRasseNummerExtern.Rasse));
               Anzeige.TextBauenNeu (Ende).Nummer := 10_000 + Positive (EinheitSchleifenwert);
               Ende := Ende + 1;
            end if;
            
         else
            Anzeige.TextBauenNeu (Ende).Text
              := GlobaleVariablen.TexteEinlesenNeu (GlobaleDatentypen.WelcheDatei_Enum'Pos (Beschreibungen_Einheiten_Kurz), Positive (EinheitSchleifenwert) + RassenAufschlagEinheiten (StadtRasseNummerExtern.Rasse));
            Anzeige.TextBauenNeu (Ende).Nummer := 10_000 + Positive (EinheitSchleifenwert);
            Ende := Ende + 1;
         end if;
         
      end loop EinheitenSchleife;

      if Anzeige.TextBauenNeu (Ende).Nummer = 0 and Ende > 1 then
         Anzeige.TextBauenNeu (Ende).Text := GlobaleVariablen.TexteEinlesenNeu (GlobaleDatentypen.WelcheDatei_Enum'Pos (Feste_Abfragen), 3);

      elsif Anzeige.TextBauenNeu (Ende).Nummer = 0 and Ende = 1 then
         return 0;
         
      else
         Ende := Ende + 1;
         Anzeige.TextBauenNeu (Ende).Text := GlobaleVariablen.TexteEinlesenNeu (GlobaleDatentypen.WelcheDatei_Enum'Pos (Feste_Abfragen), 3);
      end if;

      AktuelleAuswahl := 1;

      AuswahlSchleife:
      loop

         Put (Item => CSI & "2J" & CSI & "3J"  & CSI & "H");

         Anzeige.EinzeiligeAnzeigeOhneAuswahl (TextDateiExtern => GlobaleDatentypen.Fragen,
                                               TextZeileExtern => 13);

         Anzeige.AnzeigeStadt (AktuelleAuswahlExtern => AktuelleAuswahl);
         
         if AktuelleAuswahl = Ende then
            null;
                  
         elsif Anzeige.TextBauenNeu (AktuelleAuswahl).Nummer > 10_000 then
            Anzeige.AnzeigeLangerTextNeu (ÜberschriftDateiExtern => GlobaleDatentypen.Leer,
                                          TextDateiExtern        => GlobaleDatentypen.Beschreibungen_Einheiten_Lang,
                                          ÜberschriftZeileExtern => 0,
                                          ErsteZeileExtern       => Anzeige.TextBauenNeu (AktuelleAuswahl).Nummer - 10_000,
                                          LetzteZeileExtern      => Anzeige.TextBauenNeu (AktuelleAuswahl).Nummer - 10_000,
                                          AbstandAnfangExtern    => GlobaleDatentypen.Neue_Zeile,
                                          AbstandEndeExtern      => GlobaleDatentypen.Keiner);
            
         else
            Anzeige.AnzeigeLangerTextNeu (ÜberschriftDateiExtern => GlobaleDatentypen.Leer,
                                          TextDateiExtern        => GlobaleDatentypen.Beschreibungen_Gebäude_Lang,
                                          ÜberschriftZeileExtern => 0,
                                          ErsteZeileExtern       => Anzeige.TextBauenNeu (AktuelleAuswahl).Nummer - 1_000,
                                          LetzteZeileExtern      => Anzeige.TextBauenNeu (AktuelleAuswahl).Nummer - 1_000,
                                          AbstandAnfangExtern    => GlobaleDatentypen.Neue_Zeile,
                                          AbstandEndeExtern      => GlobaleDatentypen.Keiner);
         end if;
         
         Get_Immediate (Item => Taste);
         
         case To_Lower (Item => Taste) is               
            when 'w' | '8' => 
               if AktuelleAuswahl = Anzeige.TextBauenNeu'First then
                  AktuelleAuswahl := Ende;
                  
               else
                  AktuelleAuswahl := AktuelleAuswahl - 1;
               end if;

            when 's' | '2' =>
               if AktuelleAuswahl = Ende then
                  AktuelleAuswahl := Anzeige.TextBauenNeu'First;
                  
               else
                  AktuelleAuswahl := AktuelleAuswahl + 1;
               end if;
                              
            when 'e' | '5' =>
               return Anzeige.TextBauenNeu (AktuelleAuswahl).Nummer;

            when 'q' =>
               return 0;
                     
            when others =>
               null;
         end case;
         
      end loop AuswahlSchleife;
      
   end BauobjektAuswählen;

end InDerStadtBauen;