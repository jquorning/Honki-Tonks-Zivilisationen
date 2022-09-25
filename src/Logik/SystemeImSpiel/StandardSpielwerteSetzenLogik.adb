pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with WichtigesRecordKonstanten;
with StadtRecordKonstanten;
with SpielVariablen;
with KartenRecordKonstanten;
with EinheitenRecordKonstanten;
with WeltkarteRecords;
with KartengeneratorRecordKonstanten;

with Weltkarte;
with KartengeneratorVariablenLogik;
with Sichtweiten;

package body StandardSpielwerteSetzenLogik is

   procedure StandardSpielwerteSetzenLogik
     (EinstellungenBehaltenExtern : in Boolean)
   is begin
      
      case
        EinstellungenBehaltenExtern
      is
         when True =>
            null;
            
         when False =>
            KartengeneratorVariablenLogik.Kartenparameter := KartenRecordKonstanten.Standardkartengeneratorparameter;
            KartengeneratorVariablenLogik.Polgrößen := KartengeneratorRecordKonstanten.Eisrand;
            KartengeneratorVariablenLogik.Landgrößen := KartengeneratorRecordKonstanten.Kontinentgröße;
      end case;
      
      SpielVariablen.EinheitenGebaut := (others => (others => EinheitenRecordKonstanten.LeerEinheit));
      SpielVariablen.StadtGebaut := (others => (others => StadtRecordKonstanten.LeerStadt));
      SpielVariablen.Wichtiges := (others => WichtigesRecordKonstanten.LeerWichtigesZeug);
      SpielVariablen.Diplomatie := (others => (others => WichtigesRecordKonstanten.StartDiplomatie));
      SpielVariablen.CursorImSpiel := (others => WichtigesRecordKonstanten.LeerCursor);
      SpielVariablen.Rassenbelegung := (others => WichtigesRecordKonstanten.LeerRassenbelegung);
      SpielVariablen.Allgemeines := WichtigesRecordKonstanten.LeerAllgemeines;
      
      Weltkarte.Karteneinstellungen := KartenRecordKonstanten.Standardkartenparameter;
      Weltkarte.Karte := (others => (others => (others => WeltkarteRecords.LeerWeltkarte)));
      
      SpielVariablen.Debug := (others => False);
      
      Sichtweiten.StandardSichtweiten;
      
   end StandardSpielwerteSetzenLogik;

end StandardSpielwerteSetzenLogik;
