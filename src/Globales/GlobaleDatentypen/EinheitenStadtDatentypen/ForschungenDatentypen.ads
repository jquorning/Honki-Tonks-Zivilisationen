pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

package ForschungenDatentypen is

   -- Die -1 wird benötigt für Gebäude/Einheiten die nicht möglich sind zu bauen/unbelegt sind.
   type ForschungIDNichtMöglich is range -1 .. 75;
   subtype ForschungIDMitNullWert is ForschungIDNichtMöglich range 0 .. ForschungIDNichtMöglich'Last;
   subtype ForschungID is ForschungIDMitNullWert range 1 .. ForschungIDMitNullWert'Last;

   type AnforderungForschungArray is array (1 .. 4) of ForschungIDNichtMöglich;
   type ErforschtArray is array (ForschungID'Range) of Boolean;
   
end ForschungenDatentypen;
