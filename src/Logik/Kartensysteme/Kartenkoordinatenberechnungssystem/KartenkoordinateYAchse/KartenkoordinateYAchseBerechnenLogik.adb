pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KartenKonstanten;

package body KartenkoordinateYAchseBerechnenLogik is

   function KartenkoordinateYAchseBerechnen
     (YAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      ÄnderungYAchseExtern : in KartenDatentypen.Kartenfeld;
      ArrayPositionExtern : in KartenDatentypen.EbeneVorhanden;
      LogikGrafikExtern : in Boolean)
      return KartenDatentypen.KartenfeldNatural
   is begin
      
      if
        YAchseExtern + ÄnderungYAchseExtern < Weltkarte.KarteArray'First (2)
      then
         return ÜbergangNorden (YAchseExtern         => YAchseExtern,
                                 ÄnderungYAchseExtern => ÄnderungYAchseExtern,
                                 ArrayPositionExtern  => ArrayPositionExtern,
                                 LogikGrafikExtern    => LogikGrafikExtern);
        
      elsif
        YAchseExtern + ÄnderungYAchseExtern > Weltkarte.Karteneinstellungen.Kartengröße.YAchse
      then
         return ÜbergangSüden (YAchseExtern         => YAchseExtern,
                                 ÄnderungYAchseExtern => ÄnderungYAchseExtern,
                                 ArrayPositionExtern  => ArrayPositionExtern,
                                 LogikGrafikExtern    => LogikGrafikExtern);
         
      else
         return YAchseExtern + ÄnderungYAchseExtern;
      end if;
      
   end KartenkoordinateYAchseBerechnen;
   
   
   
   function ÜbergangNorden
     (YAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      ÄnderungYAchseExtern : in KartenDatentypen.Kartenfeld;
      ArrayPositionExtern : in KartenDatentypen.EbeneVorhanden;
      LogikGrafikExtern : in Boolean)
      return KartenDatentypen.KartenfeldNatural
   is begin
      
      case
        Weltkarte.Karteneinstellungen.Kartenform.YAchseNorden
      is
         when KartenDatentypen.Karte_Y_Kein_Übergang_Enum =>
            return KartenKonstanten.LeerYAchse;
            
         when KartenDatentypen.Karte_Y_Rückwärts_Verschobener_Übergang_Enum =>
            KartenkoordinatenWerteLogik.VerschiebungNorden (LogikGrafikExtern, ArrayPositionExtern) := Weltkarte.Karteneinstellungen.Kartenform.YAchseNorden;
            
            -- Kann ich hier nicht einfach den Süden und umgekehrt aufrufen? äöü
            return ÜbergangNordenRückwärts (YAchseExtern         => YAchseExtern,
                                               ÄnderungYAchseExtern => ÄnderungYAchseExtern,
                                               ArrayPositionExtern  => ArrayPositionExtern,
                                               LogikGrafikExtern    => LogikGrafikExtern);
                        
         when KartenDatentypen.Karte_Y_Übergang_Enum | KartenDatentypen.Karte_Y_Verschobener_Übergang_Enum =>
            KartenkoordinatenWerteLogik.VerschiebungNorden (LogikGrafikExtern, ArrayPositionExtern) := Weltkarte.Karteneinstellungen.Kartenform.YAchseNorden;
            
            return ÜbergangNordenNormal (YAchseExtern         => YAchseExtern,
                                          ÄnderungYAchseExtern => ÄnderungYAchseExtern,
                                          ArrayPositionExtern  => ArrayPositionExtern,
                                          LogikGrafikExtern    => LogikGrafikExtern);
      end case;
      
   end ÜbergangNorden;
   
   
   
   function ÜbergangNordenNormal
     (YAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      ÄnderungYAchseExtern : in KartenDatentypen.Kartenfeld;
      ArrayPositionExtern : in KartenDatentypen.EbeneVorhanden;
      LogikGrafikExtern : in Boolean)
      return KartenDatentypen.KartenfeldPositiv
   is begin
      
      ÜberhangYAchse (LogikGrafikExtern, ArrayPositionExtern) := Integer (YAchseExtern + ÄnderungYAchseExtern + Weltkarte.Karteneinstellungen.Kartengröße.YAchse);
      
      YAchseKleinerSchleife:
      while ÜberhangYAchse (LogikGrafikExtern, ArrayPositionExtern) < Positive (Weltkarte.KarteArray'First (2)) loop
            
         ÜberhangYAchse (LogikGrafikExtern, ArrayPositionExtern) := ÜberhangYAchse (LogikGrafikExtern, ArrayPositionExtern) + Positive (Weltkarte.Karteneinstellungen.Kartengröße.YAchse);

      end loop YAchseKleinerSchleife;
         
      return KartenDatentypen.KartenfeldPositiv (ÜberhangYAchse (LogikGrafikExtern, ArrayPositionExtern));
      
   end ÜbergangNordenNormal;
   
   
   
   function ÜbergangNordenRückwärts
     (YAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      ÄnderungYAchseExtern : in KartenDatentypen.Kartenfeld;
      ArrayPositionExtern : in KartenDatentypen.EbeneVorhanden;
      LogikGrafikExtern : in Boolean)
      return KartenDatentypen.KartenfeldPositiv
   is begin
            
      ÜberhangYAchse (LogikGrafikExtern, ArrayPositionExtern) := Positive (YAchseExtern);
      Zwischenwert (LogikGrafikExtern, ArrayPositionExtern) := Integer (ÄnderungYAchseExtern);
      
      while ÜberhangYAchse (LogikGrafikExtern, ArrayPositionExtern) > Positive (Weltkarte.KarteArray'First (2)) loop
         
         ÜberhangYAchse (LogikGrafikExtern, ArrayPositionExtern) := ÜberhangYAchse (LogikGrafikExtern, ArrayPositionExtern) - 1;
         Zwischenwert (LogikGrafikExtern, ArrayPositionExtern) := Zwischenwert (LogikGrafikExtern, ArrayPositionExtern) + 1;
         
      end loop;
      
      -- Eventuell immer die Hauptberechnung erneut aufrufen und nicht einfach das hier? äöü
      -- Könnte das nicht Probleme machen wenn die Berechnung auch kleiner als das erste Kartenfeld ist? äöü
      if
        ÜberhangYAchse (LogikGrafikExtern, ArrayPositionExtern) - Zwischenwert (LogikGrafikExtern, ArrayPositionExtern) <= Positive (Weltkarte.Karteneinstellungen.Kartengröße.YAchse)
      then
         return KartenDatentypen.KartenfeldPositiv (ÜberhangYAchse (LogikGrafikExtern, ArrayPositionExtern) - Zwischenwert (LogikGrafikExtern, ArrayPositionExtern));
         
      else
         Rückgabe (LogikGrafikExtern, ArrayPositionExtern) := Integer (KartenkoordinateYAchseBerechnen (YAchseExtern         => Weltkarte.Karteneinstellungen.Kartengröße.YAchse,
                                                                                                         ÄnderungYAchseExtern => -(ÄnderungYAchseExtern + Weltkarte.Karteneinstellungen.Kartengröße.YAchse),
                                                                                                         ArrayPositionExtern  => ArrayPositionExtern,
                                                                                                         LogikGrafikExtern    => LogikGrafikExtern));
      end if;
      
      case
        KartenDatentypen.KartenfeldNatural (Rückgabe (LogikGrafikExtern, ArrayPositionExtern))
      is
         when KartenKonstanten.LeerYAchse =>
            return Weltkarte.Karteneinstellungen.Kartengröße.YAchse;
            
         when others =>
            return KartenDatentypen.KartenfeldPositiv (Rückgabe (LogikGrafikExtern, ArrayPositionExtern));
      end case;
      
   end ÜbergangNordenRückwärts;
   
   
   
   function ÜbergangSüden
     (YAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      ÄnderungYAchseExtern : in KartenDatentypen.Kartenfeld;
      ArrayPositionExtern : in KartenDatentypen.EbeneVorhanden;
      LogikGrafikExtern : in Boolean)
      return KartenDatentypen.KartenfeldNatural
   is begin
      
      case
        Weltkarte.Karteneinstellungen.Kartenform.YAchseSüden
      is
         when KartenDatentypen.Karte_Y_Kein_Übergang_Enum =>
            return KartenKonstanten.LeerYAchse;
            
         when KartenDatentypen.Karte_Y_Rückwärts_Verschobener_Übergang_Enum =>
            KartenkoordinatenWerteLogik.VerschiebungSüden (LogikGrafikExtern, ArrayPositionExtern) := Weltkarte.Karteneinstellungen.Kartenform.YAchseSüden;
            
            -- Kann ich hier nicht einfach den Norden und umgekehrt aufrufen? äöü
            return ÜbergangSüdenRückwärts (YAchseExtern         => YAchseExtern,
                                               ÄnderungYAchseExtern => ÄnderungYAchseExtern,
                                               ArrayPositionExtern  => ArrayPositionExtern,
                                               LogikGrafikExtern    => LogikGrafikExtern);
            
         when KartenDatentypen.Karte_Y_Übergang_Enum | KartenDatentypen.Karte_Y_Verschobener_Übergang_Enum =>
            KartenkoordinatenWerteLogik.VerschiebungSüden (LogikGrafikExtern, ArrayPositionExtern) := Weltkarte.Karteneinstellungen.Kartenform.YAchseSüden;
            
            return ÜbergangSüdenNormal (YAchseExtern         => YAchseExtern,
                                          ÄnderungYAchseExtern => ÄnderungYAchseExtern,
                                          ArrayPositionExtern  => ArrayPositionExtern,
                                          LogikGrafikExtern    => LogikGrafikExtern);
      end case;
      
   end ÜbergangSüden;
   
   
   
   function ÜbergangSüdenNormal
     (YAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      ÄnderungYAchseExtern : in KartenDatentypen.Kartenfeld;
      ArrayPositionExtern : in KartenDatentypen.EbeneVorhanden;
      LogikGrafikExtern : in Boolean)
      return KartenDatentypen.KartenfeldPositiv
   is begin
      
      ÜberhangYAchse (LogikGrafikExtern, ArrayPositionExtern) := Positive (YAchseExtern + ÄnderungYAchseExtern - Weltkarte.Karteneinstellungen.Kartengröße.YAchse);
         
      YAchseGrößerSchleife:
      while ÜberhangYAchse (LogikGrafikExtern, ArrayPositionExtern) > Positive (Weltkarte.Karteneinstellungen.Kartengröße.YAchse) loop
            
         ÜberhangYAchse (LogikGrafikExtern, ArrayPositionExtern) := ÜberhangYAchse (LogikGrafikExtern, ArrayPositionExtern) - Positive (Weltkarte.Karteneinstellungen.Kartengröße.YAchse);
            
      end loop YAchseGrößerSchleife;
         
      return KartenDatentypen.KartenfeldPositiv (ÜberhangYAchse (LogikGrafikExtern, ArrayPositionExtern));
      
   end ÜbergangSüdenNormal;
   
   
   
   function ÜbergangSüdenRückwärts
     (YAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      ÄnderungYAchseExtern : in KartenDatentypen.Kartenfeld;
      ArrayPositionExtern : in KartenDatentypen.EbeneVorhanden;
      LogikGrafikExtern : in Boolean)
      return KartenDatentypen.KartenfeldPositiv
   is begin
      
      ÜberhangYAchse (LogikGrafikExtern, ArrayPositionExtern) := Positive (YAchseExtern);
      Zwischenwert (LogikGrafikExtern, ArrayPositionExtern) := Integer (ÄnderungYAchseExtern);
      
      while ÜberhangYAchse (LogikGrafikExtern, ArrayPositionExtern) < Positive (Weltkarte.Karteneinstellungen.Kartengröße.YAchse) loop
         
         ÜberhangYAchse (LogikGrafikExtern, ArrayPositionExtern) := ÜberhangYAchse (LogikGrafikExtern, ArrayPositionExtern) + 1;
         Zwischenwert (LogikGrafikExtern, ArrayPositionExtern) := Zwischenwert (LogikGrafikExtern, ArrayPositionExtern) - 1;
         
      end loop;
      
      -- Eventuell immer die Hauptberechnung erneut aufrufen und nicht einfach das hier? äöü
      -- Könnte das nicht Probleme machen wenn die Berechnung auch kleiner als das erste Kartenfeld ist? äöü
      if
        ÜberhangYAchse (LogikGrafikExtern, ArrayPositionExtern) - Zwischenwert (LogikGrafikExtern, ArrayPositionExtern) >= Positive (Weltkarte.KarteArray'First (2))
      then
         return KartenDatentypen.KartenfeldPositiv (ÜberhangYAchse (LogikGrafikExtern, ArrayPositionExtern) - Zwischenwert (LogikGrafikExtern, ArrayPositionExtern));
         
      else
         Rückgabe (LogikGrafikExtern, ArrayPositionExtern) := Integer (KartenkoordinateYAchseBerechnen (YAchseExtern         => Weltkarte.KarteArray'First (2),
                                                                                                         ÄnderungYAchseExtern => -ÄnderungYAchseExtern,
                                                                                                         ArrayPositionExtern  => ArrayPositionExtern,
                                                                                                         LogikGrafikExtern    => LogikGrafikExtern));
      end if;
      
      case
        KartenDatentypen.KartenfeldNatural (Rückgabe (LogikGrafikExtern, ArrayPositionExtern))
      is
         when KartenKonstanten.LeerYAchse =>
            return Weltkarte.KarteArray'First (2);
            
         when others =>
            return KartenDatentypen.KartenfeldPositiv (Rückgabe (LogikGrafikExtern, ArrayPositionExtern));
      end case;
      
   end ÜbergangSüdenRückwärts;
   
   
   
   function YAchseVerschieben
     (YAchseExtern : in KartenDatentypen.KartenfeldPositiv)
      return KartenDatentypen.KartenfeldPositiv
   is begin
      
      if
        YAchseExtern + KartenfeldPositiv (KartenkoordinatenWerteLogik.VerschiebungswertYAchse * Float (Weltkarte.Karteneinstellungen.Kartengröße.YAchse)) > Weltkarte.Karteneinstellungen.Kartengröße.YAchse
      then
         return YAchseExtern - KartenfeldPositiv (KartenkoordinatenWerteLogik.VerschiebungswertYAchse * Float (Weltkarte.Karteneinstellungen.Kartengröße.YAchse));

      else
         return YAchseExtern + KartenfeldPositiv (KartenkoordinatenWerteLogik.VerschiebungswertYAchse * Float (Weltkarte.Karteneinstellungen.Kartengröße.YAchse));
      end if;
      
   end YAchseVerschieben;

end KartenkoordinateYAchseBerechnenLogik;