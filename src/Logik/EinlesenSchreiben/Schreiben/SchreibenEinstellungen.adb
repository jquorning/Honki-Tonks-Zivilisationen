pragma SPARK_Mode (On);

with Ada.Directories; use Ada.Directories;

with GlobaleVariablen;
with SystemRecords;

with EinstellungenSFML;

package body SchreibenEinstellungen is

   procedure SchreibenEinstellungen
   is begin
      
      case
        Exists (Name => "Einstellungen/Einstellungen")
      is
         when True =>
            Open (File => DateiEinstellungenSchreiben,
                  Mode => Out_File,
                  Name => "Einstellungen/Einstellungen");

         when False =>
            Create (File => DateiEinstellungenSchreiben,
                    Mode => Out_File,
                    Name => "Einstellungen/Einstellungen");
      end case;
         
      SystemRecords.NutzerEinstellungenRecord'Write (Stream (File => DateiEinstellungenSchreiben),
                                                     GlobaleVariablen.NutzerEinstellungen);
      
      SystemRecords.FensterRecord'Write (Stream (File => DateiEinstellungenSchreiben),
                                         EinstellungenSFML.FensterEinstellungen);
      SystemRecords.SchriftfarbenRecord'Write (Stream (File => DateiEinstellungenSchreiben),
                                               EinstellungenSFML.Schriftfarben);
      EinstellungenSFML.RassenFarbenArray'Write (Stream (File => DateiEinstellungenSchreiben),
                                                 EinstellungenSFML.RassenFarben);
      
      Close (File => DateiEinstellungenSchreiben);
      
   end SchreibenEinstellungen;

end SchreibenEinstellungen;
