with Weltkarte;

with CursorbewegungLogik;
with NachGrafiktask;
with EinstellungenGrafik;

package body SichtweitenGrafik is
   
   procedure SichtweiteBewegungsfeldFestlegen
   is begin
         
      KartenfelderAbmessungBerechnen;
      StadtfelderAbmessungBerechnen;
      
   end SichtweiteBewegungsfeldFestlegen;
   
   
   
   procedure StandardSichtweiten
   is begin
      
      AktuelleZoomstufe := StandardZoomstufe;
      SichtweiteBewegungsfeldFestlegen;
      
   end StandardSichtweiten;
   
   
   
   procedure ZoomstufeÄndern
     (ÄnderungExtern : in KartenDatentypen.Kartenfeld)
   is
      use type KartenDatentypen.Kartenfeld;
   begin
      
      -- Eine Möglichkeit einbauen das abzustellen? äöü
      -- Eine Möglichkeit einbauen um direkt zu Standardzoomstufe zu springen und nicht zur Kleinsten?
      if
        AktuelleZoomstufe + ÄnderungExtern > MaximaleZoomstufe
      then
         AktuelleZoomstufe := KartenDatentypen.KartenfeldPositiv'First;
         WelcheZoomanpassung := TastenbelegungDatentypen.Ebene_Hoch_Enum;
         
      elsif
        AktuelleZoomstufe + ÄnderungExtern < MinimaleZoomstufe
      then
         AktuelleZoomstufe := MaximaleZoomstufe;
         WelcheZoomanpassung := TastenbelegungDatentypen.Ebene_Runter_Enum;
         
      else
         AktuelleZoomstufe := AktuelleZoomstufe + ÄnderungExtern;
         WelcheZoomanpassung := TastenbelegungDatentypen.Auswählen_Enum;
      end if;
      
      CursorbewegungLogik.CursorbewegungBerechnen (RichtungExtern => WelcheZoomanpassung,
                                                   RasseExtern    => NachGrafiktask.AktuelleRasse);
      
      KartenfelderAbmessungBerechnen;
      
   end ZoomstufeÄndern;
   
   

   function SichtweiteLesen
     return KartenDatentypen.KartenfeldPositiv
   is
      use type KartenDatentypen.Kartenfeld;
   begin
      
      return AktuelleZoomstufe * 2;
            
   end SichtweiteLesen;
   
   

   function BewegungsfeldLesen
     return KartenDatentypen.KartenfeldPositiv
   is
      use type KartenDatentypen.Kartenfeld;
   begin
      
      return SichtweiteLesen - 1;
      
   end BewegungsfeldLesen;
   
   
   
   function UntenRechts
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return Boolean
   is
      use type KartenDatentypen.Kartenfeld;
   begin
      
      if
        SpielVariablen.CursorImSpiel (RasseExtern).KoordinatenAlt.YAchse >= Weltkarte.Karteneinstellungen.Kartengröße.YAchse - SichtweiteLesen
        and
          SpielVariablen.CursorImSpiel (RasseExtern).KoordinatenAlt.XAchse >= Weltkarte.Karteneinstellungen.Kartengröße.XAchse - SichtweiteLesen
      then
         return False;
               
      else
         return True;
      end if;
      
   end UntenRechts;
   
   
   
   procedure KartenfelderAbmessungBerechnen
   is
      use type KartenDatentypen.Kartenfeld;
   begin
      
      FensterKarte := (0.00, 0.00, EinstellungenGrafik.AktuelleFensterAuflösung.x, EinstellungenGrafik.AktuelleFensterAuflösung.y);
      
      KartenfelderAbmessung.x := FensterKarte.width / Float (2 * SichtweiteLesen + 1);
      KartenfelderAbmessung.y := FensterKarte.height / Float (2 * SichtweiteLesen + 1);
      
   end KartenfelderAbmessungBerechnen;
   
   
   
   procedure StadtfelderAbmessungBerechnen
   is begin
      
      StadtKarte := (0.00, 0.00, EinstellungenGrafik.AktuelleFensterAuflösung.x, EinstellungenGrafik.AktuelleFensterAuflösung.y);
      
      StadtfelderAbmessung.x := StadtKarte.width / Float (KartenDatentypen.Stadtfeld'Last);
      StadtfelderAbmessung.y := StadtKarte.height / Float (KartenDatentypen.Stadtfeld'Last);
      
   end StadtfelderAbmessungBerechnen;

end SichtweitenGrafik;
