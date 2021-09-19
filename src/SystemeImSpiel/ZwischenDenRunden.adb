pragma SPARK_Mode (On);

with Ada.Calendar;
use Ada.Calendar;

with GlobaleDatentypen, GlobaleVariablen, GlobaleKonstanten;
use GlobaleDatentypen;

with SchreibeWichtiges;
with LeseWichtiges;

with Wachstum, ForschungAllgemein, StadtProduktion, SiegBedingungen, DiplomatischerZustand, StadtMeldungenSetzen, EinheitenMeldungenSetzen, EinheitInUmgebung, EinheitenModifizieren,
     Ladezeiten, Speichern, Auswahl, VerbesserungFertiggestellt;

package body ZwischenDenRunden is

   function BerechnungenNachZugendeAllerSpieler
     return Boolean
   is begin
      
      Ladezeiten.EinzelneZeiten (Ladezeiten.Zwischen_Runden, GlobaleDatentypen.Anfangswert) := Clock;
      
      case
        NachSiegWeiterspielen
      is
         when True =>
            return True;
            
         when False =>
            null;
      end case;
      
      StadtMeldungenSetzen.StadtMeldungenSetzenRundenEnde;
      EinheitenMeldungenSetzen.EinheitenMeldungenSetzenRundenEnde;
      EinheitInUmgebung.EinheitInUmgebung;
      
      EinheitenModifizieren.HeilungBewegungspunkteNeueRundeErmitteln;
      VerbesserungFertiggestellt.VerbesserungFertiggestellt;
      Wachstum.StadtWachstum;
      StadtProduktion.StadtProduktion ((GlobaleDatentypen.Leer, 0));
      GeldForschungMengeSetzen;
      ForschungAllgemein.ForschungFortschritt;
      
      RundenAnzahlSetzen;
      EinzelneKIZeitenAnzeigen;
      DiplomatieÄnderung;

      -- Autospeichern muss immer nach allen Änderungen kommen, sonst werden nicht alle Änderungen gespeichert.
      Speichern.AutoSpeichern;
            
      GesamteZeitenAnzeigen;
      
      return False;
      
   end BerechnungenNachZugendeAllerSpieler;
   
   
   
   function NachSiegWeiterspielen
     return Boolean
   is begin
      
      case
        GlobaleVariablen.WeiterSpielen
      is
         when False =>
            if
              SiegBedingungen.SiegBedingungen = False
            then
               null;
            
            elsif
              Auswahl.AuswahlJaNein (FrageZeileExtern => 34) = GlobaleKonstanten.JaKonstante
            then
               GlobaleVariablen.WeiterSpielen := True;
                                 
            else
               return True;
            end if;
         
         when True =>
            null;
      end case;
      
      return False;
      
   end NachSiegWeiterspielen;
   
   
   
   procedure RundenAnzahlSetzen
   is begin
      
      case
        GlobaleVariablen.RundenAnzahl
      is
         when Positive'Last =>
            null;
            
         when others =>
            GlobaleVariablen.RundenAnzahl := GlobaleVariablen.RundenAnzahl + 1;
      end case;
      
   end RundenAnzahlSetzen;
   
   
   
   procedure EinzelneKIZeitenAnzeigen
   is begin
      
      KIVorhanden := False;
      
      RassenSchleife:
      for RasseSchleifenwert in GlobaleDatentypen.Rassen_Verwendet_Enum'Range loop
         
         if
           GlobaleVariablen.RassenImSpiel (RasseSchleifenwert) = GlobaleDatentypen.Spieler_KI
         then
            KIVorhanden := True;
            Ladezeiten.AnzeigeKIZeit (WelcheZeitExtern => RasseSchleifenwert);
            
         else
            Ladezeiten.KIZeiten (RasseSchleifenwert, GlobaleDatentypen.Anfangswert) := Clock;
            Ladezeiten.KIZeiten (RasseSchleifenwert, GlobaleDatentypen.Endwert) := Ladezeiten.KIZeiten (RasseSchleifenwert, GlobaleDatentypen.Anfangswert);
         end if;
         
      end loop RassenSchleife;
      
   end EinzelneKIZeitenAnzeigen;
   
   
   
   procedure DiplomatieÄnderung
   is begin
      
      RassenEinsSchleife:
      for RasseEinsSchleifenwert in GlobaleDatentypen.Rassen_Verwendet_Enum'Range loop
         RassenZweiSchleife:
         for RasseZweiSchleifenwert in GlobaleDatentypen.Rassen_Verwendet_Enum'Range loop
            
            if
              GlobaleVariablen.Diplomatie (RasseEinsSchleifenwert, RasseZweiSchleifenwert).AktuellerZustand = GlobaleDatentypen.Unbekannt
              or
                RasseEinsSchleifenwert = RasseZweiSchleifenwert
                or
                  GlobaleVariablen.RassenImSpiel (RasseEinsSchleifenwert) = GlobaleDatentypen.Leer
              or
                GlobaleVariablen.RassenImSpiel (RasseZweiSchleifenwert) = GlobaleDatentypen.Leer
            then
               null;
                  
            else
               DiplomatischerZustand.VergangeneZeitÄndern (RasseEinsExtern => RasseEinsSchleifenwert,
                                                            RasseZweiExtern => RasseZweiSchleifenwert);
               DiplomatischerZustand.SympathieÄndern (EigeneRasseExtern => RasseEinsSchleifenwert,
                                                       FremdeRasseExtern => RasseZweiSchleifenwert,
                                                       ÄnderungExtern    => 1);
            end if;
            
         end loop RassenZweiSchleife;
         
      end loop RassenEinsSchleife;
      
   end DiplomatieÄnderung;
   
   
   
   procedure GeldForschungMengeSetzen
   is begin
      
      RassenSchleife:
      for RasseSchleifenwert in GlobaleDatentypen.Rassen_Verwendet_Enum'Range loop
         
         case
           GlobaleVariablen.RassenImSpiel (RasseSchleifenwert)
         is
            when GlobaleDatentypen.Leer =>
               null;
            
            when others =>
               SchreibeWichtiges.Geldmenge (RasseExtern         => RasseSchleifenwert,
                                            GeldZugewinnExtern  => Integer (LeseWichtiges.GeldZugewinnProRunde (RasseExtern => RasseSchleifenwert)),
                                            RechnenSetzenExtern => True);
               
               SchreibeWichtiges.Forschungsmenge (RasseExtern             => RasseSchleifenwert,
                                                  ForschungZugewinnExtern => LeseWichtiges.GesamteForschungsrate (RasseExtern => RasseSchleifenwert),
                                                  RechnenSetzenExtern     => True);
         end case;
         
      end loop RassenSchleife;
      
   end GeldForschungMengeSetzen;
   
   
   
   procedure GesamteZeitenAnzeigen
   is begin
      
      case
        KIVorhanden
      is
         when True =>
            Ladezeiten.AnzeigeKIZeit (WelcheZeitExtern => GlobaleDatentypen.Leer);
            
         when False =>
            null;
      end case;
      
      Ladezeiten.EinzelneZeiten (Ladezeiten.Zwischen_Runden, GlobaleDatentypen.Endwert) := Clock;
      Ladezeiten.AnzeigeEinzelneZeit (WelcheZeitExtern => Ladezeiten.Zwischen_Runden);
      
   end GesamteZeitenAnzeigen;

end ZwischenDenRunden;
