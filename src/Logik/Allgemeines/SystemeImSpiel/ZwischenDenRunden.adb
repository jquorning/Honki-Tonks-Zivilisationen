pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Ada.Calendar; use Ada.Calendar;

with RassenDatentypen; use RassenDatentypen;
with SystemDatentypen; use SystemDatentypen;
with RueckgabeDatentypen; use RueckgabeDatentypen;
with SonstigeVariablen;
with StadtKonstanten;
with SpielVariablen;
with TextKonstanten;
with GrafikDatentypen;

with SchreibeWichtiges;
with LeseWichtiges;

with Wachstum;
with ForschungAllgemein;
with StadtProduktion;
with SiegBedingungen;
with DiplomatischerZustand;
with StadtMeldungenSetzen;
with EinheitenMeldungenSetzen;
with EinheitInUmgebung;
with EinheitenModifizieren;
with Ladezeiten;
with Speichern;
with VerbesserungFertiggestellt;
with InteraktionGrafiktask;
with Auswahl;

package body ZwischenDenRunden is

   function BerechnungenNachZugendeAllerSpieler
     return Boolean
   is begin
      
      case
        SonstigeVariablen.RasseAmZugNachLaden
      is
         when StadtKonstanten.LeerRasse =>
            null;
            
         when others =>
            return False;
      end case;
      
      case
        NachSiegWeiterspielen
      is
         when True =>
            Ladezeiten.RundenendeNullsetzen;
            Ladezeiten.RundenendeZeit (SystemDatentypen.Anfangswert_Enum) := Clock;
            InteraktionGrafiktask.AktuelleDarstellung := GrafikDatentypen.Grafik_Rundenende_Enum;
            
         when False =>
            return True;
      end case;
      
      ---------------------------------- Später in verschiedene Teilbereiche aufteilen und nicht nur einen einzelnen Berechnungsfortschritt anzeigen?
      StadtMeldungenSetzen.StadtMeldungenSetzenRundenEnde;
      Ladezeiten.RundenendeSchreiben;
      
      EinheitenMeldungenSetzen.EinheitenMeldungenSetzenRundenEnde;
      Ladezeiten.RundenendeSchreiben;
      
      EinheitInUmgebung.EinheitInUmgebung;
      Ladezeiten.RundenendeSchreiben;
            
      EinheitenModifizieren.HeilungBewegungspunkteNeueRundeErmitteln;
      Ladezeiten.RundenendeSchreiben;
      
      VerbesserungFertiggestellt.VerbesserungFertiggestellt;
      Ladezeiten.RundenendeSchreiben;
      
      Wachstum.StadtWachstum;
      Ladezeiten.RundenendeSchreiben;
      
      StadtProduktion.StadtProduktion (StadtRasseNummerExtern => StadtKonstanten.LeerRasseNummer);
      Ladezeiten.RundenendeSchreiben;
      
      GeldForschungMengeSetzen;
      Ladezeiten.RundenendeSchreiben;
      
      ForschungAllgemein.ForschungFortschritt;
      Ladezeiten.RundenendeSchreiben;
            
      RundenAnzahlSetzen;
      Ladezeiten.RundenendeSchreiben;
      
      DiplomatieÄnderung;
      Ladezeiten.RundenendeSchreiben;
      
      -- Autospeichern muss immer nach allen Änderungen kommen, sonst werden nicht alle Änderungen gespeichert.
      Speichern.AutoSpeichern;
      Ladezeiten.RundenendeMaximum;
      
      InteraktionGrafiktask.AktuelleDarstellung := GrafikDatentypen.Grafik_Pause_Enum;
      Ladezeiten.RundenendeZeit (SystemDatentypen.Endwert_Enum) := Clock;
      
      --------------------- Wäre True statt False und oben umgekehrt nicht besser?
      return False;
      
   end BerechnungenNachZugendeAllerSpieler;
   
   
   
   function NachSiegWeiterspielen
     return Boolean
   is begin
      
      case
        SonstigeVariablen.WeiterSpielen
      is
         when False =>
            if
              SiegBedingungen.SiegBedingungen = False
            then
               null;
            
            elsif
              Auswahl.AuswahlJaNein (FrageZeileExtern => TextKonstanten.FrageGewonnenWeiterspielen) = RueckgabeDatentypen.Ja_Enum
            then
               SonstigeVariablen.WeiterSpielen := True;
                                 
            else
               return False;
            end if;
         
         when True =>
            null;
      end case;
      
      return True;
      
   end NachSiegWeiterspielen;
   
   
   
   procedure RundenAnzahlSetzen
   is begin
      
      case
        SpielVariablen.RundenAnzahl
      is
         when Positive'Last =>
            null;
            
         when others =>
            SpielVariablen.RundenAnzahl := SpielVariablen.RundenAnzahl + 1;
      end case;
      
   end RundenAnzahlSetzen;
   
   
   
   procedure DiplomatieÄnderung
   is begin
      
      RassenEinsSchleife:
      for RasseEinsSchleifenwert in RassenDatentypen.Rassen_Verwendet_Enum'Range loop
         RassenZweiSchleife:
         for RasseZweiSchleifenwert in RassenDatentypen.Rassen_Verwendet_Enum'Range loop
            
            if
              SpielVariablen.Diplomatie (RasseEinsSchleifenwert, RasseZweiSchleifenwert).AktuellerZustand = SystemDatentypen.Unbekannt_Enum
              or
                RasseEinsSchleifenwert = RasseZweiSchleifenwert
                or
                  SonstigeVariablen.RassenImSpiel (RasseEinsSchleifenwert) = RassenDatentypen.Leer_Spieler_Enum
              or
                SonstigeVariablen.RassenImSpiel (RasseZweiSchleifenwert) = RassenDatentypen.Leer_Spieler_Enum
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
      for RasseSchleifenwert in RassenDatentypen.Rassen_Verwendet_Enum'Range loop
         
         case
           SonstigeVariablen.RassenImSpiel (RasseSchleifenwert)
         is
            when RassenDatentypen.Leer_Spieler_Enum =>
               null;
            
            when others =>
               if
                 RasseSchleifenwert = RassenDatentypen.Ekropa_Enum
               then
                  null;
                  
               else
                  SchreibeWichtiges.Geldmenge (RasseExtern         => RasseSchleifenwert,
                                               GeldZugewinnExtern  => Integer (LeseWichtiges.GeldZugewinnProRunde (RasseExtern => RasseSchleifenwert)),
                                               RechnenSetzenExtern => True);
               end if;
               
               SchreibeWichtiges.Forschungsmenge (RasseExtern             => RasseSchleifenwert,
                                                  ForschungZugewinnExtern => LeseWichtiges.GesamteForschungsrate (RasseExtern => RasseSchleifenwert),
                                                  RechnenSetzenExtern     => True);
         end case;
         
      end loop RassenSchleife;
      
   end GeldForschungMengeSetzen;

end ZwischenDenRunden;
