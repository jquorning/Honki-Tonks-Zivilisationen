pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with RueckgabeDatentypen; use RueckgabeDatentypen;
with EinheitenKonstanten;
with GrafikDatentypen;
with MenueDatentypen;
with TextnummernKonstanten;

with Optionen;
with LadezeitenLogik;
with Speichern;
with Laden;
with RasseEntfernen;
with RundenendeLogik;
with Fehler;
with NachGrafiktask;
with BefehlsauswahlLogik;
with JaNeinLogik;
with Spielertests;
with AuswahlaufteilungLogik;

with KI;

package body SpielLogik is

   function Spiel
     return RueckgabeDatentypen.Rückgabe_Werte_Enum
   is begin
            
      SpielSchleife:
      loop
                  
         RassenSchleife:
         for RasseSchleifenwert in RassenDatentypen.Rassen_Verwendet_Enum'Range loop
            
            RückgabeRassen := RasseImSpiel (RasseExtern => RasseSchleifenwert);
            
            case
              RückgabeRassen
            is
               when RueckgabeDatentypen.Hauptmenü_Beenden_Enum'Range =>
                  return RückgabeRassen;
                  
               when RueckgabeDatentypen.Schleife_Verlassen_Enum =>
                  exit RassenSchleife;
                  
               when RueckgabeDatentypen.Start_Weiter_Enum =>
                  null;
               
               when others =>
                  Fehler.LogikFehler (FehlermeldungExtern => "SpielLogik.Spiel: Falsche Rückgabe.");
            end case;
            
         end loop RassenSchleife;
         
         if
           SpielVariablen.Allgemeines.RasseAmZugNachLaden = EinheitenKonstanten.LeerRasse
         then
            case
              Spielertests.MenschlicheSpieler (RasseExtern => RassenDatentypen.Keine_Rasse_Enum)
            is
               when True =>
                  null;
               
               when False =>
                  exit SpielSchleife;
            end case;
            
            case
              RundenendeLogik.BerechnungenRundenende
            is
               when False =>
                  exit SpielSchleife;
               
               when True =>
                  null;
            end case;
            
         elsif
           SpielVariablen.Allgemeines.Rundengrenze > 0
           and
             SpielVariablen.Allgemeines.Rundengrenze < SpielVariablen.Allgemeines.Rundenanzahl
         then
            exit SpielSchleife;
            
         else
            null;
         end if;
            
      end loop SpielSchleife;
      
      return RueckgabeDatentypen.Hauptmenü_Enum;
            
   end Spiel;
   
   
   
   function RasseImSpiel
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return RueckgabeDatentypen.Rückgabe_Werte_Enum
   is begin
      
      if
        SpielVariablen.Rassenbelegung (RasseExtern).Belegung = RassenDatentypen.Leer_Spieler_Enum
        or
          SpielVariablen.Rassenbelegung (RasseExtern).Besiegt = True
      then
         return RueckgabeDatentypen.Start_Weiter_Enum;
      
      elsif
        SpielVariablen.Grenzen (RasseExtern).RassenRundengrenze < SpielVariablen.Allgemeines.Rundenanzahl
        and
          SpielVariablen.Grenzen (RasseExtern).RassenRundengrenze > 0
      then
         RasseEntfernen.RasseEntfernen (RasseExtern => RasseExtern);
         return RueckgabeDatentypen.Start_Weiter_Enum;
         
      else
         return RasseDurchgehen (RasseExtern => RasseExtern);
      end if;
      
   end RasseImSpiel;
   
   
   
   function RasseDurchgehen
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return RueckgabeDatentypen.Rückgabe_Werte_Enum
   is begin
            
      if
        SpielVariablen.Allgemeines.RasseAmZugNachLaden = EinheitenKonstanten.LeerRasse
        or
          RasseExtern = SpielVariablen.Allgemeines.RasseAmZugNachLaden
      then
         SpielVariablen.Allgemeines.RasseAmZugNachLaden := EinheitenKonstanten.LeerRasse;
            
         case
           SpielVariablen.Rassenbelegung (RasseExtern).Belegung
         is
            when RassenDatentypen.Mensch_Spieler_Enum =>
               return MenschlicherSpieler (RasseExtern => RasseExtern);
               
            when RassenDatentypen.KI_Spieler_Enum =>
               KISpieler (RasseExtern => RasseExtern);
               
            when RassenDatentypen.Leer_Spieler_Enum =>
               Fehler.LogikFehler (FehlermeldungExtern => "SpielLogik.RasseDurchgehen: Keine Rasse.");
         end case;

      else
         null;
      end if;
      
      return RueckgabeDatentypen.Start_Weiter_Enum;
      
   end RasseDurchgehen;
   
   
   
   procedure KISpieler
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      LadezeitenLogik.KINullsetzenFortschritt;
      
      -- Mal was einbauen damit man die KI sieht bei ihren Bewegungen? Wenn dann bei Debug an, sonst würde man ja auch nicht sichtbare KIs sehen. äöü
      -- NachGrafiktask.AktuelleRasseEinheit.Rasse := RasseExtern;
      -- NachGrafiktask.AktuelleDarstellung := GrafikDatentypen.Grafik_Weltkarte_Enum;
      
      NachGrafiktask.KIRechnet := RasseExtern;
      NachGrafiktask.AktuelleDarstellung := GrafikDatentypen.Grafik_KI_Rechenzeit_Enum;
      
      KI.KI (RasseExtern => RasseExtern);
      
      NachGrafiktask.AktuelleDarstellung := GrafikDatentypen.Grafik_Pause_Enum;
      NachGrafiktask.KIRechnet := RassenDatentypen.Keine_Rasse_Enum;
      
   end KISpieler;
   
   
   
   function MenschlicherSpieler
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return RueckgabeDatentypen.Rückgabe_Werte_Enum
   is begin
                           
      RückgabeWert := MenschAmZug (RasseExtern => RasseExtern);
      
      case
        RückgabeWert
      is
         when RueckgabeDatentypen.Spiel_Beenden_Enum | RueckgabeDatentypen.Hauptmenü_Enum =>
            if
              Spielertests.MenschlicheSpieler (RasseExtern => RasseExtern) = True
            then
               case
                 JaNeinLogik.JaNein (FrageZeileExtern => TextnummernKonstanten.FrageKIEinsetzen)
               is
                  when True =>
                     RasseEntfernen.RasseAufKISetzen (RasseExtern => RasseExtern);
                     
                  when others =>
                     RasseEntfernen.RasseEntfernen (RasseExtern => RasseExtern);
               end case;
               
            else
               return RückgabeWert;
            end if;
            
         when RueckgabeDatentypen.Schleife_Verlassen_Enum =>
            return RückgabeWert;
            
         when others =>
            null;
      end case;
      
      return RueckgabeDatentypen.Start_Weiter_Enum;
      
   end MenschlicherSpieler;



   function MenschAmZug
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return RueckgabeDatentypen.Rückgabe_Werte_Enum
   is begin
      
      NachGrafiktask.AktuelleRasse := RasseExtern;
      
      SpielerSchleife:
      loop
         
         NachGrafiktask.AktuelleDarstellung := GrafikDatentypen.Grafik_Weltkarte_Enum;
         
         case
           SpielVariablen.Rassenbelegung (RasseExtern).Belegung
         is
            when RassenDatentypen.Mensch_Spieler_Enum =>
               AktuellerBefehlSpieler := BefehlsauswahlLogik.Befehlsauswahl (RasseExtern => RasseExtern);
               
            when others =>
               RückgabeMenschAmZug := RueckgabeDatentypen.Hauptmenü_Enum;
               exit SpielerSchleife;
         end case;
         
         case
           SpielVariablen.Rassenbelegung (RasseExtern).Besiegt
         is
            when True =>
               exit SpielerSchleife;
               
            when False =>
               null;
         end case;
         
         case
           AktuellerBefehlSpieler
         is
            when RueckgabeDatentypen.Start_Weiter_Enum =>
               if
                 SpielVariablen.Rassenbelegung (RasseExtern).Belegung = RassenDatentypen.Mensch_Spieler_Enum
               then
                  null;
                  
               else
                  RückgabeMenschAmZug := RueckgabeDatentypen.Start_Weiter_Enum;
                  exit SpielerSchleife;
               end if;
               
            when RueckgabeDatentypen.Runde_Beenden_Enum =>
               RückgabeMenschAmZug := AktuellerBefehlSpieler;
               exit SpielerSchleife;
               
            when RueckgabeDatentypen.Spielmenü_Enum =>
               RückgabeSpielmenü := Spielmenü (RasseExtern => RasseExtern);

               if
                 RückgabeSpielmenü = RueckgabeDatentypen.Laden_Enum
               then
                  RückgabeMenschAmZug := RueckgabeDatentypen.Schleife_Verlassen_Enum;
                  exit SpielerSchleife;
                  
               elsif
                 RückgabeSpielmenü in RueckgabeDatentypen.Hauptmenü_Beenden_Enum'Range
               then
                  RückgabeMenschAmZug := RückgabeSpielmenü;
                  exit SpielerSchleife;
                  
               elsif
                 RückgabeSpielmenü = RueckgabeDatentypen.Start_Weiter_Enum
                 or
                   RückgabeSpielmenü = RueckgabeDatentypen.Zurück_Enum
               then
                  null;
                  
               else
                  Fehler.LogikFehler (FehlermeldungExtern => "SpielLogik.MenschAmZug: Falsche Rückgabe.");
               end if;
               
            when others =>
               Fehler.LogikFehler (FehlermeldungExtern => "SpielLogik.MenschAmZug: Falscher Befehl.");
         end case;
                     
      end loop SpielerSchleife;
      
      NachGrafiktask.AktuelleDarstellung := GrafikDatentypen.Grafik_Pause_Enum;
      NachGrafiktask.AktuelleRasse := RassenDatentypen.Keine_Rasse_Enum;
      
      return RückgabeMenschAmZug;
      
   end MenschAmZug;



   function Spielmenü
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return RueckgabeDatentypen.Rückgabe_Werte_Enum
   is begin
      
      SpielmenüSchleife:
      loop
         
         AuswahlSpielmenü := AuswahlaufteilungLogik.AuswahlMenüsAufteilung (WelchesMenüExtern => MenueDatentypen.Spiel_Menü_Enum);

         case
           AuswahlSpielmenü
         is
            when RueckgabeDatentypen.Speichern_Enum =>
               SpielVariablen.Allgemeines.RasseAmZugNachLaden := RasseExtern;
               Speichern.Speichern (AutospeichernExtern => False);
               
            when RueckgabeDatentypen.Laden_Enum =>
               if
                 Laden.Laden = True
               then
                  return RueckgabeDatentypen.Laden_Enum;

               else
                  null;
               end if;
               
            when RueckgabeDatentypen.Optionen_Enum =>
               RückgabeOptionen := Optionen.Optionen;
               
               if
                 RückgabeOptionen in RueckgabeDatentypen.Hauptmenü_Beenden_Enum'Range
               then
                  return RückgabeOptionen;
                  
               else
                  null;
               end if;
               
            when RueckgabeDatentypen.Hauptmenü_Beenden_Enum'Range | RueckgabeDatentypen.Start_Weiter_Enum | RueckgabeDatentypen.Zurück_Enum =>
               return AuswahlSpielmenü;
                  
            when others =>
               Fehler.LogikFehler (FehlermeldungExtern => "SpielLogik.Spielmenü: Falsche Rückgabe.");
         end case;
      
      end loop SpielmenüSchleife;
   
   end Spielmenü;

end SpielLogik;