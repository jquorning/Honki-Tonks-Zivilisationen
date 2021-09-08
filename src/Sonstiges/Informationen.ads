pragma SPARK_Mode (On);

package Informationen is

   Versionsnummer : constant Wide_Wide_String (1 .. 9) := "0.00.8630";

   procedure Informationen
     with
       Global =>
         (Input => Versionsnummer),
         Depends =>
           (null => Versionsnummer);

end Informationen;
