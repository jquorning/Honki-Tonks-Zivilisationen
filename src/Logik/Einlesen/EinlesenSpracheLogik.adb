with Ada.Characters.Conversions; use Ada.Characters.Conversions;

with GlobaleTexte;
with TextKonstanten;

package body EinlesenSpracheLogik is

   function EinlesenSprache
     return Boolean
   is begin
      
      GlobaleTexte.SprachenEinlesen := (others => TextKonstanten.LeerUnboundedString);
      
      Start_Search (Search    => Suche,
                    Directory => VerzeichnisKonstanten.Sprachen,
                    Pattern   => "",
                    Filter    => (Directory => True,
                                  others    => False));

      VerzeichnisAußenSchleife:
      while More_Entries (Search => Suche) = True loop

         Get_Next_Entry (Search          => Suche,
                         Directory_Entry => Verzeichnis);
         
         if
           Simple_Name (Directory_Entry => Verzeichnis) = "."
           or
             Simple_Name (Directory_Entry => Verzeichnis) = ".."
         then
            null;
            
         elsif
           LeeresVerzeichnis (VerzeichnisExtern => VerzeichnisKonstanten.SprachenStrich & Simple_Name (Directory_Entry => Verzeichnis)) = True
         then
            null;
                  
         else
            VerzeichnisInnenSchleife:
            for SpracheSchleifenwert in GlobaleTexte.SprachenEinlesen'Range loop
               if
                 GlobaleTexte.SprachenEinlesen (SpracheSchleifenwert) /= TextKonstanten.LeerUnboundedString
               then
                  null;
            
               else
                  GlobaleTexte.SprachenEinlesen (SpracheSchleifenwert) := To_Unbounded_Wide_Wide_String (Source => To_Wide_Wide_String (Item => Simple_Name (Directory_Entry => Verzeichnis)));
                  exit VerzeichnisInnenSchleife;
               end if;
         
            end loop VerzeichnisInnenSchleife;
         end if;

      end loop VerzeichnisAußenSchleife;
      
      if
        GlobaleTexte.SprachenEinlesen (1) = TextKonstanten.LeerUnboundedString
      then
         return False;
         
      else
         SprachenSortieren;
         return True;
      end if;
      
   end EinlesenSprache;



   -- Später eventuell noch um weitere Prüfungen erweitern. äöü
   -- Das eventuell auch an anderen Stellen verwenden. äöü
   -- Eventuell bei Speicherdateien? Da dann vielleicht eher die Dateigröße prüfen? äöü
   function LeeresVerzeichnis
     (VerzeichnisExtern : in String)
      return Boolean
   is begin
      
      Start_Search (Search    => Prüfungssuche,
                    Directory => VerzeichnisExtern,
                    Pattern   => "",
                    Filter    => (others => True));
      
      PrüfenSchleife:
      while More_Entries (Search => Prüfungssuche) = True loop

         Get_Next_Entry (Search          => Prüfungssuche,
                         Directory_Entry => Verzeichnisprüfung);
         
         if
           Simple_Name (Directory_Entry => Verzeichnisprüfung) = "."
           or
             Simple_Name (Directory_Entry => Verzeichnisprüfung) = ".."
         then
            null;
            
         else
            return False;
         end if;
            
      end loop PrüfenSchleife;
         
      return True;
      
   end LeeresVerzeichnis;
   
   
   
   procedure SprachenSortieren
   is begin
            
      SortierSchleife:
      for PositionSchleifenwert in GlobaleTexte.SprachenEinlesen'First + 1 .. GlobaleTexte.SprachenEinlesen'Last loop
         
         if
           GlobaleTexte.SprachenEinlesen (PositionSchleifenwert) = TextKonstanten.LeerUnboundedString
         then
            exit SortierSchleife;
            
         else
            SchleifenAbzug := 0;
            PrüfSchleife:
            loop
               
               if
                 PositionSchleifenwert - SchleifenAbzug > GlobaleTexte.SprachenEinlesen'First
                 and then
                   GlobaleTexte.SprachenEinlesen (PositionSchleifenwert) < GlobaleTexte.SprachenEinlesen (PositionSchleifenwert - SchleifenAbzug - 1)
               then
                  SchleifenAbzug := SchleifenAbzug + 1;
                  
               else
                  if
                    PositionSchleifenwert = SchleifenAbzug
                  then
                     SchleifenAbzug := SchleifenAbzug - 1;
                     
                  else
                     null;
                  end if;
                  
                  VerschiebungSchleife:
                  while SchleifenAbzug > 0 loop
                     
                     ZwischenSpeicher := GlobaleTexte.SprachenEinlesen (PositionSchleifenwert);
                     GlobaleTexte.SprachenEinlesen (PositionSchleifenwert) := GlobaleTexte.SprachenEinlesen (PositionSchleifenwert - SchleifenAbzug);
                     GlobaleTexte.SprachenEinlesen (PositionSchleifenwert - SchleifenAbzug) := ZwischenSpeicher;
                     SchleifenAbzug := SchleifenAbzug - 1;
                     
                  end loop VerschiebungSchleife;
                  
                  exit PrüfSchleife;
               end if;
               
            end loop PrüfSchleife;
         end if;
         
      end loop SortierSchleife;
      
   end SprachenSortieren;

end EinlesenSpracheLogik;
