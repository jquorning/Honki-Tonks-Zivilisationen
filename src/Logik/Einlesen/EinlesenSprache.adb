pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Ada.Characters.Conversions;

with GlobaleTexte;
with TextKonstanten;

package body EinlesenSprache is

   function EinlesenSprache
     return Boolean
   is begin
      
      GlobaleTexte.SprachenEinlesen := (others => TextKonstanten.LeerUnboundedString);
      
      Start_Search (Search    => Suche,
                    Directory => TextKonstanten.Sprachen,
                    Pattern   => "");

      VerzeichnisAußenSchleife:
      while More_Entries (Search => Suche) loop

         Get_Next_Entry (Search          => Suche,
                         Directory_Entry => Verzeichnis);
         
         if
           Simple_Name (Directory_Entry => Verzeichnis) = "."
           or
             Simple_Name (Directory_Entry => Verzeichnis) = ".."
           or
             Simple_Name (Directory_Entry => Verzeichnis) = TextKonstanten.Schriftart
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
                  GlobaleTexte.SprachenEinlesen (SpracheSchleifenwert)
                    := To_Unbounded_Wide_Wide_String (Source => Ada.Characters.Conversions.To_Wide_Wide_String (Item => Simple_Name (Directory_Entry => Verzeichnis)));
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

end EinlesenSprache;
