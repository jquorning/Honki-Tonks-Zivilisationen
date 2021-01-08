package body SpielEinstellungen is

   function SpielEinstellungen return Integer is
   begin

      Wahl := 1;

      AuswahlSchleife:
      loop

         case Wahl is
            when 1 =>
               Wahl := KartengrößeWählen;

            when 2 =>
               Wahl := KartenartWählen;

            when 3 =>            
               Wahl := KartentemperaturWählen;
               
            when 4 =>
               Wahl := SpieleranzahlWählen;

            when 5 =>
               Wahl := MenschlicheSpieleranzahl;

            when 6 =>
               exit AuswahlSchleife;

            when -1 | 0 =>
               return Wahl;

            when others =>
               null;
         end case;

      end loop AuswahlSchleife;

      KartenGenerator.KartenGenerator;
      
      Ladezeiten.LadezeitenSpielweltErstellenZeit (1, 13) := Clock;
      StartwerteErmitteln;
      Ladezeiten.LadezeitenSpielweltErstellenZeit (2, 13) := Clock;
      Ladezeiten.LadezeitenSpielweltErstellen (WelcheZeit => 13);
      Ladezeiten.LadezeitenSpielweltErstellen (WelcheZeit => 1);
         
      return ImSpiel.ImSpiel;
              
   end SpielEinstellungen;



   function KartengrößeWählen return Integer is
   begin
      
      KartengrößeSchleife:
      loop
         
         Wahl := Auswahl.Auswahl (WelcheAuswahl => 1,
                                  WelcherText   => 2);
         
         case Wahl is
            when 1 .. 9 =>
               Karten.Kartengröße := Wahl;
               return 2;

            when 10 =>
               Karten.Kartengröße := Wahl;
               Anzeige.WelcheAuswahl (WasWurdeGewählt => 19);
               BenutzerdefinierteGröße := Eingabe.GanzeZahl (Zahlengröße => 4);
               case BenutzerdefinierteGröße is
                  when 10 .. 1_000 =>
                     Karten.Kartengrößen (Wahl).YAchsenGröße := GlobaleDatentypen.KartenfeldPositiv (BenutzerdefinierteGröße);
                     BenutzerdefinierteGröße := Eingabe.GanzeZahl (Zahlengröße => 4);
                     
                     case BenutzerdefinierteGröße is
                        when 10 .. 1_000 =>
                           Karten.Kartengrößen (Wahl).XAchsenGröße := GlobaleDatentypen.KartenfeldPositiv (BenutzerdefinierteGröße);
                           Karten.Kartengrößen (Wahl).Ressourcenmenge := Integer (Karten.Kartengrößen (Wahl).YAchsenGröße) * Integer (Karten.Kartengrößen (Wahl).XAchsenGröße) / 32;
                           return 2;
                           
                        when others =>
                           null;
                     end case;
                     
                  when others =>
                     null;
               end case;
               
            when 11 =>
               ZufälligeKartengrößeWählen.Reset (ZufälligeKartenGrößeGewählt);
               Karten.Kartengröße := ZufälligeKartengrößeWählen.Random (ZufälligeKartengrößeGewählt);
               return 2;

            when -1 | 0 =>
               return Wahl;
               
            when others =>
               null;
         end case;

         Put (Item => CSI & "2J" & CSI & "H");
                  
      end loop KartengrößeSchleife;
      
   end KartengrößeWählen;



   function KartenartWählen return Integer is
   begin
            
      KartenartSchleife:
      loop

         Wahl := Auswahl.Auswahl (WelcheAuswahl => 2,
                                  WelcherText   => 3);
                  
         case Wahl is
            when 1 .. 3  | 5 =>
               KartenGenerator.Kartenart := Wahl;
               return 3;
               
            when 6 =>
               ZufälligeKartenartWählen.Reset (ZufälligeKartenartGewählt);
               KartenGenerator.Kartenart := ZufälligeKartenartWählen.Random (ZufälligeKartenartGewählt);
               return 3;
               
            when -2 =>
               return 1;

            when -1 | 0 =>
               return Wahl;
               
            when others =>
               null;
         end case;

         Put (Item => CSI & "2J" & CSI & "H");                  

      end loop KartenartSchleife;
      
   end KartenartWählen;



   function KartentemperaturWählen return Integer is
   begin
            
      KartentemperaturSchleife:
      loop

         Wahl := Auswahl.Auswahl (WelcheAuswahl =>  3,
                                  WelcherText   => 4);
                  
         case Wahl is
            when 1 .. 3 =>
               KartenGenerator.Kartentemperatur := Wahl;
               return 4;
               
            when 6 =>
               ZufälligeKartentemperaturWählen.Reset (ZufälligeKartentemperaturGewählt);
               KartenGenerator.Kartentemperatur := ZufälligeKartentemperaturWählen.Random (ZufälligeKartentemperaturGewählt);
               return 4;
               
            when -2 =>
               return 2;

            when -1 | 0 =>
               return Wahl;
               
            when others =>
               null;
         end case;

         Put (Item => CSI & "2J" & CSI & "H");
                  
      end loop KartentemperaturSchleife;
      
   end KartentemperaturWählen;



   function SpieleranzahlWählen return Integer is
   begin
      
      SpieleranzahlSchleife:
      loop

         Wahl := Auswahl.Auswahl (WelcheAuswahl => 4,
                                  WelcherText   => 5);
         
         case Wahl is
            when 1 .. 18 =>
               GlobaleVariablen.SpielerAnzahl := Wahl;
               return 5;

            when 19 => 
               ZufälligeSpieleranzahlWählen.Reset (ZufälligeSpieleranzahlGewählt);
               GlobaleVariablen.SpielerAnzahl := ZufälligeSpieleranzahlWählen.Random (ZufälligeSpieleranzahlGewählt);
               return 5;
               
            when -2 =>
               return 3;

            when -1 | 0 =>
               return Wahl;
               
            when others =>
               null;
         end case;

         Put (Item => CSI & "2J" & CSI & "H");
         
      end loop SpieleranzahlSchleife;
      
   end SpielerAnzahlWählen;



   function MenschlicheSpieleranzahl return Integer is
   begin
      
      GlobaleVariablen.RassenImSpiel := (others => 0);
      Spieler := 0;

      SpielerSchleife:
      while Spieler < GlobaleVariablen.SpielerAnzahl loop
         
         Wert := RasseWählen;
         case Wert is                  
            when -2 =>
               return 4;

            when -1 | 0 =>
               return Wahl;
               
            when others =>
               null;
         end case;
         
         case GlobaleVariablen.RassenImSpiel (Wert)is
            when 0 =>
               Wahl := Auswahl.Auswahl (WelcheAuswahl => 21,
                                        WelcherText   => 25);
         
               case Wahl is
                  when 1 .. 2 =>
                     GlobaleVariablen.RassenImSpiel (Wert) := Wahl;
                     Spieler := Spieler + 1;

                  when others =>
                     null;
               end case;
               
            when others =>
               null;
         end case;

         Put (Item => CSI & "2J" & CSI & "H");
         
      end loop SpielerSchleife;

      return 6;

   end MenschlicheSpieleranzahl;


   
   function RasseWählen return Integer is -- 0 = Nicht belegt, 1 = Menschlicher Spieler, 2 = KI
   begin

      RasseSchleife:
      loop
         
         Wahl := Auswahl.Auswahl (WelcheAuswahl => 5,
                                  WelcherText   => 6);

         case Wahl is
            when 1 .. 18 =>      
               Anzeige.AnzeigeLangerText (WelcherText => 7,
                                          WelcheZeile => Wahl);
               Wahl2 := Auswahl.Auswahl (WelcheAuswahl => 6,
                                         WelcherText   => 18);
               case Wahl2 is
                  when -3 =>
                     return Wahl;
                     
                  when others =>
                     null;
               end case;

            when 19 =>
               ZufälligeRasseWählen.Reset (ZufälligeRasseGewählt);
               Zufallswahl := ZufälligeRasseWählen.Random (ZufälligeRasseGewählt);
               return Zufallswahl;

            when -2 .. 0 =>
               return Wahl;
               
            when others =>
               null;
         end case;               

         Put (Item => CSI & "2J" & CSI & "H");
         
      end loop RasseSchleife;
      
   end RasseWählen;



   procedure StartwerteErmitteln is
   begin
      
      SpieleranzahlWerteFestlegen:
      for Rasse in GlobaleVariablen.RassenImSpiel'Range loop
        
         case GlobaleVariablen.RassenImSpiel (Rasse) is
            when 0 =>
               null;
               
            when others =>
               SicherheitsTestWert := 0;
         
               StartwerteFestlegenSchleife:
               loop
                  
                  Koordinaten := ((0, 0, 0), (0, 0, 0));
                  GezogeneWerte := ZufallsGeneratoren.YXPosition;

                  PrüfungEinheit := UmgebungPrüfen (YPosition => GezogeneWerte.YAchse,
                                                    XPosition => GezogeneWerte.XAchse,
                                                    Rasse     => Rasse);

                  case PrüfungEinheit is
                     when True =>
                        exit StartwerteFestlegenSchleife;
                        
                     when False =>
                        SicherheitsTestWert := SicherheitsTestWert + 1;
                  end case;

                  case SicherheitsTestWert is
                     when 10_000 =>
                        Put_Line ("Keine geeignete Startposition für Rasse" & Rasse'Wide_Wide_Image & " gefunden!");
                        Put_Line ("Rasse wird entfernt. Wenden sie sich an den Entwickler.");
                        GlobaleVariablen.RassenImSpiel (Rasse) := 0;
                        delay 1.5;
                        exit StartwerteFestlegenSchleife;
                        
                     when others =>
                        null;
                  end case;
         
               end loop StartwerteFestlegenSchleife;
               
         end case;
         
      end loop SpieleranzahlWerteFestlegen;
      
   end StartwerteErmitteln;



   function UmgebungPrüfen (YPosition, XPosition : in GlobaleDatentypen.Kartenfeld; Rasse : in Integer) return Boolean is
   begin
      
      PrüfungGrund := SchleifenPruefungen.KartenGrund (Ebene       => 0,
                                                       YKoordinate => YPosition,
                                                       XKoordinate => XPosition);

      case PrüfungGrund is
         when False =>
            return False;
            
         when True =>
            PositionWert := SchleifenPruefungen.KoordinatenEinheitOhneRasseSuchen (YAchse => YPosition,
                                                                                   XAchse => XPosition);
      end case;

      case PositionWert.Rasse is
         when SchleifenPruefungen.RückgabeWert =>
            Koordinaten (1) := (0, YPosition, XPosition);
            YAchseSchleife:
            for YÄnderung in GlobaleDatentypen.LoopRangeMinusEinsZuEins'Range loop
               XAchseSchleife:
               for XÄnderung in GlobaleDatentypen.LoopRangeMinusEinsZuEins'Range loop

                  KartenWert := SchleifenPruefungen.KartenUmgebung (YKoordinate    => YPosition,
                                                                    XKoordinate    => XPosition,
                                                                    YÄnderung      => YÄnderung,
                                                                    XÄnderung      => XÄnderung,
                                                                    ZusatzYAbstand => 0);
                  case KartenWert.YAchse is
                     when GlobaleDatentypen.Kartenfeld'First =>
                        exit XAchseSchleife;
                  
                     when others =>
                        if YÄnderung /= 0 or XÄnderung /= 0 then
                           PrüfungGrund := SchleifenPruefungen.KartenGrund (Ebene       => 0,
                                                                            YKoordinate => KartenWert.YAchse,
                                                                            XKoordinate => KartenWert.XAchse);

                           case PrüfungGrund is
                              when False =>
                                 PlatzBelegt := (1, 1);
            
                              when True =>
                                 PlatzBelegt := SchleifenPruefungen.KoordinatenEinheitOhneRasseSuchen (YAchse => KartenWert.YAchse,
                                                                                                       XAchse => KartenWert.XAchse);
                           end case;                    
                           
                           case PlatzBelegt.Rasse is
                              when SchleifenPruefungen.RückgabeWert =>
                                    Koordinaten (2) := (0, KartenWert.YAchse, KartenWert.XAchse);
                                    StartpunktFestlegen (Rasse => Rasse);
                                 return True;
                                 
                              when others =>
                                 null;
                           end case;
                                             
                        else
                           null;
                        end if;
                  end case;

               end loop XAchseSchleife;
            end loop YAchseSchleife;
                           
         when others =>
            null;
      end case;
         
      return False;
      
   end UmgebungPrüfen;



   procedure StartpunktFestlegen (Rasse : in Integer) is
   begin

      GlobaleVariablen.EinheitenGebaut (Rasse, 1).ID := 1;
      GlobaleVariablen.EinheitenGebaut (Rasse, 1).AchsenPosition.EAchse := Koordinaten (1).EAchse;
      GlobaleVariablen.EinheitenGebaut (Rasse, 1).AchsenPosition.YAchse := Koordinaten (1).YAchse;
      GlobaleVariablen.EinheitenGebaut (Rasse, 1).AchsenPosition.XAchse := Koordinaten (1).XAchse;
      EinheitenDatenbank.LebenspunkteBewegungspunkteAufMaximumSetzen (Rasse, 1);

      GlobaleVariablen.EinheitenGebaut (Rasse, 2).ID := 2;
      GlobaleVariablen.EinheitenGebaut (Rasse, 2).AchsenPosition.EAchse := Koordinaten (2).EAchse;
      GlobaleVariablen.EinheitenGebaut (Rasse, 2).AchsenPosition.YAchse := Koordinaten (2).YAchse;
      GlobaleVariablen.EinheitenGebaut (Rasse, 2).AchsenPosition.XAchse := Koordinaten (2).XAchse;
      EinheitenDatenbank.LebenspunkteBewegungspunkteAufMaximumSetzen (Rasse, 2);
      
      GlobaleVariablen.CursorImSpiel (Rasse).AchsenPosition := GlobaleVariablen.EinheitenGebaut (Rasse, 1).AchsenPosition;
      GlobaleVariablen.CursorImSpiel (Rasse).AchsenPositionAlt := GlobaleVariablen.EinheitenGebaut (Rasse, 1).AchsenPosition;
      
   end StartpunktFestlegen;

end SpielEinstellungen;
