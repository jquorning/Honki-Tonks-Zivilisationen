pragma SPARK_Mode (On);

with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

with Sf.Graphics.RenderWindow;

with GrafikEinstellungen;

package body TextAnzeigeSFML is

   procedure AnzeigeMitAuswahl
     (FrageDateiExtern : in GlobaleTexte.Welche_Datei_Enum;
      TextDateiExtern : in GlobaleTexte.Welche_Datei_Enum;
      FrageZeileExtern : in Natural;
      ErsteZeileExtern : in Natural;
      LetzteZeileExtern : in Natural;
      AktuelleAuswahlExtern : in Positive)
   is begin
      
      -- GrafikAllgemein.FensterLeeren;
      
      -- TextAccess := GrafikEinstellungen.TextStandard;
      
      case
        FrageDateiExtern
      is
         when GlobaleTexte.Leer =>
            ÜberschriftAbstand := 0;

         when others =>
            ÜberschriftAbstand := 1;
            AktuelleTextFarbe := Sf.Graphics.Color.sfRed;
            TextSetzen (TextExtern        => To_Wide_Wide_String (Source => GlobaleTexte.TexteEinlesen (GlobaleTexte.Welche_Datei_Enum'Pos (FrageDateiExtern), FrageZeileExtern)),
                        TextAccessExtern => TextAccess);
            TextZeichnen (PositionExtern    => (TextMittelPositionErmitteln (TextAccessExtern => TextAccess), StartPositionYAchse),
                          TextAccessExtern => TextAccess);
      end case;
      
      ZeilenAbstand := 1.25 * Float (GrafikEinstellungen.FensterEinstellungen.Schriftgröße);
      AktuelleZeile := 0;
      
      if
        LetzteZeileExtern - ErsteZeileExtern > 11
      then
         TextAnfang := ErsteZeileExtern;
         TextEnde := LetzteZeileExtern;
         
      else
         TextAnfang := ErsteZeileExtern;
         TextEnde := LetzteZeileExtern;
      end if;
      
      AnzeigeSchleife:
      for ZeileSchleifenwert in TextAnfang .. TextEnde loop
                  
         if
           AktuelleAuswahlExtern - ZeileSchleifenwert < -5
         then
            exit AnzeigeSchleife;
            
         elsif
           AktuelleAuswahlExtern - ZeileSchleifenwert > 5
         then
            null;
            
         else
            AnzeigeSelbst (TextDateiExtern        => TextDateiExtern,
                           AktuelleAuswahlExtern  => AktuelleAuswahlExtern,
                           AktuelleZeileExtern    => ZeileSchleifenwert);
            
            AktuelleZeile := AktuelleZeile + 1;
         end if;
         
      end loop AnzeigeSchleife;
      
      -- GrafikAllgemein.FensterAnzeigen;
      
   end AnzeigeMitAuswahl;
   
   
   
   procedure TextSetzen
     (TextExtern : in Wide_Wide_String;
      TextAccessExtern : in Sf.Graphics.sfText_Ptr)
   is begin
      
      Sf.Graphics.Text.setUnicodeString (text => TextAccessExtern,
                                         str  => TextExtern);
      
   end TextSetzen;
   
   
   
   procedure TextZeichnen
     (PositionExtern : in Sf.System.Vector2.sfVector2f;
      TextAccessExtern : in Sf.Graphics.sfText_Ptr)
   is begin
            
      Sf.Graphics.Text.setPosition (text     => TextAccessExtern,
                                    position => PositionExtern);
      Sf.Graphics.Text.setColor (text  => TextAccessExtern,
                                 color => AktuelleTextFarbe);
      Sf.Graphics.RenderWindow.drawText (renderWindow => GrafikEinstellungen.FensterAccess,
                                         text         => TextAccessExtern);
      
   end TextZeichnen;
   
   
   
   function TextMittelPositionErmitteln
     (TextAccessExtern : in Sf.Graphics.sfText_Ptr)
      return Float
   is begin
      
      return (Float (GrafikEinstellungen.AktuelleFensterAuflösung.x) / 2.00 - Sf.Graphics.Text.getLocalBounds (text => TextAccessExtern).width / 2.00);
      
   end TextMittelPositionErmitteln;
   
   
   
   procedure AnzeigeSelbst
     (TextDateiExtern : in GlobaleTexte.Welche_Datei_Enum;
      AktuelleAuswahlExtern : in Natural;
      AktuelleZeileExtern : in Positive)
   is begin
      
      TextSetzen (TextExtern        => To_Wide_Wide_String (Source => GlobaleTexte.TexteEinlesen (GlobaleTexte.Welche_Datei_Enum'Pos (TextDateiExtern), AktuelleZeileExtern)),
                  TextAccessExtern => TextAccess);
      
      if
        AktuelleAuswahlExtern = AktuelleZeileExtern
      then
         AktuelleTextFarbe := Sf.Graphics.Color.sfGreen;
         
      else
         AktuelleTextFarbe := Sf.Graphics.Color.sfWhite;
      end if;
      
      TextZeichnen (PositionExtern    => (TextMittelPositionErmitteln (TextAccessExtern => TextAccess), ZeilenPositionErmitteln),
                    TextAccessExtern => TextAccess);
      
   end AnzeigeSelbst;
   
   
   
   function ZeilenPositionErmitteln
     return Float
   is begin
      
      return StartPositionYAchse + Float ((ÜberschriftAbstand + AktuelleZeile)) * ZeilenAbstand;
      
   end ZeilenPositionErmitteln;
   
   
   
   procedure AnzeigeOhneAuswahl
     (ÜberschriftDateiExtern : in GlobaleTexte.Welche_Datei_Enum;
      TextDateiExtern : in GlobaleTexte.Welche_Datei_Enum;
      ÜberschriftZeileExtern : in Natural;
      ErsteZeileExtern : in Positive;
      LetzteZeileExtern : in Positive)
   is begin
      
      -- GrafikAllgemein.FensterLeeren;
      
      -- TextAccess := GrafikEinstellungen.TextStandard;
      
      case
        ÜberschriftDateiExtern
      is
         when GlobaleTexte.Leer =>
            ÜberschriftAbstand := 0;

         when others =>
            ÜberschriftAbstand := 1;
            AktuelleTextFarbe := Sf.Graphics.Color.sfRed;
            TextSetzen (TextExtern        => To_Wide_Wide_String (Source => GlobaleTexte.TexteEinlesen (GlobaleTexte.Welche_Datei_Enum'Pos (ÜberschriftDateiExtern), ÜberschriftZeileExtern)),
                        TextAccessExtern => TextAccess);
            TextZeichnen (PositionExtern    => (TextMittelPositionErmitteln (TextAccessExtern => TextAccess), StartPositionYAchse),
                          TextAccessExtern => TextAccess);
      end case;
      
      ZeilenAbstand := 1.25 * Float (GrafikEinstellungen.FensterEinstellungen.Schriftgröße);
      AktuelleZeile := 0;
      
      TextAnzeigeSchleife:
      for TextZeileSchleifenwert in ErsteZeileExtern .. LetzteZeileExtern loop
         
         AnzeigeSelbst (TextDateiExtern       => TextDateiExtern,
                        AktuelleAuswahlExtern => 0,
                        AktuelleZeileExtern   => TextZeileSchleifenwert);
            
         AktuelleZeile := AktuelleZeile + 1;

      end loop TextAnzeigeSchleife;
      
      -- GrafikAllgemein.FensterAnzeigen;
      
   end AnzeigeOhneAuswahl;

end TextAnzeigeSFML;
