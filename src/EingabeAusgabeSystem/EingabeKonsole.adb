pragma SPARK_Mode (On);

with Ada.Wide_Wide_Text_IO; use Ada.Wide_Wide_Text_IO;
with Ada.Wide_Wide_Characters.Handling; use Ada.Wide_Wide_Characters.Handling;
with Ada.Strings.Wide_Wide_Fixed;

with GlobaleTexte;

with Anzeige;
with Fehler;
with InteraktionTasks;

package body EingabeKonsole is

   function GanzeZahl
     (ZahlenMinimumExtern : in Grenzen;
      ZahlenMaximumExtern : in Grenzen;
      WelcheFrageExtern : in Positive)
      return SystemRecords.ZahlenEingabeRecord
   is begin
      
      AktuellerWert := 0;
      EingegebeneZahl.EingegebeneZahl := AktuellerWert;
      
      if
        WelcheFrageExtern > GlobaleTexte.Frage'Last
      then
         Fehler.LogikStopp (FehlermeldungExtern => "EingabeKonsole.GanzeZahl - Frage ist außerhalb des Fragenbereichs.");
         
      elsif
        ZahlenMinimumExtern > ZahlenMaximumExtern
      then
         Fehler.LogikStopp (FehlermeldungExtern => "EingabeKonsole.GanzeZahl - Zahlenminimum ist größer als Zahlenmaximum.");
         
      else
         -- Wegen der grafischen Anzeige festgelegt.
         Frage := WelcheFrageExtern;
         ZahlenString := ZahlenStringLeer;
         VorzeichenAnpassen (ZahlenMinimumExtern => ZahlenMinimumExtern,
                             ZahlenMaximumExtern => ZahlenMaximumExtern,
                             PlusMinusExtern     => True);
         InteraktionTasks.EingabeÄndern (EingabeExtern => SystemDatentypen.Zahlen_Eingabe);
      end if;
      
      case
        InteraktionTasks.AktuelleDarstellungAbrufen
      is
         -- Brauche ich den Stadtteil wirklich? Eventuell um in der Stadt bestimmte Dinge festzulegen.
         when SystemDatentypen.Grafik_Weltkarte | SystemDatentypen.Grafik_Stadtkarte =>
            null;
            
         when others =>
            InteraktionTasks.AktuelleDarstellungÄndern (DarstellungExtern => SystemDatentypen.Grafik_Menüs);
      end case;
                  
      case
        ZahlSchleife (ZahlenMinimumExtern => ZahlenMinimumExtern,
                      ZahlenMaximumExtern => ZahlenMaximumExtern)
      is
         when True =>
            EingegebeneZahl.EingabeAbbruch := True;
               
         when False =>
            EingegebeneZahl.EingabeAbbruch := False;
      end case;
      
      if
        WelchesVorzeichen
      then
         EingegebeneZahl.EingegebeneZahl := Integer'Wide_Wide_Value (ZahlenString);
                  
      else
         EingegebeneZahl.EingegebeneZahl := -Integer'Wide_Wide_Value (ZahlenString);
      end if;
      
      case
        InteraktionTasks.AktuelleDarstellungAbrufen
      is
         when SystemDatentypen.Grafik_Menüs =>
            InteraktionTasks.EingabeÄndern (EingabeExtern => SystemDatentypen.Keine_Eingabe);
            InteraktionTasks.AktuelleDarstellungÄndern (DarstellungExtern => SystemDatentypen.Grafik_Pause);
            
         when others =>
            null;
      end case;
            
      return EingegebeneZahl;
      
   end GanzeZahl;



   function ZahlSchleife
     (ZahlenMinimumExtern : in Grenzen;
      ZahlenMaximumExtern : in Grenzen)
      return Boolean
   is begin
      
      ZahlenSchleife:
      loop
         
         Get_Immediate (Item => Zahlen);
         
         case
           GanzeZahlPrüfung (ZeichenExtern => Zahlen)
         is
            when Zahl_Hinzufügen =>
               ZahlHinzufügen (EingegebeneZahlExtern => Zahlen);

            when Eingabe_Abbrechen =>
               return False;

            when Eingabe_Fertig =>
               if
                 MinimumMaximumSetzen (ZahlenMinimumExtern => ZahlenMinimumExtern,
                                       ZahlenMaximumExtern => ZahlenMaximumExtern)
                 = True
               then
                  return True;
                  
               else
                  null;
               end if;

            when Zahl_Löschen =>
               ZahlEntfernen;
               
            when Vorzeichen_Plus =>
               VorzeichenAnpassen (ZahlenMinimumExtern => ZahlenMinimumExtern,
                                   ZahlenMaximumExtern => ZahlenMaximumExtern,
                                   PlusMinusExtern     => True);
               
            when Vorzeichen_Minus =>
               VorzeichenAnpassen (ZahlenMinimumExtern => ZahlenMinimumExtern,
                                   ZahlenMaximumExtern => ZahlenMaximumExtern,
                                   PlusMinusExtern     => False);
                  
            when Leer =>
               null;
         end case;
         
         AktuellerWert := Natural'Wide_Wide_Value (ZahlenString);

      end loop ZahlenSchleife;
      
   end ZahlSchleife;
   
   
   
   procedure VorzeichenAnpassen
     (ZahlenMinimumExtern : in Grenzen;
      ZahlenMaximumExtern : in Grenzen;
      PlusMinusExtern : in Boolean)
   is begin
            
      if
        ZahlenMinimumExtern >= 0
      then
         WelchesVorzeichen := True;
         
      elsif
        ZahlenMaximumExtern < 0
      then
         WelchesVorzeichen := False;
         
      elsif
        PlusMinusExtern
      then
         WelchesVorzeichen := True;
         
      else
         WelchesVorzeichen := False;
      end if;
      
   end VorzeichenAnpassen;
   
   
   
   procedure ZahlHinzufügen
     (EingegebeneZahlExtern : in Wide_Wide_Character)
   is begin
      
      ZahlenNachLinksVerschiebenSchleife:
      for ZahlEinsSchleifenwert in ZahlenString'First + 1 .. ZahlenString'Last loop
                  
         ZahlenString (ZahlEinsSchleifenwert - 1) := ZahlenString (ZahlEinsSchleifenwert);

      end loop ZahlenNachLinksVerschiebenSchleife;
      
      ZahlenString (ZahlenString'Last) := EingegebeneZahlExtern;

      if
        ZahlenString (1) /= '0'
      then
         ZahlenString := Ada.Strings.Wide_Wide_Fixed.Trim (Source => Grenzen'Last'Wide_Wide_Image,
                                                           Side   => Ada.Strings.Left);
           
      else
         null;
      end if;
      
   end ZahlHinzufügen;
   
   
   
   procedure ZahlEntfernen
   is begin
      
      ZahlenNachRechtsVerschiebenSchleifeZwei:
      for ZahlDreiSchleifenwert in reverse ZahlenString'First + 1 .. ZahlenString'Last loop
                  
         ZahlenString (ZahlDreiSchleifenwert) := ZahlenString (ZahlDreiSchleifenwert - 1);

      end loop ZahlenNachRechtsVerschiebenSchleifeZwei;
      ZahlenString (1) := '0';
      
   end ZahlEntfernen;



   function GanzeZahlPrüfung
     (ZeichenExtern : in Wide_Wide_Character)
      return Zahl_Prüfung_Enum
   is begin
      
      case
        ZeichenExtern
      is
         when '0' | '1' | '2' | '3' | '4' | '5' | '6' | '7' | '8' | '9' =>
            return Zahl_Hinzufügen;
            
         when ESC =>
            return Eingabe_Abbrechen;

         when DEL =>
            return Zahl_Löschen;

         when LF =>
            return Eingabe_Fertig;

         when '-' =>
            return Vorzeichen_Minus;
            
         when '+' =>
            return Vorzeichen_Plus;
            
         when others =>
            return Leer;
      end case;
      
   end GanzeZahlPrüfung;
   
   
   
   function MinimumMaximumSetzen
     (ZahlenMinimumExtern : in Grenzen;
      ZahlenMaximumExtern : in Grenzen)
      return Boolean
   is begin
      
      if
        (WelchesVorzeichen
         and
           Integer'Wide_Wide_Value (ZahlenString) > ZahlenMaximumExtern)
        or
          (WelchesVorzeichen = False
           and
             Integer'Wide_Wide_Value (ZahlenString) > ZahlenMaximumExtern
           and
             ZahlenMaximumExtern < 0)
      then
         AktuelleZahl := Ada.Strings.Wide_Wide_Fixed.Trim (Source => ZahlenMaximumExtern'Wide_Wide_Image,
                                                           Side   => Ada.Strings.Left)'Length;
         ZahlenString := ZahlenStringLeer;
         
         ZahlenString (ZahlenString'Last - AktuelleZahl + 1 .. ZahlenString'Last) := Ada.Strings.Wide_Wide_Fixed.Trim (Source => ZahlenMaximumExtern'Wide_Wide_Image,
                                                                                                                       Side   => Ada.Strings.Left);
         return False;
         
      elsif
        (WelchesVorzeichen = False
         and
           Integer'Wide_Wide_Value (ZahlenString) > ZahlenMinimumExtern)
        or
          (WelchesVorzeichen
           and
             Integer'Wide_Wide_Value (ZahlenString) < ZahlenMinimumExtern
           and
             ZahlenMinimumExtern > 0)
      then
         AktuelleZahl := Ada.Strings.Wide_Wide_Fixed.Trim (Source => ZahlenMinimumExtern'Wide_Wide_Image,
                                                           Side   => Ada.Strings.Left)'Length;
         ZahlenString := ZahlenStringLeer;
         
         ZahlenString (ZahlenString'Last - AktuelleZahl + 1 .. ZahlenString'Last) := Ada.Strings.Wide_Wide_Fixed.Trim (Source => ZahlenMinimumExtern'Wide_Wide_Image,
                                                                                                                       Side   => Ada.Strings.Left);
         return False;
         
      else
         return True;
      end if;
      
   end MinimumMaximumSetzen;

   

   function StadtName
     return SystemRecords.TextEingabeRecord
   is begin
      
      Anzeige.EinzeiligeAnzeigeOhneAuswahl (TextDateiExtern => GlobaleTexte.Zeug,
                                            TextZeileExtern => 32);
      
      return (True, To_Unbounded_Wide_Wide_String (Source => Get_Line));
      
   end StadtName;



   function SpielstandName
     return SystemRecords.TextEingabeRecord
   is begin
      
      Anzeige.EinzeiligeAnzeigeOhneAuswahl (TextDateiExtern => GlobaleTexte.Fragen,
                                            TextZeileExtern => 22);

      Name := To_Unbounded_Wide_Wide_String (Source => Get_Line);

      case
        To_Wide_Wide_String (Source => Name)'Length
      is
         when 0 =>
            -- Später noch durch eine Prüfung ersetzen ob das ein nicht leerer Name ist.
            return (True, To_Unbounded_Wide_Wide_String (Source => "Kein Name"));
              
         when others =>
            return (True, Name);
      end case;
      
   end SpielstandName;



   function TastenEingabe
     return Wide_Wide_Character
   is begin

      Get_Immediate (Item => Taste);

      if
        Taste = ESC
      then
         Get_Immediate (Item => Taste);
         if
           Taste = '['
         then
            Get_Immediate (Item => Taste);
            if
              -- Pfeiltaste hoch
              Taste = 'A'
            then
               return 'w';
               
            elsif
              -- Pfeiltaste runter
              Taste = 'B'
            then
               return 's';

            elsif
              -- Pfeiltaste rechts
              Taste = 'C'
            then
               return 'd';
                 
            elsif
              -- Pfeiltaste links
              Taste = 'D'
            then
               return 'a';
                 
            else
               return '0';
            end if;
         
         else
            return ESC;
         end if;

      else
         null;
      end if;
      
      return To_Lower (Item => Taste);
      
   end TastenEingabe;



   procedure WartenEingabe
   is begin
      
      New_Line;
      Anzeige.EinzeiligeAnzeigeOhneAuswahl (TextDateiExtern => GlobaleTexte.Zeug,
                                            TextZeileExtern => 47);
      Get_Immediate (Taste);
      
   end WartenEingabe;
   
   
   
   function Tastenwert
     return SystemDatentypen.Tastenbelegung_Enum
   is begin
      
      Taste := TastenEingabe;
      
      BelegungFeldSchleife:
      for BelegungFeldSchleifenwert in TastenbelegungArray'Range (1) loop
         BelegungPositionSchleife:
         for BelegungPositionSchleifenwert in TastenbelegungArray'Range (2) loop
            
            if
              Tastenbelegung (BelegungFeldSchleifenwert, BelegungPositionSchleifenwert) = Taste
            then
               return BelegungPositionSchleifenwert;
               
            else
               null;
            end if;
            
         end loop BelegungPositionSchleife;
      end loop BelegungFeldSchleife;
      
      return SystemDatentypen.Leer;
      
   end Tastenwert;
   
   
   
   procedure StandardTastenbelegungLaden
   is begin
      
      Tastenbelegung := TastenbelegungStandard;
      
   end StandardTastenbelegungLaden;

end EingabeKonsole;
