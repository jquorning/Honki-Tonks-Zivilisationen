pragma SPARK_Mode (On);

with SystemDatentypen; use SystemDatentypen;
with EinheitStadtDatentypen; use EinheitStadtDatentypen;
with StadtKonstanten;
with SystemKonstanten;

with Fehler;
with StartEndeSFML;
with IntroSFML;
with AnzeigeAuswahlMenueSFML;
with Karte;
with InteraktionGrafiktask;
with KarteStadt;
with InDerStadt;
with AllgemeinSFML;
with Sichtweiten;
with ForschungAnzeigeSFML;
with AnzeigeSprachauswahlSFML;
with AnzeigeEingabeSFML;
with BauAuswahlAnzeigeSFML;
with InteraktionLogiktask;

package body GrafikSFML is
   
   procedure GrafikSFML
   is begin
      
      StartEndeSFML.FensterErzeugen;

      GrafikSchleife:
      loop
         
         case
           InteraktionGrafiktask.FensterVerändert
         is
            when InteraktionGrafiktask.Fenster_Verändert_Enum'Range =>
               AllgemeinSFML.FensterAnpassen;
               Sichtweiten.SichtweiteBewegungsfeldFestlegen;
               InteraktionGrafiktask.FensterVerändert := InteraktionGrafiktask.Keine_Änderung;
               
            when InteraktionGrafiktask.Fenster_Unverändert_Enum'Range =>
               null;
         end case;
         
         case
           InteraktionGrafiktask.FensterVerändert
         is
            when InteraktionGrafiktask.Bildrate_Ändern =>
               AllgemeinSFML.BildrateÄndern;
               InteraktionGrafiktask.FensterVerändert := InteraktionGrafiktask.Keine_Änderung;
               
            when others =>
               null;
         end case;
         
         StartEndeSFML.FensterLeeren;
         
         case
           AnzeigeAuswahl
         is
            when True =>
               StartEndeSFML.FensterAnzeigen;
               
            when False =>
               exit GrafikSchleife;
         end case;
         
      end loop GrafikSchleife;
      
      StartEndeSFML.FensterEntfernen;
      
   end GrafikSFML;
   
   
   
   function AnzeigeAuswahl
     return Boolean
   is begin
      
      case
        InteraktionGrafiktask.AktuelleDarstellungAbrufen
      is
         when SystemDatentypen.Grafik_Konsole =>
            Fehler.GrafikStopp (FehlermeldungExtern => "GrafikSFML.AnzeigeAuswahl - Konsole wird bei SFML aufgerufen.");
            
         when SystemDatentypen.Grafik_SFML =>
            InteraktionLogiktask.FensterErzeugtÄndern;
            InteraktionGrafiktask.AktuelleDarstellungÄndern (DarstellungExtern => SystemDatentypen.Grafik_Pause);
            
         when SystemDatentypen.Grafik_Sprache =>
            AnzeigeSprachauswahlSFML.AnzeigeSprache;
               
         when SystemDatentypen.Grafik_Intro =>
            IntroSFML.Intro;
            InteraktionGrafiktask.AktuelleDarstellungÄndern (DarstellungExtern => SystemDatentypen.Grafik_Pause);
                              
         when SystemDatentypen.Grafik_Pause =>
            delay SystemKonstanten.WartezeitGrafik;
            
         when SystemDatentypen.Grafik_Laden =>
            null;
         
         when SystemDatentypen.Grafik_Menüs =>
            AnzeigeAuswahlMenueSFML.AnzeigeAnfang;
               
         when SystemDatentypen.Editoren_Anzeigen_Enum'Range =>
            AnzeigeEditoren;
               
         when SystemDatentypen.Grafik_Weltkarte =>
            if
              InteraktionLogiktask.AktuelleRasseAbrufen = SystemDatentypen.Keine_Rasse
            then
               delay SystemKonstanten.WartezeitGrafik;
                     
            else
               Karte.AnzeigeKarte (RasseExtern => InteraktionLogiktask.AktuelleRasseAbrufen);
            end if;
               
         when SystemDatentypen.Grafik_Stadtkarte =>
            if
              InDerStadt.AktuelleRasseStadt.Platznummer = StadtKonstanten.LeerNummer
            then
               delay SystemKonstanten.WartezeitGrafik;
                  
            else
               KarteStadt.AnzeigeStadt (StadtRasseNummerExtern => InDerStadt.AktuelleRasseStadt);
            end if;
               
         when SystemDatentypen.Grafik_Forschung =>
            if
              InteraktionLogiktask.AktuelleRasseAbrufen = SystemDatentypen.Keine_Rasse
            then
               -- Da die Rasse schon auf der Weltkarte festgelegt wird, sollte dieser Fall niemals eintreten können. Beachten dass die Rasse zwischen den Zügen notwendig aber nicht festgelegt ist.
               Fehler.GrafikStopp (FehlermeldungExtern => "GrafikSFML.AnzeigeAuswahl - Forschungsmenü wird ohne Rasse aufgerufen.");
                     
            else
               ForschungAnzeigeSFML.ForschungAnzeige;
            end if;
            
         when SystemDatentypen.Grafik_Bauen =>
            if
              InteraktionLogiktask.AktuelleRasseAbrufen = SystemDatentypen.Keine_Rasse
            then
               -- Da die Rasse schon auf der Weltkarte festgelegt wird, sollte dieser Fall niemals eintreten können. Beachten dass die Rasse zwischen den Zügen notwendig aber nicht festgelegt ist.
               Fehler.GrafikStopp (FehlermeldungExtern => "GrafikSFML.AnzeigeAuswahl - Baumenü wird ohne Rasse aufgerufen.");
                     
            else
               BauAuswahlAnzeigeSFML.BauAuswahlAnzeige;
            end if;
         
         when SystemDatentypen.Grafik_Ende =>
            return False;
      end case;
      
      AnzeigeEingaben;
      
      return True;
      
   end AnzeigeAuswahl;
   
   
   
   procedure AnzeigeEingaben
   is begin
      
      case
        InteraktionGrafiktask.EingabeAbrufen
      is
         when SystemDatentypen.Text_Eingabe =>
            AnzeigeEingabeSFML.AnzeigeText;
            
         when SystemDatentypen.Zahlen_Eingabe =>
            AnzeigeEingabeSFML.AnzeigeGanzeZahl;
            
         when SystemDatentypen.Einheit_Auswahl =>
            if
              InteraktionLogiktask.AktuelleRasseAbrufen = SystemDatentypen.Keine_Rasse
            then
               null;
                     
            else
               AnzeigeEingabeSFML.AnzeigeEinheitenStadt (RasseExtern => InteraktionLogiktask.AktuelleRasseAbrufen);
            end if;
               
         when SystemDatentypen.Keine_Eingabe =>
            null;
      end case;
      
   end AnzeigeEingaben;
   
   
   
   procedure AnzeigeEditoren
   is begin
      
      null;
      
   end AnzeigeEditoren;

end GrafikSFML;
