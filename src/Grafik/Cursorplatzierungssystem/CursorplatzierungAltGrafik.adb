pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Ada.Calendar; use Ada.Calendar;

with Sf.Graphics.RenderWindow;
with Sf.Graphics.View;

with KartenKonstanten;
with ZeitKonstanten;
with Views;
with EinheitenKonstanten;

with KartenkoordinatenberechnungssystemLogik;
with SichtweitenGrafik;
with NachGrafiktask;
with EinstellungenGrafik;
with NachLogiktask;
with KartenberechnungenGrafik;
with Vergleiche;
with GeheZuGrafik;

package body CursorplatzierungAltGrafik is

   procedure CursorplatzierungAlt
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
   is begin
      
      case
        NachGrafiktask.GeheZu.EAchse
      is
         when KartenKonstanten.LeerEAchse =>
            if
              Ada.Calendar.Clock - Scrollzeit > ZeitKonstanten.ScrollverzögernMinimalzoom
              and
                (SichtweitenGrafik.SichtweiteLesen (YXExtern => True) <= 4
                 or
                   SichtweitenGrafik.SichtweiteLesen (YXExtern => False) <= 4)
            then
               null;
                
            elsif
              Ada.Calendar.Clock - Scrollzeit > ZeitKonstanten.Scrollverzögerung
              and
                (SichtweitenGrafik.SichtweiteLesen (YXExtern => True) > 4
                 or
                   SichtweitenGrafik.SichtweiteLesen (YXExtern => False) > 4)
            then
               null;
               
            else
               return;
            end if;
            
            Scrollzeit := Clock;
            
            if
              BefehlsknöpfePrüfen (EinheitRasseNummerExtern => EinheitRasseNummerExtern) = True
            then
               return;
                  
            else
               Mausposition := Sf.Graphics.RenderWindow.mapPixelToCoords (renderWindow => EinstellungenGrafik.FensterAccess,
                                                                          point        => (Sf.sfInt32 (NachLogiktask.Mausposition.x), Sf.sfInt32 (NachLogiktask.Mausposition.y)),
                                                                          view         => Views.KartenviewAccess);
            end if;
                                    
            -- Die EAchse später auch noch über eine Funktion die Änderung ermitteln oder einfach so lassen? äöü
            SpielVariablen.CursorImSpiel (EinheitRasseNummerExtern.Rasse).KoordinatenAlt.EAchse := SpielVariablen.CursorImSpiel (EinheitRasseNummerExtern.Rasse).KoordinatenAktuell.EAchse;
            
            Koordinatenänderung.EAchse := 0;
            Koordinatenänderung.YAchse := AlteYAchseFestlegen (MauspositionExtern => Mausposition,
                                                               YAchseAltExtern    => SpielVariablen.CursorImSpiel (EinheitRasseNummerExtern.Rasse).KoordinatenAlt.YAchse);
            
            Koordinatenänderung.XAchse := AlteXAchseFestlegen (MausachseExtern => Mausposition.x,
                                                               XAchseAltExtern => SpielVariablen.CursorImSpiel (EinheitRasseNummerExtern.Rasse).KoordinatenAlt.XAchse);
           
            Kartenwert := KartenkoordinatenberechnungssystemLogik.Kartenkoordinatenberechnungssystem (KoordinatenExtern => SpielVariablen.CursorImSpiel (EinheitRasseNummerExtern.Rasse).KoordinatenAlt,
                                                                                                      ÄnderungExtern    => Koordinatenänderung,
                                                                                                      LogikGrafikExtern => False);
            
            if
              Kartenwert.EAchse = KartenKonstanten.LeerEAchse
            then
               null;
                  
            else
               SpielVariablen.CursorImSpiel (EinheitRasseNummerExtern.Rasse).KoordinatenAlt := Kartenwert;
            end if;
                  
         when others =>
            GeheZuGrafik.GeheZuFestlegung (RasseExtern => EinheitRasseNummerExtern.Rasse);
      end case;
      
   end CursorplatzierungAlt;
   
   
   
   -- Hierfür später mal eine bessere Lösung einbauen. äöü
   function BefehlsknöpfePrüfen
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return Boolean
   is begin
            
      if
        NachLogiktask.Mausposition.x < 0.00
        or
          NachLogiktask.Mausposition.y < 0.00
      then
         null;
         
      else
         Viewfläche := Sf.Graphics.View.getSize (view => Views.KartenbefehlsviewAccess);
         Viewzentrum := Sf.Graphics.View.getCenter (view => Views.KartenbefehlsviewAccess);
         
         Mausposition := Sf.Graphics.RenderWindow.mapPixelToCoords (renderWindow => EinstellungenGrafik.FensterAccess,
                                                                    point        => (Sf.sfInt32 (NachLogiktask.Mausposition.x), Sf.sfInt32 (NachLogiktask.Mausposition.y)),
                                                                    view         => Views.KartenbefehlsviewAccess);
      
         case
           Vergleiche.Auswahlposition (MauspositionExtern => Mausposition,
                                       TextboxExtern      => (Viewzentrum.x - Viewfläche.x / 2.00, Viewzentrum.y - Viewfläche.y / 2.00, Viewfläche.x, Viewfläche.y))
         is
            when True =>
               return True;
               
            when False =>
               null;
         end case;
      end if;
                        
      if
        EinheitRasseNummerExtern.Nummer = EinheitenKonstanten.LeerNummer
      then
         null;
         
      elsif
        NachLogiktask.Mausposition.x <= 0.00
        or
          NachLogiktask.Mausposition.y <= 0.00
      then
         null;
         
      else
         Viewfläche := Sf.Graphics.View.getSize (view => Views.EinheitenbefehlsviewAccess);
         Viewzentrum := Sf.Graphics.View.getCenter (view => Views.EinheitenbefehlsviewAccess);
         
         Mausposition := Sf.Graphics.RenderWindow.mapPixelToCoords (renderWindow => EinstellungenGrafik.FensterAccess,
                                                                    point        => (Sf.sfInt32 (NachLogiktask.Mausposition.x), Sf.sfInt32 (NachLogiktask.Mausposition.y)),
                                                                    view         => Views.EinheitenbefehlsviewAccess);
            
         case
           Vergleiche.Auswahlposition (MauspositionExtern => Mausposition,
                                       TextboxExtern      => (Viewzentrum.x - Viewfläche.x / 2.00, Viewzentrum.y - Viewfläche.y / 2.00, Viewfläche.x, Viewfläche.y))
         is
            when True =>
               return True;
               
            when False =>
               null;
         end case;
      end if;
      
      return False;
      
   end BefehlsknöpfePrüfen;
   
   
   
   function AlteYAchseFestlegen
     (MauspositionExtern : in Sf.System.Vector2.sfVector2f;
      YAchseAltExtern : in KartenDatentypen.KartenfeldPositiv)
      return KartenDatentypen.UmgebungsbereichEins
   is begin
      
      Achsenviewfläche := Sf.Graphics.View.getSize (view => Views.KartenviewAccess);
      
      if
        MauspositionExtern.x not in 0.00 .. Achsenviewfläche.x
      then
         return 0;
      
      elsif
        MauspositionExtern.y in 0.00 .. KartenberechnungenGrafik.KartenfelderAbmessung.y / 2.00
      then
         if
           YAchseAltExtern <= Weltkarte.KarteArray'First (2) + SichtweitenGrafik.SichtweiteLesen (YXExtern => True)
           and
             Weltkarte.Karteneinstellungen.Kartenform.YAchseNorden = KartenDatentypen.Karte_Y_Kein_Übergang_Enum
         then
            return 0;
            
         else
            return -1;
         end if;
         
      elsif
        MauspositionExtern.y in Achsenviewfläche.y - KartenberechnungenGrafik.KartenfelderAbmessung.y / 2.00 .. Achsenviewfläche.y
      then
         if
           YAchseAltExtern >= Weltkarte.Karteneinstellungen.Kartengröße.YAchse - SichtweitenGrafik.SichtweiteLesen (YXExtern => True)
           and
             Weltkarte.Karteneinstellungen.Kartenform.YAchseSüden = KartenDatentypen.Karte_Y_Kein_Übergang_Enum
         then
            return 0;
         
         else
            return 1;
         end if;
      
      else
         return 0;
      end if;
      
   end AlteYAchseFestlegen;
   
   
   
   function AlteXAchseFestlegen
     (MausachseExtern : in Float;
      XAchseAltExtern : in KartenDatentypen.KartenfeldPositiv)
      return KartenDatentypen.UmgebungsbereichEins
   is begin
      
      XAchsenbereich := Sf.Graphics.View.getSize (view => Views.KartenviewAccess).x;
      
      if
        MausachseExtern in 0.00 .. KartenberechnungenGrafik.KartenfelderAbmessung.x / 2.00
      then
         if
           XAchseAltExtern <= Weltkarte.KarteArray'First (3) + SichtweitenGrafik.SichtweiteLesen (YXExtern => False)
           and
             Weltkarte.Karteneinstellungen.Kartenform.XAchseWesten = KartenDatentypen.Karte_X_Kein_Übergang_Enum
         then
            return 0;
            
         else
            return -1;
         end if;
         
      elsif
        MausachseExtern in XAchsenbereich - KartenberechnungenGrafik.KartenfelderAbmessung.x / 2.00 .. XAchsenbereich
      then
         if
           XAchseAltExtern >= Weltkarte.Karteneinstellungen.Kartengröße.XAchse - SichtweitenGrafik.SichtweiteLesen (YXExtern => False)
           and
             Weltkarte.Karteneinstellungen.Kartenform.XAchseOsten = KartenDatentypen.Karte_X_Kein_Übergang_Enum
         then
            return 0;
         
         else
            return 1;
         end if;
         
      else
         return 0;
      end if;
      
   end AlteXAchseFestlegen;

end CursorplatzierungAltGrafik;
