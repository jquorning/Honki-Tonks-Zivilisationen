pragma SPARK_Mode (On);

with Sf.Graphics.RenderWindow;
with Sf.Graphics.Color;

with EinheitStadtDatentypen; use EinheitStadtDatentypen;
with GlobaleTexte;
with TextKonstanten;

with EingabeSFML;
with GrafikEinstellungenSFML;
with ObjekteZeichnenSFML;
with EingabeSystemeSFML;
with EinheitenBeschreibungen;
with LeseEinheitenGebaut;
with LeseStadtGebaut;

package body AnzeigeEingabeSFML is

   procedure AnzeigeGanzeZahl
   is begin
      
      WelcheFrage := EingabeSFML.Frage;
      
      Sf.Graphics.Text.setFont (text => TextAccess,
                                font => GrafikEinstellungenSFML.SchriftartAccess);
      Sf.Graphics.Text.setUnicodeString (text => TextAccess,
                                         str  => To_Wide_Wide_String (Source => GlobaleTexte.Frage (WelcheFrage)));
      Sf.Graphics.Text.setCharacterSize (text => TextAccess,
                                         size => Sf.sfUint32 (1.50 * Float (GrafikEinstellungenSFML.FensterEinstellungen.Schriftgröße)));
      Sf.Graphics.Text.setPosition (text     => TextAccess,
                                    position => ((Float (GrafikEinstellungenSFML.AktuelleFensterAuflösung.x) / 2.00
                                                 - Sf.Graphics.Text.getLocalBounds (text => TextAccess).width / 2.00), 100.00));
      Sf.Graphics.Text.setColor (text  => TextAccess,
                                 color => Sf.Graphics.Color.sfRed);
      
      ObjekteZeichnenSFML.RechteckZeichnen (AbmessungExtern      => (Sf.Graphics.Text.getLocalBounds (text => TextAccess).width + 20.00, 100.00),
                                            PositionExtern       => (Sf.Graphics.Text.getPosition (text => TextAccess).x - 10.00, Sf.Graphics.Text.getPosition (text => TextAccess).y - 10.00),
                                            FarbeExtern          => Sf.Graphics.Color.sfBlack,
                                            RechteckAccessExtern => RechteckAccess);
      
      Sf.Graphics.RenderWindow.drawText (renderWindow => GrafikEinstellungenSFML.FensterAccess,
                                         text         => TextAccess);
      
      Sf.Graphics.Text.setCharacterSize (text => TextAccess,
                                         size => GrafikEinstellungenSFML.FensterEinstellungen.Schriftgröße);
      Sf.Graphics.Text.setColor (text  => TextAccess,
                                 color => Sf.Graphics.Color.sfWhite);
      
      WelchesVorzeichen := EingabeSFML.WelchesVorzeichen;
      AktuellerWert := ZahlAlsStringNatural (ZahlExtern => EingabeSFML.AktuellerWert);
      
      case
        WelchesVorzeichen
      is
         when False =>
            AktuellerText := To_Unbounded_Wide_Wide_String (Source => "-") & AktuellerWert;
                              
         when True =>
            AktuellerText := AktuellerWert;         
      end case;
                              
      Sf.Graphics.Text.setUnicodeString (text => TextAccess,
                                         str  => To_Wide_Wide_String (Source => AktuellerText));
      Sf.Graphics.Text.setPosition (text     => TextAccess,
                                    position => ((Float (GrafikEinstellungenSFML.AktuelleFensterAuflösung.x) / 2.00
                                                 - Sf.Graphics.Text.getLocalBounds (text => TextAccess).width / 2.00), 150.00));
      Sf.Graphics.RenderWindow.drawText (renderWindow => GrafikEinstellungenSFML.FensterAccess,
                                         text         => TextAccess);
      
   end AnzeigeGanzeZahl;
   
   
   
   procedure AnzeigeText
   is begin
      
      WelcheFrage := EingabeSFML.Frage;
      
      Sf.Graphics.Text.setFont (text => TextAccess,
                                font => GrafikEinstellungenSFML.SchriftartAccess);
      Sf.Graphics.Text.setUnicodeString (text => TextAccess,
                                         str  => To_Wide_Wide_String (Source => GlobaleTexte.Frage (WelcheFrage)));
      Sf.Graphics.Text.setCharacterSize (text => TextAccess,
                                         size => Sf.sfUint32 (1.50 * Float (GrafikEinstellungenSFML.FensterEinstellungen.Schriftgröße)));
      Sf.Graphics.Text.setPosition (text     => TextAccess,
                                    position => ((Float (GrafikEinstellungenSFML.AktuelleFensterAuflösung.x) / 2.00
                                                 - Sf.Graphics.Text.getLocalBounds (text => TextAccess).width / 2.00), 100.00));
      Sf.Graphics.Text.setColor (text  => TextAccess,
                                 color => Sf.Graphics.Color.sfRed);
      
      ObjekteZeichnenSFML.RechteckZeichnen (AbmessungExtern      => (Sf.Graphics.Text.getLocalBounds (text => TextAccess).width + 20.00, 100.00),
                                            PositionExtern       => (Sf.Graphics.Text.getPosition (text => TextAccess).x - 10.00, Sf.Graphics.Text.getPosition (text => TextAccess).y - 10.00),
                                            FarbeExtern          => Sf.Graphics.Color.sfBlack,
                                            RechteckAccessExtern => RechteckAccess);
      
      Sf.Graphics.RenderWindow.drawText (renderWindow => GrafikEinstellungenSFML.FensterAccess,
                                         text         => TextAccess);
      
      Sf.Graphics.Text.setCharacterSize (text => TextAccess,
                                         size => GrafikEinstellungenSFML.FensterEinstellungen.Schriftgröße);
      Sf.Graphics.Text.setColor (text  => TextAccess,
                                 color => Sf.Graphics.Color.sfWhite);
      
      Sf.Graphics.Text.setUnicodeString (text => TextAccess,
                                         str  => To_Wide_Wide_String (Source => EingabeSystemeSFML.EingegebenerText));
      Sf.Graphics.Text.setPosition (text     => TextAccess,
                                    position => ((Float (GrafikEinstellungenSFML.AktuelleFensterAuflösung.x) / 2.00
                                                 - Sf.Graphics.Text.getLocalBounds (text => TextAccess).width / 2.00), 150.00));
      Sf.Graphics.RenderWindow.drawText (renderWindow => GrafikEinstellungenSFML.FensterAccess,
                                         text         => TextAccess);
      
   end AnzeigeText;
   
   
   
   procedure AnzeigeEinheitenStadt
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      Sf.Graphics.Text.setFont (text => TextAccess,
                                font => GrafikEinstellungenSFML.SchriftartAccess);
      Sf.Graphics.Text.setCharacterSize (text => TextAccess,
                                         size => GrafikEinstellungenSFML.FensterEinstellungen.Schriftgröße);
      Zeilenabstand := Float (GrafikEinstellungenSFML.FensterEinstellungen.Schriftgröße) * 0.15;
      
      AktuelleAuswahl := AuswahlStadtEinheit.AktuelleAuswahl;
      WelcheAuswahl := AuswahlStadtEinheit.WelcheAuswahl;
      TextPosition := (Float (GrafikEinstellungenSFML.AktuelleFensterAuflösung.x) / 2.00, Float (GrafikEinstellungenSFML.AktuelleFensterAuflösung.y) / 2.00);
      
      AuswahlSchleife:
      for AuswahlSchleifenwert in WelcheAuswahl.MöglicheAuswahlen'Range loop
         
         if
           AuswahlSchleifenwert = WelcheAuswahl.MöglicheAuswahlen'First
         then
            case
              WelcheAuswahl.StadtEinheit
            is
               when True =>
                  Sf.Graphics.Text.setUnicodeString (text => TextAccess,
                                                     str  => To_Wide_Wide_String (Source => GlobaleTexte.ZeugSachen (TextKonstanten.ZeugStadt))
                                                     & To_Wide_Wide_String (Source => LeseStadtGebaut.Name (StadtRasseNummerExtern => (RasseExtern, WelcheAuswahl.MöglicheAuswahlen (0)))));
         
               when False =>
                  Sf.Graphics.Text.setUnicodeString (text => TextAccess,
                                                     str  => EinheitenBeschreibungen.BeschreibungKurz (IDExtern => LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => (RasseExtern, WelcheAuswahl.MöglicheAuswahlen (0)))));
            end case;
            
         else
            if
              WelcheAuswahl.MöglicheAuswahlen (AuswahlSchleifenwert) = EinheitStadtDatentypen.MaximaleEinheitenMitNullWert'First
            then
               null;
               
            else
               Sf.Graphics.Text.setUnicodeString (text => TextAccess,
                                                  str  => EinheitenBeschreibungen.BeschreibungKurz
                                                    (IDExtern => LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => (RasseExtern, WelcheAuswahl.MöglicheAuswahlen (AuswahlSchleifenwert)))));
            end if;
         end if;
            
         if
           -- Hier besser MaximaleStädteMitNullWert prüfen, wenn gleich es auch mit MaximaleEinheitenMitNullWert gehen sollte.
           WelcheAuswahl.MöglicheAuswahlen (AuswahlSchleifenwert) = EinheitStadtDatentypen.MaximaleStädteMitNullWert'First
         then
            null;
         
         else
            if
              AktuelleAuswahl = Natural (AuswahlSchleifenwert)
            then
               Sf.Graphics.Text.setColor (text  => TextAccess,
                                          color => GrafikEinstellungenSFML.Schriftfarben.FarbeAusgewähltText);
         
            else
               Sf.Graphics.Text.setColor (text  => TextAccess,
                                          color => GrafikEinstellungenSFML.Schriftfarben.FarbeStandardText);
            end if;
            Sf.Graphics.Text.setPosition (text     => TextAccess,
                                          position => (TextPosition.x - Sf.Graphics.Text.getLocalBounds (text => TextAccess).width / 2.00, TextPosition.y));
            Sf.Graphics.RenderWindow.drawText (renderWindow => GrafikEinstellungenSFML.FensterAccess,
                                               text         => TextAccess);
            TextPosition.y := TextPosition.y + Sf.Graphics.Text.getLocalBounds (text => TextAccess).height + 3.00 * Zeilenabstand;
         end if;
         
      end loop AuswahlSchleife;
            
   end AnzeigeEinheitenStadt;

end AnzeigeEingabeSFML;