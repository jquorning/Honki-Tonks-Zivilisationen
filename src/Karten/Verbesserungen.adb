with SchleifenPruefungen, GlobaleVariablen, EinheitenDatenbank, Anzeige, WerteFestlegen;

package body Verbesserungen is

   procedure Verbesserung (RasseExtern : in GlobaleDatentypen.Rassen; Befehl : in Befehle; EinheitNummer : in Positive) is
   begin

      case GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummer).AktuelleBeschäftigung is
         when 0 =>
            VerbesserungeFestgelegt (Befehl        => Befehl,
                                     RasseExtern   => RasseExtern,
                                     EinheitNummer => EinheitNummer);
            
         when others =>
            Wahl := EinheitenDatenbank.BeschäftigungAbbrechenVerbesserungErsetzenBrandschatzenEinheitAuflösen (WelcheAuswahl => 7);
            case Wahl is
               when True =>
                  VerbesserungeFestgelegt (Befehl        => Befehl,
                                           RasseExtern   => RasseExtern,
                                           EinheitNummer => EinheitNummer);
                     
               when False =>
                  null;
            end case;
      end case;
      
   end Verbesserung;



   procedure VerbesserungeFestgelegt (RasseExtern : in GlobaleDatentypen.Rassen; Befehl : in Befehle; EinheitNummer : in Positive) is
   begin

      if Befehl = Straße_Bauen and Karten.Karten (GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummer).AchsenPosition.EAchse, GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummer).AchsenPosition.YAchse,
                                                   GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummer).AchsenPosition.XAchse).VerbesserungStraße >= 5
        and Karten.Karten (GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummer).AchsenPosition.EAchse, GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummer).AchsenPosition.YAchse,
                           GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummer).AchsenPosition.XAchse).VerbesserungStraße <= 19 then
         Anzeige.AnzeigeNeu (AuswahlOderAnzeige => False,
                             AktuelleAuswahl    => 1,
                             FrageDatei         => 0,
                             FrageZeile         => 0,
                             TextDatei          => 8,
                             ErsteZeile         => 4,
                             LetzteZeile        => 4);
         return;

      elsif Befehl = Mine_Bauen
        and Karten.Karten (GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummer).AchsenPosition.EAchse, GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummer).AchsenPosition.YAchse,
                           GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummer).AchsenPosition.XAchse).VerbesserungGebiet = 21 then
         Anzeige.AnzeigeNeu (AuswahlOderAnzeige => False,
                             AktuelleAuswahl    => 1,
                             FrageDatei         => 0,
                             FrageZeile         => 0,
                             TextDatei          => 8,
                             ErsteZeile         => 4,
                             LetzteZeile        => 4);
         return;

      elsif Befehl = Mine_Bauen
        and (Karten.Karten (GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummer).AchsenPosition.EAchse, GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummer).AchsenPosition.YAchse,
                            GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummer).AchsenPosition.XAchse).VerbesserungGebiet = 20
             or Karten.Karten (GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummer).AchsenPosition.EAchse, GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummer).AchsenPosition.YAchse,
                               GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummer).AchsenPosition.XAchse).VerbesserungGebiet = 22) then
         Wahl := EinheitenDatenbank.BeschäftigungAbbrechenVerbesserungErsetzenBrandschatzenEinheitAuflösen (WelcheAuswahl => 8);
         case Wahl is
            when True =>
               null;
                     
            when False =>
               return;
         end case;
      
      elsif Befehl = Farm_Bauen and Karten.Karten (GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummer).AchsenPosition.EAchse, GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummer).AchsenPosition.YAchse,
                                                   GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummer).AchsenPosition.XAchse).VerbesserungGebiet = 20 then
         Anzeige.AnzeigeNeu (AuswahlOderAnzeige => False,
                             AktuelleAuswahl    => 1,
                             FrageDatei         => 0,
                             FrageZeile         => 0,
                             TextDatei          => 8,
                             ErsteZeile         => 4,
                             LetzteZeile        => 4);
         return;

      elsif Befehl = Farm_Bauen and Karten.Karten (GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummer).AchsenPosition.EAchse, GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummer).AchsenPosition.YAchse,
                                                   GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummer).AchsenPosition.XAchse).Grund = 1 then
         Anzeige.AnzeigeNeu (AuswahlOderAnzeige => False,
                             AktuelleAuswahl    => 1,
                             FrageDatei         => 0,
                             FrageZeile         => 0,
                             TextDatei          => 8,
                             ErsteZeile         => 1,
                             LetzteZeile        => 1);
         return;

      elsif Befehl = Farm_Bauen and (Karten.Karten (GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummer).AchsenPosition.EAchse, GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummer).AchsenPosition.YAchse,
                                                    GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummer).AchsenPosition.XAchse).VerbesserungGebiet = 21
                                     or Karten.Karten (GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummer).AchsenPosition.EAchse, GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummer).AchsenPosition.YAchse,
                                                       GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummer).AchsenPosition.XAchse).VerbesserungGebiet = 22) then
         Wahl := EinheitenDatenbank.BeschäftigungAbbrechenVerbesserungErsetzenBrandschatzenEinheitAuflösen (WelcheAuswahl => 8);
         case Wahl is
            when True =>
               null;
                     
            when False =>
               return;
         end case;
      
      elsif Befehl = Festung_Bauen and Karten.Karten (GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummer).AchsenPosition.EAchse, GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummer).AchsenPosition.YAchse,
                                                      GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummer).AchsenPosition.XAchse).VerbesserungGebiet = 22 then
         Anzeige.AnzeigeNeu (AuswahlOderAnzeige => False,
                             AktuelleAuswahl    => 1,
                             FrageDatei         => 0,
                             FrageZeile         => 0,
                             TextDatei          => 8,
                             ErsteZeile         => 4,
                             LetzteZeile        => 4);
         return;

      elsif Befehl = Festung_Bauen and (Karten.Karten (GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummer).AchsenPosition.EAchse, GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummer).AchsenPosition.YAchse,
                                                       GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummer).AchsenPosition.XAchse).VerbesserungGebiet = 20
                                        or Karten.Karten (GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummer).AchsenPosition.EAchse, GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummer).AchsenPosition.YAchse,
                                                          GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummer).AchsenPosition.XAchse).VerbesserungGebiet = 21) then
         Wahl := EinheitenDatenbank.BeschäftigungAbbrechenVerbesserungErsetzenBrandschatzenEinheitAuflösen (WelcheAuswahl => 8);
         case Wahl is
            when True =>
               null;
                     
            when False =>
               return;
         end case;

      elsif Befehl = Wald_Aufforsten and (Karten.Karten (GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummer).AchsenPosition.EAchse, GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummer).AchsenPosition.YAchse,
                                                         GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummer).AchsenPosition.XAchse).VerbesserungGebiet = 20
                                          or Karten.Karten (GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummer).AchsenPosition.EAchse, GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummer).AchsenPosition.YAchse,
                                                            GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummer).AchsenPosition.XAchse).VerbesserungGebiet = 21) then
         Wahl := EinheitenDatenbank.BeschäftigungAbbrechenVerbesserungErsetzenBrandschatzenEinheitAuflösen (WelcheAuswahl => 8);
         case Wahl is
            when True =>
               null;
                     
            when False =>
               return;
         end case;
         
      elsif Befehl = Runde_Aussetzen then
         GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummer).AktuelleBewegungspunkte := 0.0;
         return;
                              
      else
         null;
      end if;
                              
      GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummer).AktuelleBeschäftigung := 0;
      GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummer).AktuelleBeschäftigung2 := 0;
      GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummer).AktuelleBeschäftigungszeit := 0;
      GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummer).AktuelleBeschäftigungszeit2 := 0;
      
      case Befehl is
         when Straße_Bauen => -- Landstraße
            case Karten.Karten (GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummer).AchsenPosition.EAchse, GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummer).AchsenPosition.YAchse,
                                GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummer).AchsenPosition.XAchse).Grund is
               when 1 | 3 .. 6 | 8 | 10 .. 28 =>
                  GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummer).AktuelleBeschäftigung := Befehle'Pos (Befehl);
                  GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummer).AktuelleBeschäftigungszeit := 3;

               when 7 | 9 | 32 =>
                  GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummer).AktuelleBeschäftigung := Befehle'Pos (Befehl);
                  GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummer).AktuelleBeschäftigungszeit := 6;
               
               when others =>
                  Anzeige.AnzeigeNeu (AuswahlOderAnzeige => False,
                                      AktuelleAuswahl    => 1,
                                      FrageDatei         => 0,
                                      FrageZeile         => 0,
                                      TextDatei          => 8,
                                      ErsteZeile         => 1,
                                      LetzteZeile        => 1);
            end case;
                              
         when Mine_Bauen => -- Tiefengrabung
            case Karten.Karten (GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummer).AchsenPosition.EAchse, GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummer).AchsenPosition.YAchse,
                                GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummer).AchsenPosition.XAchse).Grund is
               when 1 | 3 .. 6 | 10 .. 28 =>
                  GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummer).AktuelleBeschäftigung := Befehle'Pos (Befehl);
                  GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummer).AktuelleBeschäftigungszeit := 3;

               when 7 =>
                  GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummer).AktuelleBeschäftigung := Befehle'Pos (Befehl);
                  GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummer).AktuelleBeschäftigungszeit := 5;

               when 8 | 9 | 32 =>
                  GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummer).AktuelleBeschäftigung := 6;
                  GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummer).AktuelleBeschäftigungszeit := 3;
                  GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummer).AktuelleBeschäftigung2 := Befehle'Pos (Befehl);
                  GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummer).AktuelleBeschäftigungszeit2 := 3;
               
               when others =>
                  Anzeige.AnzeigeNeu (AuswahlOderAnzeige => False,
                                      AktuelleAuswahl    => 1,
                                      FrageDatei         => 0,
                                      FrageZeile         => 0,
                                      TextDatei          => 8,
                                      ErsteZeile         => 1,
                                      LetzteZeile        => 1);
            end case;
            
         when Farm_Bauen => -- Farm bauen
            case Karten.Karten (GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummer).AchsenPosition.EAchse, GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummer).AchsenPosition.YAchse,
                                GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummer).AchsenPosition.XAchse).Grund is
               when 3 .. 6 | 10 .. 28 =>
                  GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummer).AktuelleBeschäftigung := Befehle'Pos (Befehl);
                  GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummer).AktuelleBeschäftigungszeit := 3;

               when 7 =>
                  GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummer).AktuelleBeschäftigung := Befehle'Pos (Befehl);
                  GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummer).AktuelleBeschäftigungszeit := 5;

               when 8 .. 9 | 32 =>
                  GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummer).AktuelleBeschäftigung := 6;
                  GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummer).AktuelleBeschäftigungszeit := 3;
                  GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummer).AktuelleBeschäftigung2 := Befehle'Pos (Befehl);
                  GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummer).AktuelleBeschäftigungszeit2 := 3;
               
               when others =>
                  Anzeige.AnzeigeNeu (AuswahlOderAnzeige => False,
                                      AktuelleAuswahl    => 1,
                                      FrageDatei         => 0,
                                      FrageZeile         => 0,
                                      TextDatei          => 8,
                                      ErsteZeile         => 1,
                                      LetzteZeile        => 1);
            end case;
            
         when Festung_Bauen => -- Festung bauen
            case Karten.Karten (GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummer).AchsenPosition.EAchse, GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummer).AchsenPosition.YAchse,
                                GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummer).AchsenPosition.XAchse).Grund is
               when 1 | 3 .. 6 | 8 .. 28 | 32 =>
                  GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummer).AktuelleBeschäftigung := Befehle'Pos (Befehl);
                  GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummer).AktuelleBeschäftigungszeit := 3;

               when 7 =>
                  GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummer).AktuelleBeschäftigung := Befehle'Pos (Befehl);
                  GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummer).AktuelleBeschäftigungszeit := 5;
               
               when others =>
                  Anzeige.AnzeigeNeu (AuswahlOderAnzeige => False,
                                      AktuelleAuswahl    => 1,
                                      FrageDatei         => 0,
                                      FrageZeile         => 0,
                                      TextDatei          => 8,
                                      ErsteZeile         => 1,
                                      LetzteZeile        => 1);
            end case;
            
         when Wald_Aufforsten => -- Wald aufforsten
            case Karten.Karten (GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummer).AchsenPosition.EAchse, GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummer).AchsenPosition.YAchse,
                                GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummer).AchsenPosition.XAchse).Grund is
               when 3 | 6 | 10 .. 28 =>
                  GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummer).AktuelleBeschäftigung := Befehle'Pos (Befehl);
                  GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummer).AktuelleBeschäftigungszeit := 3;

               when 9 | 32 =>
                  GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummer).AktuelleBeschäftigung := 6;
                  GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummer).AktuelleBeschäftigungszeit := 3;
                  GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummer).AktuelleBeschäftigung2 := Befehle'Pos (Befehl);
                  GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummer).AktuelleBeschäftigungszeit2 := 3;
               
               when others =>
                  Anzeige.AnzeigeNeu (AuswahlOderAnzeige => False,
                                      AktuelleAuswahl    => 1,
                                      FrageDatei         => 0,
                                      FrageZeile         => 0,
                                      TextDatei          => 8,
                                      ErsteZeile         => 1,
                                      LetzteZeile        => 1);
            end case;

         when Roden_Trockenlegen => -- Roden-Trockenlegen
            case Karten.Karten (GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummer).AchsenPosition.EAchse, GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummer).AchsenPosition.YAchse,
                                GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummer).AchsenPosition.XAchse).Grund is
               when 8 | 9 | 32 =>
                  GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummer).AktuelleBeschäftigung := Befehle'Pos (Befehl);
                  GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummer).AktuelleBeschäftigungszeit := 3;
              
               when others =>
                  Anzeige.AnzeigeNeu (AuswahlOderAnzeige => False,
                                      AktuelleAuswahl    => 1,
                                      FrageDatei         => 0,
                                      FrageZeile         => 0,
                                      TextDatei          => 8,
                                      ErsteZeile         => 2,
                                      LetzteZeile        => 2);
            end case;
            
         when Heilen => -- Heilen
            if GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummer).AktuelleLebenspunkte
              = EinheitenDatenbank.EinheitenListe (RasseExtern, GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummer).ID).MaximaleLebenspunkte then
               Anzeige.AnzeigeNeu (AuswahlOderAnzeige => False,
                                   AktuelleAuswahl    => 1,
                                   FrageDatei         => 0,
                                   FrageZeile         => 0,
                                   TextDatei          => 8,
                                   ErsteZeile         => 5,
                                   LetzteZeile        => 5);
               
            else
               case Karten.Karten (GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummer).AchsenPosition.EAchse, GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummer).AchsenPosition.YAchse,
                                   GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummer).AchsenPosition.XAchse).Grund is
                  when 1 .. 32 =>
                     GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummer).AktuelleBeschäftigung := Befehle'Pos (Befehl);
               
                  when others =>
                     Anzeige.AnzeigeNeu (AuswahlOderAnzeige => False,
                                         AktuelleAuswahl    => 1,
                                         FrageDatei         => 0,
                                         FrageZeile         => 0,
                                         TextDatei          => 8,
                                         ErsteZeile         => 2,
                                         LetzteZeile        => 2);
               end case;
            end if;

         when Verschanzen => -- Verschanzen
            case Karten.Karten (GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummer).AchsenPosition.EAchse, GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummer).AchsenPosition.YAchse,
                                GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummer).AchsenPosition.XAchse).Grund is
               when 1 .. 32 =>
                  GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummer).AktuelleBeschäftigung := Befehle'Pos (Befehl);
               
               when others =>
                  Anzeige.AnzeigeNeu (AuswahlOderAnzeige => False,
                                      AktuelleAuswahl    => 1,
                                      FrageDatei         => 0,
                                      FrageZeile         => 0,
                                      TextDatei          => 8,
                                      ErsteZeile         => 2,
                                      LetzteZeile        => 2);
            end case;

         when Einheit_Auflösen => -- Einheit auflösen
            Wahl := EinheitenDatenbank.BeschäftigungAbbrechenVerbesserungErsetzenBrandschatzenEinheitAuflösen (WelcheAuswahl => 9);
            case Wahl is
               when True =>
                  EinheitenDatenbank.EinheitEntfernenMitSortieren (RasseExtern   => RasseExtern,
                                                                   EinheitNummer => EinheitNummer);
                     
               when False =>
                  null;
            end case;

         when Plündern => -- Plündern
            Wahl := EinheitenDatenbank.BeschäftigungAbbrechenVerbesserungErsetzenBrandschatzenEinheitAuflösen (WelcheAuswahl => 12);
            case Wahl is
               when True =>
                  Karten.Karten (GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummer).AchsenPosition.EAchse, GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummer).AchsenPosition.YAchse,
                                 GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummer).AchsenPosition.XAchse).VerbesserungGebiet := 0;
                  Karten.Karten (GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummer).AchsenPosition.EAchse, GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummer).AchsenPosition.YAchse,
                                 GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummer).AchsenPosition.XAchse).VerbesserungStraße := 0;
                  GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummer).AktuelleBewegungspunkte := 0.0;
                     
               when False =>
                  null;
            end case;
                     
         when others =>
            null;
      end case;
            
   end VerbesserungeFestgelegt;
   


   procedure VerbesserungFertiggestellt is
   begin
      
      RassenSchleife:
      for RasseIntern in GlobaleVariablen.RassenImSpiel'Range loop
         
         case GlobaleVariablen.RassenImSpiel (RasseIntern) is
            when 0 =>
               null;
               
            when others =>
               VerbesserungInArbeitSchleife:
               for EinheitNummer in GlobaleVariablen.EinheitenGebaut'Range (2) loop
         
                  case GlobaleVariablen.EinheitenGebaut (RasseIntern, EinheitNummer).ID is
                     when 0 =>
                        exit VerbesserungInArbeitSchleife;
               
                     when others =>
                        case GlobaleVariablen.EinheitenGebaut (RasseIntern, EinheitNummer).AktuelleBeschäftigung is
                           when 0 | 7 .. 8 =>
                              null;
               
                           when others =>
                              GlobaleVariablen.EinheitenGebaut (RasseIntern, EinheitNummer).AktuelleBeschäftigungszeit := GlobaleVariablen.EinheitenGebaut (RasseIntern, EinheitNummer).AktuelleBeschäftigungszeit - 1;
                              if GlobaleVariablen.EinheitenGebaut (RasseIntern, EinheitNummer).AktuelleBeschäftigungszeit <= 0 then
                                 VerbesserungAngelegt (RasseExtern   => RasseIntern,
                                                       EinheitNummer => EinheitNummer);

                                 case GlobaleVariablen.EinheitenGebaut (RasseIntern, EinheitNummer).AktuelleBeschäftigung2 is
                                    when 0 =>
                                       GlobaleVariablen.EinheitenGebaut (RasseIntern, EinheitNummer).AktuelleBeschäftigung := 0;
                                       GlobaleVariablen.EinheitenGebaut (RasseIntern, EinheitNummer).AktuelleBeschäftigungszeit := 0;

                                    when others =>
                                       GlobaleVariablen.EinheitenGebaut (RasseIntern, EinheitNummer).AktuelleBeschäftigung := GlobaleVariablen.EinheitenGebaut (RasseIntern, EinheitNummer).AktuelleBeschäftigung2;
                                       GlobaleVariablen.EinheitenGebaut (RasseIntern, EinheitNummer).AktuelleBeschäftigung2 := 0;
                                       GlobaleVariablen.EinheitenGebaut (RasseIntern, EinheitNummer).AktuelleBeschäftigungszeit := GlobaleVariablen.EinheitenGebaut (RasseIntern, EinheitNummer).AktuelleBeschäftigungszeit2;
                                       GlobaleVariablen.EinheitenGebaut (RasseIntern, EinheitNummer).AktuelleBeschäftigungszeit2 := 0;
                                 end case;
                        
                              else
                                 null;
                              end if;
                        end case;
                  end case;
         
               end loop VerbesserungInArbeitSchleife;
         end case;

      end loop RassenSchleife;
      
   end VerbesserungFertiggestellt;



   procedure VerbesserungAngelegt (RasseExtern : in GlobaleDatentypen.Rassen; EinheitNummer : in Positive) is
   begin
      
      case GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummer).AktuelleBeschäftigung is -- Landstraße/Tiefengrabung/Farm/Festung/Wald aufforsten/Roden-Trockenlegen
         when 1 =>
            StraßeBerechnung (Koordinaten => GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummer).AchsenPosition);
              
         when 2 =>
            Karten.Karten (GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummer).AchsenPosition.EAchse, GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummer).AchsenPosition.YAchse,
                           GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummer).AchsenPosition.XAchse).VerbesserungGebiet := 21;
            
         when 3 =>
            Karten.Karten (GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummer).AchsenPosition.EAchse, GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummer).AchsenPosition.YAchse,
                           GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummer).AchsenPosition.XAchse).VerbesserungGebiet := 20;
            
         when 4 =>
            Karten.Karten (GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummer).AchsenPosition.EAchse, GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummer).AchsenPosition.YAchse,
                           GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummer).AchsenPosition.XAchse).VerbesserungGebiet := 22;
              
         when 5 =>
            Karten.Karten (GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummer).AchsenPosition.EAchse, GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummer).AchsenPosition.YAchse,
                           GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummer).AchsenPosition.XAchse).Grund := 8;
            case Karten.Karten (GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummer).AchsenPosition.EAchse, GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummer).AchsenPosition.YAchse,
                                GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummer).AchsenPosition.XAchse).VerbesserungGebiet is
               when 20 .. 21 =>
                  Karten.Karten (GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummer).AchsenPosition.EAchse, GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummer).AchsenPosition.YAchse,
                                 GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummer).AchsenPosition.XAchse).VerbesserungGebiet := 0;
                  
               when others =>
                  null;
            end case;
              
         when 6 =>
            case Karten.Karten (GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummer).AchsenPosition.EAchse, GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummer).AchsenPosition.YAchse,
                                GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummer).AchsenPosition.XAchse).Hügel is
               when True =>
                  Karten.Karten (GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummer).AchsenPosition.EAchse, GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummer).AchsenPosition.YAchse,
                                 GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummer).AchsenPosition.XAchse).Grund := 6;
                  
               when False =>
                  Karten.Karten (GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummer).AchsenPosition.EAchse, GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummer).AchsenPosition.YAchse,
                                 GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummer).AchsenPosition.XAchse).Grund := 3;
            end case;
            
         when others =>
            null;
      end case;

      WerteFestlegen.KartenfelderBewerten (Generierung => False,
                                           Koordinaten => GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummer).AchsenPosition);
      
   end VerbesserungAngelegt;



   procedure StraßeBerechnung (Koordinaten : in GlobaleRecords.AchsenAusKartenfeldPositivRecord) is
   begin

      Straßenwert := 10_000;
      
      YAchseSchleife:
      for YÄnderung in GlobaleDatentypen.LoopRangeMinusEinsZuEins'Range loop
         XAchseSchleife:
         for XÄnderung in GlobaleDatentypen.LoopRangeMinusEinsZuEins'Range loop

            KartenWert := SchleifenPruefungen.KartenUmgebung (Koordinaten    => Koordinaten,
                                                              Änderung       => (0, YÄnderung, XÄnderung),
                                                              ZusatzYAbstand => 0);

            case KartenWert.YAchse is
               when GlobaleDatentypen.Kartenfeld'First =>
                  exit XAchseSchleife;

               when others =>
                  if XÄnderung = -1 and YÄnderung = 0 then
                     case Karten.Karten (Koordinaten.EAchse, KartenWert.YAchse, KartenWert.XAchse).VerbesserungStraße is
                        when 0 =>
                           Straßenwert := Straßenwert - 1_000;

                        when 7 =>
                           Karten.Karten (Koordinaten.EAchse, KartenWert.YAchse, KartenWert.XAchse).VerbesserungStraße := 14;
                     
                        when 9 =>
                           Karten.Karten (Koordinaten.EAchse, KartenWert.YAchse, KartenWert.XAchse).VerbesserungStraße := 13;

                        when 11 =>                     
                           Karten.Karten (Koordinaten.EAchse, KartenWert.YAchse, KartenWert.XAchse).VerbesserungStraße := 12;

                        when 15 =>
                           Karten.Karten (Koordinaten.EAchse, KartenWert.YAchse, KartenWert.XAchse).VerbesserungStraße := 5;

                        when 17 =>
                           Karten.Karten (Koordinaten.EAchse, KartenWert.YAchse, KartenWert.XAchse).VerbesserungStraße := 6;

                        when 18 =>
                           Karten.Karten (Koordinaten.EAchse, KartenWert.YAchse, KartenWert.XAchse).VerbesserungStraße := 10;

                        when 19 =>
                           Karten.Karten (Koordinaten.EAchse, KartenWert.YAchse, KartenWert.XAchse).VerbesserungStraße := 8;
                     
                        when others =>
                           null;
                     end case;
                     Straßenwert := Straßenwert + 1_000;
               
                  elsif XÄnderung = 1 and YÄnderung = 0 then
                     case Karten.Karten (Koordinaten.EAchse, KartenWert.YAchse, KartenWert.XAchse).VerbesserungStraße is
                        when 0 =>
                           Straßenwert := Straßenwert - 100;

                        when 7 =>
                           Karten.Karten (Koordinaten.EAchse, KartenWert.YAchse, KartenWert.XAchse).VerbesserungStraße := 15;
                     
                        when 8 =>
                           Karten.Karten (Koordinaten.EAchse, KartenWert.YAchse, KartenWert.XAchse).VerbesserungStraße := 13;

                        when 10 =>                     
                           Karten.Karten (Koordinaten.EAchse, KartenWert.YAchse, KartenWert.XAchse).VerbesserungStraße := 12;

                        when 14 =>
                           Karten.Karten (Koordinaten.EAchse, KartenWert.YAchse, KartenWert.XAchse).VerbesserungStraße := 5;

                        when 16 =>
                           Karten.Karten (Koordinaten.EAchse, KartenWert.YAchse, KartenWert.XAchse).VerbesserungStraße := 6;

                        when 18 =>
                           Karten.Karten (Koordinaten.EAchse, KartenWert.YAchse, KartenWert.XAchse).VerbesserungStraße := 11;

                        when 19 =>
                           Karten.Karten (Koordinaten.EAchse, KartenWert.YAchse, KartenWert.XAchse).VerbesserungStraße := 9;
                     
                        when others =>
                           null;
                     end case;
                     Straßenwert := Straßenwert + 100;
               
                  elsif YÄnderung = -1 and XÄnderung = 0 then
                     case Karten.Karten (Koordinaten.EAchse, KartenWert.YAchse, KartenWert.XAchse).VerbesserungStraße is
                        when 0 =>
                           Straßenwert := Straßenwert - 10;
                     
                        when 6 =>
                           Karten.Karten (Koordinaten.EAchse, KartenWert.YAchse, KartenWert.XAchse).VerbesserungStraße := 13;
                     
                        when 10 =>
                           Karten.Karten (Koordinaten.EAchse, KartenWert.YAchse, KartenWert.XAchse).VerbesserungStraße := 14;

                        when 11 =>                     
                           Karten.Karten (Koordinaten.EAchse, KartenWert.YAchse, KartenWert.XAchse).VerbesserungStraße := 15;

                        when 12 =>
                           Karten.Karten (Koordinaten.EAchse, KartenWert.YAchse, KartenWert.XAchse).VerbesserungStraße := 5;

                        when 16 =>
                           Karten.Karten (Koordinaten.EAchse, KartenWert.YAchse, KartenWert.XAchse).VerbesserungStraße := 8;

                        when 17 =>
                           Karten.Karten (Koordinaten.EAchse, KartenWert.YAchse, KartenWert.XAchse).VerbesserungStraße := 9;

                        when 18 =>
                           Karten.Karten (Koordinaten.EAchse, KartenWert.YAchse, KartenWert.XAchse).VerbesserungStraße := 7;
                     
                        when others =>
                           null;
                     end case;
                     Straßenwert := Straßenwert + 10;
               
                  elsif YÄnderung = 1 and XÄnderung = 0 then
                     case Karten.Karten (Koordinaten.EAchse, KartenWert.YAchse, KartenWert.XAchse).VerbesserungStraße is
                        when 0 =>
                           Straßenwert := Straßenwert - 1;
                     
                        when 6 =>
                           Karten.Karten (Koordinaten.EAchse, KartenWert.YAchse, KartenWert.XAchse).VerbesserungStraße := 12;
                     
                        when 8 =>
                           Karten.Karten (Koordinaten.EAchse, KartenWert.YAchse, KartenWert.XAchse).VerbesserungStraße := 14;

                        when 9 =>                     
                           Karten.Karten (Koordinaten.EAchse, KartenWert.YAchse, KartenWert.XAchse).VerbesserungStraße := 15;

                        when 13 =>
                           Karten.Karten (Koordinaten.EAchse, KartenWert.YAchse, KartenWert.XAchse).VerbesserungStraße := 5;

                        when 16 =>
                           Karten.Karten (Koordinaten.EAchse, KartenWert.YAchse, KartenWert.XAchse).VerbesserungStraße := 10;

                        when 17 =>
                           Karten.Karten (Koordinaten.EAchse, KartenWert.YAchse, KartenWert.XAchse).VerbesserungStraße := 11;

                        when 19 =>
                           Karten.Karten (Koordinaten.EAchse, KartenWert.YAchse, KartenWert.XAchse).VerbesserungStraße := 7;
                     
                        when others =>
                           null;
                     end case;
                     Straßenwert := Straßenwert + 1;
               
                  else
                     null;
                  end if;
            end case;
            
         end loop XAchseSchleife;
      end loop YAchseSchleife;

      case Straßenwert is
         when 11_000 =>
            Karten.Karten (Koordinaten.EAchse, Koordinaten.YAchse, Koordinaten.XAchse).VerbesserungStraße := 17;

         when 10_100 =>
            Karten.Karten (Koordinaten.EAchse, Koordinaten.YAchse, Koordinaten.XAchse).VerbesserungStraße := 16;

         when 10_010 =>
            Karten.Karten (Koordinaten.EAchse, Koordinaten.YAchse, Koordinaten.XAchse).VerbesserungStraße := 18;

         when 10_001 =>
            Karten.Karten (Koordinaten.EAchse, Koordinaten.YAchse, Koordinaten.XAchse).VerbesserungStraße := 19;

         when 11_010 =>
            Karten.Karten (Koordinaten.EAchse, Koordinaten.YAchse, Koordinaten.XAchse).VerbesserungStraße := 11;

         when 11_001 =>
            Karten.Karten (Koordinaten.EAchse, Koordinaten.YAchse, Koordinaten.XAchse).VerbesserungStraße := 9;

         when 11_110 =>
            Karten.Karten (Koordinaten.EAchse, Koordinaten.YAchse, Koordinaten.XAchse).VerbesserungStraße := 12;

         when 11_101 =>
            Karten.Karten (Koordinaten.EAchse, Koordinaten.YAchse, Koordinaten.XAchse).VerbesserungStraße := 13;

         when 11_111 =>
            Karten.Karten (Koordinaten.EAchse, Koordinaten.YAchse, Koordinaten.XAchse).VerbesserungStraße := 5;

         when 10_110 =>
            Karten.Karten (Koordinaten.EAchse, Koordinaten.YAchse, Koordinaten.XAchse).VerbesserungStraße := 10;

         when 10_101 =>
            Karten.Karten (Koordinaten.EAchse, Koordinaten.YAchse, Koordinaten.XAchse).VerbesserungStraße := 8;

         when 10_111 =>
            Karten.Karten (Koordinaten.EAchse, Koordinaten.YAchse, Koordinaten.XAchse).VerbesserungStraße := 14;

         when 10_011 =>
            Karten.Karten (Koordinaten.EAchse, Koordinaten.YAchse, Koordinaten.XAchse).VerbesserungStraße := 7;
         
         when others =>
            Karten.Karten (Koordinaten.EAchse, Koordinaten.YAchse, Koordinaten.XAchse).VerbesserungStraße := 6;
      end case;
      
   end StraßeBerechnung;

end Verbesserungen;
