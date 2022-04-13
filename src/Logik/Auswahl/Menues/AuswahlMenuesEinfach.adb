pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Sf;

with SystemDatentypen; use SystemDatentypen;
with TastenbelegungDatentypen;
with GrafikTonDatentypen;
with SystemKonstanten;

with GrafikEinstellungenSFML;
with Eingabe;
with RueckgabeMenues;
with InteraktionGrafiktask;
with InteraktionAuswahl;

package body AuswahlMenuesEinfach is

   --------------------------- Das ganze noch einmal unabhängiger schreiben, damit man es zu Not auch auslagern kann und Überschreibungen nicht vorkommen können.
   function AuswahlMenüsEinfach
     (WelchesMenüExtern : in SystemDatentypen.Menü_Einfach_Enum)
      return SystemDatentypen.Rückgabe_Werte_Enum
   is begin
      
      InteraktionGrafiktask.AktuellesMenü := WelchesMenüExtern;
      InteraktionGrafiktask.AktuelleDarstellungÄndern (DarstellungExtern => GrafikTonDatentypen.Grafik_Menüs_Enum);
      
      -- Wird benötigt damit das hier ohne und mit Überschrift funktioniert.
      case
        WelchesMenüExtern
      is
         when SystemDatentypen.Menü_Ohne_Überschrift_Enum =>
            Anfang := 1;
            AnfangAbzug := 0;
            EndeAbzug := 0;
            
         when SystemDatentypen.Menü_Mit_Überschrift_Enum =>
            Anfang := 2;
            AnfangAbzug := 1;
            EndeAbzug := 1;
      end case;
      
      Ende := SystemKonstanten.EndeMenü (WelchesMenüExtern);
      
      Ausgewählt := Auswahl (WelchesMenüExtern => WelchesMenüExtern);
   
      RückgabeWert := RueckgabeMenues.RückgabeMenüs (AnfangExtern          => Anfang - AnfangAbzug,
                                                        EndeExtern            => Ende - EndeAbzug,
                                                        AktuelleAuswahlExtern => Ausgewählt,
                                                        WelchesMenüExtern     => WelchesMenüExtern);
      
      InteraktionGrafiktask.AktuellesMenü := SystemDatentypen.Leer_Menü_Enum;
      InteraktionGrafiktask.AktuelleDarstellungÄndern (DarstellungExtern => GrafikTonDatentypen.Grafik_Pause_Enum);
      
      return RückgabeWert;
      
   end AuswahlMenüsEinfach;

      
   
   function Auswahl
     (WelchesMenüExtern : in SystemDatentypen.Menü_Einfach_Enum)
      return Positive
   is begin
      
      -------------------------- Ist das so in der SFML Version überhaupt noch sinnvoll? Oder reicht die Mausauswahl?
      AuswahlSchleife:
      loop
      
         AktuelleAuswahl := MausAuswahl (WelchesMenüExtern => WelchesMenüExtern);
      
         case
           Eingabe.Tastenwert
         is
            when TastenbelegungDatentypen.Oben_Enum | TastenbelegungDatentypen.Ebene_Hoch_Enum =>
               if
                 AktuelleAuswahl = Anfang
                 or
                   AktuelleAuswahl = 0
               then
                  AktuelleAuswahl := Ende;

               else
                  AktuelleAuswahl := AktuelleAuswahl - 1;
               end if;

            when TastenbelegungDatentypen.Unten_Enum | TastenbelegungDatentypen.Ebene_Runter_Enum =>
               if
                 AktuelleAuswahl = Ende
                 or
                   AktuelleAuswahl = 0
               then
                  AktuelleAuswahl := Anfang;

               else
                  AktuelleAuswahl := AktuelleAuswahl + 1;
               end if;
               
               -- Später noch erweitern oder entfernen?
            when TastenbelegungDatentypen.Links_Enum =>
               null;
               
            when TastenbelegungDatentypen.Rechts_Enum =>
               null;
                              
            when TastenbelegungDatentypen.Auswählen_Enum =>
               if
                 AktuelleAuswahl = 0
               then
                  null;
                  
               else
                  return AktuelleAuswahl;
               end if;
            
            when others =>
               null;
         end case;
         
      end loop AuswahlSchleife;
      
   end Auswahl;
   
         
   
   function MausAuswahl
     (WelchesMenüExtern : in SystemDatentypen.Menü_Einfach_Enum)
      return Natural
   is begin
      
      -- Niemals direkt die Mausposition abrufen sondern immer die Werte in der Eingabe ermitteln lassen. Sonst kann es zu einem Absturz kommen.
      MausZeigerPosition := GrafikEinstellungenSFML.MausPosition;
      
      PositionSchleife:
      for PositionSchleifenwert in Anfang .. Ende loop
         
         if
           MausZeigerPosition.y in Sf.sfInt32 (InteraktionAuswahl.PositionenEinfach (WelchesMenüExtern, PositionSchleifenwert).top)
             .. Sf.sfInt32 (InteraktionAuswahl.PositionenEinfach (WelchesMenüExtern, PositionSchleifenwert).top + InteraktionAuswahl.PositionenEinfach (WelchesMenüExtern, PositionSchleifenwert).height)
             and
               MausZeigerPosition.x in Sf.sfInt32 (InteraktionAuswahl.PositionenEinfach (WelchesMenüExtern, PositionSchleifenwert).left)
                 .. Sf.sfInt32 (InteraktionAuswahl.PositionenEinfach (WelchesMenüExtern, PositionSchleifenwert).left + InteraktionAuswahl.PositionenEinfach (WelchesMenüExtern, PositionSchleifenwert).width)
         then
            return PositionSchleifenwert;
            
         else
            null;
         end if;
         
      end loop PositionSchleife;
      
      return 0;
      
   end MausAuswahl;
   
end AuswahlMenuesEinfach;
