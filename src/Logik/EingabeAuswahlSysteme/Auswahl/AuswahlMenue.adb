pragma SPARK_Mode (On);

with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

with Sf;

with SystemDatentypen; use SystemDatentypen;
with GlobaleTexte;
with SystemKonstanten;

with GrafikEinstellungenSFML;
with Eingabe;
with AllgemeineTextBerechnungenSFML;
with RueckgabeMenues;
with InteraktionGrafiktask;

package body AuswahlMenue is

   function AuswahlMenü
     (WelchesMenüExtern : in SystemDatentypen.Welches_Menü_Enum)
      return SystemDatentypen.Rückgabe_Werte_Enum
   is begin
      
      AllgemeinesFestlegen (WelchesMenüExtern => WelchesMenüExtern);
      InteraktionGrafiktask.AktuelleDarstellungÄndern (DarstellungExtern => SystemDatentypen.Grafik_Menüs);
      
      Auswahl;
   
      RückgabeWert := RueckgabeMenues.RückgabeMenüs (AnfangExtern          => Anfang,
                                                        EndeExtern            => Ende,
                                                        AktuelleAuswahlExtern => AktuelleAuswahl,
                                                        WelchesMenüExtern     => WelchesMenü);
      
      InteraktionGrafiktask.AktuelleDarstellungÄndern (DarstellungExtern => SystemDatentypen.Grafik_Pause);
      
      return RückgabeWert;
      
   end AuswahlMenü;

   

   procedure AllgemeinesFestlegen
     (WelchesMenüExtern : in SystemDatentypen.Welches_Menü_Enum)
   is begin

      WelchesMenü := WelchesMenüExtern;
     
      Sf.Graphics.Text.setFont (text => TextAccess,
                                font => GrafikEinstellungenSFML.SchriftartAccess);
            
      Anfang := AnfangEndeMenü (WelchesMenüExtern, SystemDatentypen.Anfangswert);
      Ende := AnfangEndeMenü (WelchesMenüExtern, SystemDatentypen.Endwert);
      ZeilenAbstand := 0.50 * Float (GrafikEinstellungenSFML.FensterEinstellungen.Schriftgröße);
      
      if
        LetztesMenü = WelchesMenüExtern
      then
         if
           AktuelleAuswahl < AnfangEndeMenü (WelchesMenüExtern, SystemDatentypen.Anfangswert)
         then
            AktuelleAuswahl := AnfangEndeMenü (WelchesMenüExtern, SystemDatentypen.Anfangswert);

         elsif
           AktuelleAuswahl > AnfangEndeMenü (WelchesMenüExtern, SystemDatentypen.Endwert)
         then
            AktuelleAuswahl := AnfangEndeMenü (WelchesMenüExtern, SystemDatentypen.Endwert);

         else
            null;
         end if;
         
      else
         AktuelleAuswahl := AnfangEndeMenü (WelchesMenüExtern, SystemDatentypen.Anfangswert);
         LetztesMenü := WelchesMenüExtern;
      end if;
      
      case
        AnfangEndeMenü (WelchesMenü, SystemDatentypen.Anfangswert) mod 2
      is
         when 0 =>
            AnzeigeStartwert := 0;
            
         when others =>
            AnzeigeStartwert := 1;
      end case;

   end AllgemeinesFestlegen;

      
   
   procedure Auswahl
   is begin
      
      AuswahlSchleife:
      loop
      
         MausAuswahl;
      
         case
           Eingabe.Tastenwert
         is
            when SystemDatentypen.Oben | SystemDatentypen.Ebene_Hoch =>
               if
                 AktuelleAuswahl = Anfang
               then
                  AktuelleAuswahl := Ende;

               else
                  AktuelleAuswahl := AktuelleAuswahl - 1;
               end if;

            when SystemDatentypen.Unten | SystemDatentypen.Ebene_Runter =>
               if
                 AktuelleAuswahl = Ende
               then
                  AktuelleAuswahl := Anfang;

               else
                  AktuelleAuswahl := AktuelleAuswahl + 1;
               end if;
               
               -- Später noch erweitern?
            when SystemDatentypen.Links =>
               null;
               
            when SystemDatentypen.Rechts =>
               null;
                              
            when SystemDatentypen.Auswählen =>
               return;
            
            when others =>
               null;
         end case;
         
      end loop AuswahlSchleife;
      
   end Auswahl;
   
         
   
   procedure MausAuswahl
   is begin
      
      -- Niemals direkt die Mausposition abrufen sondern immer die Werte in der Eingabe ermitteln lassen. Sonst kann es zu einem Absturz kommen.
      MausZeigerPosition := GrafikEinstellungenSFML.MausPosition;
      
      Sf.Graphics.Text.setUnicodeString (text => TextAccess,
                                         str  => StringSetzen (WelcheZeileExtern => 1,
                                                               WelchesMenüExtern => WelchesMenü));
      Sf.Graphics.Text.setCharacterSize (text => TextAccess,
                                         size => Sf.sfUint32 (1.50 * Float (GrafikEinstellungenSFML.FensterEinstellungen.Schriftgröße)));
      TextPositionMaus.y := StartPositionYAchse + Sf.Graphics.Text.getLocalBounds (text => TextAccess).height + ZeilenAbstand;
      Sf.Graphics.Text.setCharacterSize (text => TextAccess,
                                         size => GrafikEinstellungenSFML.FensterEinstellungen.Schriftgröße);
      
      MausZeigerSchleife:
      for ZeileSchleifenwert in Anfang .. Ende loop
         
         Sf.Graphics.Text.setUnicodeString (text => TextAccess,
                                            str  => StringSetzen (WelcheZeileExtern => ZeileSchleifenwert,
                                                                  WelchesMenüExtern => WelchesMenü));
         
         case
           (ZeileSchleifenwert + AnzeigeStartwert) mod 2
         is
            when 0 =>
               TextPositionMaus.x := AllgemeineTextBerechnungenSFML.TextViertelPositionErmittelnLogik (TextAccessExtern => TextAccess,
                                                                                                       LinksRechtsExtern => False);
               
            when others =>
               TextPositionMaus.x := AllgemeineTextBerechnungenSFML.TextViertelPositionErmittelnLogik (TextAccessExtern => TextAccess,
                                                                                                       LinksRechtsExtern => True);
         end case;
         
         if
           MausZeigerPosition.y in Sf.sfInt32 (TextPositionMaus.y)
           .. Sf.sfInt32 (TextPositionMaus.y + Sf.Graphics.Text.getLocalBounds (text => TextAccess).height)
           and
             MausZeigerPosition.x in Sf.sfInt32 (TextPositionMaus.x) .. Sf.sfInt32 (TextPositionMaus.x + Sf.Graphics.Text.getLocalBounds (text => TextAccess).width)
         then
            AktuelleAuswahl := ZeileSchleifenwert;
            return;
         
         else
            null;
         end if;
         
         case
           (ZeileSchleifenwert + AnzeigeStartwert) mod 2
         is
            when 0 =>
               null;
               
            when others =>
               TextPositionMaus.y := TextPositionMaus.y + Sf.Graphics.Text.getLocalBounds (text => TextAccess).height + ZeilenAbstand;
         end case;   
                  
      end loop MausZeigerSchleife;
      
   end MausAuswahl;
   
   
   
   function StringSetzen
     (WelcheZeileExtern : in Positive;
      WelchesMenüExtern : in SystemDatentypen.Welches_Menü_Enum)
      return Wide_Wide_String
   is begin
      
      -- Bei zu langem Text keinen leeren String zurückgeben sondern das Programm stoppen?
      case
        WelchesMenüExtern
      is
         when SystemDatentypen.Haupt_Menü =>
            if
              WelcheZeileExtern > GlobaleTexte.Hauptmenü'Last
            then
               null;
               
            else
               return To_Wide_Wide_String (Source => GlobaleTexte.Hauptmenü (WelcheZeileExtern));
            end if;
            
         when SystemDatentypen.Spiel_Menü =>
            if
              WelcheZeileExtern > GlobaleTexte.Spielmenü'Last
            then
               null;
               
            else
               return To_Wide_Wide_String (Source => GlobaleTexte.Spielmenü (WelcheZeileExtern));
            end if;
            
         when SystemDatentypen.Optionen_Menü =>
            if
              WelcheZeileExtern > GlobaleTexte.Optionsmenü'Last
            then
               null;
               
            else
               return To_Wide_Wide_String (Source => GlobaleTexte.Optionsmenü (WelcheZeileExtern));
            end if;
            
         when SystemDatentypen.Kartengröße_Menü =>
            if
              WelcheZeileExtern > GlobaleTexte.Kartengröße'Last
            then
               null;
               
            else
               return To_Wide_Wide_String (Source => GlobaleTexte.Kartengröße (WelcheZeileExtern));
            end if;
            
         when SystemDatentypen.Kartenart_Menü =>
            if
              WelcheZeileExtern > GlobaleTexte.Kartenart'Last
            then
               null;
               
            else
               return To_Wide_Wide_String (Source => GlobaleTexte.Kartenart (WelcheZeileExtern));
            end if;
            
         when SystemDatentypen.Kartenform_Menü =>
            if
              WelcheZeileExtern > GlobaleTexte.Kartenform'Last
            then
               null;
               
            else
               return To_Wide_Wide_String (Source => GlobaleTexte.Kartenform (WelcheZeileExtern));
            end if;
            
         when SystemDatentypen.Kartentemperatur_Menü =>
            if
              WelcheZeileExtern > GlobaleTexte.Kartentemperatur'Last
            then
               null;
               
            else
               return To_Wide_Wide_String (Source => GlobaleTexte.Kartentemperatur (WelcheZeileExtern));
            end if;
            
         when SystemDatentypen.Kartenressourcen_Menü =>
            if
              WelcheZeileExtern > GlobaleTexte.Ressourcenmenge'Last
            then
               null;
               
            else
               return To_Wide_Wide_String (Source => GlobaleTexte.Ressourcenmenge (WelcheZeileExtern));
            end if;
            
         when SystemDatentypen.Schwierigkeitsgrad_Menü =>
            if
              WelcheZeileExtern > GlobaleTexte.Schwierigkeitsgrad'Last
            then
               null;
               
            else
               return To_Wide_Wide_String (Source => GlobaleTexte.Schwierigkeitsgrad (WelcheZeileExtern));
            end if;
                        
         when SystemDatentypen.Rassen_Menü =>
            if
              WelcheZeileExtern > GlobaleTexte.Rassenauswahl'Last
            then
               null;
               
            else
               return To_Wide_Wide_String (Source => GlobaleTexte.Rassenauswahl (WelcheZeileExtern));
            end if;
            
         when SystemDatentypen.Grafik_Menü =>
            if
              WelcheZeileExtern > GlobaleTexte.Grafikmenü'Last
            then
               null;
               
            else
               return To_Wide_Wide_String (Source => GlobaleTexte.Grafikmenü (WelcheZeileExtern));
            end if;
            
         when SystemDatentypen.Sound_Menü =>
            if
              WelcheZeileExtern > GlobaleTexte.Soundmenü'Last
            then
               null;
               
            else
               return To_Wide_Wide_String (Source => GlobaleTexte.Soundmenü (WelcheZeileExtern));
            end if;
            
         when SystemDatentypen.Sonstiges_Menü =>
            if
              WelcheZeileExtern > GlobaleTexte.Sonstigesmenü'Last
            then
               null;
               
            else
               return To_Wide_Wide_String (Source => GlobaleTexte.Sonstigesmenü (WelcheZeileExtern));
            end if;
            
         when SystemDatentypen.Steuerung_Menü =>
            if
              WelcheZeileExtern > GlobaleTexte.Steuerungmenü'Last
            then
               null;
               
            else
               return To_Wide_Wide_String (Source => GlobaleTexte.Steuerungmenü (WelcheZeileExtern));
            end if;
            
         when SystemDatentypen.Editoren_Menü =>
            if
              WelcheZeileExtern > GlobaleTexte.Editoren'Last
            then
               null;
               
            else
               return To_Wide_Wide_String (Source => GlobaleTexte.Editoren (WelcheZeileExtern));
            end if;
      end case;
      
      return SystemKonstanten.LeerString;
      
   end StringSetzen;
   
end AuswahlMenue;
