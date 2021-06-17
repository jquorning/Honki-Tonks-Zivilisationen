pragma SPARK_Mode (On);

with GlobaleKonstanten;

with Karten, KartenPruefungen;

package body StadtWerteFestlegen is

   procedure StadtUmgebungGrößeFestlegen
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
   is begin    
            
      if
        GlobaleVariablen.Wichtiges (StadtRasseNummerExtern.Rasse).Erforscht (2) = True
        and
          GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).EinwohnerArbeiter (1) >= 10
      then
         GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).UmgebungGröße := 2;

      elsif
        GlobaleVariablen.Wichtiges (StadtRasseNummerExtern.Rasse).Erforscht (4) = True
        and
          GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).EinwohnerArbeiter (1) >= 20
      then
         GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).UmgebungGröße := 3;

      elsif
        GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).EinwohnerArbeiter (1) = 0
      then
         GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).UmgebungGröße := 0;
                  
      else
         GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).UmgebungGröße := 1;
      end if;

      YAchseSchleife:
      for YÄnderungSchleifenwert in GlobaleDatentypen.LoopRangeMinusDreiZuDrei'Range loop -- StadtUmgebungGröße darf hier nicht genutzt werden, damit bei einer Verkleinerung auch alle Felder zurückgenommen werden können.
         XAchseSchleife:
         for XÄnderungSchleifenwert in GlobaleDatentypen.LoopRangeMinusDreiZuDrei'Range loop
            
            KartenWert := KartenPruefungen.KartenPositionBestimmen (KoordinatenExtern    => GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).AchsenPosition,
                                                                    ÄnderungExtern       => (0, YÄnderungSchleifenwert, XÄnderungSchleifenwert));
            
            exit XAchseSchleife when KartenWert.YAchse = 0;
            
            if
              (YÄnderungSchleifenwert < -GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).UmgebungGröße
               or
                 YÄnderungSchleifenwert > GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).UmgebungGröße
               or
                 XÄnderungSchleifenwert < -GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).UmgebungGröße
               or
                 XÄnderungSchleifenwert > GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).UmgebungGröße)
              and
                Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).DurchStadtBelegterGrund 
              = GlobaleDatentypen.BelegterGrund (StadtRasseNummerExtern.Rasse) * GlobaleKonstanten.RassenMulitplikationWert + GlobaleDatentypen.BelegterGrund (StadtRasseNummerExtern.Platznummer)
            then
               Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).DurchStadtBelegterGrund := 0;

            elsif
              YÄnderungSchleifenwert < -GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).UmgebungGröße
              or
                YÄnderungSchleifenwert > GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).UmgebungGröße
              or
                XÄnderungSchleifenwert < -GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).UmgebungGröße
              or
                XÄnderungSchleifenwert > GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).UmgebungGröße
            then
               null;
                     
            elsif
              Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).DurchStadtBelegterGrund = 0
            then
               Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).DurchStadtBelegterGrund
                 := GlobaleDatentypen.BelegterGrund (StadtRasseNummerExtern.Rasse) * GlobaleKonstanten.RassenMulitplikationWert + GlobaleDatentypen.BelegterGrund (StadtRasseNummerExtern.Platznummer);
                     
            else
               null;
            end if;
            
         end loop XAchseSchleife;
      end loop YAchseSchleife;
      
   end StadtUmgebungGrößeFestlegen;
   


   procedure BewirtschaftbareFelderBelegen
     (ZuwachsOderSchwundExtern : in Boolean;
      StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
   is begin
      
      NutzbarerBereich := GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).UmgebungGröße;

      YAchseSchleife:
      for YPositionSchleifenwert in -NutzbarerBereich .. NutzbarerBereich loop
         XAchseSchleife:
         for XPositionSchleifenwert in -NutzbarerBereich .. NutzbarerBereich loop
            
            case
              ZuwachsOderSchwundExtern
            is
               when True =>
                  if
                    GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).UmgebungBewirtschaftung (YPositionSchleifenwert, XPositionSchleifenwert) = True
                  then
                     null;
                  
                  else
                     KartenWert := KartenPruefungen.KartenPositionBestimmen (KoordinatenExtern    => GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).AchsenPosition,
                                                                             ÄnderungExtern       => (0, YPositionSchleifenwert, XPositionSchleifenwert));

                     exit XAchseSchleife when KartenWert.YAchse = 0;

                     if
                       Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).DurchStadtBelegterGrund
                       = GlobaleDatentypen.BelegterGrund (StadtRasseNummerExtern.Rasse) * GlobaleKonstanten.RassenMulitplikationWert + GlobaleDatentypen.BelegterGrund (StadtRasseNummerExtern.Platznummer)
                     then
                        GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).UmgebungBewirtschaftung (YPositionSchleifenwert, XPositionSchleifenwert) := True;
                        GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).EinwohnerArbeiter (2)
                          := GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).EinwohnerArbeiter (2) + 1;
                        return;
                                 
                     else
                        null;
                     end if;
                  end if;
                  
               when False => -- Hier erst prüfen ob mehr Bürger als Bewirtschaftungsfelder vorhanden sind und dann dementsprechend erst diese entfernen.
                  if
                    YPositionSchleifenwert = 0
                    and
                      XPositionSchleifenwert = 0
                  then
                     null;

                  elsif
                    GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).UmgebungBewirtschaftung (YPositionSchleifenwert, XPositionSchleifenwert) = True
                  then
                     GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).UmgebungBewirtschaftung (YPositionSchleifenwert, XPositionSchleifenwert) := False;
                     GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).EinwohnerArbeiter (2)
                       := GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).EinwohnerArbeiter (2) - 1;
                     return;

                  else
                     null;
                  end if;
            end case;
            
         end loop XAchseSchleife;
      end loop YAchseSchleife;
      
   end BewirtschaftbareFelderBelegen;



   procedure BelegteStadtfelderFreigeben
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
   is begin
      
      YAchseSchleife:
      for YÄnderungSchleifenwert in GlobaleDatentypen.LoopRangeMinusDreiZuDrei'Range loop
         XAchseSchleife:
         for XÄnderungSchleifenwert in GlobaleDatentypen.LoopRangeMinusDreiZuDrei'Range loop
            
            KartenWert := KartenPruefungen.KartenPositionBestimmen (KoordinatenExtern    => GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).AchsenPosition,
                                                                    ÄnderungExtern       => (0, YÄnderungSchleifenwert, XÄnderungSchleifenwert));
            
            exit XAchseSchleife when KartenWert.YAchse = 0;
            
            if
              Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).DurchStadtBelegterGrund
              = GlobaleDatentypen.BelegterGrund (StadtRasseNummerExtern.Rasse) * GlobaleKonstanten.RassenMulitplikationWert + GlobaleDatentypen.BelegterGrund (StadtRasseNummerExtern.Platznummer)
            then
               Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).DurchStadtBelegterGrund := 0;
                        
            else
               null;
            end if;
            
         end loop XAchseSchleife;
      end loop YAchseSchleife;
      
   end BelegteStadtfelderFreigeben;

end StadtWerteFestlegen;
