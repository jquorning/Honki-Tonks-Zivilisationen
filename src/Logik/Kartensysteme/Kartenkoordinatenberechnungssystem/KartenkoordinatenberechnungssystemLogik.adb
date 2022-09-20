pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KartenRecordKonstanten;

with KartenkoordinateEAchseBerechnenLogik;
with KartenkoordinateYAchseBerechnenLogik;
with KartenkoordinateXAchseBerechnenLogik;

-- Die Überhangschleifen in den Berechnungen sind nötig, da zwar eine Einheitenbewegung nicht so groß sein kann, aber der Spieler eventuell soweit rauszoomt. äöü
-- Die Überhangschleifen müssten auch mal noch angepasst werden an die ganzen Änderungen. äöü
package body KartenkoordinatenberechnungssystemLogik is

   function Kartenkoordinatenberechnungssystem
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      ÄnderungExtern : in KartenRecords.AchsenKartenfeldRecord;
      LogikGrafikExtern : in Boolean)
      return KartenRecords.AchsenKartenfeldNaturalRecord
   is begin
      
      -- Wenn man das in einen Grafik- und einen Logikteil aufteilt, könnte man dann Zufallsübergänge berechnen? äöü
      -- Nein, da auch der Kartengenerator Teil der Logik ist, wenn dann bräuchte man drei Teile, eventuell auch mehr. äöü
      -- Wobei, man könnte auch beim Kartengenerator dann einfach False statt True übergeben. Die Grafik sollte zu diesem Zeitpunkt ja nicht auf die Berechnungen zugreifen. äöü
      
      case
        ÄnderungExtern.EAchse
      is
         when KartenKonstanten.LeerEAchseÄnderung =>
            NeueKoordinate (LogikGrafikExtern, KoordinatenExtern.EAchse).EAchse := KoordinatenExtern.EAchse;
            
         when others =>
            NeueKoordinate (LogikGrafikExtern, KoordinatenExtern.EAchse).EAchse := KartenkoordinateEAchseBerechnenLogik.KartenkoordinateEAchseBerechnen (EAchseExtern         => KoordinatenExtern.EAchse,
                                                                                                                                                         ÄnderungEAchseExtern => ÄnderungExtern.EAchse,
                                                                                                                                                         LogikGrafikExtern    => LogikGrafikExtern);
            
            if
              NeueKoordinate (LogikGrafikExtern, KoordinatenExtern.EAchse).EAchse = KartenKonstanten.LeerEAchse
            then
               return KartenRecordKonstanten.LeerKoordinate;
            else
               null;
            end if;
      end case;
      
      case
        ÄnderungExtern.YAchse
      is
         when KartenKonstanten.LeerYAchseÄnderung =>
            NeueKoordinate (LogikGrafikExtern, KoordinatenExtern.EAchse).YAchse := KoordinatenExtern.YAchse;
            KartenkoordinateYAchseBerechnenLogik.WelcheVerschiebungYAchse (LogikGrafikExtern, KoordinatenExtern.EAchse) := KartenDatentypen.Karte_Y_Kein_Übergang_Enum;
            
         when others =>
            NeueKoordinate (LogikGrafikExtern, KoordinatenExtern.EAchse).YAchse := KartenkoordinateYAchseBerechnenLogik.KartenkoordinateYAchseBerechnen (YAchseExtern         => KoordinatenExtern.YAchse,
                                                                                                                                                         ÄnderungYAchseExtern => ÄnderungExtern.YAchse,
                                                                                                                                                         ArrayPositionExtern  => KoordinatenExtern.EAchse,
                                                                                                                                                         LogikGrafikExtern    => LogikGrafikExtern);
      
            if
              NeueKoordinate (LogikGrafikExtern, KoordinatenExtern.EAchse).YAchse = KartenKonstanten.LeerYAchse
            then
               return KartenRecordKonstanten.LeerKoordinate;
            
            else
               null;
            end if;
      end case;
            
      case
        ÄnderungExtern.XAchse
      is
         when KartenKonstanten.LeerXAchseÄnderung =>
            NeueKoordinate (LogikGrafikExtern, KoordinatenExtern.EAchse).XAchse := KoordinatenExtern.XAchse;
            KartenkoordinateXAchseBerechnenLogik.WelcheVerschiebungXAchse (LogikGrafikExtern, KoordinatenExtern.EAchse) := KartenDatentypen.Karte_X_Kein_Übergang_Enum;
            
         when others =>
            NeueKoordinate (LogikGrafikExtern, KoordinatenExtern.EAchse).XAchse := KartenkoordinateXAchseBerechnenLogik.KartenkoordinateXAchseBerechnen (XAchseExtern         => KoordinatenExtern.XAchse,
                                                                                                                                                         ÄnderungXAchseExtern => ÄnderungExtern.XAchse,
                                                                                                                                                         ArrayPositionExtern  => KoordinatenExtern.EAchse,
                                                                                                                                                         LogikGrafikExtern    => LogikGrafikExtern);
            
            if
              NeueKoordinate (LogikGrafikExtern, KoordinatenExtern.EAchse).XAchse = KartenKonstanten.LeerXAchse
            then
               return KartenRecordKonstanten.LeerKoordinate;
                  
            else
               null;
            end if;
      end case;
      
      case
        KartenkoordinateYAchseBerechnenLogik.WelcheVerschiebungYAchse (LogikGrafikExtern, KoordinatenExtern.EAchse)
      is
         when KartenDatentypen.Karte_Y_Kein_Übergang_Enum | KartenDatentypen.Karte_Y_Übergang_Enum =>
            null;
            
         when KartenDatentypen.Karte_Y_Rückwärts_Verschobener_Übergang_Enum | KartenDatentypen.Karte_Y_Verschobener_Übergang_Enum =>
            NeueKoordinate (LogikGrafikExtern, KoordinatenExtern.EAchse).XAchse
              := KartenkoordinateXAchseBerechnenLogik.XAchseVerschieben (XAchseExtern => NeueKoordinate (LogikGrafikExtern, KoordinatenExtern.EAchse).XAchse);
      end case;
      
      case
        KartenkoordinateXAchseBerechnenLogik.WelcheVerschiebungXAchse (LogikGrafikExtern, KoordinatenExtern.EAchse)
      is
         when KartenDatentypen.Karte_X_Kein_Übergang_Enum | KartenDatentypen.Karte_X_Übergang_Enum =>
            null;
            
         when KartenDatentypen.Karte_X_Rückwärts_Verschobener_Übergang_Enum | KartenDatentypen.Karte_X_Verschobener_Übergang_Enum =>
            NeueKoordinate (LogikGrafikExtern, KoordinatenExtern.EAchse).YAchse
              := KartenkoordinateYAchseBerechnenLogik.YAchseVerschieben (YAchseExtern => NeueKoordinate (LogikGrafikExtern, KoordinatenExtern.EAchse).YAchse);
      end case;
      
      return NeueKoordinate (LogikGrafikExtern, KoordinatenExtern.EAchse);
      
   end Kartenkoordinatenberechnungssystem;

end KartenkoordinatenberechnungssystemLogik;