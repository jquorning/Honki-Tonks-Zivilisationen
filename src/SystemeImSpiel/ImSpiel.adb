pragma SPARK_Mode (On);

with Ada.Calendar; use Ada.Calendar;

with EinheitenKonstanten;

with Karte;
with BefehleImSpiel;
with Optionen;
with Ladezeiten;
with Speichern;
with Laden;
with RasseEntfernen;
with ZwischenDenRunden;

with KI;

package body ImSpiel is

   function ImSpiel
     return SystemDatentypen.Rückgabe_Werte_Enum
   is begin
      
      Karte.SichtweiteBewegungsfeldFestlegen;
      
      SpielSchleife:
      loop
         RassenSchleife:
         for RasseSchleifenwert in SystemDatentypen.Rassen_Verwendet_Enum'Range loop
            
            RückgabeRassen := RasseImSpiel (RasseExtern => RasseSchleifenwert);
            
            case
              RückgabeRassen
            is
               when SystemDatentypen.Spiel_Beenden | SystemDatentypen.Hauptmenü =>
                  return RückgabeRassen;
                  
               when SystemDatentypen.Schleife_Verlassen =>
                  exit RassenSchleife;
                  
               when SystemDatentypen.Start_Weiter =>
                  null;
               
               when others =>
                  raise Program_Error;
            end case;
            
         end loop RassenSchleife;
               
         if
           GlobaleVariablen.RasseAmZugNachLaden = EinheitenKonstanten.LeerRasse
           and
             ZwischenDenRunden.BerechnungenNachZugendeAllerSpieler = True
         then
            return SystemDatentypen.Hauptmenü;
            
         elsif
           GlobaleVariablen.Rundengrenze > GlobaleVariablen.RundenAnzahl
         then
            return SystemDatentypen.Hauptmenü;
            
         else
            null;
         end if;
            
      end loop SpielSchleife;
            
   end ImSpiel;
   
   
   
   function RasseImSpiel
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
      return SystemDatentypen.Rückgabe_Werte_Enum
   is begin
      
      if
        GlobaleVariablen.RassenImSpiel (RasseExtern) = SystemDatentypen.Leer
      then
         return SystemDatentypen.Start_Weiter;
      
      elsif
        GlobaleVariablen.Grenzen (RasseExtern).RassenRundengrenze < GlobaleVariablen.RundenAnzahl
        and
          GlobaleVariablen.Grenzen (RasseExtern).RassenRundengrenze > 0
      then
         RasseEntfernen.RasseEntfernen (RasseExtern => RasseExtern);
         return SystemDatentypen.Start_Weiter;
         
      else
         return RasseDurchgehen (RasseExtern => RasseExtern);
      end if;
      
   end RasseImSpiel;
   
   
   
   function RasseDurchgehen
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
      return SystemDatentypen.Rückgabe_Werte_Enum
   is begin
            
      if
        GlobaleVariablen.RasseAmZugNachLaden = EinheitenKonstanten.LeerRasse
        or
          RasseExtern = GlobaleVariablen.RasseAmZugNachLaden
      then
         GlobaleVariablen.RasseAmZugNachLaden := EinheitenKonstanten.LeerRasse;
            
         case
           GlobaleVariablen.RassenImSpiel (RasseExtern)
         is
            when SystemDatentypen.Spieler_Mensch =>
               return MenschlicherSpieler (RasseExtern => RasseExtern);
               
            when SystemDatentypen.Spieler_KI =>
               KISpieler (RasseExtern => RasseExtern);
               
            when SystemDatentypen.Leer =>
               raise Program_Error;
         end case;

      else
         null;
      end if;
      
      return SystemDatentypen.Start_Weiter;
      
   end RasseDurchgehen;
   
   
   
   procedure KISpieler
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
   is begin
            
      Ladezeiten.KIZeiten (RasseExtern, SystemDatentypen.Anfangswert) := Clock;
      KI.KI (RasseExtern => RasseExtern);
      Ladezeiten.KIZeiten (RasseExtern, SystemDatentypen.Endwert) := Clock;
      
   end KISpieler;
   
   
   
   function MenschlicherSpieler
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
      return SystemDatentypen.Rückgabe_Werte_Enum
   is begin
                           
      RückgabeWert := MenschAmZug (RasseExtern => RasseExtern);
      
      if
        (RückgabeWert = SystemDatentypen.Spiel_Beenden
         or
           RückgabeWert = SystemDatentypen.Hauptmenü)
        and
          NochSpielerVorhanden (RasseExtern => RasseExtern) = True
      then
         RasseEntfernen.RasseAufKISetzen (RasseExtern => RasseExtern);
                        
      elsif
        RückgabeWert = SystemDatentypen.Spiel_Beenden
        or
          RückgabeWert = SystemDatentypen.Hauptmenü
          or
            RückgabeWert = SystemDatentypen.Schleife_Verlassen
      then
         return RückgabeWert;
                        
      else
         null;
      end if;
      
      return SystemDatentypen.Start_Weiter;
      
   end MenschlicherSpieler;



   function MenschAmZug
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
      return SystemDatentypen.Rückgabe_Werte_Enum
   is begin
      
      SpielerSchleife:
      loop
         
         case
           GlobaleVariablen.RassenImSpiel (RasseExtern)
         is
            when SystemDatentypen.Spieler_Mensch =>
               Karte.AnzeigeKarte (RasseExtern => RasseExtern);
               AktuellerBefehlSpieler := BefehleImSpiel.Befehle (RasseExtern => RasseExtern);
               
            when others =>
               -- Sollte niemals auftreten? Könnte auftreten wenn der Spieler eliminiert wird oder auf KI gesetzt wird? Mal ein besseres System bauen.
               raise Program_Error;
         end case;
         
         case
           AktuellerBefehlSpieler
         is
            when SystemDatentypen.Start_Weiter =>
               null;

            when SystemDatentypen.Speichern =>
               GlobaleVariablen.RasseAmZugNachLaden := RasseExtern;
               Speichern.SpeichernNeu (AutospeichernExtern => False);
               
            when SystemDatentypen.Laden =>
               if
                 Laden.LadenNeu = True
               then
                  return SystemDatentypen.Schleife_Verlassen;

               else
                  null;
               end if;
               
            when SystemDatentypen.Optionen =>
               RückgabeOptionen := Optionen.Optionen;
               if
                 RückgabeOptionen = SystemDatentypen.Spiel_Beenden
                 or
                   RückgabeOptionen = SystemDatentypen.Hauptmenü
               then
                  return RückgabeOptionen;
                  
               else
                  null;
               end if;
               
            when SystemDatentypen.Spiel_Beenden | SystemDatentypen.Hauptmenü | SystemDatentypen.Runde_Beenden =>
               return AktuellerBefehlSpieler;
                  
            when others =>
               raise Program_Error;
         end case;
                     
      end loop SpielerSchleife;
      
   end MenschAmZug;
   
   
   
   function NochSpielerVorhanden
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
      return Boolean
   is begin
      
      RassenSchleife:
      for RasseSchleifenwert in SystemDatentypen.Rassen_Verwendet_Enum'Range loop
         
         if
           RasseSchleifenwert = RasseExtern
           or
             GlobaleVariablen.RassenImSpiel (RasseSchleifenwert) /= SystemDatentypen.Spieler_Mensch
         then
            null;
            
         else
            return True;
         end if;
         
      end loop RassenSchleife;
      
      return False;
      
   end NochSpielerVorhanden;

end ImSpiel;
