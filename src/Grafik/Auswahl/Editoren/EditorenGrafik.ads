pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with GrafikDatentypen;

package EditorenGrafik is
   pragma Elaborate_Body;

   procedure Editoren
     (WelcherEditorExtern : in GrafikDatentypen.Editor_Enum);

end EditorenGrafik;
