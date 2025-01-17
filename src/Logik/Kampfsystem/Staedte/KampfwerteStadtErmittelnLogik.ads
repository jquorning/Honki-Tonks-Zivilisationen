with SpeziesDatentypen;
with KampfDatentypen;
with StadtRecords;
with KartenverbesserungDatentypen;
with KartenRecords;

with LeseSpeziesbelegung;

package KampfwerteStadtErmittelnLogik is
   pragma Elaborate_Body;
   use type SpeziesDatentypen.Spieler_Enum;

   function AktuelleVerteidigungStadt
     (IDExtern : in KartenverbesserungDatentypen.Karten_Verbesserung_Stadt_ID_Enum;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
      GebäudeExtern : in StadtRecords.GebäudeVorhandenArray)
      return KampfDatentypen.KampfwerteGroß
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
              );
   
   function AktuellerAngriffStadt
     (IDExtern : in KartenverbesserungDatentypen.Karten_Verbesserung_Stadt_ID_Enum;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
      GebäudeExtern : in StadtRecords.GebäudeVorhandenArray)
      return KampfDatentypen.KampfwerteGroß
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
              );
   
private
   
   VerteidigungWert : KampfDatentypen.KampfwerteGroß;
   AngriffWert : KampfDatentypen.KampfwerteGroß;

end KampfwerteStadtErmittelnLogik;
