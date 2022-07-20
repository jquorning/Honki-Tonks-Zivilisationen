pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Ada.Calendar; use Ada.Calendar;

with RassenDatentypen;
with SystemDatentypen;
with MenueDatentypen;
with GrafikDatentypen;
with LadezeitenDatentypen;

with ImSpiel;
with Kartengenerator;
with SpieleinstellungenKarten;
with SpieleinstellungenRasseSpieler;
with SpieleinstellungenSonstiges;
with Warnung;
with Ladezeiten;
with AuswahlMenues;
with NachGrafiktask;
with AllesAufAnfangSetzen;
with Karten;
with KartengeneratorVariablen;
with SpielerVorhanden;

package body Spieleinstellungen is

   function Spieleinstellungen
     (SchnellstartExtern : in Boolean)
      return RueckgabeDatentypen.Rückgabe_Werte_Enum
   is begin
      
      AllesAufAnfangSetzen.AllesAufAnfangSetzen (EinstellungenBehaltenExtern => True);
      
      case
        SchnellstartExtern
      is
         when True =>
            SpieleinstellungenRasseSpieler.RasseBelegenSchnellstart;
            return AutomatischeEinstellungen;
            
         when False =>
            null;
      end case;
      
      SpielGespieltSchleife:
      loop
         SpielEinstellungenSchleife:
         loop
         
            Auswahl := AuswahlMenues.AuswahlMenüsAufteilung (WelchesMenüExtern => MenueDatentypen.Einstellungen_Menü_Enum);
         
            case
              Auswahl
            is
               when RueckgabeDatentypen.Auswahl_Kartenpole_Enum =>
                  SpieleinstellungenKarten.KartenpoleWählen;
                    
               when RueckgabeDatentypen.Auswahl_Kartengröße_Enum =>
                  SpieleinstellungenKarten.KartengrößeWählen;

               when RueckgabeDatentypen.Auswahl_Kartenart_Enum =>
                  SpieleinstellungenKarten.KartenartWählen;
               
               when RueckgabeDatentypen.Auswahl_Kartenform_Enum =>
                  SpieleinstellungenKarten.KartenformWählen;

               when RueckgabeDatentypen.Auswahl_Kartentemperatur_Enum =>
                  SpieleinstellungenKarten.KartentemperaturWählen;
               
               when RueckgabeDatentypen.Auswahl_Kartenressourcen_Enum =>
                  SpieleinstellungenKarten.KartenressourcenWählen;

               when RueckgabeDatentypen.Auswahl_Rassen_Enum =>
                  SpieleinstellungenRasseSpieler.RassenWählen;

               when RueckgabeDatentypen.Auswahl_Schwierigkeitsgrad_Enum =>
                  SpieleinstellungenSonstiges.SchwierigkeitsgradFestlegen;
               
               when RueckgabeDatentypen.Fertig_Enum =>
                  if
                    SpieleinstellungenRasseSpieler.EineRasseBelegt = True
                  then
                     null;
                  
                  else
                     SpieleinstellungenRasseSpieler.RasseAutomatischBelegen;
                  end if;
                  
                  exit SpielEinstellungenSchleife;

               when RueckgabeDatentypen.Hauptmenü_Beenden_Enum'Range =>
                  return RueckgabeDatentypen.Hauptmenü_Enum;

               when others =>
                  null;
            end case;

         end loop SpielEinstellungenSchleife;
         
         Rückgabewert := AutomatischeEinstellungen;
         
         case
           Rückgabewert
         is
            when RueckgabeDatentypen.Spielmenü_Enum =>
               null;
               
            when others =>
               return Rückgabewert;
         end case;
         
      end loop SpielGespieltSchleife;
              
   end Spieleinstellungen;
   
   
   
   function AutomatischeEinstellungen
     return RueckgabeDatentypen.Rückgabe_Werte_Enum
   is begin
      
      ------------------------------ Nullsetzen der Ladezeiten und das umschalten der Grafik kombinieren?
      Ladezeiten.SpielweltNullsetzen;
      NachGrafiktask.AktuelleDarstellung := GrafikDatentypen.Grafik_Generierungszeit_Enum;

      -- Wird benötigt, da sonst die wichtigen Kartenwerte nicht gespeichert/geladen werden können. Sicherheitshalber immer vor Aufruf des Kartengenerators setzen.
      Karten.Karteneinstellungen.Kartengröße := KartengeneratorVariablen.Kartenparameter.Kartengröße;
      Karten.Karteneinstellungen.Kartenform := KartengeneratorVariablen.Kartenparameter.Kartenform;
      Kartengenerator.Kartengenerator;
      
      Ladezeiten.SpielweltErstellen (LadezeitenDatentypen.Platziere_Rassen_Enum, SystemDatentypen.Anfangswert_Enum) := Clock;
      
      SpieleinstellungenRasseSpieler.StartwerteErmitteln;
      
      case
        SpielerVorhanden.BeliebigeSpielerart (RasseExtern => RassenDatentypen.Keine_Rasse_Enum)
      is
         when True =>
            null;
            
         when False =>
            Warnung.LogikWarnung (WarnmeldungExtern => "SpielEinstellungen.AutomatischeEinstellungen - Es konnte keine Rasse platziert werden.");
            return RueckgabeDatentypen.Spielmenü_Enum;
      end case;
         
      Ladezeiten.SpielweltErstellen (LadezeitenDatentypen.Platziere_Rassen_Enum, SystemDatentypen.Endwert_Enum) := Clock;
      
      return ImSpiel.ImSpiel;
      
   end AutomatischeEinstellungen;

end Spieleinstellungen;
