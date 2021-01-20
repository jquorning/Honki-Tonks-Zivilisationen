package body Anzeige is

   procedure Anzeige (WelcherText, AktuelleAuswahl : in Integer) is
   begin

      LängsterText := 1;
      
      TextlängePrüfenSchleife:
      for A in GlobaleVariablen.TexteEinlesen'Range (2) loop
         if To_Wide_Wide_String (Source => GlobaleVariablen.TexteEinlesen (WelcherText, A)) = "|" then
            exit TextlängePrüfenSchleife;
            
         elsif To_Wide_Wide_String (Source => GlobaleVariablen.TexteEinlesen (WelcherText, A))'Length > LängsterText then
            LängsterText := To_Wide_Wide_String (Source => GlobaleVariablen.TexteEinlesen (WelcherText, A))'Length;
            
         else
            null;
         end if;
      end loop TextlängePrüfenSchleife;
      
      AnzeigeSchleife:
      for A in GlobaleVariablen.TexteEinlesen'Range (2) loop

         if AktuelleAuswahl = A then
            for B in 1 .. LängsterText loop

               if To_Wide_Wide_String (Source => GlobaleVariablen.TexteEinlesen (WelcherText, A)) = "|" then
                  exit AnzeigeSchleife;
                  
               elsif B = 1 then
                  Put (Item => "╔");
                  Put (Item => "═");

               elsif B = LängsterText then                  
                  Put (Item => "═");
                  Put_Line (Item => "╗");
                  Put (Item => "║");
                  Put (Item => To_Wide_Wide_String (Source => GlobaleVariablen.TexteEinlesen (WelcherText, A)));

                  for Leer in 1 .. LängsterText - To_Wide_Wide_String (Source => GlobaleVariablen.TexteEinlesen (WelcherText, A))'Length loop
                        
                     Put (" ");
                        
                  end loop;
                  Put_Line (Item => "║");
                  Put (Item => "╚");

               else
                  Put (Item => "═");
               end if;
               
            end loop;

            for C in 1 .. LängsterText loop
               
               if C = LängsterText then
                  Put (Item => "═");
                  Put_Line (Item => "╝");
               
               else
                  Put (Item => "═");
               end if;
            
            end loop;
         
         else
            if To_Wide_Wide_String (Source => GlobaleVariablen.TexteEinlesen (WelcherText, A)) = "|" then
               exit AnzeigeSchleife; 
            
            else
               Put_Line (Item => To_Wide_Wide_String (Source => GlobaleVariablen.TexteEinlesen (WelcherText, A)));
            end if;
         end if;
         
      end loop AnzeigeSchleife;
   
   end Anzeige;



   procedure AnzeigeStadt (AktuelleAuswahl : in Positive) is
   begin
      
      LängsterText := 1;
      
      TextlängePrüfenSchleife:
      for A in GlobaleVariablen.TexteEinlesen'Range (2) loop
         if To_Wide_Wide_String (Source => TextBauen (A).Text) = "|" then
            exit TextlängePrüfenSchleife;
            
         elsif To_Wide_Wide_String (Source => TextBauen (A).Text)'Length > LängsterText then
            LängsterText := To_Wide_Wide_String (Source => TextBauen (A).Text)'Length;
            
         else
            null;
         end if;
      end loop TextlängePrüfenSchleife;
      
      AnzeigeSchleife:
      for A in GlobaleVariablen.TexteEinlesen'Range (2) loop

         if AktuelleAuswahl = A then
            for B in 1 .. LängsterText loop

               if To_Wide_Wide_String (Source => TextBauen (A).Text) = "|" then
                  exit AnzeigeSchleife;
                  
               elsif B = 1 then
                  Put (Item => "╔");
                  Put (Item => "═");

               elsif B = LängsterText then                  
                  Put (Item => "═");
                  Put_Line (Item => "╗");
                  Put (Item => "║");
                  Put (Item => To_Wide_Wide_String (Source => TextBauen (A).Text));

                  for Leer in 1 .. LängsterText - To_Wide_Wide_String (Source => TextBauen (A).Text)'Length loop
                        
                     Put (" ");
                        
                  end loop;
                  Put_Line (Item => "║");
                  Put (Item => "╚");

               else
                  Put (Item => "═");
               end if;
               
            end loop;

            for C in 1 .. LängsterText loop
               
               if C = LängsterText then
                  Put (Item => "═");
                  Put_Line (Item => "╝");
               
               else
                  Put (Item => "═");
               end if;
            
            end loop;
         
         else
            if To_Wide_Wide_String (Source => TextBauen (A).Text) = "|" then
               exit AnzeigeSchleife; 
            
            else
               Put_Line (Item => To_Wide_Wide_String (Source => TextBauen (A).Text));
            end if;
         end if;
         
      end loop AnzeigeSchleife;
      
   end AnzeigeStadt;



   procedure AnzeigeForschung (AktuelleAuswahl : in Positive) is
   begin
      
      LängsterText := 1;
      
      TextlängePrüfenSchleife:
      for A in GlobaleVariablen.TexteEinlesen'Range (2) loop
         if To_Wide_Wide_String (Source => TextForschung (A).Text) = "|" then
            exit TextlängePrüfenSchleife;
            
         elsif To_Wide_Wide_String (Source => TextForschung (A).Text)'Length > LängsterText then
            LängsterText := To_Wide_Wide_String (Source => TextForschung (A).Text)'Length;
            
         else
            null;
         end if;
      end loop TextlängePrüfenSchleife;
      
      AnzeigeSchleife:
      for A in GlobaleVariablen.TexteEinlesen'Range (2) loop

         if AktuelleAuswahl = A then
            for B in 1 .. LängsterText loop

               if To_Wide_Wide_String (Source => TextForschung (A).Text) = "|" then
                  exit AnzeigeSchleife;
                  
               elsif B = 1 then
                  Put (Item => "╔");
                  Put (Item => "═");

               elsif B = LängsterText then                  
                  Put (Item => "═");
                  Put_Line (Item => "╗");
                  Put (Item => "║");
                  Put (Item => To_Wide_Wide_String (Source => TextForschung (A).Text));

                  for Leer in 1 .. LängsterText - To_Wide_Wide_String (Source => TextForschung (A).Text)'Length loop
                        
                     Put (" ");
                        
                  end loop;
                  Put_Line (Item => "║");
                  Put (Item => "╚");

               else
                  Put (Item => "═");
               end if;
               
            end loop;

            for C in 1 .. LängsterText loop
               
               if C = LängsterText then
                  Put (Item => "═");
                  Put_Line (Item => "╝");
               
               else
                  Put (Item => "═");
               end if;
            
            end loop;
         
         else
            if To_Wide_Wide_String (Source => TextForschung (A).Text) = "|" then
               exit AnzeigeSchleife; 
            
            else
               Put_Line (Item => To_Wide_Wide_String (Source => TextForschung (A).Text));
            end if;
         end if;
         
      end loop AnzeigeSchleife;
      
   end AnzeigeForschung;



   procedure AnzeigeLangerText (WelcherText, WelcheZeile : in Positive) is
   begin
      
      Text := (others => ('|'));
      N := 1;
      New_Line;

      for A in To_Wide_Wide_String (Source => GlobaleVariablen.TexteEinlesen (WelcherText, WelcheZeile))'Range loop
         
         if To_Wide_Wide_String (Source => GlobaleVariablen.TexteEinlesen (WelcherText, WelcheZeile)) (A) = '|' then
            exit;
            
            else
               Text (A) := To_Wide_Wide_String (Source => GlobaleVariablen.TexteEinlesen (WelcherText, WelcheZeile)) (A);
         end if;
         
      end loop;
      
      for B in Text'Range loop
         
         if Text (B) = '|' then
            exit;
            
         elsif B - 80 * N > 1 then
            if Text (B) = ' ' then
               N := N + 1;
               New_Line;
               
            else
               Put (Item => Text (B));
            end if;
            
         else
            Put (Item => Text (B));
         end if;
         
      end loop;
      New_Line;
      
   end AnzeigeLangerText;



   procedure AnzeigeNeu (AuswahlOderAnzeige : in Boolean; FrageDatei, FrageZeile, TextDatei, ErsteZeile, LetzteZeile : in Integer) is
   begin
      
      Get_Immediate (Item => Taste);
      
   end AnzeigeNeu;



   procedure RassenBeschreibung (WelcheRasse : in GlobaleDatentypen.Rassen) is
   begin
      
      null; -- Hier kann der Standardansatz nicht verwendet werden, den einfügen den ich habe, ist in Anzeige
      
   end RassenBeschreibung;
   
   
   
   procedure Zeug (WelchesZeug : in Positive) is
   begin
      
      Put_Line (Item => To_Wide_Wide_String (Source => GlobaleVariablen.TexteEinlesen (19, WelchesZeug)));
      
   end Zeug;



   procedure Fehlermeldungen (WelcheFehlermeldung : in Positive) is
   begin
      
      Put_Line (Item => To_Wide_Wide_String (Source => GlobaleVariablen.TexteEinlesen (20, WelcheFehlermeldung)));
      delay 1.5;
      
   end Fehlermeldungen;



   procedure WelcheAuswahl (WasWurdeGewählt : in Positive) is
   begin
      
      Put_Line (Item => To_Wide_Wide_String (Source => GlobaleVariablen.TexteEinlesen (21, WasWurdeGewählt)));
      
   end WelcheAuswahl;



   procedure TexteEinlesenAusgabe (WelcheDatei, WelcherText : in Positive) is
   begin
      
      Put_Line (Item => To_Wide_Wide_String (Source => GlobaleVariablen.TexteEinlesen (WelcheDatei, WelcherText)));
      
   end TexteEinlesenAusgabe;


end Anzeige;
