pragma SPARK_Mode (On);

with Ada.Characters.Wide_Wide_Latin_1; use Ada.Characters.Wide_Wide_Latin_1;

with Sf; use Sf;
with Sf.Window.Keyboard; use Sf.Window.Keyboard;
with Sf.Graphics.RenderWindow;

with SystemKonstanten;
with SystemDatentypen;

with GrafikEinstellungen;
with InteraktionTasks;

package body EingabeSystemeSFML is

   procedure TastenEingabe
   is begin
      
      SchleifeVerlassen := False;
      TastaturTaste := Sf.Window.Keyboard.sfKeyUnknown;
      -- Kann man sfMouseButtonCount einfach so als Leerwert nehmen?
      MausTaste := Sf.Window.Mouse.sfMouseButtonCount;
      MausRad := 0.00;
      
      -- EingabeSchleife ist nicht notwendig, das entfernen macht aber die Probleme schlimmer, das ganze hier mal umbauen/in den Grafiktask verschieben.
      EingabeSchleife:
      while SchleifeVerlassen = False loop
         TasteSchleife:
         while Sf.Graphics.RenderWindow.pollEvent (renderWindow => GrafikEinstellungen.Fenster,
                                                   event        => ZeichenEingeben)
           = Sf.sfTrue loop
            
            case
              ZeichenEingeben.eventType
            is
               when Sf.Window.Event.sfEvtClosed =>
                  -- Hier noch einen universellen Endebefehl einbauen.
                  null;
                  
               when Sf.Window.Event.sfEvtResized =>
                  -- Schleife hier auch danach verlassen? Würde das irgendwas bringen?
                  InteraktionTasks.FensterVerändert := True;
                  
               when Sf.Window.Event.sfEvtMouseMoved =>
                  -- Immer hier die neue Mausposition festlegen, denn es kann/wird bei mehreren gleichzeitigen Mausaufrufen des RenderWindow zu Abstürzen kommen.
                  GrafikEinstellungen.MausPosition := (ZeichenEingeben.mouseMove.x, ZeichenEingeben.mouseMove.y);
                  -- Schleife muss auch hier verlassen werden, sonst wird die aktuelle Mausposition nicht oft genug festgelegt.
                  SchleifeVerlassen := True;
                  
               when others =>
                  null;
            end case;
            
            -- Gäbe es einen Vorteil diesen Teil in jeweils eine eigene Prüfung umzuwandeln? Eventuell um mehrere Dinge gleichzeitig festlegen zu können?
            case
              ZeichenEingeben.eventType
            is
               when Sf.Window.Event.sfEvtKeyPressed =>
                  TastaturTaste := ZeichenEingeben.key.code;
                  SchleifeVerlassen := True;
                  
               when Sf.Window.Event.sfEvtMouseWheelScrolled =>
                  MausRad := ZeichenEingeben.mouseWheelScroll.eventDelta;
                  SchleifeVerlassen := True;
                  
               when Sf.Window.Event.sfEvtMouseButtonPressed =>
                  MausTaste := ZeichenEingeben.mouseButton.button;
                  SchleifeVerlassen := True;
                  
               when others =>
                  null;
            end case;
                     
         end loop TasteSchleife;
      end loop EingabeSchleife;
      
   end TastenEingabe;
   
   
   
   function TextEingeben
     return SystemRecords.TextEingabeRecord
   is begin
      
      EingegebenerText := SystemKonstanten.LeerUnboundedString;
      InteraktionTasks.Eingabe := SystemDatentypen.Text_Eingabe;
      
      EingabeSchleife:
      loop
         TasteSchleife:
         while Sf.Graphics.RenderWindow.pollEvent (renderWindow => GrafikEinstellungen.Fenster,
                                                   event        => TextEingegeben)
           = Sf.sfTrue loop
            
            case
              TextEingegeben.eventType
            is
               when Sf.Window.Event.sfEvtTextEntered =>
                  TextPrüfen (UnicodeNummerExtern => TextEingegeben.text.unicode);
               
                  -- Im aktuellen System gibt es gar kein Abbruch für Speichern/Laden/Städtbau/usw., oder?
               when Sf.Window.Event.sfEvtKeyPressed =>
                  if
                    TextEingegeben.key.code = Sf.Window.Keyboard.sfKeyEnter
                  then
                     ErfolgreichAbbruch := True;
                     exit EingabeSchleife;
                     
                  elsif
                    TextEingegeben.key.code = Sf.Window.Keyboard.sfKeyEscape
                  then
                     ErfolgreichAbbruch := False;
                     exit EingabeSchleife;
                  
                  else
                     null;
                  end if;
               
               when others =>
                  null;
            end case;
         
         end loop TasteSchleife;
      end loop EingabeSchleife;
   
      InteraktionTasks.Eingabe := SystemDatentypen.Keine_Eingabe;
      
      return (ErfolgreichAbbruch, EingegebenerText);
      
   end TextEingeben;
   
   
   
   procedure TextPrüfen
     (UnicodeNummerExtern : in Sf.sfUint32)
   is begin
      
      case
        UnicodeNummerExtern
      is
         when 0 .. 7 | 9 .. 26 | 28 .. 31 | 128 .. 159 =>
            return;
            
         when others =>
            EingegebenesZeichen := Wide_Wide_Character'Val (UnicodeNummerExtern);
      end case;
      
      case
        EingegebenesZeichen
      is
         when ESC =>
            null; -- Kann ich ESC hier nicht entfernen wenn ich es bei der Eingebae bereits prüfe?
            
         when BS | DEL =>
            ZeichenEntfernen;
         
         when others =>
            ZeichenHinzufügen (EingegebenesZeichenExtern => EingegebenesZeichen);
      end case;
      
   end TextPrüfen;
   
   
   
   procedure ZeichenHinzufügen
     (EingegebenesZeichenExtern : in Wide_Wide_Character)
   is begin
      
      CharacterZuText (1) := EingegebenesZeichenExtern;
      
      EingegebenerText := EingegebenerText & To_Unbounded_Wide_Wide_String (Source => CharacterZuText);
      
   end ZeichenHinzufügen;
   
   
   
   procedure ZeichenEntfernen
   is begin
      
      if
        To_Wide_Wide_String (Source => EingegebenerText)'Length < 1
      then
         null;
         
      else
         EingegebenerText := Ada.Strings.Wide_Wide_Unbounded.Delete (Source  => EingegebenerText,
                                                                     From    => To_Wide_Wide_String (Source => EingegebenerText)'Last,
                                                                     Through => To_Wide_Wide_String (Source => EingegebenerText)'Last);
      end if;
      
   end ZeichenEntfernen;

end EingabeSystemeSFML;
