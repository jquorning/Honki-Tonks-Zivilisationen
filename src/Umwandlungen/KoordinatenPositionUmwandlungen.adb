with KartenKonstanten;
with KartenRecordKonstanten;
with GrafikRecordKonstanten;

with LeseCursor;

with SichtweitenGrafik;
with KartenkoordinatenberechnungssystemLogik;
with Vergleiche;

package body KoordinatenPositionUmwandlungen is

   function KoordinatenZuKartenposition
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
      return Sf.System.Vector2.sfVector2f
   is
      use type KartenRecords.AchsenKartenfeldNaturalRecord;
   begin
      
      Sichtbereich := SichtweitenGrafik.SichtweiteLesen;
      CursorKoordinatenAlt := LeseCursor.KoordinatenAlt (SpeziesExtern => SpeziesExtern);
      Feldposition := GrafikRecordKonstanten.Nullposition;
            
      YAchseSchleife:
      for YAchseSchleifenwert in -Sichtbereich .. Sichtbereich loop
         XAchseSchleife:
         for XAchseSchleifenwert in -Sichtbereich .. Sichtbereich loop
            
            KartenWert := KartenkoordinatenberechnungssystemLogik.Kartenkoordinatenberechnungssystem (KoordinatenExtern => CursorKoordinatenAlt,
                                                                                                      ÄnderungExtern    => (KartenKonstanten.LeerEAchseÄnderung, YAchseSchleifenwert, XAchseSchleifenwert),
                                                                                                      LogikGrafikExtern => False);
            
            if
              KartenWert.XAchse = KartenKonstanten.LeerXAchse
            then
               null;
               
            elsif
              KartenWert = KoordinatenExtern
            then
               return Feldposition;
               
            else
               null;
            end if;
            
            Feldposition.x := Feldposition.x + SichtweitenGrafik.KartenfelderAbmessung.x;
                          
         end loop XAchseSchleife;
         
         Feldposition := (GrafikRecordKonstanten.Nullposition.x, Feldposition.y + SichtweitenGrafik.KartenfelderAbmessung.y);
         
      end loop YAchseSchleife;
      
      return GrafikRecordKonstanten.FalschePosition;
      
   end KoordinatenZuKartenposition;
   
   
   
   -- Noch ungetestet, könnte eventuell nicht richtig funktionieren.
   function KartenpositionZuKoordinaten
     (PositionExtern : in Sf.System.Vector2.sfVector2f;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
      return KartenRecords.AchsenKartenfeldNaturalRecord
   is begin
      
      Sichtbereich := SichtweitenGrafik.SichtweiteLesen;
      CursorKoordinatenAlt := LeseCursor.KoordinatenAlt (SpeziesExtern => SpeziesExtern);
      Feldposition := GrafikRecordKonstanten.Nullposition;
            
      YAchseSchleife:
      for YAchseSchleifenwert in -Sichtbereich .. Sichtbereich loop
         XAchseSchleife:
         for XAchseSchleifenwert in -Sichtbereich .. Sichtbereich loop
            
            KartenWert := KartenkoordinatenberechnungssystemLogik.Kartenkoordinatenberechnungssystem (KoordinatenExtern => CursorKoordinatenAlt,
                                                                                                      ÄnderungExtern    => (KartenKonstanten.LeerEAchseÄnderung, YAchseSchleifenwert, XAchseSchleifenwert),
                                                                                                      LogikGrafikExtern => False);
            
            if
              KartenWert.XAchse = KartenKonstanten.LeerXAchse
            then
               null;
               
            elsif
              True = Vergleiche.Auswahlposition (MauspositionExtern => PositionExtern,
                                                 TextboxExtern      => (Feldposition.x, Feldposition.y,
                                                                        Feldposition.x + SichtweitenGrafik.KartenfelderAbmessung.x, Feldposition.y + SichtweitenGrafik.KartenfelderAbmessung.y))
            then
               return KartenWert;
               
            else
               null;
            end if;
            
            Feldposition.x := Feldposition.x + SichtweitenGrafik.KartenfelderAbmessung.x;
                          
         end loop XAchseSchleife;
         
         Feldposition := (GrafikRecordKonstanten.Nullposition.x, Feldposition.y + SichtweitenGrafik.KartenfelderAbmessung.y);
         
      end loop YAchseSchleife;
      
      return KartenRecordKonstanten.LeerKoordinate;
      
   end KartenpositionZuKoordinaten;

end KoordinatenPositionUmwandlungen;
