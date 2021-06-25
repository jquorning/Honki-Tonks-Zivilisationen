pragma SPARK_Mode (On);

with GlobaleKonstanten;

with Karten, Eingabe, KartenPruefungen;

package body BewegungssystemCursor is

   procedure BewegungCursorRichtung
     (KarteExtern : in Boolean;
      RichtungExtern : in Positive;
      RasseExtern : in GlobaleDatentypen.Rassen)
   is begin
      
      case
        RichtungExtern
      is
         when 1 =>
            Änderung := (0, -1, 0);
            
         when 2 =>
            Änderung := (0, 0, -1);
            
         when 3 =>
            Änderung := (0, 1, 0);
            
         when 4  =>
            Änderung := (0, 0, 1);
            
         when 5 =>
            Änderung := (0, -1, -1);
            
         when 6 =>
            Änderung := (0, -1, 1);
            
         when 7 =>
            Änderung := (0, 1, -1);

         when 8 =>
            Änderung := (0, 1, 1);
            
         when 9 =>
            Änderung := (1, 0, 0);
            
         when 10 =>
            Änderung := (-1, 0, 0);
            
         when others =>
            return;
      end case;
      
      case
        KarteExtern
      is
         when True =>
            BewegungCursorBerechnen (ÄnderungExtern => Änderung,
                                     RasseExtern    => RasseExtern);
            
         when False =>
            BewegungCursorBerechnenStadt (ÄnderungExtern => Änderung,
                                          RasseExtern    => RasseExtern);
      end case;
      
   end BewegungCursorRichtung;



   procedure GeheZuCursor
     (RasseExtern : in GlobaleDatentypen.Rassen)
   is begin
      
      KoordinatenPunkt := Eingabe.GanzeZahl (TextDateiExtern     => GlobaleDatentypen.Zeug,
                                             ZeileExtern         => 40,
                                             ZahlenMinimumExtern => Integer (Karten.Weltkarte'First (1)),
                                             ZahlenMaximumExtern => Integer (Karten.Weltkarte'Last (1)));
      
      case
        KoordinatenPunkt
      is
         when GlobaleKonstanten.GanzeZahlAbbruchKonstante =>
            return;
         
         when others =>
            Position.EAchse := GlobaleDatentypen.EbeneVorhanden (KoordinatenPunkt);
            KoordinatenPunkt := Eingabe.GanzeZahl (TextDateiExtern     => GlobaleDatentypen.Zeug,
                                                   ZeileExtern         => 30,
                                                   ZahlenMinimumExtern => Integer (Karten.Weltkarte'First (2)),
                                                   ZahlenMaximumExtern => Integer (Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße));
      end case;
      
      case
        KoordinatenPunkt
      is
         when GlobaleKonstanten.GanzeZahlAbbruchKonstante =>
            return;
         
         when others =>
            Position.YAchse := GlobaleDatentypen.Kartenfeld (KoordinatenPunkt);
            KoordinatenPunkt := Eingabe.GanzeZahl (TextDateiExtern     => GlobaleDatentypen.Zeug,
                                                   ZeileExtern         => 31,
                                                   ZahlenMinimumExtern => Integer (Karten.Weltkarte'First (3)),
                                                   ZahlenMaximumExtern => Integer (Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße));
      end case;

      case
        KoordinatenPunkt
      is
         when GlobaleKonstanten.GanzeZahlAbbruchKonstante =>
            return;
         
         when others =>
            Position.XAchse := GlobaleDatentypen.Kartenfeld (KoordinatenPunkt);
            GlobaleVariablen.CursorImSpiel (RasseExtern).Position := Position;
      end case;
      
   end GeheZuCursor;
   
   

   procedure BewegungCursorBerechnen
     (ÄnderungExtern : in GlobaleRecords.AchsenKartenfeldRecord;
      RasseExtern : in GlobaleDatentypen.Rassen)
   is begin
      
      -- Kann nicht nach KartenPruefungen.KartenPositionBestimmen verschoben werden, da darüber auch Einheiten geprüft werden
      if
        ÄnderungExtern.EAchse = 1
        and
          GlobaleVariablen.CursorImSpiel (RasseExtern).Position.EAchse = Karten.Weltkarte'Last (1)
      then
         GlobaleVariablen.CursorImSpiel (RasseExtern).Position.EAchse := Karten.Weltkarte'First (1);
         return;
         
      elsif
        ÄnderungExtern.EAchse = -1
        and
          GlobaleVariablen.CursorImSpiel (RasseExtern).Position.EAchse = Karten.Weltkarte'First (1)
      then
         GlobaleVariablen.CursorImSpiel (RasseExtern).Position.EAchse := Karten.Weltkarte'Last (1);
         return;
         
      elsif
        ÄnderungExtern.EAchse /= 0
      then
         GlobaleVariablen.CursorImSpiel (RasseExtern).Position.EAchse := GlobaleVariablen.CursorImSpiel (RasseExtern).Position.EAchse + ÄnderungExtern.EAchse;
         return;
         
      else
         null;
      end if;
      
      KartenWert := KartenPruefungen.KartenPositionBestimmen (KoordinatenExtern    => GlobaleVariablen.CursorImSpiel (RasseExtern).Position,
                                                              ÄnderungExtern       => ÄnderungExtern);
      
      case
        KartenWert.YAchse
      is
         when 0 =>
            return;
              
         when others =>
            GlobaleVariablen.CursorImSpiel (RasseExtern).Position := KartenWert;
      end case;
      
   end BewegungCursorBerechnen;



   procedure BewegungCursorBerechnenStadt
     (ÄnderungExtern : in GlobaleRecords.AchsenKartenfeldRecord;
      RasseExtern : in GlobaleDatentypen.Rassen)
   is begin

      if
        GlobaleVariablen.CursorImSpiel (RasseExtern).PositionStadt.YAchse + ÄnderungExtern.YAchse < Karten.Stadtkarte'First (1)
      then
         GlobaleVariablen.CursorImSpiel (RasseExtern).PositionStadt.YAchse := Karten.Stadtkarte'Last (1);

      elsif
        GlobaleVariablen.CursorImSpiel (RasseExtern).PositionStadt.YAchse + ÄnderungExtern.YAchse > Karten.Stadtkarte'Last (1)
      then
         GlobaleVariablen.CursorImSpiel (RasseExtern).PositionStadt.YAchse := Karten.Stadtkarte'First (1);

      else
         GlobaleVariablen.CursorImSpiel (RasseExtern).PositionStadt.YAchse := GlobaleVariablen.CursorImSpiel (RasseExtern).PositionStadt.YAchse + ÄnderungExtern.YAchse;
      end if;
      
      if
        GlobaleVariablen.CursorImSpiel (RasseExtern).PositionStadt.XAchse + ÄnderungExtern.XAchse < Karten.Stadtkarte'First (2)
      then
         GlobaleVariablen.CursorImSpiel (RasseExtern).PositionStadt.XAchse := Karten.Stadtkarte'Last (2);

      elsif
        GlobaleVariablen.CursorImSpiel (RasseExtern).PositionStadt.XAchse + ÄnderungExtern.XAchse > Karten.Stadtkarte'Last (2)
      then
         GlobaleVariablen.CursorImSpiel (RasseExtern).PositionStadt.XAchse := Karten.Stadtkarte'First (2);

      else
         GlobaleVariablen.CursorImSpiel (RasseExtern).PositionStadt.XAchse := GlobaleVariablen.CursorImSpiel (RasseExtern).PositionStadt.XAchse + ÄnderungExtern.XAchse;
      end if;
      
   end BewegungCursorBerechnenStadt;

end BewegungssystemCursor;
