pragma SPARK_Mode (On);

with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

with Sf;

with SystemDatentypen; use SystemDatentypen;
with GlobaleTexte;

with GrafikEinstellungen;
with Eingabe;
with AllgemeineTextBerechnungenSFML;
with RueckgabeMenues;
with GrafikWichtigeEinstellungen;

package body AuswahlMenue is

   function AuswahlMenü
     (WelchesMenüExtern : in SystemDatentypen.Welches_Menü_Enum)
      return SystemDatentypen.Rückgabe_Werte_Enum
   is begin
      
      AllgemeinesFestlegen (WelchesMenüExtern => WelchesMenüExtern);
      GrafikWichtigeEinstellungen.AktuelleDarstellung := SystemDatentypen.Grafik_Menüs;
      
      Auswahl;
   
      RückgabeWert := RueckgabeMenues.RückgabeMenüs (AnfangExtern          => Anfang,
                                                        EndeExtern            => Ende,
                                                        AktuelleAuswahlExtern => AktuelleAuswahl,
                                                        WelchesMenüExtern     => WelchesMenü);
      
      GrafikWichtigeEinstellungen.AktuelleDarstellung := SystemDatentypen.Grafik_Pause;
      
      return RückgabeWert;
      
   end AuswahlMenü;

   

   procedure AllgemeinesFestlegen
     (WelchesMenüExtern : in SystemDatentypen.Welches_Menü_Enum)
   is begin

      WelchesMenü := WelchesMenüExtern;
      Sf.Graphics.Text.setFont (text => TextAccess,
                                font => GrafikEinstellungen.Schriftart);
      Anfang := AnfangEndeMenü (WelchesMenüExtern, SystemDatentypen.Anfangswert);
      Ende := AnfangEndeMenü (WelchesMenüExtern, SystemDatentypen.Endwert);
      ZeilenAbstand := 0.50 * Float (GrafikEinstellungen.FensterEinstellungen.Schriftgröße);
      
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
   
         
   
   procedure MausAuswahl
   is begin
      
      -- Niemals direkt die Mausposition abrufen sondern immer die Werte in der Eingabe ermitteln lassen. Sonst kann es zu einem Absturz kommen.
      MausZeigerPosition := GrafikEinstellungen.MausPosition;
      
      Sf.Graphics.Text.setUnicodeString (text => TextAccess,
                                         str  => StringSetzen (WelcheZeileExtern => 1,
                                                               WelchesMenüExtern => WelchesMenü));
      Sf.Graphics.Text.setCharacterSize (text => TextAccess,
                                         size => Sf.sfUint32 (1.50 * Float (GrafikEinstellungen.FensterEinstellungen.Schriftgröße)));
      TextPositionMaus.y := StartPositionYAchse + Sf.Graphics.Text.getLocalBounds (text => TextAccess).height + ZeilenAbstand;
      Sf.Graphics.Text.setCharacterSize (text => TextAccess,
                                         size => GrafikEinstellungen.FensterEinstellungen.Schriftgröße);
      
      MausZeigerSchleife:
      for ZeileSchleifenwert in Anfang .. Ende loop
         
         Sf.Graphics.Text.setUnicodeString (text => TextAccess,
                                            str  => StringSetzen (WelcheZeileExtern => ZeileSchleifenwert,
                                                                  WelchesMenüExtern => WelchesMenü));
         
         case
           (ZeileSchleifenwert + AnzeigeStartwert) mod 2
         is
            when 0 =>
               TextPositionMaus.x := AllgemeineTextBerechnungenSFML.TextViertelPositionErmitteln (TextAccessExtern => TextAccess,
                                                                                                  LinksRechtsExtern => False);
               
            when others =>
               TextPositionMaus.x := AllgemeineTextBerechnungenSFML.TextViertelPositionErmitteln (TextAccessExtern => TextAccess,
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
   
   
   
   function StringSetzen
     (WelcheZeileExtern : in Positive;
      WelchesMenüExtern : in SystemDatentypen.Welches_Menü_Enum)
      return Wide_Wide_String
   is begin
      
      case
        WelchesMenüExtern
      is
         when SystemDatentypen.Haupt_Menü =>
            return To_Wide_Wide_String (Source => GlobaleTexte.Hauptmenü (WelcheZeileExtern));
            
         when SystemDatentypen.Spiel_Menü =>
            return To_Wide_Wide_String (Source => GlobaleTexte.Spielmenü (WelcheZeileExtern));
            
         when SystemDatentypen.Optionen_Menü =>
            return To_Wide_Wide_String (Source => GlobaleTexte.Optionsmenü (WelcheZeileExtern));
            
         when SystemDatentypen.Kartengröße_Menü =>
            return To_Wide_Wide_String (Source => GlobaleTexte.Kartengröße (WelcheZeileExtern));
            
         when SystemDatentypen.Kartenart_Menü =>
            return To_Wide_Wide_String (Source => GlobaleTexte.Kartenart (WelcheZeileExtern));
            
         when SystemDatentypen.Kartenform_Menü =>
            return To_Wide_Wide_String (Source => GlobaleTexte.Kartenform (WelcheZeileExtern));
            
         when SystemDatentypen.Kartentemperatur_Menü =>
            return To_Wide_Wide_String (Source => GlobaleTexte.Kartentemperatur (WelcheZeileExtern));
            
         when SystemDatentypen.Kartenressourcen_Menü =>
            return To_Wide_Wide_String (Source => GlobaleTexte.Ressourcenmenge (WelcheZeileExtern));
            
         when SystemDatentypen.Schwierigkeitsgrad_Menü =>
            return To_Wide_Wide_String (Source => GlobaleTexte.Schwierigkeitsgrad (WelcheZeileExtern));
                        
         when SystemDatentypen.Rassen_Menü =>
            return To_Wide_Wide_String (Source => GlobaleTexte.Rassenauswahl (WelcheZeileExtern));
            
         when SystemDatentypen.Grafik_Menü =>
            return To_Wide_Wide_String (Source => GlobaleTexte.Grafikmenü (WelcheZeileExtern));
            
         when SystemDatentypen.Sound_Menü =>
            return To_Wide_Wide_String (Source => GlobaleTexte.Soundmenü (WelcheZeileExtern));
            
         when SystemDatentypen.Sonstiges_Menü =>
            return To_Wide_Wide_String (Source => GlobaleTexte.Sonstigesmenü (WelcheZeileExtern));
            
         when SystemDatentypen.Steuerung_Menü =>
            return To_Wide_Wide_String (Source => GlobaleTexte.Steuerungmenü (WelcheZeileExtern));
      end case;
      
   end StringSetzen;
   
end AuswahlMenue;
