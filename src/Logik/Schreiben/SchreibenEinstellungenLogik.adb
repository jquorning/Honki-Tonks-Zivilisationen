pragma Warnings (Off, "*array aggregate*");

with OptionenVariablen;
with SystemRecords;
with VerzeichnisKonstanten;
with GrafikRecords;

with EinstellungenGrafik;
with TexteinstellungenGrafik;
with RasseneinstellungenGrafik;

package body SchreibenEinstellungenLogik is
   
   procedure Nutzereinstellungen
   is begin
      
      Create (File => DateiNutzereinstellungen,
              Mode => Out_File,
              Name => VerzeichnisKonstanten.Nutzereinstellungen);
      
      SystemRecords.NutzerEinstellungenRecord'Write (Stream (File => DateiNutzereinstellungen),
                                                     OptionenVariablen.NutzerEinstellungen);
      
      Close (File => DateiNutzereinstellungen);
      
   end Nutzereinstellungen;
   
   
   
   procedure Grafikeinstellungen
   is begin
      
      Create (File => DateiGrafikeinstellungen,
              Mode => Out_File,
              Name => VerzeichnisKonstanten.Grafikeinstellungen);
            
      GrafikRecords.FensterRecord'Write (Stream (File => DateiGrafikeinstellungen),
                                         EinstellungenGrafik.FensterEinstellungen);
      GrafikRecords.GrafikeinstellungenRecord'Write (Stream (File => DateiGrafikeinstellungen),
                                                     EinstellungenGrafik.Grafikeinstellungen);
      
      GrafikRecords.SchriftgrößenRecord'Write (Stream (File => DateiGrafikeinstellungen),
                                                 TexteinstellungenGrafik.Schriftgrößen);
      GrafikRecords.SchriftfarbenRecord'Write (Stream (File => DateiGrafikeinstellungen),
                                               TexteinstellungenGrafik.Schriftfarben);
      
      RasseneinstellungenGrafik.RassenFarbenArray'Write (Stream (File => DateiGrafikeinstellungen),
                                                         RasseneinstellungenGrafik.Rassenfarben);
      RasseneinstellungenGrafik.RassenFarbenArray'Write (Stream (File => DateiGrafikeinstellungen),
                                                         RasseneinstellungenGrafik.RassenfarbenRahmen);
      
      Close (File => DateiGrafikeinstellungen);
      
   end Grafikeinstellungen;
   
   
   
   procedure Soundeinstellungen
   is begin
      
      Create (File => DateiSoundeinstellungen,
              Mode => Out_File,
              Name => VerzeichnisKonstanten.Soundeinstelllungen);
      
      
      
      Close (File => DateiSoundeinstellungen);
            
   end Soundeinstellungen;

end SchreibenEinstellungenLogik;
