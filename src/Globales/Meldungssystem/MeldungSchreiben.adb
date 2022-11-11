with Ada.Directories; use Ada.Directories;

package body MeldungSchreiben is

   procedure MeldungSchreiben
     (MeldungExtern : in Wide_Wide_String)
   is begin
      
      case
        Exists (Name => "Meldungen")
      is
         when True =>
            Open (File => DateiMeldung,
                  Mode => Append_File,
                  Name => "Meldungen");
            
         when False =>
            Create (File => DateiMeldung,
                    Mode => Out_File,
                    Name => "Meldungen");
      end case;
      
      Put_Line (File => DateiMeldung,
                Item => MeldungExtern);
      
      Close (File => DateiMeldung);
      
   end MeldungSchreiben;
   
   
   
   procedure MeldungSchreibenASCII
     (MeldungExtern : in String)
   is begin
      
      case
        Exists (Name => "Meldungen")
      is
         when True =>
            Ada.Text_IO.Open (File => DateiMeldungASCII,
                              Mode => Ada.Text_IO.Append_File,
                              Name => "Meldungen");
            
         when False =>
            Ada.Text_IO.Create (File => DateiMeldungASCII,
                                Mode => Ada.Text_IO.Out_File,
                                Name => "Meldungen");
      end case;
      
      Ada.Text_IO.Put_Line (File => DateiMeldungASCII,
                            Item => MeldungExtern);
      
      Ada.Text_IO.Close (File => DateiMeldungASCII);
      
   end MeldungSchreibenASCII;

end MeldungSchreiben;
