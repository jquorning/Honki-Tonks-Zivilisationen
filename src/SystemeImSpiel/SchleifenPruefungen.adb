package body SchleifenPruefungen is 

   function KartenUmgebung (YKoordinate, XKoordinate, YÄnderung, XÄnderung, ZusatzYAbstand : in GlobaleDatentypen.Kartenfeld) return GlobaleDatentypen.AchsenAusKartenfeld is
   begin
      -- Der ZusatzYAbstand ist für <=, also z. B. 1 für <= oder 4 für <= Karten.Karten'First (2) + 3
      
      if YKoordinate + YÄnderung < Karten.Karten'First (2) + ZusatzYAbstand or YKoordinate + YÄnderung > Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße - ZusatzYAbstand then
         return (0, GlobaleDatentypen.Kartenfeld'First, GlobaleDatentypen.Kartenfeld'First);

      elsif XKoordinate + XÄnderung < Karten.Karten'First (3) then
         Überhang := Integer (XKoordinate + XÄnderung + Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße);
         SchleifeKleiner:
         while Überhang < Integer (Karten.Karten'First (3)) loop
            
            Überhang := Überhang + Integer (Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße);

         end loop SchleifeKleiner;
         return (0, YKoordinate + YÄnderung, GlobaleDatentypen.Kartenfeld (Überhang));
               
      elsif XKoordinate + XÄnderung > Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße then
         Überhang := Integer (XKoordinate + XÄnderung - Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße);
         SchleifeGrößer:
         while Überhang > Integer (Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße) loop
            
            Überhang := Überhang - Integer (Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße);
            
         end loop SchleifeGrößer;
         return (0, YKoordinate + YÄnderung, GlobaleDatentypen.Kartenfeld (Überhang));
               
      else
         return (0, YKoordinate + YÄnderung, XKoordinate + XÄnderung);
      end if;
      
   end KartenUmgebung;

   

   function KoordinatenStadtMitRasseSuchen (Rasse : in Integer; YAchse, XAchse : in GlobaleDatentypen.Kartenfeld) return Integer is
   begin
      
      StadtSchleife:
      for Stadtnummer in GlobaleVariablen.StadtGebaut'Range (2) loop
         
         if GlobaleVariablen.StadtGebaut (Rasse, Stadtnummer).ID = 0 then
            exit StadtSchleife;
            
         elsif GlobaleVariablen.StadtGebaut (Rasse, Stadtnummer).AchsenPosition.YAchse = YAchse and GlobaleVariablen.StadtGebaut (Rasse, Stadtnummer).AchsenPosition.XAchse = XAchse then
            return Stadtnummer;
            
         else
            null;
         end if;
         
      end loop StadtSchleife;
      
      return 0;
      
   end KoordinatenStadtMitRasseSuchen;



   function KoordinatenEinheitMitRasseSuchen (Rasse : in Integer; YAchse, XAchse : in GlobaleDatentypen.Kartenfeld) return Integer is
   begin
      
      EinheitSchleife:
      for Einheitennummer in GlobaleVariablen.EinheitenGebaut'Range (2) loop
         
         if GlobaleVariablen.EinheitenGebaut (Rasse, Einheitennummer).ID = 0 then
            exit EinheitSchleife;
            
         elsif GlobaleVariablen.EinheitenGebaut (Rasse, Einheitennummer).AchsenPosition.YAchse = YAchse and GlobaleVariablen.EinheitenGebaut (Rasse, Einheitennummer).AchsenPosition.XAchse = XAchse then
            return Einheitennummer;
            
         else
            null;
         end if;
         
      end loop EinheitSchleife;
      
      return 0;
      
   end KoordinatenEinheitMitRasseSuchen;
   
   
   
   function KoordinatenStadtOhneRasseSuchen (YAchse, XAchse : in GlobaleDatentypen.Kartenfeld) return GlobaleDatentypen.RasseUndPlatznummerRecord is
   begin

      RasseSchleife:
      for Rasse in GlobaleVariablen.StadtGebaut'Range (1) loop
         StadtSchleife:
         for Stadtnummer in GlobaleVariablen.StadtGebaut'Range (2) loop
            
            if GlobaleVariablen.StadtGebaut (Rasse, Stadtnummer).ID = 0 then
               exit StadtSchleife;
               
            elsif GlobaleVariablen.StadtGebaut (Rasse, Stadtnummer).AchsenPosition.YAchse = YAchse and GlobaleVariablen.StadtGebaut (Rasse, Stadtnummer).AchsenPosition.XAchse = XAchse then
               return (Rasse, Stadtnummer);
               
            else
               null;
            end if;
            
         end loop StadtSchleife;
      end loop RasseSchleife;
      
      return (RückgabeWert, RückgabeWert);
      
   end KoordinatenStadtOhneRasseSuchen;
   
   
   
   function KoordinatenEinheitOhneRasseSuchen (YAchse, XAchse : in GlobaleDatentypen.Kartenfeld) return GlobaleDatentypen.RasseUndPlatznummerRecord is
   begin

      RasseSchleife:
      for Rasse in GlobaleVariablen.StadtGebaut'Range (1) loop
         EinheitSchleife:
         for EinheitNummer in GlobaleVariablen.EinheitenGebaut'Range (2) loop
            
            if GlobaleVariablen.EinheitenGebaut (Rasse, EinheitNummer).ID = 0 then
               exit EinheitSchleife;
               
            elsif GlobaleVariablen.EinheitenGebaut (Rasse, EinheitNummer).AchsenPosition.YAchse = YAchse and GlobaleVariablen.EinheitenGebaut (Rasse, EinheitNummer).AchsenPosition.XAchse = XAchse then
               return (Rasse, EinheitNummer);
               
            else
               null;
            end if;
            
         end loop EinheitSchleife;
      end loop RasseSchleife;
      
      return (RückgabeWert, RückgabeWert);
      
   end KoordinatenEinheitOhneRasseSuchen;
   
   
   
   function KartenGrund (Ebene : in GlobaleDatentypen.Ebene; YKoordinate, XKoordinate : in GlobaleDatentypen.Kartenfeld) return Boolean is
   begin
      
      case Karten.Karten (Ebene, YKoordinate, XKoordinate).Grund is
         when 1 .. 2 | 29 .. 31 | 36 =>
            return False;
            
         when others =>
            return True;
      end case;
      
   end KartenGrund;

end SchleifenPruefungen;
