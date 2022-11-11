with Ada.Task_Identification; use Ada.Task_Identification;
with Ada.Exceptions; use Ada.Exceptions;
with Ada.Text_IO;

with StartLogik;
with Grafik;
with Musik;
with Sound;

with NachGrafiktask;
with MeldungSchreiben;
with StartEndeSound;
with StartEndeMusik;

procedure Start
is

   UnerwarteterFehler : Boolean := False;

   type Tasks_Enum is (
                       Task_Logik_Enum, Task_Grafik_Enum, Task_Musik_Enum, Task_Sound_Enum
                      );

   type TasksLaufenArray is array (Tasks_Enum'Range) of Boolean;
   TasksLaufen : TasksLaufenArray := (
                                      others => False
                                     );

   type TaskIDArray is array (Tasks_Enum'Range) of Task_Id;
   TaskID : TaskIDArray;

   task LogikTask;
   task GrafikTask;
   task MusikTask;
   task SoundTask;

   task body LogikTask
   is begin

      TaskID (Task_Logik_Enum) := Current_Task;

      TasksLaufen (Task_Logik_Enum) := True;
      StartLogik.StartLogik;
      TasksLaufen (Task_Logik_Enum) := False;

   exception
      when StandardAdaFehler : others =>
         Ada.Text_IO.Put_Line (Item => "Logiktask wurde abgebrochen.");
         Ada.Text_IO.Put_Line (Item => Exception_Information (StandardAdaFehler));
         MeldungSchreiben.MeldungSchreiben (MeldungExtern => "Logiktask wurde abgebrochen.");
         MeldungSchreiben.MeldungSchreibenASCII (MeldungExtern => Exception_Information (StandardAdaFehler));
         UnerwarteterFehler := True;

   end LogikTask;



   task body GrafikTask
   is begin

      TaskID (Task_Grafik_Enum) := Current_Task;

      TasksLaufen (Task_Grafik_Enum) := True;
      Grafik.Grafik;
      TasksLaufen (Task_Grafik_Enum) := False;

   exception
      when StandardAdaFehler : others =>
         Ada.Text_IO.Put_Line (Item => "Grafiktask wurde abgebrochen.");
         Ada.Text_IO.Put_Line (Item => Exception_Information (StandardAdaFehler));
         MeldungSchreiben.MeldungSchreiben (MeldungExtern => "Grafiktask wurde abgebrochen.");
         MeldungSchreiben.MeldungSchreibenASCII (MeldungExtern => Exception_Information (StandardAdaFehler));
         UnerwarteterFehler := True;

   end GrafikTask;



   task body MusikTask
   is begin

      TaskID (Task_Musik_Enum) := Current_Task;

      TasksLaufen (Task_Musik_Enum) := True;
      Musik.Musik;
      TasksLaufen (Task_Musik_Enum) := False;

   exception
      when StandardAdaFehler : others =>
         Ada.Text_IO.Put_Line (Item => "Musiktask wurde abgebrochen.");
         Ada.Text_IO.Put_Line (Item => Exception_Information (StandardAdaFehler));
         MeldungSchreiben.MeldungSchreiben (MeldungExtern => "Musiktask wurde abgebrochen.");
         MeldungSchreiben.MeldungSchreibenASCII (MeldungExtern => Exception_Information (StandardAdaFehler));
         UnerwarteterFehler := True;

   end MusikTask;



   task body SoundTask
   is begin

      TaskID (Task_Sound_Enum) := Current_Task;

      TasksLaufen (Task_Sound_Enum) := True;
      Sound.Sound;
      TasksLaufen (Task_Sound_Enum) := False;

   exception
      when StandardAdaFehler : others =>
         Ada.Text_IO.Put_Line (Item => "Soundtask wurde abgebrochen.");
         Ada.Text_IO.Put_Line (Item => Exception_Information (StandardAdaFehler));
         MeldungSchreiben.MeldungSchreiben (MeldungExtern => "Soundtask wurde abgebrochen.");
         MeldungSchreiben.MeldungSchreibenASCII (MeldungExtern => Exception_Information (StandardAdaFehler));
         UnerwarteterFehler := True;

   end SoundTask;

begin

   TaskIDsBelegenLassenSchleife:
   loop

      if
        TasksLaufen (Task_Logik_Enum) = True
        and
          TasksLaufen (Task_Grafik_Enum) = True
        and
          TasksLaufen (Task_Musik_Enum) = True
        and
          TasksLaufen (Task_Sound_Enum) = True
      then
         exit TaskIDsBelegenLassenSchleife;

      elsif
        UnerwarteterFehler
      then
         exit TaskIDsBelegenLassenSchleife;

      else
         delay 0.02;
      end if;

   end loop TaskIDsBelegenLassenSchleife;

   SpielLäuftSchleife:
   loop

      case
        UnerwarteterFehler
      is
         when True =>
            Abort_Task (T => TaskID (Task_Logik_Enum));
            Abort_Task (T => TaskID (Task_Grafik_Enum));
            Abort_Task (T => TaskID (Task_Musik_Enum));
            Abort_Task (T => TaskID (Task_Sound_Enum));
            MeldungSchreiben.MeldungSchreiben (MeldungExtern => "Unerwartet beendet.");
            exit SpielLäuftSchleife;

         when False =>
            delay 0.20;
      end case;

      case
        NachGrafiktask.FensterGeschlossen
      is
         when True =>
            -- Hier nicht mehr direkt die Schleife verlassen, da sonst die erfolgreiche Endmeldung nicht mehr geschrieben wird.
            Abort_Task (T => TaskID (Task_Logik_Enum));
            Abort_Task (T => TaskID (Task_Musik_Enum));
            Abort_Task (T => TaskID (Task_Sound_Enum));
            StartEndeSound.Stoppen;
            StartEndeSound.Entfernen;
            StartEndeMusik.Stoppen;
            StartEndeMusik.Entfernen;
            TasksLaufen := (others => False);

         when False =>
            null;
      end case;

      if
        TasksLaufen (Task_Logik_Enum) = False
        and
          TasksLaufen (Task_Grafik_Enum) = False
        and
          TasksLaufen (Task_Musik_Enum) = False
        and
          TasksLaufen (Task_Sound_Enum) = False
      then
         exit SpielLäuftSchleife;

      else
         null;
      end if;

      UnerwarteterFehlerSchleife:
      for UnerwarteterFehlerSchleifenwert in Tasks_Enum'Range loop

         if
           Is_Terminated (T => TaskID (UnerwarteterFehlerSchleifenwert)) = True
           and
             TasksLaufen (UnerwarteterFehlerSchleifenwert) = True
         then
            UnerwarteterFehler := True;
            exit UnerwarteterFehlerSchleife;

         else
            null;
         end if;

      end loop UnerwarteterFehlerSchleife;

   end loop SpielLäuftSchleife;

end Start;
