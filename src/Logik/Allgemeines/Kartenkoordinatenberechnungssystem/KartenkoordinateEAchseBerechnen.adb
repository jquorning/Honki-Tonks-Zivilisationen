pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KartenDatentypen; use KartenDatentypen;
with KartenKonstanten;

with Karten;

-- Die zweidimensionalen Arrays existieren wegen der Parallelisierung der Kartenfelderbewertung und weil das hier von Logik und Grafik benötigt wird.
-- Die Überhangschleifen in den Berechnungen sind nötig, da zwar eine Einheitenbewegung nicht so groß sein kann, aber der Spieler eventuell soweit rauszoomt.
package body KartenkoordinateEAchseBerechnen is

   function KartenkoordinateEAchseBerechnen
     (EAchseExtern : in KartenDatentypen.EbeneVorhanden;
      ÄnderungEAchseExtern : in KartenDatentypen.Ebene;
      LogikGrafikExtern : in Boolean)
      return KartenDatentypen.Ebene
   is begin
      
      if
        EAchseExtern + ÄnderungEAchseExtern < Karten.WeltkarteArray'First (1)
      then
         return KartenkoordinateEAchseÜbergangUnten (EAchseExtern         => EAchseExtern,
                                                      ÄnderungEAchseExtern => ÄnderungEAchseExtern,
                                                      LogikGrafikExtern    => LogikGrafikExtern);
         
      elsif
        EAchseExtern + ÄnderungEAchseExtern > Karten.WeltkarteArray'Last (1)
      then
         return KartenkoordinateEAchseÜbergangOben (EAchseExtern         => EAchseExtern,
                                                     ÄnderungEAchseExtern => ÄnderungEAchseExtern,
                                                     LogikGrafikExtern    => LogikGrafikExtern);
         
      else
         return EAchseExtern + ÄnderungEAchseExtern;
      end if;
      
   end KartenkoordinateEAchseBerechnen;
   
   
   
   function KartenkoordinateEAchseÜbergangUnten
     (EAchseExtern : in KartenDatentypen.EbeneVorhanden;
      ÄnderungEAchseExtern : in KartenDatentypen.Ebene;
      LogikGrafikExtern : in Boolean)
      return KartenDatentypen.Ebene
   is begin
      
      case
        Karten.Karteneinstellungen.Kartenform.EAchseUnten
      is
         when KartenDatentypen.Karte_E_Kein_Übergang_Enum =>
            return KartenKonstanten.LeerEAchse;
            
         when others =>
            null;
      end case;
                    
      ZwischenwertEAchse (LogikGrafikExtern, EAchseExtern) := abs (Integer (ÄnderungEAchseExtern));
      ÜberhangEAchse (LogikGrafikExtern, EAchseExtern) := Integer (EAchseExtern);
         
      EAchseKleinerSchleife:
      while ZwischenwertEAchse (LogikGrafikExtern, EAchseExtern) > 0 loop
            
         if
           ÜberhangEAchse (LogikGrafikExtern, EAchseExtern) - 1 < Integer (Karten.WeltkarteArray'First (1))
         then
            ÜberhangEAchse (LogikGrafikExtern, EAchseExtern) := Positive (Karten.WeltkarteArray'Last (1));
               
         else
            ÜberhangEAchse (LogikGrafikExtern, EAchseExtern) := ÜberhangEAchse (LogikGrafikExtern, EAchseExtern) - 1;
         end if;
            
         ZwischenwertEAchse (LogikGrafikExtern, EAchseExtern) := ZwischenwertEAchse (LogikGrafikExtern, EAchseExtern) - 1;
            
      end loop EAchseKleinerSchleife;
         
      return KartenDatentypen.EbeneVorhanden (ÜberhangEAchse (LogikGrafikExtern, EAchseExtern));
      
   end KartenkoordinateEAchseÜbergangUnten;
   
   
   
   function KartenkoordinateEAchseÜbergangOben
     (EAchseExtern : in KartenDatentypen.EbeneVorhanden;
      ÄnderungEAchseExtern : in KartenDatentypen.Ebene;
      LogikGrafikExtern : in Boolean)
      return KartenDatentypen.Ebene
   is begin
      
      case
        Karten.Karteneinstellungen.Kartenform.EAchseOben
      is
         when KartenDatentypen.Karte_E_Kein_Übergang_Enum =>
            return KartenKonstanten.LeerEAchse;
            
         when others =>
            null;
      end case;
      
      ZwischenwertEAchse (LogikGrafikExtern, EAchseExtern) := (Positive (ÄnderungEAchseExtern));
      ÜberhangEAchse (LogikGrafikExtern, EAchseExtern) := Integer (EAchseExtern);
         
      EAchseGrößerSchleife:
      while ZwischenwertEAchse (LogikGrafikExtern, EAchseExtern) > 0 loop
            
         if
           ÜberhangEAchse (LogikGrafikExtern, EAchseExtern) + 1 > Positive (Karten.WeltkarteArray'Last (1))
         then
            ÜberhangEAchse (LogikGrafikExtern, EAchseExtern) := Integer (Karten.WeltkarteArray'First (1));
               
         else
            ÜberhangEAchse (LogikGrafikExtern, EAchseExtern) := ÜberhangEAchse (LogikGrafikExtern, EAchseExtern) + 1;
         end if;
            
         ZwischenwertEAchse (LogikGrafikExtern, EAchseExtern) := ZwischenwertEAchse (LogikGrafikExtern, EAchseExtern) - 1;
            
      end loop EAchseGrößerSchleife;
         
      return KartenDatentypen.EbeneVorhanden (ÜberhangEAchse (LogikGrafikExtern, EAchseExtern));
      
   end KartenkoordinateEAchseÜbergangOben;

end KartenkoordinateEAchseBerechnen;
