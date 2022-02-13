pragma SPARK_Mode (On);

with Ada.Wide_Wide_Text_IO; use Ada.Wide_Wide_Text_IO;
with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

with SystemKonstanten;

with EingeleseneTexturenSFML;

package EinlesenTexturen is

   procedure EinlesenTexturen;

private

   AktuelleZeile : Positive;

   DateiTextEinlesen : File_Type;

   type HintergrundEinlesenArray is array (EingeleseneTexturenSFML.HintergrundArray'Range) of Unbounded_Wide_Wide_String;
   HintergrundEinlesen : HintergrundEinlesenArray := (others => SystemKonstanten.LeerUnboundedString);

   type KartenfelderEinlesenArray is array (EingeleseneTexturenSFML.KartenfelderAccessArray'Range) of Unbounded_Wide_Wide_String;
   KartenfelderEinlesen : KartenfelderEinlesenArray := (others => SystemKonstanten.LeerUnboundedString);

   type VerbesserungenEinlesenArray is array (EingeleseneTexturenSFML.VerbesserungenAccessArray'Range) of Unbounded_Wide_Wide_String;
   VerbesserungenEinlesen : VerbesserungenEinlesenArray := (others => SystemKonstanten.LeerUnboundedString);

   type EinheitenEinlesenArray is array (EingeleseneTexturenSFML.EinheitenAccesArray'Range) of Unbounded_Wide_Wide_String;
   EinheitenEinlesen : EinheitenEinlesenArray := (others => SystemKonstanten.LeerUnboundedString);

   type GebäudeEinlesenArray is array (EingeleseneTexturenSFML.GebäudeAccessArray'Range) of Unbounded_Wide_Wide_String;
   GebäudeEinlesen : GebäudeEinlesenArray := (others => SystemKonstanten.LeerUnboundedString);

   procedure EinlesenHintergrund;
   procedure EinlesenKartenfelder;
   procedure EinlesenVerbesserungen;
   procedure EinlesenEinheiten;
   procedure EinlesenGebäude;



   function VorzeitigesZeilenende
     (AktuelleDateiExtern : in File_Type;
      AktuelleZeileExtern : in Positive)
      return Boolean;

end EinlesenTexturen;
