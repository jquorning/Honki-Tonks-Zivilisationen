package body BewegungssystemCursor is

   procedure BewegungCursorRichtung (Karte : in Boolean; Richtung : in Wide_Wide_Character; RasseExtern : in GlobaleDatentypen.Rassen) is -- Hier noch Bewegung für Stadt einbauen
   begin

   YÄnderung := 0;
   XÄnderung := 0;
      
      case Richtung is
         when 'w' | '8' =>
            YÄnderung := -1;
            XÄnderung := 0;
            
         when 'a' | '4' =>
            YÄnderung := 0;
            XÄnderung := -1;
            
         when 's' | '2' =>
            YÄnderung := 1;
            XÄnderung := 0;
            
         when 'd' | '6'  =>
            YÄnderung := 0;
            XÄnderung := 1;
            
         when '1' =>
            YÄnderung := 1;
            XÄnderung := -1;

         when '3' =>
            YÄnderung := 1;
            XÄnderung := 1;
            
         when '7' =>
            YÄnderung := -1;
            XÄnderung := -1;
            
         when '9' =>
            YÄnderung := -1;
            XÄnderung := 1;            
            
         when others =>
            return;
      end case;
      
      case Karte is
         when True =>
            BewegungCursorBerechnen (YÄnderung   => YÄnderung,
                                     XÄnderung   => XÄnderung,
                                     RasseExtern => RasseExtern);
            
         when False =>
            BewegungCursorBerechnenStadt (YÄnderung   => YÄnderung,
                                          XÄnderung   => XÄnderung,
                                          RasseExtern => RasseExtern);
      end case;
      
   end BewegungCursorRichtung;



   procedure GeheZuCursor (RasseExtern : in GlobaleDatentypen.Rassen) is
   begin

      Put (Item => To_Wide_Wide_String (Source => GlobaleVariablen.TexteEinlesen (19, 30)));
      Put_Line (Item => Karten.Karten'First (2)'Wide_Wide_Image & " .." & Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße'Wide_Wide_Image);
      case Karten.Kartengröße is
         when 1 .. 3 =>
            Stellenanzahl := 2;
            
         when 4 .. 8 =>
            Stellenanzahl := 3;
            
         when others =>
            Stellenanzahl := 4;
      end case;
      Wert := Eingabe.GanzeZahl (Zahlengröße => Stellenanzahl);
      
      if Wert < 1 or Wert > Integer (Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße) then
         Anzeige.Fehlermeldungen (WelcheFehlermeldung => 12);
         return;
         
      else
         YPosition := GlobaleDatentypen.Kartenfeld (Wert);
      end if;
      
      Put_Line (Item => Karten.Karten'First (3)'Wide_Wide_Image & " .." & Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße'Wide_Wide_Image);
      Wert := Eingabe.GanzeZahl (Zahlengröße => Stellenanzahl);

      if Wert < 1 or Wert > Integer (Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße) then
         Anzeige.Fehlermeldungen (WelcheFehlermeldung => 12);
         return;
         
      else
         XPosition := GlobaleDatentypen.Kartenfeld (Wert);
      end if;
      
      GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.YAchse := YPosition;
      GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.XAchse := XPosition;
      
   end GeheZuCursor;
   
   

   procedure BewegungCursorBerechnen (YÄnderung, XÄnderung : in GlobaleDatentypen.LoopRangeMinusEinsZuEins; RasseExtern : in GlobaleDatentypen.Rassen) is
   begin
      
      KartenWert := SchleifenPruefungen.KartenUmgebung (YKoordinate    => GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.YAchse,
                                                        XKoordinate    => GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.XAchse,
                                                        YÄnderung      => YÄnderung,
                                                        XÄnderung      => XÄnderung,
                                                        ZusatzYAbstand => 0);

      case KartenWert.YAchse is
         when GlobaleDatentypen.Kartenfeld'First =>
            return;
              
         when others =>
            GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.YAchse := KartenWert.YAchse;
            GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.XAchse := KartenWert.XAchse;
      end case;
      
   end BewegungCursorBerechnen;



   procedure BewegungCursorBerechnenStadt (YÄnderung, XÄnderung : in GlobaleDatentypen.LoopRangeMinusEinsZuEins; RasseExtern : in GlobaleDatentypen.Rassen) is
   begin

      if GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPositionStadt.YAchse + YÄnderung < Karten.Stadtkarte'First (1) then
         GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPositionStadt.YAchse := Karten.Stadtkarte'Last (1);

      elsif GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPositionStadt.YAchse + YÄnderung > Karten.Stadtkarte'Last (1) then
         GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPositionStadt.YAchse := Karten.Stadtkarte'First (1);

      else
         GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPositionStadt.YAchse := GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPositionStadt.YAchse + YÄnderung;
      end if;
      
      if GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPositionStadt.XAchse + XÄnderung < Karten.Stadtkarte'First (2) then
         GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPositionStadt.XAchse := Karten.Stadtkarte'Last (2);

      elsif GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPositionStadt.XAchse + XÄnderung > Karten.Stadtkarte'Last (2) then
         GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPositionStadt.XAchse := Karten.Stadtkarte'First (2);

      else
         GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPositionStadt.XAchse := GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPositionStadt.XAchse + XÄnderung;
      end if;
      
   end BewegungCursorBerechnenStadt;

end BewegungssystemCursor;
