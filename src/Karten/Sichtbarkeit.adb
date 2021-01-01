package body Sichtbarkeit is

   procedure Sichtbarkeitsprüfung is
   begin
      
      EinheitenPlätzeSchleife:
      for EinheitNummer in GlobaleVariablen.EinheitenGebaut'Range (2) loop

         case GlobaleVariablen.EinheitenGebaut (GlobaleVariablen.GeradeAmZug, EinheitNummer).ID is
            when 0 =>
               exit EinheitenPlätzeSchleife;
            
            when others =>
               null;
         end case;
         
         case Karten.Karten (GlobaleVariablen.EinheitenGebaut (GlobaleVariablen.GeradeAmZug, EinheitNummer).AchsenPosition.EAchse,
                             GlobaleVariablen.EinheitenGebaut (GlobaleVariablen.GeradeAmZug, EinheitNummer).AchsenPosition.YAchse,
                             GlobaleVariablen.EinheitenGebaut (GlobaleVariablen.GeradeAmZug, EinheitNummer).AchsenPosition.XAchse).Grund is
            when 7 =>
               Sichtweite := 3;

            when 9 =>
               Sichtweite := 1;
               
            when others =>
               Sichtweite := 2;
         end case;

         YÄnderungEinheitenSchleife:
         for YÄnderung in -Sichtweite .. Sichtweite loop            
            XÄnderungEinheitenSchleife:
            for XÄnderung in -Sichtweite .. Sichtweite loop
               
               Kartenwert := SchleifenPruefungen.KartenUmgebung (YKoordinate    => GlobaleVariablen.EinheitenGebaut (GlobaleVariablen.GeradeAmZug, EinheitNummer).AchsenPosition.YAchse,
                                                                 XKoordinate    => GlobaleVariablen.EinheitenGebaut (GlobaleVariablen.GeradeAmZug, EinheitNummer).AchsenPosition.XAchse,
                                                                 YÄnderung      => YÄnderung,
                                                                 XÄnderung      => XÄnderung,
                                                                 ZusatzYAbstand => 0);

               case Kartenwert.YAchse is
                  when GlobaleDatentypen.Kartenfeld'First =>
                     exit XÄnderungEinheitenSchleife;
                     
                  when others =>
                     Karten.Karten (GlobaleVariablen.EinheitenGebaut (GlobaleVariablen.GeradeAmZug, EinheitNummer).AchsenPosition.EAchse, Kartenwert.YAchse, Kartenwert.XAchse).Sichtbar (GlobaleVariablen.GeradeAmZug) := True;
               end case;
            
            end loop XÄnderungEinheitenSchleife;
         end loop YÄnderungEinheitenSchleife;
      end loop EinheitenPlätzeSchleife;

      StadtPlätzeSchleife:
      for StadtNummer in GlobaleVariablen.EinheitenGebaut'Range (2) loop

         if GlobaleVariablen.StadtGebaut (GlobaleVariablen.GeradeAmZug, StadtNummer).ID = 0 then
            exit StadtPlätzeSchleife;
                  
         elsif GlobaleVariablen.StadtGebaut (GlobaleVariablen.GeradeAmZug, StadtNummer).Einwohner < 10 then
            Sichtweite := 2;
            
         else
            Sichtweite := 3;
         end if;

         YÄnderungStadtSchleife:         
         for YÄnderung in -Sichtweite .. Sichtweite loop            
            XÄnderungStadtSchleife:
            for XÄnderung in -Sichtweite .. Sichtweite loop

               Kartenwert := SchleifenPruefungen.KartenUmgebung (YKoordinate    => GlobaleVariablen.StadtGebaut (GlobaleVariablen.GeradeAmZug, StadtNummer).AchsenPosition.YAchse,
                                                                 XKoordinate    => GlobaleVariablen.StadtGebaut (GlobaleVariablen.GeradeAmZug, StadtNummer).AchsenPosition.XAchse,
                                                                 YÄnderung      => YÄnderung,
                                                                 XÄnderung      => XÄnderung,
                                                                 ZusatzYAbstand => 0);
               
               case Kartenwert.YAchse is
                  when GlobaleDatentypen.Kartenfeld'First =>
                     exit XÄnderungStadtSchleife;
                     
                  when others =>
                     Karten.Karten (GlobaleVariablen.StadtGebaut (GlobaleVariablen.GeradeAmZug, StadtNummer).AchsenPosition.EAchse, Kartenwert.YAchse, Kartenwert.XAchse).Sichtbar (GlobaleVariablen.GeradeAmZug) := True;
               end case;
            
            end loop XÄnderungStadtSchleife;
         end loop YÄnderungStadtSchleife;
      end loop StadtPlätzeSchleife;
      
   end Sichtbarkeitsprüfung;



   procedure Sichtbarkeit (InDerStadt : Boolean; EAchse : GlobaleDatentypen.Ebene; YAchse, XAchse : in GlobaleDatentypen.KartenfeldPositiv) is
   begin
      
      -- Über den Kartenfeldern kommen die Kartenressourcen
      -- Über den Kartenressourcen kommen die Kartenverbesserungen
      -- Über die Kartenverbesserungen kommen die Städte
      -- Über die Städte kommen die Einheiten
      -- Über den Einheiten kommt der Cursor      
       
      if Karten.Karten (EAchse, YAchse, XAchse).Sichtbar (GlobaleVariablen.GeradeAmZug) = True then
         if EAchse = GlobaleVariablen.CursorImSpiel.AchsenPosition.EAchse and YAchse = GlobaleVariablen.CursorImSpiel.AchsenPosition.YAchse and XAchse = GlobaleVariablen.CursorImSpiel.AchsenPosition.XAchse
           and InDerStadt = False then
            Farben (Einheit      => 0,
                    Verbesserung => 0,
                    Ressource    => 0,
                    Grund        => Karten.Karten (EAchse, YAchse, XAchse).Grund,
                    Cursor       => True);
            return;
         
         else
            null;
         end if;
                  
         RassenEinheitenPrüfenSchleife:
         for Rasse in GlobaleVariablen.EinheitenGebaut'Range (1) loop
            EinheitenPrüfenSchleife:
            for EinheitNummer in GlobaleVariablen.EinheitenGebaut'Range (2) loop
            
               if GlobaleVariablen.EinheitenGebaut (Rasse, EinheitNummer).ID = 0 then
                  exit EinheitenPrüfenSchleife;
               
               elsif GlobaleVariablen.EinheitenGebaut (Rasse, EinheitNummer).AchsenPosition.EAchse = EAchse and GlobaleVariablen.EinheitenGebaut (Rasse, EinheitNummer).AchsenPosition.YAchse = YAchse
                 and GlobaleVariablen.EinheitenGebaut (Rasse, EinheitNummer).AchsenPosition.XAchse = XAchse then
                  Farben (Einheit      => GlobaleVariablen.EinheitenGebaut (Rasse, EinheitNummer).ID,
                          Verbesserung => 0,
                          Ressource    => 0,
                          Grund        => Karten.Karten (EAchse, YAchse, XAchse).Grund,
                          Cursor       => False);
                  return;
               
               else
                  null;
               end if;
            
            end loop EinheitenPrüfenSchleife;
         end loop RassenEinheitenPrüfenSchleife;

         RassenStädtePrüfenSchleife:
         for Rasse in GlobaleVariablen.StadtGebaut'Range (1) loop
            StädtePrüfenSchleife:
            for StadtNummer in GlobaleVariablen.StadtGebaut'Range (2) loop
            
               if GlobaleVariablen.StadtGebaut (Rasse, StadtNummer).ID = 0 then
                  exit StädtePrüfenSchleife;

               elsif GlobaleVariablen.StadtGebaut (Rasse, StadtNummer).AchsenPosition.EAchse = EAchse and GlobaleVariablen.StadtGebaut (Rasse, StadtNummer).AchsenPosition.YAchse = YAchse
                 and GlobaleVariablen.StadtGebaut (Rasse, StadtNummer).AchsenPosition.XAchse = XAchse then
                  Farben (Einheit      => 0,
                          Verbesserung => GlobaleDatentypen.KartenVerbesserung (GlobaleVariablen.StadtGebaut (Rasse, StadtNummer).ID),
                          Ressource    => 0,
                          Grund        => Karten.Karten (EAchse, YAchse, XAchse).Grund,
                          Cursor       => False);
                  return;
               
               else
                  null;
               end if;
               
            end loop StädtePrüfenSchleife;
         end loop RassenStädtePrüfenSchleife;

         if Karten.Karten (EAchse, YAchse, XAchse).VerbesserungGebiet /= 0 then            
            Farben (Einheit      => 0,
                    Verbesserung => Karten.Karten (EAchse, YAchse, XAchse).VerbesserungGebiet,
                    Ressource    => 0,
                    Grund        => Karten.Karten (EAchse, YAchse, XAchse).Grund,
                    Cursor       => False);
           
         elsif Karten.Karten (EAchse, YAchse, XAchse).VerbesserungStraße /= 0 then
            Farben (Einheit      => 0,
                    Verbesserung => Karten.Karten (EAchse, YAchse, XAchse).VerbesserungStraße,
                    Ressource    => 0,
                    Grund        => Karten.Karten (EAchse, YAchse, XAchse).Grund,
                    Cursor       => False);
            
         elsif Karten.Karten (EAchse, YAchse, XAchse).Ressource /= 0 then
            Farben (Einheit      => 0,
                    Verbesserung => 0,
                    Ressource    => Karten.Karten (EAchse, YAchse, XAchse).Ressource,
                    Grund        => Karten.Karten (EAchse, YAchse, XAchse).Grund,
                    Cursor       => False);
            
         elsif Karten.Karten (EAchse, YAchse, XAchse).Fluss /= 0 then
            Farben (Einheit      => 0,
                    Verbesserung => 0,
                    Ressource    => Karten.Karten (EAchse, YAchse, XAchse).Fluss,
                    Grund        => Karten.Karten (EAchse, YAchse, XAchse).Grund,
                    Cursor       => False);
            
         else
            Farben (Einheit      => 0,
                    Verbesserung => 0,
                    Ressource    => 0,
                    Grund        => Karten.Karten (EAchse, YAchse, XAchse).Grund,
                    Cursor       => False);
         end if;
         
      else
         if EAchse = GlobaleVariablen.CursorImSpiel.AchsenPosition.EAchse and YAchse = GlobaleVariablen.CursorImSpiel.AchsenPosition.YAchse and XAchse = GlobaleVariablen.CursorImSpiel.AchsenPosition.XAchse then         
            Farben (Einheit      => 0,
                    Verbesserung => 0,
                    Ressource    => 0,
                    Grund        => 0,
                    Cursor       => True);
         
         else
            Put (Item => NichtSichtbar);
         end if;
      end if;
      
   end Sichtbarkeit;



   procedure Farben (Einheit : GlobaleDatentypen.EinheitenID; Verbesserung : GlobaleDatentypen.KartenVerbesserung; Ressource, Grund : in GlobaleDatentypen.KartenGrund; Cursor : in Boolean) is
   begin

      case Cursor is
         when True =>
            case Grund is
               when 1 | 4 | 5 | 31 | 37 =>
                  Put (Item => CSI & "38;2;0;0;0m");
                  
               when others =>
                  Put (Item => CSI & "38;2;255;255;255m");
            end case;
            
         when False =>
            null;
      end case;

      case Einheit is
         when EinheitenDatenbank.EinheitenListe'Range (2) =>
            case Grund is
               when 1 | 4 | 5 | 31 | 37 =>
                  Put (Item => CSI & "38;2;0;0;0m");
                  
               when others =>
                  Put (Item => CSI & "38;2;255;255;255m");
            end case;
            
         when others =>
            null;
      end case;
      
      case Verbesserung is
         when 1 =>
            Put (Item => CSI & "38;2;0;0;0m");
         
         when 2 =>
            Put (Item => CSI & "38;2;0;0;0m");
            
         when 3 =>
            Put (Item => CSI & "38;2;0;0;0m");
            
         when 4 =>
            Put (Item => CSI & "38;2;0;0;0m");
            
         when 5 .. 19 =>
            Put (Item => CSI & "38;2;0;0;0m");

         when 20 =>
            Put (Item => CSI & "38;2;0;0;0m");
            
         when 21 =>
            Put (Item => CSI & "38;2;0;0;0m");
            
         when 22 =>
            Put (Item => CSI & "38;2;0;0;0m");
            
         when others =>
            null;
      end case;
      
      case Ressource is
         when 10 =>
            Put (Item => CSI & "38;2;0;0;0m");

         when 11 =>
            Put (Item => CSI & "38;2;0;0;0m");

         when 12 =>
            Put (Item => CSI & "38;2;0;0;0m");

         when 13 =>
            Put (Item => CSI & "38;2;0;0;0m");
            
         when 14 .. 28 =>
            Put (Item => CSI & "38;2;0;0;205m");

         when 29 => 
            Put (Item => CSI & "38;2;255;255;255m");

         when 30 =>
            Put (Item => CSI & "38;2;255;255;255m");

         when 33 =>
            Put (Item => CSI & "38;2;0;0;0m");
            
         when others =>
            null;
      end case;
      
      case Grund is
         when 1 =>
            Put (Item => CSI & "48;2;255;245;238m");
            
         when 2 =>
            Put (Item => CSI & "48;2;0;0;205m");
            
         when 3 =>
            Put (Item => CSI & "48;2;100;160;60m");
            
         when 4 =>
            Put (Item => CSI & "48;2;205;200;177m");
            
         when 5 =>
            Put (Item => CSI & "48;2;238;238;0m");
            
         when 6 =>
            Put (Item => CSI & "48;2;205;133;63m");
            
         when 7 =>
            Put (Item => CSI & "48;2;120;120;120m");
            
         when 8 =>
            Put (Item => CSI & "48;2;30;130;30m");
            
         when 9 =>
            Put (Item => CSI & "48;2;0;70;0m");
            
         when 31 =>
            Put (Item => CSI & "48;2;135;206;250m");
            
         when 32 =>
            Put (Item => CSI & "48;2;0;40;0m");

         when 35 =>
            Put (Item => CSI & "48;2;139;69;19");
            
         when 36 =>
            Put (Item => CSI & "48;2;250;39;39");
            
         when 37 =>
            Put (Item => "W" & CSI & "48;2;236;236;236");
            
         when 38 =>
            Put (Item => CSI & "48;2;127;127;127");
            
         when 39 =>
            Put (Item => CSI & "48;2;97;56;11");
            
         when 40 =>
            Put (Item => CSI & "48;2;87;87;87");
            
         when others =>
            null;
      end case;
      
      if Cursor = True then
         Put (Item => CSI & "5m" & GlobaleVariablen.CursorImSpiel.CursorGrafik & CSI & "0m");
         
      elsif Einheit /= 0 then
         Put (Item => EinheitenDatenbank.EinheitenListe (GlobaleVariablen.GeradeAmZug, Einheit).Anzeige & CSI & "0m");
        
      elsif Verbesserung /= 0 then
         Put (Item => VerbesserungenDatenbank.VerbesserungObjektListe (Verbesserung).Anzeige & CSI & "0m");

      elsif Ressource /= 0 then
         Put (Item => KartenDatenbank.KartenObjektListe (Ressource).Anzeige & CSI & "0m");
            
      else
         Put (Item => KartenDatenbank.KartenObjektListe (Grund).Anzeige & CSI & "0m");
      end if;
      
   end Farben;

end Sichtbarkeit;