pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KartenKonstanten;

-- Überhangsschleifen noch an das aktuelle System anpassen. äöü
package body KartenkoordinateYAchseBerechnenLogik is

   function KartenkoordinateYAchseBerechnen
     (YAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      ÄnderungYAchseExtern : in KartenDatentypen.Kartenfeld;
      ArrayPositionExtern : in KartenDatentypen.EbeneVorhanden;
      LogikGrafikExtern : in Boolean)
      return KartenDatentypen.KartenfeldNatural
   is begin
      
      WelcheVerschiebungYAchse (LogikGrafikExtern, ArrayPositionExtern) := KartenDatentypen.Karte_Y_Kein_Übergang_Enum;
      
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
            WelcheVerschiebungYAchse (LogikGrafikExtern, ArrayPositionExtern) := Weltkarte.Karteneinstellungen.Kartenform.YAchseNorden;
            
            return ÜbergangNordenRückwärts (YAchseExtern         => YAchseExtern,
                                               ÄnderungYAchseExtern => ÄnderungYAchseExtern);
                        
         when KartenDatentypen.Karte_Y_Übergang_Enum | KartenDatentypen.Karte_Y_Verschobener_Übergang_Enum =>
            WelcheVerschiebungYAchse (LogikGrafikExtern, ArrayPositionExtern) := Weltkarte.Karteneinstellungen.Kartenform.YAchseNorden;
            
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
      ÄnderungYAchseExtern : in KartenDatentypen.Kartenfeld)
      return KartenDatentypen.KartenfeldPositiv
   is begin
      
      return YAchseExtern - (ÄnderungYAchseExtern + 1);
      
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
            WelcheVerschiebungYAchse (LogikGrafikExtern, ArrayPositionExtern) := Weltkarte.Karteneinstellungen.Kartenform.YAchseSüden;
            
            return ÜbergangNordenRückwärts (YAchseExtern         => YAchseExtern,
                                               ÄnderungYAchseExtern => ÄnderungYAchseExtern);
            
         when KartenDatentypen.Karte_Y_Übergang_Enum | KartenDatentypen.Karte_Y_Verschobener_Übergang_Enum =>
            WelcheVerschiebungYAchse (LogikGrafikExtern, ArrayPositionExtern) := Weltkarte.Karteneinstellungen.Kartenform.YAchseSüden;
            
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
      ÄnderungYAchseExtern : in KartenDatentypen.KartenfeldPositiv)
      return KartenDatentypen.KartenfeldPositiv
   is begin
      
      return YAchseExtern - (ÄnderungYAchseExtern - 1);
      
   end ÜbergangSüdenRückwärts;
   
   
   
   function YAchseVerschieben
     (YAchseExtern : in KartenDatentypen.KartenfeldPositiv)
      return KartenDatentypen.KartenfeldPositiv
   is begin
      
      if
        YAchseExtern + KartenfeldPositiv (HalberWert * Float (Weltkarte.Karteneinstellungen.Kartengröße.YAchse)) > Weltkarte.Karteneinstellungen.Kartengröße.YAchse
      then
         return YAchseExtern - KartenfeldPositiv (HalberWert * Float (Weltkarte.Karteneinstellungen.Kartengröße.YAchse));

      else
         return YAchseExtern + KartenfeldPositiv (HalberWert * Float (Weltkarte.Karteneinstellungen.Kartengröße.YAchse));
      end if;
      
   end YAchseVerschieben;

end KartenkoordinateYAchseBerechnenLogik;
