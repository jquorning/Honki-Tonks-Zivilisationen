package body EinheitenDatenbank is

   procedure Beschreibung (ID : in Integer) is
   begin
      
      Put (Item => To_Wide_Wide_String (Source => Einlesen.TexteEinlesen (10, ID)));
      
   end Beschreibung;



   procedure LebenspunkteBewegungspunkteAufMaximumSetzen (Rasse, EinheitNummer : in Integer) is
   begin
      
      GlobaleVariablen.EinheitenGebaut (Rasse, EinheitNummer).AktuelleLebenspunkte := EinheitenListe (GlobaleVariablen.EinheitenGebaut (Rasse, EinheitNummer).ID).MaximaleLebenspunkte;
      GlobaleVariablen.EinheitenGebaut (Rasse, EinheitNummer).AktuelleBewegungspunkte := EinheitenListe (GlobaleVariablen.EinheitenGebaut (Rasse, EinheitNummer).ID).MaximaleBewegungspunkte;
      
   end LebenspunkteBewegungspunkteAufMaximumSetzen;



   procedure HeilungBewegungspunkteFürNeueRundeSetzen is
   begin
      
      RassenSchleife:
      for A in GlobaleVariablen.EinheitenGebaut'Range (1) loop
         EinheitenSchleife:
         for B in GlobaleVariablen.EinheitenGebaut'Range (2) loop
            
            if GlobaleVariablen.EinheitenGebaut (A, B).ID = 0 then
               exit EinheitenSchleife;

            else
               null;
            end if;

            if GlobaleVariablen.EinheitenGebaut (A, B).AktuelleBeschäftigung = 0 then
               GlobaleVariablen.EinheitenGebaut (A, B).AktuelleBewegungspunkte := EinheitenListe (GlobaleVariablen.EinheitenGebaut (A, B).ID).MaximaleBewegungspunkte;

            else
               GlobaleVariablen.EinheitenGebaut (A, B).AktuelleBewegungspunkte := 0.0;
            end if;

            if GlobaleVariablen.EinheitenGebaut (A, B).AktuelleBeschäftigung = 7
              and GlobaleVariablen.EinheitenGebaut (A, B).AktuelleLebenspunkte + Heilungsrate >= EinheitenListe (GlobaleVariablen.EinheitenGebaut (A, B).ID).MaximaleLebenspunkte then
               GlobaleVariablen.EinheitenGebaut (A, B).AktuelleLebenspunkte := EinheitenListe (GlobaleVariablen.EinheitenGebaut (A, B).ID).MaximaleLebenspunkte;
               GlobaleVariablen.EinheitenGebaut (A, B).AktuelleBeschäftigung := 0;
               GlobaleVariablen.EinheitenGebaut (A, B).AktuelleBeschäftigungszeit := 0;
                  
            elsif GlobaleVariablen.EinheitenGebaut (A, B).AktuelleBeschäftigung = 7
              and GlobaleVariablen.EinheitenGebaut (A, B).AktuelleLebenspunkte + Heilungsrate < EinheitenListe (GlobaleVariablen.EinheitenGebaut (A, B).ID).MaximaleLebenspunkte then
               GlobaleVariablen.EinheitenGebaut (A, B).AktuelleLebenspunkte := GlobaleVariablen.EinheitenGebaut (A, B).AktuelleLebenspunkte + Heilungsrate;
               
            else
               null;
            end if;
            
         end loop EinheitenSchleife;
      end loop RassenSchleife;
      
   end HeilungBewegungspunkteFürNeueRundeSetzen;
   


   procedure EinheitErzeugen (Rasse, StadtNummer, ID : in Integer) is
   begin

      Position := (GlobaleVariablen.StadtGebaut (Rasse, StadtNummer).YAchse, GlobaleVariablen.StadtGebaut (Rasse, StadtNummer).XAchse);
      EinheitenPosition := 0;
            
      EinheitenSchleife:
      for EinheitenListenplatz in GlobaleVariablen.EinheitenGebaut'Range (2) loop
            
         if GlobaleVariablen.EinheitenGebaut (Rasse, EinheitenListenplatz).ID = 0 then
            EinheitenPosition := EinheitenListenplatz;
            exit EinheitenSchleife;

         elsif GlobaleVariablen.EinheitenGebaut (Rasse, EinheitenListenplatz).YAchse = GlobaleVariablen.StadtGebaut (Rasse, StadtNummer).YAchse
           and GlobaleVariablen.EinheitenGebaut (Rasse, EinheitenListenplatz).XAchse = GlobaleVariablen.StadtGebaut (Rasse, StadtNummer).XAchse then
            Position := (0, 0);
            return;
            
         else
            null;
         end if;
            
      end loop EinheitenSchleife;

      case EinheitenPosition is
         when 0 =>
            return;
            
         when others =>
            GlobaleVariablen.EinheitenGebaut (Rasse, EinheitenPosition).ID := ID;
            GlobaleVariablen.EinheitenGebaut (Rasse, EinheitenPosition).YAchse := Position.YAchse;
            GlobaleVariablen.EinheitenGebaut (Rasse, EinheitenPosition).XAchse := Position.XAchse;
            LebenspunkteBewegungspunkteAufMaximumSetzen (Rasse         => Rasse,
                                                         EinheitNummer => EinheitenPosition);
            GlobaleVariablen.StadtGebaut (Rasse, StadtNummer).VerbleibendeBauzeit := 0;
            GlobaleVariablen.StadtGebaut (Rasse, StadtNummer).AktuelleRessourcen := 0;
            GlobaleVariablen.StadtGebaut (Rasse, StadtNummer).AktuellesBauprojekt := 0;
      end case;
            
   end EinheitErzeugen;



   procedure EinheitEntfernen (Rasse, EinheitNummer : in Integer) is
   begin
      
      GlobaleVariablen.EinheitenGebaut (Rasse, EinheitNummer) := (0, 0, 0, 0, 0, 0, 0.00, 0, 0, 0, 0);      
      EinheitGebautSortieren (Rasse => Rasse);
      
   end EinheitEntfernen;



   procedure EinheitGebautSortieren (Rasse : in Integer) is
   begin

      TauschSchleife:
      for Tauschen in GlobaleVariablen.EinheitenGebautArray'Range (2) loop
         
         Sortieren (Tauschen) := GlobaleVariablen.EinheitenGebaut (Rasse, Tauschen);
         GlobaleVariablen.EinheitenGebaut (Rasse, Tauschen) := (0, 0, 0, 0, 0, 0, 0.00, 0, 0, 0, 0); 
         
      end loop TauschSchleife;

      SortierenAußenSchleife:
      for Einsortieren in GlobaleVariablen.EinheitenGebautArray'Range (2) loop
         SortierenInnenSchleife:
         for Auswahl in Sortieren'Range loop
            
            if Sortieren (Auswahl).ID /= 0 then
               GlobaleVariablen.EinheitenGebaut (Rasse, Einsortieren) := Sortieren (Auswahl);
               Sortieren (Auswahl) := (0, 0, 0, 0, 0, 0, 0.00, 0, 0, 0, 0);
               exit SortierenInnenSchleife;
               
            elsif Auswahl = Sortieren'Last then
               exit SortierenAußenSchleife;
               
            else
               null;
            end if;               
            
         end loop SortierenInnenSchleife;         
      end loop SortierenAußenSchleife;
            
   end EinheitGebautSortieren;

   

   procedure Beschäftigung (Arbeit : in Integer) is
   begin
      
      case Arbeit is
         when 0 =>
            Put (Item => To_Wide_Wide_String (Source => Einlesen.TexteEinlesen (22, 9)));            
            
         when others =>
            Put (Item => To_Wide_Wide_String (Source => Einlesen.TexteEinlesen (22, Arbeit)));
      end case;
      
   end Beschäftigung;
   


   function BeschäftigungAbbrechenVerbesserungErsetzenBrandschatzenEinheitAuflösen (WelcheAuswahl : in Integer) return Boolean is
   begin
      
      Wahl := Auswahl.Auswahl (WelcheAuswahl => WelcheAuswahl,
                               WelcherText => 18);
      case Wahl is
         when -3 =>
            return True;
                     
         when others =>
            return False;
      end case;
      
   end BeschäftigungAbbrechenVerbesserungErsetzenBrandschatzenEinheitAuflösen;

end EinheitenDatenbank;
