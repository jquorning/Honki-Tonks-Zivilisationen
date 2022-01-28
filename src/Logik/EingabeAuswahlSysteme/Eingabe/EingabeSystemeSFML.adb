pragma SPARK_Mode (On);

with Ada.Characters.Wide_Wide_Latin_1; use Ada.Characters.Wide_Wide_Latin_1;

with Sf; use Sf;
with Sf.Window.Keyboard; use Sf.Window.Keyboard;
with Sf.Graphics.RenderWindow;

-- with SystemKonstanten;
-- with SystemDatentypen;

with GrafikEinstellungenSFML;
with Fehler;
with InteraktionGrafiktask;

package body EingabeSystemeSFML is

   procedure TastenEingabe
   is begin
            
      TastaturTaste := Sf.Window.Keyboard.sfKeyUnknown;
      -- Kann man sfMouseButtonCount einfach so als Leerwert nehmen?
      MausTaste := Sf.Window.Mouse.sfMouseButtonCount;
      MausRad := 0.00;
      
      TasteSchleife:
      while Sf.Graphics.RenderWindow.pollEvent (renderWindow => GrafikEinstellungenSFML.FensterAccess,
                                                event        => ZeichenEingeben)
        = Sf.sfTrue loop
                        
         case
           ZeichenEingeben.eventType
         is
            when Sf.Window.Event.sfEvtClosed =>
               -- Hier noch einen universellen Endebefehl einbauen.
               -- Nur als Zwischenlösung gedacht, später wieder entfernen!
               Fehler.GrafikStopp (FehlermeldungExtern => "");
                  
            when Sf.Window.Event.sfEvtResized =>
               InteraktionGrafiktask.FensterVerändert := InteraktionGrafiktask.Fenster_Verändert;
                  
            when Sf.Window.Event.sfEvtMouseMoved =>
               -- Immer hier die neue Mausposition festlegen, denn es kann/wird bei mehreren gleichzeitigen Mausaufrufen des RenderWindow zu Abstürzen kommen.
               GrafikEinstellungenSFML.MausPosition := (ZeichenEingeben.mouseMove.x, ZeichenEingeben.mouseMove.y);
                  
            when others =>
               null;
         end case;
            
         -- Gäbe es einen Vorteil diesen Teil in jeweils eine eigene Prüfung umzuwandeln? Eventuell um mehrere Dinge gleichzeitig festlegen zu können?
         -- Beeinflusst das nicht auch die Auswertung in EingabeSFML? Hier einzeln durchgehen und dann in EingabeSFML die Auswertungsreihenfolge festlegen?
         case
           ZeichenEingeben.eventType
         is
            when Sf.Window.Event.sfEvtKeyPressed =>
               TastaturTaste := ZeichenEingeben.key.code;
                  
            when Sf.Window.Event.sfEvtMouseWheelScrolled =>
               MausRad := ZeichenEingeben.mouseWheelScroll.eventDelta;
                  
            when Sf.Window.Event.sfEvtMouseButtonPressed =>
               MausTaste := ZeichenEingeben.mouseButton.button;
                  
            when others =>
               null;
         end case;
                     
      end loop TasteSchleife;
      
   end TastenEingabe;
   
   
   
   procedure TextEingeben
   is begin
      
      TasteSchleife:
      while Sf.Graphics.RenderWindow.pollEvent (renderWindow => GrafikEinstellungenSFML.FensterAccess,
                                                event        => TextEingegeben)
        = Sf.sfTrue loop
            
         case
           TextEingegeben.eventType
         is
            when Sf.Window.Event.sfEvtTextEntered =>
               TextPrüfen (UnicodeNummerExtern => TextEingegeben.text.unicode);
               
            when Sf.Window.Event.sfEvtKeyPressed =>
               if
                 TextEingegeben.key.code = Sf.Window.Keyboard.sfKeyEnter
               then
                  ErfolgreichAbbruch := True;
                  InteraktionGrafiktask.TextEingabe := False;
                     
               elsif
                 TextEingegeben.key.code = Sf.Window.Keyboard.sfKeyEscape
               then
                  ErfolgreichAbbruch := False;
                  InteraktionGrafiktask.TextEingabe := False;
                  
               else
                  null;
               end if;
               
            when others =>
               null;
         end case;
         
      end loop TasteSchleife;
      
   end TextEingeben;
   
   
   
   procedure TextPrüfen
     (UnicodeNummerExtern : in Sf.sfUint32)
   is begin
      
      case
        UnicodeNummerExtern
      is
         when 0 .. 7 | 9 .. 31 | 128 .. 159 =>
            return;
            
         when others =>
            EingegebenesZeichen := Wide_Wide_Character'Val (UnicodeNummerExtern);
      end case;
      
      case
        EingegebenesZeichen
      is
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
