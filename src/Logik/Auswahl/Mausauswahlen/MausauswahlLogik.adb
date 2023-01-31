with Sf.Graphics.RenderWindow;
with Sf.Graphics.View;

with Views;
with InteraktionAuswahl;
with SystemKonstanten;
with SpeziesDatentypen;
with ForschungKonstanten;
with StadtKonstanten;
with EinheitenKonstanten;
with ViewKonstanten;

with NachLogiktask;
with Vergleiche;
with EinstellungenGrafik;
with SichtweitenGrafik;

-- Thematisch aufteilen? äöü
package body MausauswahlLogik is

   function SpeziesauswahlDiplomatie
     return Natural
   is begin
      
      Mausposition := Sf.Graphics.RenderWindow.mapPixelToCoords (renderWindow => EinstellungenGrafik.FensterAccess,
                                                                 point        => (Sf.sfInt32 (NachLogiktask.Mausposition.x), Sf.sfInt32 (NachLogiktask.Mausposition.y)),
                                                                 view         => Views.MenüviewAccess);
            
      MauszeigerSchleife:
      for SpeziesSchleifenwert in InteraktionAuswahl.SpeziesMöglicheArray'Range loop
         
         case
           InteraktionAuswahl.SpeziesMöglich (SpeziesSchleifenwert)
         is
            when True =>
               if
                 True = Vergleiche.Auswahlposition (MauspositionExtern => Mausposition,
                                                    TextboxExtern      => InteraktionAuswahl.PositionenDiplomatieSpezies (SpeziesSchleifenwert))
               then
                  return SpeziesDatentypen.Spezies_Enum'Pos (SpeziesSchleifenwert);
         
               else
                  null;
               end if;

            when False =>
               null;
         end case;
         
      end loop MauszeigerSchleife;
      
      return SystemKonstanten.LeerAuswahl;
      
   end SpeziesauswahlDiplomatie;
   
   
   
   function Forschungsmenü
     return ForschungenDatentypen.ForschungIDMitNullWert
   is begin
      
      Mausposition := Sf.Graphics.RenderWindow.mapPixelToCoords (renderWindow => EinstellungenGrafik.FensterAccess,
                                                                 point        => (Sf.sfInt32 (NachLogiktask.Mausposition.x), Sf.sfInt32 (NachLogiktask.Mausposition.y)),
                                                                 view         => Views.ForschungsviewAccesse (ViewKonstanten.ForschungsmenüForschungsliste));
            
      MausZeigerSchleife:
      for ForschungSchleifenwert in InteraktionAuswahl.MöglicheForschungenArray'Range loop
         
         case
           InteraktionAuswahl.MöglicheForschungen (ForschungSchleifenwert)
         is
            when True =>
               if
                 True = Vergleiche.Auswahlposition (MauspositionExtern => Mausposition,
                                                    TextboxExtern      => InteraktionAuswahl.PositionenForschung (ForschungSchleifenwert))
               then
                  return ForschungSchleifenwert;
         
               else
                  null;
               end if;

            when False =>
               null;
         end case;
         
      end loop MausZeigerSchleife;
      
      return ForschungKonstanten.LeerAnforderung;
      
   end Forschungsmenü;
   
   
   
   function Baumenü
     return StadtRecords.BauprojektRecord
   is begin
      
      Mausposition := Sf.Graphics.RenderWindow.mapPixelToCoords (renderWindow => EinstellungenGrafik.FensterAccess,
                                                                 point        => (Sf.sfInt32 (NachLogiktask.Mausposition.x), Sf.sfInt32 (NachLogiktask.Mausposition.y)),
                                                                 view         => Views.BauviewAccesse (ViewKonstanten.BaumenüGebäudeliste));
      
      GebäudeSchleife:
      for GebäudeSchleifenwert in StadtDatentypen.GebäudeID'Range loop
         
         case
           InteraktionAuswahl.MöglicheGebäude (GebäudeSchleifenwert)
         is
            when True =>
               if
                 True = Vergleiche.Auswahlposition (MauspositionExtern => Mausposition,
                                                    TextboxExtern      => InteraktionAuswahl.PositionenMöglicheGebäude (GebäudeSchleifenwert))
               then
                  return (GebäudeSchleifenwert, EinheitenKonstanten.LeerID);
         
               else
                  null;
               end if;

            when others =>
               null;
         end case;
         
      end loop GebäudeSchleife;
            
      Mausposition := Sf.Graphics.RenderWindow.mapPixelToCoords (renderWindow => EinstellungenGrafik.FensterAccess,
                                                                 point        => (Sf.sfInt32 (NachLogiktask.Mausposition.x), Sf.sfInt32 (NachLogiktask.Mausposition.y)),
                                                                 view         => Views.BauviewAccesse (ViewKonstanten.BaumenüEinheitenliste));
      
      EinheitenSchleife:
      for EinheitenSchleifenwert in EinheitenDatentypen.EinheitenID'Range loop
         
         case
           InteraktionAuswahl.MöglicheEinheiten (EinheitenSchleifenwert)
         is
            when True =>
               if
                 True = Vergleiche.Auswahlposition (MauspositionExtern => Mausposition,
                                                    TextboxExtern      => InteraktionAuswahl.PositionenEinheitenBauen (EinheitenSchleifenwert))
               then
                  return (StadtKonstanten.LeerGebäudeID, EinheitenSchleifenwert);
         
               else
                  null;
               end if;

            when others =>
               null;
         end case;
               
      end loop EinheitenSchleife;
      
      return (StadtKonstanten.LeerGebäudeID, EinheitenKonstanten.LeerID);
      
   end Baumenü;
   
         
   
   function Menüs
     (WelchesMenüExtern : in MenueDatentypen.Welches_Menü_Vorhanden_Enum;
      AnfangExtern : in Positive;
      EndeExtern : in Positive)
      return Natural
   is begin
      
      Mausposition := Sf.Graphics.RenderWindow.mapPixelToCoords (renderWindow => EinstellungenGrafik.FensterAccess,
                                                                 point        => (Sf.sfInt32 (NachLogiktask.Mausposition.x), Sf.sfInt32 (NachLogiktask.Mausposition.y)),
                                                                 view         => Views.MenüviewAccess);
      
      PositionSchleife:
      for PositionSchleifenwert in AnfangExtern .. EndeExtern loop
                  
         case
           Vergleiche.Auswahlposition (MauspositionExtern => Mausposition,
                                       TextboxExtern      => InteraktionAuswahl.PositionenMenüeinträge (WelchesMenüExtern, PositionSchleifenwert))
         is
            when True =>
               return PositionSchleifenwert;
            
            when False =>
               null;
         end case;
         
      end loop PositionSchleife;
      
      return SystemKonstanten.LeerAuswahl;
      
   end Menüs;
   
   
   
   function JaNein
     return Natural
   is begin
      
      Mausposition := Sf.Graphics.RenderWindow.mapPixelToCoords (renderWindow => EinstellungenGrafik.FensterAccess,
                                                                 point        => (Sf.sfInt32 (NachLogiktask.Mausposition.x), Sf.sfInt32 (NachLogiktask.Mausposition.y)),
                                                                 view         => Views.FragenviewAccesse (ViewKonstanten.Antwort));
      
      PositionSchleife:
      for PositionSchleifenwert in InteraktionAuswahl.PositionenJaNein'Range loop
         
         case
           Vergleiche.Auswahlposition (MauspositionExtern => Mausposition,
                                       TextboxExtern      => InteraktionAuswahl.PositionenJaNein (PositionSchleifenwert))
         is
            when True =>
               return PositionSchleifenwert;
            
            when False =>
               null;
         end case;
         
      end loop PositionSchleife;
      
      return SystemKonstanten.LeerAuswahl;
      
   end JaNein;
   
         
   
   function Steuerung
     return Integer
   is begin
      
      Mausposition := Sf.Graphics.RenderWindow.mapPixelToCoords (renderWindow => EinstellungenGrafik.FensterAccess,
                                                                 point        => (Sf.sfInt32 (NachLogiktask.Mausposition.x), Sf.sfInt32 (NachLogiktask.Mausposition.y)),
                                                                 view         => Views.SteuerungviewAccesse (ViewKonstanten.SteuerungKategorie));
      
      AufteilungSchleife:
      for AufteilungSchleifenwert in InteraktionAuswahl.PositionenSteuerungsaufteilung'Range loop
         
         case
           Vergleiche.Auswahlposition (MauspositionExtern => Mausposition,
                                       TextboxExtern      => InteraktionAuswahl.PositionenSteuerungsaufteilung (AufteilungSchleifenwert))
         is
            when True =>
               return -AufteilungSchleifenwert;
               
            when False =>
               null;
         end case;
         
      end loop AufteilungSchleife;
      
      
      
      Mausposition := Sf.Graphics.RenderWindow.mapPixelToCoords (renderWindow => EinstellungenGrafik.FensterAccess,
                                                                 point        => (Sf.sfInt32 (NachLogiktask.Mausposition.x), Sf.sfInt32 (NachLogiktask.Mausposition.y)),
                                                                 view         => Views.SteuerungviewAccesse (ViewKonstanten.SteuerungAuswahl));
      
      SteuerungSchleife:
      for SteuerungSchleifenwert in InteraktionAuswahl.PositionenSteuerung'Range loop
         
         case
           Vergleiche.Auswahlposition (MauspositionExtern => Mausposition,
                                       TextboxExtern      => InteraktionAuswahl.PositionenSteuerung (SteuerungSchleifenwert))
         is
            when True =>
               return SteuerungSchleifenwert;
               
            when False =>
               null;
         end case;
         
      end loop SteuerungSchleife;
      
      return SystemKonstanten.LeerAuswahl;
      
   end Steuerung;
   
   
   
   function Weltkartenbefehle
     return TastenbelegungDatentypen.Weltkartenbefehle_Enum
   is begin
            
      Mausposition := Sf.Graphics.RenderWindow.mapPixelToCoords (renderWindow => EinstellungenGrafik.FensterAccess,
                                                                 point        => (Sf.sfInt32 (NachLogiktask.Mausposition.x), Sf.sfInt32 (NachLogiktask.Mausposition.y)),
                                                                 view         => Views.KartenbefehlsviewAccess);
      
      BefehleSchleife:
      for BefehlSchleifenwert in InteraktionAuswahl.PositionenKartenbefehleArray'Range loop
                  
         case
           Vergleiche.Auswahlposition (MauspositionExtern => Mausposition,
                                       TextboxExtern      => InteraktionAuswahl.PositionenKartenbefehle (BefehlSchleifenwert))
         is
            when True =>
               return BefehlSchleifenwert;
               
            when False =>
               null;
         end case;
         
      end loop BefehleSchleife;
      
      
      
      Mausposition := Sf.Graphics.RenderWindow.mapPixelToCoords (renderWindow => EinstellungenGrafik.FensterAccess,
                                                                 point        => (Sf.sfInt32 (NachLogiktask.Mausposition.x), Sf.sfInt32 (NachLogiktask.Mausposition.y)),
                                                                 view         => Views.WeltkarteAccess (ViewKonstanten.WeltKarte));
      
      case
        Vergleiche.Auswahlposition (MauspositionExtern => Mausposition,
                                    TextboxExtern      => (0.00, 0.00, Sf.Graphics.View.getSize (view => Views.WeltkarteAccess (ViewKonstanten.WeltKarte)).x,
                                                           Sf.Graphics.View.getSize (view => Views.WeltkarteAccess (ViewKonstanten.WeltKarte)).y))
      is
         when True =>
            return TastenbelegungDatentypen.Auswählen_Enum;
            
         when False =>
            return TastenbelegungDatentypen.Leer_Allgemeine_Belegung_Enum;
      end case;
      
   end Weltkartenbefehle;
   
   
   
   function Einheitenbefehle
     return BefehleDatentypen.Einheitenbelegung_Enum
   is begin
      
      Mausposition := Sf.Graphics.RenderWindow.mapPixelToCoords (renderWindow => EinstellungenGrafik.FensterAccess,
                                                                 point        => (Sf.sfInt32 (NachLogiktask.Mausposition.x), Sf.sfInt32 (NachLogiktask.Mausposition.y)),
                                                                 view         => Views.EinheitenbefehlsviewAccess);
      
      BefehleSchleife:
      for BefehlSchleifenwert in InteraktionAuswahl.PositionenEinheitenbefehleArray'Range loop
         
         case
           Vergleiche.Auswahlposition (MauspositionExtern => Mausposition,
                                       TextboxExtern      => InteraktionAuswahl.PositionenEinheitenbefehle (BefehlSchleifenwert))
         is
            when True =>
               return BefehlSchleifenwert;
               
            when False =>
               null;
         end case;
         
      end loop BefehleSchleife;
      
      Mausposition := Sf.Graphics.RenderWindow.mapPixelToCoords (renderWindow => EinstellungenGrafik.FensterAccess,
                                                                 point        => (Sf.sfInt32 (NachLogiktask.Mausposition.x), Sf.sfInt32 (NachLogiktask.Mausposition.y)),
                                                                 view         => Views.WeltkarteAccess (ViewKonstanten.WeltKarte));
      
      case
        Vergleiche.Auswahlposition (MauspositionExtern => Mausposition,
                                    TextboxExtern      => SichtweitenGrafik.FensterKarte)
      is
         when True =>
            return BefehleDatentypen.Auswählen_Enum;
            
         when False =>
            return BefehleDatentypen.Leer_Einheitenbelegung_Enum;
      end case;
      
   end Einheitenbefehle;
   
   
   
   function Stadtumgebung
     return Sf.System.Vector2.sfVector2f
   is begin
      
      Mausposition := Sf.Graphics.RenderWindow.mapPixelToCoords (renderWindow => EinstellungenGrafik.FensterAccess,
                                                                 point        => (Sf.sfInt32 (NachLogiktask.Mausposition.x), Sf.sfInt32 (NachLogiktask.Mausposition.y)),
                                                                 view         => Views.StadtviewAccesse (ViewKonstanten.StadtUmgebung));
      
      case
        Vergleiche.Auswahlposition (MauspositionExtern => Mausposition,
                                    TextboxExtern      => (0.00, 0.00, Sf.Graphics.View.getSize (view => Views.StadtviewAccesse (ViewKonstanten.StadtUmgebung)).x,
                                                           Sf.Graphics.View.getSize (view => Views.StadtviewAccesse (ViewKonstanten.StadtUmgebung)).y))
      is
         when False =>
            return (-1.00, -1.00);
            
         when True =>
            return Mausposition;
      end case;
            
   end Stadtumgebung;
   
   
   
   -- Hier und bei weiteren Befehle erst einmal prüfen ob der Mauszeiger sich überhaupt im Befehlsbereich befindet? äöü
   function Stadtbefehle
     return BefehleDatentypen.Stadtbefehle_Enum
   is begin
      
      Mausposition := Sf.Graphics.RenderWindow.mapPixelToCoords (renderWindow => EinstellungenGrafik.FensterAccess,
                                                                 point        => (Sf.sfInt32 (NachLogiktask.Mausposition.x), Sf.sfInt32 (NachLogiktask.Mausposition.y)),
                                                                 view         => Views.StadtviewAccesse (ViewKonstanten.StadtBefehle));
      
      BefehleSchleife:
      for BefehleSchleifenwert in InteraktionAuswahl.PositionenStadtbefehleArray'Range loop
         
         case
           Vergleiche.Auswahlposition (MauspositionExtern => Mausposition,
                                       TextboxExtern      => InteraktionAuswahl.PositionenStadtbefehle (BefehleSchleifenwert))
         is
            when True =>
               return BefehleSchleifenwert;
               
            when False =>
               null;
         end case;
         
      end loop BefehleSchleife;
      
      return BefehleDatentypen.Leer_Stadtbefehle_Enum;
      
   end Stadtbefehle;
   
   
   
   function Verkaufsmenü
     return StadtDatentypen.GebäudeIDMitNullwert
   is begin
      
      Mausposition := Sf.Graphics.RenderWindow.mapPixelToCoords (renderWindow => EinstellungenGrafik.FensterAccess,
                                                                 point        => (Sf.sfInt32 (NachLogiktask.Mausposition.x), Sf.sfInt32 (NachLogiktask.Mausposition.y)),
                                                                 view         => Views.BauviewAccesse (ViewKonstanten.BaumenüGebäudelisteVerkaufen));
      
      GebäudeSchleife:
      for GebäudeSchleifenwert in StadtDatentypen.GebäudeID'Range loop
         
         case
           InteraktionAuswahl.MöglicheGebäude (GebäudeSchleifenwert)
         is
            when True =>
               if
                 True = Vergleiche.Auswahlposition (MauspositionExtern => Mausposition,
                                                    TextboxExtern      => InteraktionAuswahl.PositionenMöglicheGebäude (GebäudeSchleifenwert))
               then
                  return GebäudeSchleifenwert;
         
               else
                  null;
               end if;

            when others =>
               null;
         end case;
         
      end loop GebäudeSchleife;
      
      return StadtKonstanten.LeerGebäudeID;
      
   end Verkaufsmenü;
   
   
   
   function SpeichernLaden
     return Natural
   is begin
      
      Mausposition := Sf.Graphics.RenderWindow.mapPixelToCoords (renderWindow => EinstellungenGrafik.FensterAccess,
                                                                 point        => (Sf.sfInt32 (NachLogiktask.Mausposition.x), Sf.sfInt32 (NachLogiktask.Mausposition.y)),
                                                                 view         => Views.MenüviewAccess);
      
      PositionSchleife:
      for PositionSchleifenwert in InteraktionAuswahl.PositionenSpielstand'Range loop
                  
         case
           Vergleiche.Auswahlposition (MauspositionExtern => Mausposition,
                                       TextboxExtern      => InteraktionAuswahl.PositionenSpielstand (PositionSchleifenwert))
         is
            when True =>
               return PositionSchleifenwert;
            
            when False =>
               null;
         end case;
         
      end loop PositionSchleife;
      
      return SystemKonstanten.LeerAuswahl;
      
   end SpeichernLaden;
   
   
   
   function StadtEinheitauswahl
     (AnfangExtern : in EinheitenDatentypen.Transportplätze;
      EndeExtern : in EinheitenDatentypen.TransportplätzeVorhanden)
      return Integer
   is begin
      
      Mausposition := Sf.Graphics.RenderWindow.mapPixelToCoords (renderWindow => EinstellungenGrafik.FensterAccess,
                                                                 point        => (Sf.sfInt32 (NachLogiktask.Mausposition.x), Sf.sfInt32 (NachLogiktask.Mausposition.y)),
                                                                 view         => Views.StadtEinheitviewAccess);
      
      AuswahlSchleife:
      for AuswahlSchleifenwert in AnfangExtern .. EndeExtern loop
         
         case
           Vergleiche.Auswahlposition (MauspositionExtern => Mausposition,
                                       TextboxExtern      => InteraktionAuswahl.PositionenEinheitStadt (AuswahlSchleifenwert))
         is
            when True =>
               return Natural (AuswahlSchleifenwert);
               
            when False =>
               null;
         end case;
         
      end loop AuswahlSchleife;
              
      return -1;
      
   end StadtEinheitauswahl;
   
   
   
   function Sprachenauswahl
     (AnfangExtern : in Positive;
      EndeExtern : in Positive)
      return Natural
   is begin
      
      Mausposition := Sf.Graphics.RenderWindow.mapPixelToCoords (renderWindow => EinstellungenGrafik.FensterAccess,
                                                                 point        => (Sf.sfInt32 (NachLogiktask.Mausposition.x), Sf.sfInt32 (NachLogiktask.Mausposition.y)),
                                                                 view         => Views.MenüviewAccess);
      
      MausZeigerSchleife:
      for PositionSchleifenwert in AnfangExtern .. EndeExtern loop
         
         case
           Vergleiche.Auswahlposition (MauspositionExtern => Mausposition,
                                       TextboxExtern      => InteraktionAuswahl.PositionenSprachauswahl (PositionSchleifenwert))
         is
            when True =>
               return PositionSchleifenwert;
            
            when False =>
               null;
         end case;
         
      end loop MausZeigerSchleife;
      
      return SystemKonstanten.LeerAuswahl;
      
   end Sprachenauswahl;
   
end MausauswahlLogik;
