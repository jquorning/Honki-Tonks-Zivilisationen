with KartenDatentypen;
with RassenDatentypen;
with EinheitenDatentypen;
with KartenRecords;
with EinheitenRecords;
with SpielVariablen;

with LeseWeltkarteneinstellungen;
with LeseGrenzen;

package EinheitSuchenLogik is
   pragma Elaborate_Body;
   use type KartenDatentypen.Kartenfeld;
   use type RassenDatentypen.Spieler_Enum;
   use type EinheitenDatentypen.MaximaleEinheitenMitNullWert;

   function KoordinatenEinheitMitRasseSuchen
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      LogikGrafikExtern : in Boolean)
      return EinheitenDatentypen.MaximaleEinheitenMitNullWert
     with
       Pre => (
                 KoordinatenExtern.YAchse <= LeseWeltkarteneinstellungen.YAchse
               and
                 KoordinatenExtern.XAchse <= LeseWeltkarteneinstellungen.XAchse
               and
                 SpielVariablen.Rassenbelegung (RasseExtern).Belegung /= RassenDatentypen.Leer_Spieler_Enum
              ),
                      
       Post => (
                  KoordinatenEinheitMitRasseSuchen'Result <= LeseGrenzen.Einheitengrenze (RasseExtern => RasseExtern)
               );

   function KoordinatenEinheitOhneRasseSuchen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      LogikGrafikExtern : in Boolean)
      return EinheitenRecords.RasseEinheitnummerRecord
     with
       Pre => (
                 KoordinatenExtern.YAchse <= LeseWeltkarteneinstellungen.YAchse
               and
                 KoordinatenExtern.XAchse <= LeseWeltkarteneinstellungen.XAchse
              );

   function KoordinatenEinheitOhneSpezielleRasseSuchen
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      LogikGrafikExtern : in Boolean)
      return EinheitenRecords.RasseEinheitnummerRecord
     with
       Pre => (
                 KoordinatenExtern.YAchse <= LeseWeltkarteneinstellungen.YAchse
               and
                 KoordinatenExtern.XAchse <= LeseWeltkarteneinstellungen.XAchse
               and
                 SpielVariablen.Rassenbelegung (RasseExtern).Belegung /= RassenDatentypen.Leer_Spieler_Enum
              );
   
   function TransporterladungSuchen
     (TransporterExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      LadungsnummerExtern : in EinheitenDatentypen.MaximaleEinheitenMitNullWert)
      return Boolean;
   
private
   
   Transporterkapazität : EinheitenDatentypen.Transportplätze;
   
   type TransporternummerArray is array (Boolean'Range) of EinheitenDatentypen.MaximaleEinheitenMitNullWert;
   Transporternummer : TransporternummerArray;
   
   type EinheitArray is array (Boolean'Range) of EinheitenRecords.RasseEinheitnummerRecord;
   Einheit : EinheitArray;
   
   
   
   function TransporterverschachtelungDurchgehen
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      LogikGrafikExtern : in Boolean)
      return EinheitenRecords.RasseEinheitnummerRecord
     with
       Pre => (
                 SpielVariablen.Rassenbelegung (EinheitRasseNummerExtern.Rasse).Belegung /= RassenDatentypen.Leer_Spieler_Enum
              );
   
end EinheitSuchenLogik;
