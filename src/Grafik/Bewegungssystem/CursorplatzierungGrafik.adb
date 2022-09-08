pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Sf.Graphics.RenderWindow;

with KartenDatentypen; use KartenDatentypen;
with KartenKonstanten;
with Views;

with NachLogiktask;
with KartenberechnungenGrafik;
with Kartenkoordinatenberechnungssystem;
with EinstellungenGrafik;
with NachGrafiktask;
with Sichtweiten;

package body CursorplatzierungGrafik is
   
   procedure Weltkarte
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      case
        NachGrafiktask.GeheZu.EAchse
      is
         when KartenKonstanten.LeerEAchse =>
            Mausposition := Sf.Graphics.RenderWindow.mapPixelToCoords (renderWindow => EinstellungenGrafik.FensterAccess,
                                                                       point        => (Sf.sfInt32 (NachLogiktask.Mausposition.x), Sf.sfInt32 (NachLogiktask.Mausposition.y)),
                                                                       view         => Views.KartenviewAccess);
            
         when others =>
            SpielVariablen.CursorImSpiel (RasseExtern).KoordinatenAktuell := NachGrafiktask.GeheZu;
            return;
      end case;
            
      SichtbereichAnfangEnde := Sichtweiten.SichtbereichKarteBerechnen;
      Kartenänderung.YAchse := SichtbereichAnfangEnde (1) + KartenDatentypen.Kartenfeld (Float'Floor (Mausposition.y / KartenberechnungenGrafik.KartenfelderAbmessung.y));
      Kartenänderung.XAchse := SichtbereichAnfangEnde (3) + KartenDatentypen.Kartenfeld (Float'Floor (Mausposition.x / KartenberechnungenGrafik.KartenfelderAbmessung.x));
      
      KartenWert := Kartenkoordinatenberechnungssystem.Kartenkoordinatenberechnungssystem (KoordinatenExtern => SpielVariablen.CursorImSpiel (RasseExtern).KoordinatenAlt,
                                                                                           ÄnderungExtern    => (0, Kartenänderung.YAchse, Kartenänderung.XAchse),
                                                                                           LogikGrafikExtern => False);
      
      case
        KartenWert.EAchse
      is
         when KartenKonstanten.LeerEAchse =>
            null;
                     
         when others =>
            SpielVariablen.CursorImSpiel (RasseExtern).KoordinatenAktuell.YAchse := KartenWert.YAchse;
            SpielVariablen.CursorImSpiel (RasseExtern).KoordinatenAktuell.XAchse := KartenWert.XAchse;
      end case;
                           
   end Weltkarte;
   
end CursorplatzierungGrafik;
