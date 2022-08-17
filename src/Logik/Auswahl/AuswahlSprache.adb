pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with GlobaleTexte;
with TextKonstanten;
with GrafikDatentypen;
with OptionenVariablen;

with Eingabe;
with Fehler;
with NachGrafiktask;
with NachLogiktask;

package body AuswahlSprache is

   function AuswahlSprache
     return Unbounded_Wide_Wide_String
   is begin
      
      ZehnerReihe := 0;
      MehrereSeiten := False;
      
      SprachenListeFestlegen;
            
      case
        OptionenVariablen.NutzerEinstellungen.Anzeigeart
      is
         when GrafikDatentypen.Grafik_Terminal_Enum =>
            return AuswahlSpracheTerminal;
            
         when GrafikDatentypen.Grafik_SFML_Enum =>
            return AuswahlSpracheSFML;
      end case;
      
   end AuswahlSprache;
   
   
   
   procedure SprachenListeFestlegen
   is begin
      
      AktuelleAuswahl := AktuelleSprachenArray'First;
      
      if
        ZehnerReihe * 10 < GlobaleTexte.SprachenEinlesenArray'Last
      then
         ZehnerReihe := ZehnerReihe + 1;
         
      else
         ZehnerReihe := 1;
      end if;
         
      if
        GlobaleTexte.SprachenEinlesen (ZehnerReihe * 10 - 9) = TextKonstanten.LeerUnboundedString
      then
         ZehnerReihe := 1;
         
      else
         null;
      end if;
      
      AktuelleSprachen := (others => TextKonstanten.LeerUnboundedString);
      
      EndeBestimmenSchleife:
      for EndeSchleifenwert in ZehnerReihe * 10 - 9 .. ZehnerReihe * 10 loop
         
         if
           EndeSchleifenwert > GlobaleTexte.SprachenEinlesenArray'Last
         then
            exit EndeBestimmenSchleife;
            
         elsif
           EndeSchleifenwert = GlobaleTexte.SprachenEinlesenArray'First
           and
             GlobaleTexte.SprachenEinlesen (EndeSchleifenwert) = TextKonstanten.LeerUnboundedString
         then
            Fehler.LogikFehler (FehlermeldungExtern => "AuswahlSprache.SprachenListeFestlegen - Keine Sprachen vorhanden.");
            
         elsif
           EndeSchleifenwert > GlobaleTexte.SprachenEinlesenArray'Last
         then
            exit EndeBestimmenSchleife;
           
         elsif
           GlobaleTexte.SprachenEinlesen (EndeSchleifenwert) = TextKonstanten.LeerUnboundedString
         then
            exit EndeBestimmenSchleife;
            
         else
            Ende := EndeSchleifenwert - ((ZehnerReihe - 1) * 10);
         end if;
         
         AktuelleSprachen (EndeSchleifenwert - ((ZehnerReihe - 1) * 10)) := GlobaleTexte.SprachenEinlesen (EndeSchleifenwert);
         
      end loop EndeBestimmenSchleife;
      
      MehrSprachenVorhandenSchleife:
      for SprachenSchleifenwert in GlobaleTexte.SprachenEinlesenArray'Range loop
         
         if
           SprachenSchleifenwert <= AktuelleSprachenArray'Last
           and
             GlobaleTexte.SprachenEinlesen (SprachenSchleifenwert) = TextKonstanten.LeerUnboundedString
         then
            return;
            
         elsif
           SprachenSchleifenwert >= AktuelleSprachenArray'Last
         then
            exit MehrSprachenVorhandenSchleife;
            
         else
            null;
         end if;
            
      end loop MehrSprachenVorhandenSchleife;
      
      Ende := Ende + 1;
      AktuelleSprachen (Ende) := MehrSprachen;
      MehrereSeiten := True;
      
   end SprachenListeFestlegen;
   
   
   
   function AuswahlSpracheTerminal
     return Unbounded_Wide_Wide_String
   is begin
                  
      NachGrafiktask.AktuelleDarstellung := GrafikDatentypen.Grafik_Sprache_Enum;
      
      AuswahlTerminalSchleife:
      loop
         
         case
           Eingabe.Tastenwert
         is
            when TastenbelegungDatentypen.Oben_Enum | TastenbelegungDatentypen.Ebene_Hoch_Enum =>
               if
                 AktuelleAuswahl = AktuelleSprachen'First
               then
                  AktuelleAuswahl := Ende;
                  
               else
                  AktuelleAuswahl := AktuelleAuswahl - 1;
               end if;

            when TastenbelegungDatentypen.Unten_Enum | TastenbelegungDatentypen.Ebene_Runter_Enum =>
               if
                 AktuelleAuswahl = Ende
               then
                  AktuelleAuswahl := AktuelleSprachen'First;
                  
               else
                  AktuelleAuswahl := AktuelleAuswahl + 1;
               end if;
                              
            when TastenbelegungDatentypen.Auswählen_Enum =>
               if
                 AktuelleSprachen (AktuelleAuswahl) = MehrSprachen
               then
                  SprachenListeFestlegen;
                  
               else
                  return AktuelleSprachen (AktuelleAuswahl);
               end if;
                     
            when others =>
               null;
         end case;
               
      end loop AuswahlTerminalSchleife;
      
   end AuswahlSpracheTerminal;
   
   
   
   function AuswahlSpracheSFML
     return Unbounded_Wide_Wide_String
   is begin
      
      NachGrafiktask.AktuelleDarstellung := GrafikDatentypen.Grafik_Sprache_Enum;
      
      AuswahlSchleife:
      loop
            
         MausAuswahl;
            
         case
           Eingabe.Tastenwert
         is
            when TastenbelegungDatentypen.Oben_Enum | TastenbelegungDatentypen.Ebene_Hoch_Enum =>
               if
                 AktuelleAuswahl = AktuelleSprachen'First
               then
                  AktuelleAuswahl := Ende;
                  
               else
                  AktuelleAuswahl := AktuelleAuswahl - 1;
               end if;

            when TastenbelegungDatentypen.Unten_Enum | TastenbelegungDatentypen.Ebene_Runter_Enum =>
               if
                 AktuelleAuswahl = Ende
               then
                  AktuelleAuswahl := AktuelleSprachen'First;
                  
               else
                  AktuelleAuswahl := AktuelleAuswahl + 1;
               end if;
                              
            when TastenbelegungDatentypen.Auswählen_Enum =>
               if
                 AktuelleSprachen (AktuelleAuswahl) = MehrSprachen
               then
                  SprachenListeFestlegen;
                  
               else
                  return AktuelleSprachen (AktuelleAuswahl);
               end if;
               
            when TastenbelegungDatentypen.Menü_Zurück_Enum =>
               return TextKonstanten.LeerUnboundedString;
            
            when others =>
               null;
         end case;
      
      end loop AuswahlSchleife;
      
   end AuswahlSpracheSFML;
   
   
   
   -- Auch mal in einen View umarbeiten. äöü
   procedure MausAuswahl
   is begin
      
      TextPositionMaus := StartPositionYAchse;
      Mausposition := NachLogiktask.Mausposition;
      
      MausZeigerSchleife:
      for ZeileSchleifenwert in AktuelleSprachen'First .. Ende loop
                  
         if
           AktuelleSprachen (ZeileSchleifenwert) = MehrSprachen
         then
            TextPositionMaus := TextPositionMaus + 15.00;
            
         else
            null;
         end if;
         
         if
           Mausposition.y in TextPositionMaus .. TextPositionMaus
         then
            AktuelleAuswahl := ZeileSchleifenwert;
            return;
         
         else
            TextPositionMaus := TextPositionMaus + 1.00;
         end if;
         
      end loop MausZeigerSchleife;
      
   end MausAuswahl;
   
end AuswahlSprache;
