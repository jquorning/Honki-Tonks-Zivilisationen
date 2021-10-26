pragma SPARK_Mode (On);

with Ada.Streams.Stream_IO; use Ada.Streams.Stream_IO;

package SchreibenTastatur is

   procedure TastenbelegungSchreiben;
   
private
   
   TastenbelegungSpeichern : File_Type;
   
   procedure BelegungKonsole;
   procedure BelegungSFML;

end SchreibenTastatur;
