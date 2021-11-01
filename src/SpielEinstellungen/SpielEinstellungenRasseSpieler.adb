pragma SPARK_Mode (On);

with Ada.Wide_Wide_Text_IO; use Ada.Wide_Wide_Text_IO;
with Ada.Characters.Wide_Wide_Latin_9; use Ada.Characters.Wide_Wide_Latin_9;

with GlobaleTexte;
with SystemKonstanten;
with KartenKonstanten;
with EinheitenKonstanten;

with LeseEinheitenGebaut;

with Auswahl;
with ZufallGeneratorenSpieleinstellungen;
with Anzeige;
with Eingabe;
with ZufallGeneratorenKarten;
with EinheitSuchen;
with KartePositionPruefen;
with BewegungPassierbarkeitPruefen;
with EinheitenErzeugenEntfernen;

package body SpielEinstellungenRasseSpieler is

   function SpieleranzahlWählen
     return SystemDatentypen.Rückgabe_Werte_Enum
   is begin
      
      SpieleranzahlSchleife:
      loop

         SpieleranzahlAuswahl := Auswahl.Auswahl (FrageDateiExtern  => GlobaleTexte.Spiel_Einstellungen,
                                                  TextDateiExtern   => GlobaleTexte.Spiel_Einstellungen,
                                                  FrageZeileExtern  => 35,
                                                  ErsteZeileExtern  => 36,
                                                  LetzteZeileExtern => 40);
         
         case
           SpieleranzahlAuswahl
         is
            when 1 =>
               SpielerAnzahl := Eingabe.GanzeZahl (TextDateiExtern     => GlobaleTexte.Fragen,
                                                   ZeileExtern         => 1,
                                                   ZahlenMinimumExtern => 1,
                                                   ZahlenMaximumExtern => 18);
               if
                 SpielerAnzahl in 1 .. 18
               then
                  return SystemKonstanten.AuswahlBelegung;
                  
               else
                  null;
               end if;

            when 2 =>
               SpielerAnzahl := ZufallGeneratorenSpieleinstellungen.ZufälligeSpieleranzahl;
               return SystemKonstanten.AuswahlBelegung;
               
            when SystemDatentypen.Zurück =>
               return SystemKonstanten.AuswahlKartenressourcen;

            when SystemDatentypen.Spiel_Beenden | SystemDatentypen.Hauptmenü =>
               return SpieleranzahlAuswahl;
               
            when SystemDatentypen.Leer =>
               null;
               
            when others =>
               raise Program_Error;
         end case;

         Put (Item => CSI & "2J" & CSI & "H");
         
      end loop SpieleranzahlSchleife;
      
   end SpieleranzahlWählen;



   function SpielerbelegungWählen
     return SystemDatentypen.Rückgabe_Werte_Enum
   is begin
      
      GlobaleVariablen.RassenImSpiel := (others => SonstigeDatentypen.Leer);
      Spieler := 0;

      SpielerSchleife:
      while Spieler < SpielerAnzahl loop
         
         SpielerartAuswahl := RasseWählen;
         
         case
           SpielerartAuswahl
         is
            when SystemDatentypen.Zurück =>
               return SystemKonstanten.AuswahlSpieleranzahl;

            when SystemDatentypen.Spiel_Beenden | SystemDatentypen.Hauptmenü =>
               return SpielerartAuswahl;
               
            when SystemDatentypen.Leer =>
               null;
               
            when others =>
               raise Program_Error;
         end case;
         
         if
           SpielerartAuswahl = RasseEntfernen
         then
            null;
            
         else
            case
              GlobaleVariablen.RassenImSpiel (SonstigeDatentypen.Rassen_Verwendet_Enum'Val (SpielerartAuswahl))
            is
               when SonstigeDatentypen.Leer =>
                  if
                    Auswahl.AuswahlJaNein (FrageZeileExtern => 21) = SystemKonstanten.JaKonstante
                  then
                     GlobaleVariablen.RassenImSpiel (SonstigeDatentypen.Rassen_Verwendet_Enum'Val (SpielerartAuswahl)) := SonstigeDatentypen.Spieler_Mensch;
                     Spieler := Spieler + 1;
                     
                  else
                     GlobaleVariablen.RassenImSpiel (SonstigeDatentypen.Rassen_Verwendet_Enum'Val (SpielerartAuswahl)) := SonstigeDatentypen.Spieler_KI;
                     Spieler := Spieler + 1;
                  end if;
               
               when others =>
                  null;
            end case;
         end if;
         
      end loop SpielerSchleife;

      return SystemKonstanten.AuswahlSchwierigkeitsgrad;

   end SpielerbelegungWählen;
   

   
   function RasseWählen
     return SystemDatentypen.Rückgabe_Werte_Enum
   is begin

      RasseSchleife:
      loop
         
         RassenAuswahl := Auswahl.Auswahl (FrageDateiExtern  => GlobaleTexte.Spiel_Einstellungen,
                                           TextDateiExtern   => GlobaleTexte.Spiel_Einstellungen,
                                           FrageZeileExtern  => 41,
                                           ErsteZeileExtern  => 42,
                                           LetzteZeileExtern => 63);

         case
           RassenAuswahl
         is
            when 1 .. 18 =>
               if
                 GlobaleVariablen.RassenImSpiel (SonstigeDatentypen.Rassen_Verwendet_Enum'Val (RassenAuswahl)) = SonstigeDatentypen.Leer
               then
                  Anzeige.AnzeigeLangerTextNeu (ÜberschriftDateiExtern => GlobaleTexte.Spiel_Einstellungen,
                                                TextDateiExtern        => GlobaleTexte.Rassen_Beschreibung_Lang,
                                                ÜberschriftZeileExtern => RassenAuswahl + 41,
                                                ErsteZeileExtern       => RassenAuswahl,
                                                AbstandAnfangExtern    => GlobaleTexte.Leer,
                                                AbstandEndeExtern      => GlobaleTexte.Leer);
                  Eingabe.WartenEingabe;
               
                  case
                    Auswahl.AuswahlJaNein (FrageZeileExtern => 6)
                  is
                     when SystemKonstanten.JaKonstante =>
                        return RassenAuswahl;
                     
                     when others =>
                        null;
                  end case;
                  
               else
                  case
                    Auswahl.AuswahlJaNein (FrageZeileExtern => 32)
                  is
                     when SystemKonstanten.JaKonstante =>
                        GlobaleVariablen.RassenImSpiel (SonstigeDatentypen.Rassen_Verwendet_Enum'Val (RassenAuswahl)) := SonstigeDatentypen.Leer;
                        Spieler := Spieler - 1;
                        return RasseEntfernen;
                     
                     when others =>
                        null;
                  end case;
               end if;

            when 19 =>
               return SonstigeDatentypen.Rassen_Verwendet_Enum'Pos (ZufallGeneratorenSpieleinstellungen.ZufälligeRasse);

            when SystemDatentypen.Zurück | SystemDatentypen.Spiel_Beenden | SystemDatentypen.Hauptmenü =>
               return RassenAuswahl;
               
            when others =>
               null;
         end case;

         Put (Item => CSI & "2J" & CSI & "H");
         
      end loop RasseSchleife;
      
   end RasseWählen;



   procedure StartwerteErmitteln
   is begin
      
      SpieleranzahlWerteFestlegen:
      for RasseSchleifenwert in SonstigeDatentypen.Rassen_Verwendet_Enum'Range loop
        
         case
           GlobaleVariablen.RassenImSpiel (RasseSchleifenwert)
         is
            when SonstigeDatentypen.Leer =>
               null;
               
            when others =>
               StartwerteFestlegenSchleife:
               for NotAusSchleifenwert in SystemDatentypen.NotAus'Range loop
                  
                  StartKoordinaten := ((0, 0, 0), (0, 0, 0));
                  GezogeneWerte := ZufallGeneratorenKarten.StartPosition (RasseSchleifenwert);

                  exit StartwerteFestlegenSchleife when UmgebungPrüfen (PositionExtern => GezogeneWerte,
                                                                         RasseExtern    => RasseSchleifenwert);

                  case
                    NotAusSchleifenwert
                  is
                     when SystemDatentypen.NotAus'Last =>
                        Anzeige.EinzeiligeAnzeigeOhneAuswahl (TextDateiExtern => GlobaleTexte.Fehlermeldungen,
                                                              TextZeileExtern => 16);
                        Anzeige.EinzeiligeAnzeigeOhneAuswahl (TextDateiExtern => GlobaleTexte.Rassen_Beschreibung_Kurz,
                                                              TextZeileExtern => SonstigeDatentypen.Rassen_Verwendet_Enum'Pos (RasseSchleifenwert));
                        Anzeige.EinzeiligeAnzeigeOhneAuswahl (TextDateiExtern => GlobaleTexte.Fehlermeldungen,
                                                              TextZeileExtern => 17);
                        GlobaleVariablen.RassenImSpiel (RasseSchleifenwert) := SonstigeDatentypen.Leer;
                        
                     when others =>
                        null;
                  end case;
         
               end loop StartwerteFestlegenSchleife;
         end case;
         
      end loop SpieleranzahlWerteFestlegen;
      
   end StartwerteErmitteln;



   function UmgebungPrüfen
     (PositionExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in SonstigeDatentypen.Rassen_Verwendet_Enum)
      return Boolean
   is begin

      FreieFelder := 0;
      
      case
        EinheitSuchen.KoordinatenEinheitOhneRasseSuchen (KoordinatenExtern => PositionExtern).Platznummer
      is
         when EinheitenKonstanten.LeerNummer =>
            StartKoordinaten (1) := PositionExtern;
            FelderBestimmen (PositionExtern => PositionExtern,
                             RasseExtern    => RasseExtern);
                           
         when others =>
            null;
      end case;
         
      if
        FreieFelder >= 3
      then
         StartpunktFestlegen (RasseExtern => RasseExtern);
         return True;
               
      else
         return False;
      end if;
      
   end UmgebungPrüfen;
   
   
   
   procedure FelderBestimmen
     (PositionExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in SonstigeDatentypen.Rassen_Verwendet_Enum)
   is begin
            
      StartpositionGefunden := False;
      
      YAchseSchleife:
      for YÄnderungSchleifenwert in KartenDatentypen.LoopRangeMinusEinsZuEins'Range loop
         XAchseSchleife:
         for XÄnderungSchleifenwert in KartenDatentypen.LoopRangeMinusEinsZuEins'Range loop

            KartenWert := KartePositionPruefen.KartenPositionBestimmen (KoordinatenExtern => PositionExtern,
                                                                        ÄnderungExtern    => (0, YÄnderungSchleifenwert, XÄnderungSchleifenwert));
                  
            if
              KartenWert.XAchse = KartenKonstanten.LeerXAchse
            then
               null;
                     
            elsif
              YÄnderungSchleifenwert = 0
              and
                XÄnderungSchleifenwert = 0
            then
               null;
                     
            elsif
              BewegungPassierbarkeitPruefen.PassierbarkeitPrüfenID (RasseExtern        => RasseExtern,
                                                                     IDExtern           => 2,
                                                                     NeuePositionExtern => KartenWert)
              = False
            then
               null;
                     
            elsif
              StartpositionGefunden = False
            then
               case
                 EinheitSuchen.KoordinatenEinheitOhneRasseSuchen (KoordinatenExtern => KartenWert).Platznummer
               is
                  when EinheitenKonstanten.LeerNummer =>
                     StartKoordinaten (2) := KartenWert;
                     StartpositionGefunden := True;
                     FreieFelder := FreieFelder + 1;
                                 
                  when others =>
                     null;
               end case;
                     
            else
               FreieFelder := FreieFelder + 1;
            end if;

         end loop XAchseSchleife;
      end loop YAchseSchleife;
      
   end FelderBestimmen;



   procedure StartpunktFestlegen
     (RasseExtern : in SonstigeDatentypen.Rassen_Verwendet_Enum)
   is begin

      EinheitenErzeugenEntfernen.EinheitErzeugen (KoordinatenExtern      => StartKoordinaten (1),
                                                  EinheitNummerExtern    => 1,
                                                  IDExtern               => 1,
                                                  StadtRasseNummerExtern => (RasseExtern, 0));
      
      EinheitenErzeugenEntfernen.EinheitErzeugen (KoordinatenExtern      => StartKoordinaten (2),
                                                  EinheitNummerExtern    => 2,
                                                  IDExtern               => 2,
                                                  StadtRasseNummerExtern => (RasseExtern, 0));
      
      GlobaleVariablen.CursorImSpiel (RasseExtern).Position := LeseEinheitenGebaut.Position (EinheitRasseNummerExtern => (RasseExtern, 1));
      GlobaleVariablen.CursorImSpiel (RasseExtern).PositionAlt := GlobaleVariablen.CursorImSpiel (RasseExtern).Position;
      
   end StartpunktFestlegen;

end SpielEinstellungenRasseSpieler;
