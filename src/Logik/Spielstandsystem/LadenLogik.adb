pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Ada.Strings.UTF_Encoding.Wide_Wide_Strings; use Ada.Strings.UTF_Encoding.Wide_Wide_Strings;

with KartenRecords;
with StadtRecords;
with SpielRecords;
with EinheitenRecords;
with TextnummernKonstanten;
with GrafikDatentypen;
with VerzeichnisKonstanten;
with WeltkarteRecords;
with TextKonstanten;

with Weltkarte;
with LadezeitenLogik;
with JaNeinLogik;
with NachGrafiktask;
with SpielstandlisteLogik;

package body LadenLogik is
   
   function Laden
     return Boolean
   is begin
      
      Spielstandname := SpielstandlisteLogik.Spielstandliste (SpeichernLadenExtern => False);
      
      if
        Spielstandname = TextKonstanten.LeerUnboundedString
      then
         return False;
         
      else
         Open (File => DateiLaden,
               Mode => In_File,
               Name => VerzeichnisKonstanten.SpielstandStrich & Encode (Item => To_Wide_Wide_String (Source => Spielstandname)));

         Wide_Wide_String'Read (Stream (File => DateiLaden),
                                VersionsnummerPrüfung);
      end if;

      if
        VersionsnummerPrüfung = SonstigesKonstanten.Versionsnummer
      then
         null;
         
      elsif
        JaNeinLogik.JaNein (FrageZeileExtern => TextnummernKonstanten.FrageLadeFalscheVersion) = True
      then
         null;
         
      else
         Close (File => DateiLaden);
         return False;
      end if;
      
      -- Hier noch Prüfungen einbauen ob die Werte so korrekt geladen werden und wenn nicht dann abbrechen und auf Standard setzen. äöü
      -- Bei Fehlschlag der Prüfungen dann einen Rückgabewert für das Hauptmenü einbauen. äöü
      -- Das wird wahrscheinlich auch nur mit Exceptions gehen, oder? äöü
      LadezeitenLogik.SpeichernLadenNullsetzen;
      NachGrafiktask.AktuelleDarstellung := GrafikDatentypen.Grafik_Speichern_Laden_Enum;
      
      Allgemeines (DateiLadenExtern => DateiLaden);
      LadezeitenLogik.SpeichernLadenSchreiben (SpeichernLadenExtern => False);
      
      KarteLaden (DateiLadenExtern => DateiLaden);
      
      RassenwerteLaden (DateiLadenExtern => DateiLaden);
      LadezeitenLogik.SpeichernLadenSchreiben (SpeichernLadenExtern => False);
      
      Close (File => DateiLaden);
      
      LadezeitenLogik.SpeichernLadenMaximum;
      NachGrafiktask.AktuelleDarstellung := GrafikDatentypen.Grafik_Pause_Enum;

      return True;
      
   end Laden;
   
   
   
   procedure Allgemeines
     (DateiLadenExtern : in File_Type)
   is begin
      
      SpielRecords.AllgemeinesRecord'Read (Stream (File => DateiLadenExtern),
                                           SpielVariablen.Allgemeines);
      
      SpielVariablen.RassenbelegungArray'Read (Stream (File => DateiLadenExtern),
                                               SpielVariablen.Rassenbelegung);
      
   end Allgemeines;
   
   
   
   procedure KarteLaden
     (DateiLadenExtern : in File_Type)
   is begin
      
      KartenRecords.PermanenteKartenparameterRecord'Read (Stream (File => DateiLadenExtern),
                                                          Weltkarte.Karteneinstellungen);

      EAchseSchleife:
      for EAchseSchleifenwert in Weltkarte.KarteArray'Range (1) loop
         YAchseSchleife:
         for YAchseSchleifenwert in Weltkarte.KarteArray'First (2) .. Weltkarte.Karteneinstellungen.Kartengröße.YAchse loop
            XAchseSchleife:
            for XAchseSchleifenwert in Weltkarte.KarteArray'First (3) .. Weltkarte.Karteneinstellungen.Kartengröße.XAchse loop

               WeltkarteRecords.WeltkarteRecord'Read (Stream (File => DateiLadenExtern),
                                                      Weltkarte.Karte (EAchseSchleifenwert, YAchseSchleifenwert, XAchseSchleifenwert));
               
            end loop XAchseSchleife;
         end loop YAchseSchleife;
         
         LadezeitenLogik.SpeichernLadenSchreiben (SpeichernLadenExtern => False);
         
      end loop EAchseSchleife;
      
   end KarteLaden;
   
   
   
   procedure RassenwerteLaden
     (DateiLadenExtern : in File_Type)
   is begin
      
      RassenSchleife:
      for RasseSchleifenwert in RassenDatentypen.Rassen_Verwendet_Enum'Range loop
         
         case
           SpielVariablen.Rassenbelegung (RasseSchleifenwert).Belegung
         is
            when RassenDatentypen.Leer_Spieler_Enum =>
               null;
               
            when others =>
               Rassenwerte (RasseExtern      => RasseSchleifenwert,
                            DateiLadenExtern => DateiLadenExtern);
         end case;
         
      end loop RassenSchleife;
      
   end RassenwerteLaden;
   
   
   
   procedure Rassenwerte
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      DateiLadenExtern : in File_Type)
   is begin
      
      SpielRecords.GrenzenRecord'Read (Stream (File => DateiLadenExtern),
                                       SpielVariablen.Grenzen (RasseExtern));
      
      EinheitenSchleife:
      for EinheitSchleifenwert in SpielVariablen.EinheitenGebautArray'First (2) .. SpielVariablen.Grenzen (RasseExtern).Einheitengrenze loop
            
         EinheitenRecords.EinheitenGebautRecord'Read (Stream (File => DateiLadenExtern),
                                                      SpielVariablen.EinheitenGebaut (RasseExtern, EinheitSchleifenwert));
            
      end loop EinheitenSchleife;
      
      StadtSchleife:
      for StadtSchleifenwert in SpielVariablen.StadtGebautArray'First (2) .. SpielVariablen.Grenzen (RasseExtern).Städtegrenze loop
                  
         StadtRecords.StadtGebautRecord'Read (Stream (File => DateiLadenExtern),
                                              SpielVariablen.StadtGebaut (RasseExtern, StadtSchleifenwert));
            
      end loop StadtSchleife;
      
      SpielRecords.WichtigesRecord'Read (Stream (File => DateiLadenExtern),
                                         SpielVariablen.Wichtiges (RasseExtern));
      
      DiplomatieSchleife:
      for RasseDiplomatieSchleifenwert in SpielVariablen.DiplomatieArray'Range (2) loop

         case
           SpielVariablen.Rassenbelegung (RasseDiplomatieSchleifenwert).Belegung
         is
            when RassenDatentypen.Leer_Spieler_Enum =>
               null;
                     
            when others =>
               SpielRecords.DiplomatieRecord'Read (Stream (File => DateiLadenExtern),
                                                   SpielVariablen.Diplomatie (RasseExtern, RasseDiplomatieSchleifenwert));
         end case;

      end loop DiplomatieSchleife;
      
      KartenRecords.CursorRecord'Read (Stream (File => DateiLadenExtern),
                                       SpielVariablen.CursorImSpiel (RasseExtern));
      
   end Rassenwerte;

end LadenLogik;