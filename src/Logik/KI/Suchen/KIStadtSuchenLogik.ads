with RassenDatentypen;
with KartenDatentypen;
with KartenRecords;

private with StadtDatentypen;

with LeseWeltkarteneinstellungen;
with LeseRassenbelegung;

private with LeseGrenzen;

package KIStadtSuchenLogik is
   pragma Elaborate_Body;
   use type RassenDatentypen.Spieler_Enum;
   use type KartenDatentypen.Kartenfeld;

   function NähesteFeindlicheStadtSuchen
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      AnfangKoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
      return KartenRecords.AchsenKartenfeldNaturalRecord
     with
       Pre => (
                 LeseRassenbelegung.Belegung (RasseExtern => RasseExtern) /= RassenDatentypen.Leer_Spieler_Enum
               and
                 AnfangKoordinatenExtern.YAchse <= LeseWeltkarteneinstellungen.YAchse
               and
                 AnfangKoordinatenExtern.XAchse <= LeseWeltkarteneinstellungen.XAchse
              ),

       Post => (
                  NähesteFeindlicheStadtSuchen'Result.YAchse <= LeseWeltkarteneinstellungen.YAchse
                and
                  NähesteFeindlicheStadtSuchen'Result.XAchse <= LeseWeltkarteneinstellungen.XAchse
               );

   function UnbewachteStadtSuchen
     (FeindlicheRasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return KartenRecords.AchsenKartenfeldNaturalRecord
     with
       Pre => (
                 LeseRassenbelegung.Belegung (RasseExtern => FeindlicheRasseExtern) = RassenDatentypen.KI_Spieler_Enum
              ),

       Post => (
                  UnbewachteStadtSuchen'Result.YAchse <= LeseWeltkarteneinstellungen.YAchse
                and
                  UnbewachteStadtSuchen'Result.XAchse <= LeseWeltkarteneinstellungen.XAchse
               );

private
   use type StadtDatentypen.MaximaleStädteMitNullWert;

   AktuelleStadt : StadtDatentypen.MaximaleStädteMitNullWert;
   GefundeneStadt : StadtDatentypen.MaximaleStädteMitNullWert;

   Entfernung : Natural;
   EntfernungNeu : Natural;

   Stadtkoordinaten : KartenRecords.AchsenKartenfeldNaturalRecord;



   function StadtSuchen
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      AnfangKoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
      return StadtDatentypen.MaximaleStädteMitNullWert
     with
       Pre => (
                 LeseRassenbelegung.Belegung (RasseExtern => RasseExtern) /= RassenDatentypen.Leer_Spieler_Enum
               and
                 AnfangKoordinatenExtern.YAchse <= LeseWeltkarteneinstellungen.YAchse
               and
                 AnfangKoordinatenExtern.XAchse <= LeseWeltkarteneinstellungen.XAchse
              ),

       Post => (
                  StadtSuchen'Result <= LeseGrenzen.Städtegrenzen (RasseExtern => RasseExtern)
               );

end KIStadtSuchenLogik;
