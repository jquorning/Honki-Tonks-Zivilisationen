pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Sf.Graphics.Text;

with TextaccessVariablen;

with TexteinstellungenSFML;

package body TextaccesseSchriftfarbeSetzenSFML is

   procedure SchriftfarbeSetzen
   is begin
      
      Allgemeines;
      MenüsEinfach;
      Rassen;
      ZusatztextKartengröße;
      Baumenü;
      Forschungsmenü;
      Sprachauswahl;
      Kartenformauswahl;
      StadtInformationen;
      EinheitenInformationen;
      KarteWichtiges;
      KarteAllgemeines;
      Karte;
      EinheitStadtAuswahl;
      AnzeigeEingabe;
      Ladezeiten;
      
   end SchriftfarbeSetzen;
   
   
   
   procedure Allgemeines
   is begin
        
      Sf.Graphics.Text.setColor (text => TextaccessVariablen.ÜberschriftAccess,
                                 color => TexteinstellungenSFML.Schriftfarben.FarbeÜberschrift);
      
      Sf.Graphics.Text.setColor (text => TextaccessVariablen.VersionsnummerAccess,
                                 color => TexteinstellungenSFML.Schriftfarben.FarbeSonstigerText);
      
      Sf.Graphics.Text.setColor (text  => TextaccessVariablen.ZeilenumbruchAccess,
                                 color => TexteinstellungenSFML.Schriftfarben.FarbeSonstigerText);
      
      Sf.Graphics.Text.setColor (text  => TextaccessVariablen.TextAccess,
                                 color => TexteinstellungenSFML.Schriftfarben.FarbeStandardText);
      
   end Allgemeines;
   
   
   
   procedure MenüsEinfach
   is begin
      
      MenüsEinfachAußenSchleife:
      for AußenSchleifenwert in TextaccessVariablen.MenüsAccessArray'Range (1) loop
         MenüsEinfachInnenSchleife:
         for InnenSchleifenwert in TextaccessVariablen.MenüsAccessArray'Range (2) loop
      
            Sf.Graphics.Text.setColor (text  => TextaccessVariablen.MenüsSFMLAccess (AußenSchleifenwert, InnenSchleifenwert),
                                       color => TexteinstellungenSFML.Schriftfarben.FarbeStandardText);
            
         end loop MenüsEinfachInnenSchleife;
      end loop MenüsEinfachAußenSchleife;
      
   end MenüsEinfach;
   
   
   
   procedure Rassen
   is begin
      
      ZusatztextRassenmenüSchleife:
      for RasseSchleifenwert in TextaccessVariablen.RassenbeschreibungAccessArray'Range loop
         
         Sf.Graphics.Text.setColor (text  => TextaccessVariablen.RassennamenAccess (RasseSchleifenwert),
                                    color => TexteinstellungenSFML.Schriftfarben.FarbeStandardText);
         
         Sf.Graphics.Text.setColor (text  => TextaccessVariablen.RassenbeschreibungAccess (RasseSchleifenwert),
                                    color => TexteinstellungenSFML.Schriftfarben.FarbeStandardText);
         
      end loop ZusatztextRassenmenüSchleife;
      
   end Rassen;
      
      
   
   procedure ZusatztextKartengröße
   is begin
      
      ZusatztextKartengrößeSchleife:
      for ZusatztextSchleifenwert in TextaccessVariablen.ZusatztextKartengrößeAccess'Range loop
         
         Sf.Graphics.Text.setColor (text  => TextaccessVariablen.ZusatztextKartengrößeAccess (ZusatztextSchleifenwert),
                                    color => TexteinstellungenSFML.Schriftfarben.FarbeStandardText);
         
      end loop ZusatztextKartengrößeSchleife;
      
   end ZusatztextKartengröße;
      
   
   
   procedure Baumenü
   is begin
      
      GebäudetextSchleife:
      for GebäudetextSchleifenwert in TextaccessVariablen.GebäudetextAccessArray'Range loop
                     
         case
           GebäudetextSchleifenwert
         is
            when TextaccessVariablen.GebäudetextAccessArray'First =>
               Sf.Graphics.Text.setColor (text => TextaccessVariablen.GebäudetextAccess (GebäudetextSchleifenwert),
                                          color => TexteinstellungenSFML.Schriftfarben.FarbeÜberschrift);
               
            when others =>
               Sf.Graphics.Text.setColor (text => TextaccessVariablen.GebäudetextAccess (GebäudetextSchleifenwert),
                                          color => TexteinstellungenSFML.Schriftfarben.FarbeStandardText);
               
               Sf.Graphics.Text.setColor (text => TextaccessVariablen.GebäudezusatztextAccess (GebäudetextSchleifenwert),
                                          color => TexteinstellungenSFML.Schriftfarben.FarbeStandardText);
         end case;
            
      end loop GebäudetextSchleife;
      
      
            
      EinheitentextSchleife:
      for EinheitentextSchleifenwert in TextaccessVariablen.EinheitentextAccess'Range loop
            
         case
           EinheitentextSchleifenwert
         is
            when TextaccessVariablen.EinheitentextAccess'First =>
               Sf.Graphics.Text.setColor (text => TextaccessVariablen.EinheitentextAccess (EinheitentextSchleifenwert),
                                          color => TexteinstellungenSFML.Schriftfarben.FarbeÜberschrift);
               
            when others =>
               Sf.Graphics.Text.setColor (text => TextaccessVariablen.EinheitentextAccess (EinheitentextSchleifenwert),
                                          color => TexteinstellungenSFML.Schriftfarben.FarbeStandardText);
               
               Sf.Graphics.Text.setColor (text => TextaccessVariablen.EinheitenzusatztextAccess (EinheitentextSchleifenwert),
                                          color => TexteinstellungenSFML.Schriftfarben.FarbeStandardText);
         end case;
         
      end loop EinheitentextSchleife;
      
   end Baumenü;
      
      
   
   procedure Forschungsmenü
   is begin
                        
      ForschungenSchleife:
      for ForschungSchleifenwert in TextaccessVariablen.ForschungsmenüAccessArray'Range loop
         
         Sf.Graphics.Text.setColor (text  => TextaccessVariablen.ForschungsmenüAccess (ForschungSchleifenwert),
                                    color => TexteinstellungenSFML.Schriftfarben.FarbeStandardText);
         
         Sf.Graphics.Text.setColor (text  => TextaccessVariablen.ForschungsmenüAccess (ForschungSchleifenwert),
                                    color => TexteinstellungenSFML.Schriftfarben.FarbeStandardText);
         
      end loop ForschungenSchleife;
      
      Sf.Graphics.Text.setColor (text  => TextaccessVariablen.ForschungsmenüErmöglichtAccess,
                                 color => TexteinstellungenSFML.Schriftfarben.FarbeStandardText);
      
   end Forschungsmenü;
   
   
   
   procedure Sprachauswahl
   is begin
      
      ForschungenZusatztextSchleife:
      for ForschungZusatztextSchleifenwert in TextaccessVariablen.ForschungsmenüZusatztextAccessArray'Range loop
         
         Sf.Graphics.Text.setColor (text  => TextaccessVariablen.ForschungsmenüZusatztextAccess (ForschungZusatztextSchleifenwert),
                                    color => TexteinstellungenSFML.Schriftfarben.FarbeStandardText);
         
      end loop ForschungenZusatztextSchleife;
      
   end Sprachauswahl;
   
      
   
   procedure Kartenformauswahl
   is begin
      
      Sf.Graphics.Text.setColor (text  => TextaccessVariablen.KartenformauswahlAccess (TextaccessVariablen.KartenformauswahlAccess'First),
                                 color => TexteinstellungenSFML.Schriftfarben.FarbeÜberschrift);
      
      SchriftfarbeSchleife:
      for SchriftfarbeSchleifenwert in TextaccessVariablen.KartenformauswahlAccess'First + 1 .. TextaccessVariablen.KartenformauswahlAccess'Last - 1 loop
         
         case
           SchriftfarbeSchleifenwert
         is
            when 10 .. 30 =>
               Sf.Graphics.Text.setColor (text  => TextaccessVariablen.KartenformauswahlAccess (SchriftfarbeSchleifenwert),
                                          color => TexteinstellungenSFML.Schriftfarben.FarbeMenschText);
               
            when others =>
               Sf.Graphics.Text.setColor (text  => TextaccessVariablen.KartenformauswahlAccess (SchriftfarbeSchleifenwert),
                                          color => TexteinstellungenSFML.Schriftfarben.FarbeStandardText);
         end case;
         
      end loop SchriftfarbeSchleife;
      
      Sf.Graphics.Text.setColor (text  => TextaccessVariablen.KartenformauswahlAccess (TextaccessVariablen.KartenformauswahlAccess'Last),
                                 color => TexteinstellungenSFML.Schriftfarben.FarbeSonstigerText);
      
   end Kartenformauswahl;
   
   
   
   procedure StadtInformationen
   is begin
      
      StadtInformationenSchleife:
      for StadtInformationenSchleifenwert in TextaccessVariablen.StadtInformationenAccess'Range loop
         
         Sf.Graphics.Text.setColor (text  => TextaccessVariablen.StadtInformationenAccess (StadtInformationenSchleifenwert),
                                    color => TexteinstellungenSFML.Schriftfarben.FarbeStandardText);
         
      end loop StadtInformationenSchleife;
      
   end StadtInformationen;
   
   
   
   procedure EinheitenInformationen
   is begin
      
      EinheitenInformationenSchleife:
      for EinheitenInformationenSchleifenwert in TextaccessVariablen.EinheitenInformationenAccess'Range loop
         
         Sf.Graphics.Text.setColor (text  => TextaccessVariablen.EinheitenInformationenAccess (EinheitenInformationenSchleifenwert),
                                    color => TexteinstellungenSFML.Schriftfarben.FarbeStandardText);
         
      end loop EinheitenInformationenSchleife;
      
   end EinheitenInformationen;
   
   
   
   procedure KarteWichtiges
   is begin
      
      KarteWichtigesSchleife:
      for KarteWichtigesSchleifenwert in TextaccessVariablen.KarteWichtigesAccess'Range loop
         
         Sf.Graphics.Text.setColor (text  => TextaccessVariablen.KarteWichtigesAccess (KarteWichtigesSchleifenwert),
                                    color => TexteinstellungenSFML.Schriftfarben.FarbeStandardText);
         
      end loop KarteWichtigesSchleife;
      
   end KarteWichtiges;
   
   
   
   procedure KarteAllgemeines
   is begin
      
      KarteAllgemeinesSchleife:
      for KarteAllgemeinesSchleifenwert in TextaccessVariablen.KarteAllgemeinesAccess'Range loop
         
         Sf.Graphics.Text.setColor (text  => TextaccessVariablen.KarteAllgemeinesAccess (KarteAllgemeinesSchleifenwert),
                                    color => TexteinstellungenSFML.Schriftfarben.FarbeStandardText);
         
      end loop KarteAllgemeinesSchleife;
      
   end KarteAllgemeines;
   
   
   
   procedure Karte
   is begin
      
      Sf.Graphics.Text.setColor (text  => TextaccessVariablen.KarteAccess,
                                 color => TexteinstellungenSFML.Schriftfarben.FarbeStandardText);
      
   end Karte;
   
   
   
   procedure EinheitStadtAuswahl
   is begin
      
      EinheitStadtSchleife:
      for EinheitStadtSchleifenwert in TextaccessVariablen.AnzeigeEinheitStadtAccessArray'Range loop
      
         Sf.Graphics.Text.setColor (text  => TextaccessVariablen.AnzeigeEinheitStadtAccess (EinheitStadtSchleifenwert),
                                    color => TexteinstellungenSFML.Schriftfarben.FarbeStandardText);
         
      end loop EinheitStadtSchleife;
      
   end EinheitStadtAuswahl;
   
   
   
   procedure AnzeigeEingabe
   is begin
            
      AnzeigeEingabeSchleife:
      for AnzeigeEingabeSchleifenwert in TextaccessVariablen.JaNeinAccessArray'Range loop
         
         Sf.Graphics.Text.setColor (text  => TextaccessVariablen.JaNeinAccess (AnzeigeEingabeSchleifenwert),
                                    color => TexteinstellungenSFML.Schriftfarben.FarbeStandardText);
         
      end loop AnzeigeEingabeSchleife;
         
   end AnzeigeEingabe;
   
   
   
   procedure Ladezeiten
   is begin
            
      LadezeitenSpielweltSchleife:
      for LadezeitenSpielweltSchleifenwert in TextaccessVariablen.LadezeitenAccess'Range loop
         
         Sf.Graphics.Text.setColor (text  => TextaccessVariablen.LadezeitenAccess (LadezeitenSpielweltSchleifenwert),
                                    color => TexteinstellungenSFML.Schriftfarben.FarbeStandardText);
         
      end loop LadezeitenSpielweltSchleife;
      
      
            
      KIZeitenSchleife:
      for KIZeitenSchleifenwert in TextaccessVariablen.KIZeitenAccess'Range loop
         
         Sf.Graphics.Text.setColor (text  => TextaccessVariablen.KIZeitenAccess (KIZeitenSchleifenwert),
                                    color => TexteinstellungenSFML.Schriftfarben.FarbeStandardText);
         
      end loop KIZeitenSchleife;
      
      
               
      Sf.Graphics.Text.setColor (text  => TextaccessVariablen.RundenendeAccess (1),
                                 color => TexteinstellungenSFML.Schriftfarben.FarbeStandardText);
      
      
               
      Sf.Graphics.Text.setColor (text  => TextaccessVariablen.SpeichernLadenAccess (1),
                                 color => TexteinstellungenSFML.Schriftfarben.FarbeStandardText);
      
   end Ladezeiten;

end TextaccesseSchriftfarbeSetzenSFML;
