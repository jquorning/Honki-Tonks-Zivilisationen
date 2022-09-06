pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Ada.Calendar; use Ada.Calendar;

with GrafikDatentypen; use GrafikDatentypen;
with SystemDatentypen;
with ZeitKonstanten;

with StartEndeGrafik;
with IntroGrafik;
with MenueaufteilungGrafik;
with NachGrafiktask;
with AllgemeinGrafik;
with Sichtweiten;
with ForschungsauswahlGrafik;
with SprachauswahlGrafik;
with EingabenanzeigeGrafik;
with BauauswahlGrafik;
with NachLogiktask;
with TexteingabeGrafik;
with TextaccesseSetzenGrafik;
with LadezeitenGrafik;
with KartenaufteilungGrafik;
with DiplomatieauswahlGrafik;
with SpielmeldungenGrafik;
with EditorenGrafik;
with ForschungserfolgGrafik;
with TasteneingabeGrafik;
with AbspannGrafik;
-- with Systemchecks;

package body Grafik is
   
   procedure Grafik
   is begin
            
      GrafikStartenSchleife:
      while NachGrafiktask.ErzeugeFenster = False loop

         delay ZeitKonstanten.WartezeitGrafik;
         
      end loop GrafikStartenSchleife;
      
      -- Das Setzen der Schriftart kann scheinbar erst nach dem Erzeugen eines Fensters stattfinden.
      -- Oder habe ich zu dem Zeitpunkt den Font noch nicht eingelesen? Mal nachprüfen. äöü
      StartEndeGrafik.FensterErzeugen;
      
      -- Systemchecks.Größenprüfung;
      
      GrafikSchleife:
      loop
                  
         case
           NachGrafiktask.FensterGeschlossen
         is
            when True =>
               exit GrafikSchleife;
               
            when False =>
               GrafikanpassungenVorFensterleerung;
               StartEndeGrafik.FensterLeeren;
               Eingaben;
         end case;
         
         case
           AnzeigeAuswahl
         is
            when True =>
               StartEndeGrafik.FensterAnzeigen;
               
            when False =>
               exit GrafikSchleife;
         end case;
         
      end loop GrafikSchleife;
      
      StartEndeGrafik.FensterEntfernen;
      
   end Grafik;
   
   
   
   procedure GrafikanpassungenVorFensterleerung
   is begin
      
      case
        NachGrafiktask.AccesseSetzen
      is
         when True =>
            TextaccesseSetzenGrafik.StandardSetzen;
            NachGrafiktask.AccesseSetzen := False;
               
         when False =>
            null;
      end case;
               
      case
        NachGrafiktask.FensterVerändert
      is
         when GrafikDatentypen.Fenster_Wurde_Verändert_Enum'Range =>
            AllgemeinGrafik.FensterAnpassen;
            Sichtweiten.SichtweiteBewegungsfeldFestlegen;
            NachGrafiktask.FensterVerändert := GrafikDatentypen.Keine_Änderung_Enum;
            NachLogiktask.Warten := False;
            
         when GrafikDatentypen.Bildrate_Ändern_Enum =>
            AllgemeinGrafik.BildrateÄndern;
            NachGrafiktask.FensterVerändert := GrafikDatentypen.Keine_Änderung_Enum;
               
         when others =>
            null;
      end case;
      
   end GrafikanpassungenVorFensterleerung;
   
   
   
   procedure Eingaben
   is begin
      
      case
        NachGrafiktask.TextEingabe
      is
         when True =>
            TexteingabeGrafik.Texteingabe;
               
         when False =>
            null;
      end case;
         
      case
        NachGrafiktask.TastenEingabe
      is
         when True =>
            TasteneingabeGrafik.Tasteneingabe;
               
         when False =>
            null;
      end case;
      
   end Eingaben;
   
   
   
   function AnzeigeAuswahl
     return Boolean
   is begin
      
      case
        NachGrafiktask.AktuelleDarstellung
      is
         when GrafikDatentypen.Grafik_Start_Enum =>
            NachGrafiktask.AktuelleDarstellung := GrafikDatentypen.Grafik_Pause_Enum;
            NachLogiktask.Warten := False;
            
         when GrafikDatentypen.Grafik_Sprache_Enum =>
            SprachauswahlGrafik.Sprachauswahl;
               
         when GrafikDatentypen.Grafik_Intro_Enum =>
            IntroGrafik.Intro;
            NachGrafiktask.AktuelleDarstellung := GrafikDatentypen.Grafik_Pause_Enum;
            NachLogiktask.Warten := False;
            
         when GrafikDatentypen.Grafik_Pause_Enum =>
            delay ZeitKonstanten.WartezeitGrafik;
            
         when GrafikDatentypen.Ladezeiten_Enum'Range =>
            LadezeitenGrafik.Ladezeiten (WelcheLadeanzeigeExtern => NachGrafiktask.AktuelleDarstellung,
                                         RasseExtern             => NachGrafiktask.KIRechnet);
            -- Diese Prüfung kann nicht rausgezogen werden, da er mit dem aktuellen System sonst Tasteneingaben nicht mehr korrekt erkennt.
            TasteneingabeGrafik.FensterAnpassen;
         
         when GrafikDatentypen.Grafik_Menüs_Enum =>
            MenueaufteilungGrafik.Menüaufteilung (WelchesMenüExtern     => NachGrafiktask.AktuellesMenü,
                                                   AktuelleAuswahlExtern => NachGrafiktask.AktuelleAuswahl);
               
         when GrafikDatentypen.Editoren_Anzeigen_Enum'Range =>
            EditorenGrafik.Editoren;
               
         when GrafikDatentypen.Grafik_Weltkarte_Enum =>
            KartenaufteilungGrafik.Weltkarte (EinheitRasseNummerExtern => (NachGrafiktask.AktuelleRasse, NachGrafiktask.AktuelleEinheit));
            
         when GrafikDatentypen.Grafik_Stadtkarte_Enum =>
            KartenaufteilungGrafik.Stadtkarte (StadtRasseNummerExtern => (NachGrafiktask.AktuelleRasse, NachGrafiktask.AktuelleStadt));
               
         when GrafikDatentypen.Grafik_Forschung_Enum =>
            ForschungsauswahlGrafik.ForschungAnzeige (RasseExtern           => NachGrafiktask.AktuelleRasse,
                                                      AktuelleAuswahlExtern => NachGrafiktask.AktuelleAuswahl.AuswahlEins);
            
         when GrafikDatentypen.Grafik_Forschung_Erfolgreich_Enum =>
            ForschungserfolgGrafik.Forschungserfolg (RasseExtern   => NachGrafiktask.AktuelleRasse,
                                                     AuswahlExtern => NachGrafiktask.AktuelleAuswahl.AuswahlEins);
            
         when GrafikDatentypen.Grafik_Bauen_Enum =>
            BauauswahlGrafik.Bauauswahl (StadtRasseNummerExtern => (NachGrafiktask.AktuelleRasse, NachGrafiktask.AktuelleStadt),
                                         AktuelleAuswahlExtern  => NachGrafiktask.AktuelleBauauswahl);
            
         when GrafikDatentypen.Grafik_Diplomatie_Enum =>
            DiplomatieauswahlGrafik.Diplomatieauswahl (AuswahlExtern => NachGrafiktask.AktuelleAuswahl.AuswahlEins);
            
         when GrafikDatentypen.Grafik_Abspann_Enum =>
            AbspannGrafik.Abspann (AbspannExtern => NachGrafiktask.Abspannart);
            
         when GrafikDatentypen.Grafik_Ende_Enum =>
            return False;
      end case;
      
      -- Hier die Eingabe/Spielmeldung mitübergeben damit sie leichter verschiebbar sind? äöü
      AnzeigeSpielmeldungen;
      AnzeigeEingaben;
      
      return True;
      
   end AnzeigeAuswahl;
   
   
   
   procedure AnzeigeSpielmeldungen
   is begin
      
      case
        NachGrafiktask.Spielmeldung
      is
         when 0 =>
            return;
            
         when others =>
            null;
      end case;
      
      if
        Ada.Calendar.Clock - NachGrafiktask.StartzeitSpielmeldung > ZeitKonstanten.AnzeigezeitSpielmeldungen
      then
         NachGrafiktask.Spielmeldung := 0;
         
      else
         SpielmeldungenGrafik.Spielmeldung (MeldungExtern => NachGrafiktask.Spielmeldung);
      end if;
            
   end AnzeigeSpielmeldungen;
   
   
   
   procedure AnzeigeEingaben
   is begin
      
      case
        NachGrafiktask.Eingabe
      is
         when SystemDatentypen.Eingaben_Fragen_Enum'Range =>
            EingabenanzeigeGrafik.Fragenaufteilung (FrageExtern   => NachGrafiktask.AnzeigeFrage,
                                                    EingabeExtern => NachGrafiktask.Eingabe);
            
         when SystemDatentypen.Einheit_Auswahl_Enum =>
            EingabenanzeigeGrafik.AnzeigeEinheitenStadt (RasseExtern => NachGrafiktask.AktuelleRasse);
            
            -- Wenn ich das Baumenü/Forschungsmenü hierher verschiebe, dann könnte ich das Neusetzen vermeiden und diese Setzsachen in eine Prozedur auslagern. äöü
            -- Dann könnte ich auch ein durchsichtiges Fenster für die Menüs erstellen. äöü
            -- Könnte Probleme mit den anderen Möglichkeiten erzeugen, genauer prüfen vor dem Umbau. äöü
               
         when SystemDatentypen.Keine_Eingabe_Enum =>
            null;
      end case;
      
   end AnzeigeEingaben;

end Grafik;
