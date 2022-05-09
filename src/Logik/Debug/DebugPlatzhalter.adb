pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Ada.Wide_Wide_Text_IO; use Ada.Wide_Wide_Text_IO;

with Sf.Window.Keyboard;

with KartenDatentypen; use KartenDatentypen;
with SystemDatentypen;

with SchreibeWichtiges;
with SchreibeKarten;
with LeseKarten;
with LeseEinheitenGebaut;
with LeseStadtGebaut;
with LeseWichtiges;

with Karten;
with ForschungAllgemein;
with EingabeSystemeSFML;

package body DebugPlatzhalter is

   -- Die Umwandlung von Wide_Wide_Image im Debugmenü einfach ignorieren, weil die Anzeige hier sowieso nicht wichtig ist?
   procedure Menü
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      MenüSchleife:
      loop
         
         -- Hier nicht mehr direkt darauf zugreifen sondern so wie in allen anderen Menüs.
         -- EingabeSystemeSFML.TastenEingabe;
         
         case
           EingabeSystemeSFML.TastaturTaste
         is
            -- Volle Informationen (unabhängig von der Rasse)
            when Sf.Window.Keyboard.sfKeyI =>
               Informationen;

               -- Sichtbarkeit der ganzen Karte
            when Sf.Window.Keyboard.sfKeyS =>
               Sichtbarkeit (RasseExtern => RasseExtern);
               
            when Sf.Window.Keyboard.sfKeyK =>
               Krieg;
               
            when Sf.Window.Keyboard.sfKeyG =>
               DebugSieg := not DebugSieg;
               
            when Sf.Window.Keyboard.sfKeyM =>
               SchreibeWichtiges.Geldmenge (RasseExtern         => RasseExtern,
                                            GeldZugewinnExtern  => Integer'Last,
                                            RechnenSetzenExtern => False);
               
            when others =>
               return;
         end case;
         
         -- Karte hier nur Anzeigen wenn Konsole aktiv ist? Oder kann die Konsole auch wie die SFML ausgelagert werden?
         -- Karte.AnzeigeKarte (RasseExtern => RasseExtern);

      end loop MenüSchleife;
      
   end Menü;



   procedure Informationen
   is begin
      
      FeindlicheInformationenSehen := not FeindlicheInformationenSehen;
   
   end Informationen;



   procedure Sichtbarkeit
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      EbeneSchleife:
      for EAchseSchleifenwert in Karten.WeltkarteArray'Range (1) loop
         YAchseSchleife:
         for YAchseSchleifenwert in Karten.WeltkarteArray'First (2) .. Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).YAchse loop
            XAchseSchleife:
            for XAchseSchleifenwert in Karten.WeltkarteArray'First (3) .. Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).XAchse loop
            
               SchreibeKarten.Sichtbar (KoordinatenExtern => (EAchseSchleifenwert, YAchseSchleifenwert, XAchseSchleifenwert),
                                        RasseExtern       => RasseExtern,
                                        SichtbarExtern    => True);
               
            end loop XAchseSchleife;
         end loop YAchseSchleife;
      end loop EbeneSchleife;
      
      Krieg;
      
   end Sichtbarkeit;
   
   
   
   procedure Krieg
   is begin
      
      RassenErsteSchleife:
      for RasseEinsSchleifenwert in RassenDatentypen.Rassen_Verwendet_Enum'Range loop
         RassenZweiteSchleife:
         for RasseZweiSchleifenwert in RassenDatentypen.Rassen_Verwendet_Enum'Range loop
            
            SpielVariablen.Diplomatie (RasseEinsSchleifenwert, RasseZweiSchleifenwert).AktuellerZustand := SystemDatentypen.Neutral_Enum;
            
         end loop RassenZweiteSchleife;
      end loop RassenErsteSchleife;
      
   end Krieg;
   
   
   
   procedure KarteInfosEinheiten
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
   is begin
      
      Put_Line (Item => "Aktuelle Rasse: " & EinheitRasseNummerExtern.Rasse'Wide_Wide_Image);
      ErsteAnzeige := True;
      
      case
        SonstigeVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse)
      is
         when RassenDatentypen.Spieler_KI_Enum =>
            BewegungPlanSchleife:
            for BewegungGeplantSchleifenwert in EinheitenRecords.KIBewegungPlanArray'Range loop
                      
               case
                 ErsteAnzeige
               is
                  when True =>
                     Put_Line (Item => "Bewegungsschritte:");
                     ErsteAnzeige := False;
                     
                  when False =>
                     null;
               end case;
               
               Put (Item => "    " & LeseEinheitenGebaut.KIBewegungPlan (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                                         PlanschrittExtern        => BewegungGeplantSchleifenwert).EAchse'Wide_Wide_Image
                    & "," & LeseEinheitenGebaut.KIBewegungPlan (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                                PlanschrittExtern        => BewegungGeplantSchleifenwert).YAchse'Wide_Wide_Image
                    & "," & LeseEinheitenGebaut.KIBewegungPlan (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                                PlanschrittExtern        => BewegungGeplantSchleifenwert).XAchse'Wide_Wide_Image);
                        
               if
                 BewegungGeplantSchleifenwert mod 8 = 0
               then
                  New_Line;
                  
               else
                  null;
               end if;
               
            end loop BewegungPlanSchleife;
                     
            New_Line;
            Put_Line (Item => "Zielposition:" & LeseEinheitenGebaut.KIZielKoordinaten (EinheitRasseNummerExtern => EinheitRasseNummerExtern).EAchse'Wide_Wide_Image
                      & "," & LeseEinheitenGebaut.KIZielKoordinaten (EinheitRasseNummerExtern => EinheitRasseNummerExtern).YAchse'Wide_Wide_Image
                      & "," & LeseEinheitenGebaut.KIZielKoordinaten (EinheitRasseNummerExtern => EinheitRasseNummerExtern).XAchse'Wide_Wide_Image);
            
            Put_Line (Item => "KIAufgabe: " & LeseEinheitenGebaut.KIBeschäftigt (EinheitRasseNummerExtern => EinheitRasseNummerExtern)'Wide_Wide_Image);
            
         when others =>
            null;
      end case;
      
      Put (Item => "AufgabeEins: " & LeseEinheitenGebaut.Beschäftigung (EinheitRasseNummerExtern => EinheitRasseNummerExtern)'Wide_Wide_Image);
      Put_Line (Item => "     AufgabeZwei: " & LeseEinheitenGebaut.BeschäftigungNachfolger (EinheitRasseNummerExtern => EinheitRasseNummerExtern)'Wide_Wide_Image);
      Put_Line (Item => "Aktuelles Forschungsprojekt:");
      Put_Line (Item => ForschungAllgemein.Beschreibung (IDExtern    => LeseWichtiges.Forschungsprojekt (RasseExtern => EinheitRasseNummerExtern.Rasse),
                                                         RasseExtern => EinheitRasseNummerExtern.Rasse));
      New_Line;
      
   end KarteInfosEinheiten;
   
   
   
   procedure KarteInfosFeld
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      -- Die Stadtbelegung eventuell in die Konsolenanzeige verschieben? Die Belegung wird ja auch in der SFML angezeigt.
      
      Put (Item => "Aktuelle GrundID: " & LeseKarten.Grund (KoordinatenExtern => SpielVariablen.CursorImSpiel (RasseExtern).KoordinatenAktuell)'Wide_Wide_Image);
      Put_Line (Item => "    Aktuelle Stadtbelegung:" & Karten.Weltkarte (SpielVariablen.CursorImSpiel (RasseExtern).KoordinatenAktuell.EAchse, SpielVariablen.CursorImSpiel (RasseExtern).KoordinatenAktuell.YAchse,
                SpielVariablen.CursorImSpiel (RasseExtern).KoordinatenAktuell.XAchse).DurchStadtBelegterGrund.RasseBelegt'Wide_Wide_Image & ", "
                & Karten.Weltkarte (SpielVariablen.CursorImSpiel (RasseExtern).KoordinatenAktuell.EAchse, SpielVariablen.CursorImSpiel (RasseExtern).KoordinatenAktuell.YAchse,
                  SpielVariablen.CursorImSpiel (RasseExtern).KoordinatenAktuell.XAchse).DurchStadtBelegterGrund.StadtBelegt'Wide_Wide_Image);
      Put (Item => "Weg: " & LeseKarten.Weg (KoordinatenExtern => SpielVariablen.CursorImSpiel (RasseExtern).KoordinatenAktuell)'Wide_Wide_Image);
      Put_Line (Item => "    Feldverbesserung: " & LeseKarten.Verbesserung (KoordinatenExtern => SpielVariablen.CursorImSpiel (RasseExtern).KoordinatenAktuell)'Wide_Wide_Image);
      
      ErsteAnzeige := True;
      
      RassenSchleife:
      for RasseSchleifenwert in RassenDatentypen.Rassen_Verwendet_Enum'Range loop
         
         case
           ErsteAnzeige
         is
            when True =>
               Put_Line (Item => "Kartenfeldbewertung:");
               ErsteAnzeige := False;
               
            when False =>
               null;
         end case;
         
         Put (Item => "    " & RasseSchleifenwert'Wide_Wide_Image & ":" & LeseKarten.Bewertung (KoordinatenExtern => SpielVariablen.CursorImSpiel (RasseExtern).KoordinatenAktuell,
                                                                                                RasseExtern       => RasseSchleifenwert)'Wide_Wide_Image);
         
         if
           RassenDatentypen.Rassen_Verwendet_Enum'Pos (RasseSchleifenwert) mod 6 = 0
         then
            New_Line;
            
         else
            null;
         end if;
         
      end loop RassenSchleife;
      
   end KarteInfosFeld;
   
   
   
   procedure KarteStadtInfos
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord)
   is begin
      
      Put_Line (Item => "Aktuelle Rasse: " & StadtRasseNummerExtern.Rasse'Wide_Wide_Image);
      Put_Line (Item => "KIAufgabe: " & LeseStadtGebaut.KIBeschäftigung (StadtRasseNummerExtern => StadtRasseNummerExtern)'Wide_Wide_Image);
      Put_Line (Item => "Aktuelles Forschungsprojekt:");
      Put_Line (Item => ForschungAllgemein.Beschreibung (IDExtern    => LeseWichtiges.Forschungsprojekt (RasseExtern => StadtRasseNummerExtern.Rasse),
                                                         RasseExtern => StadtRasseNummerExtern.Rasse));
      New_Line;
      
   end KarteStadtInfos;

end DebugPlatzhalter;
