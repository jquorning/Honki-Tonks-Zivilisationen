with SpeziesDatentypen;
with EinheitenRecords;
with EinheitenKonstanten;

private with EinheitenDatentypen;
private with KartenRecords;
private with KartenDatentypen;

with LeseGrenzen;
with LeseSpeziesbelegung;

private with LeseWeltkarteneinstellungen;

package EinheitentransporterLogik is
   pragma Elaborate_Body;
   use type SpeziesDatentypen.Spieler_Enum;
   
   procedure TransporterEntladen
     (TransporterExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
     with
       Pre => (
                 TransporterExtern.Nummer in EinheitenKonstanten.AnfangNummer .. LeseGrenzen.Einheitengrenze (SpeziesExtern => TransporterExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => TransporterExtern.Spezies) /= SpeziesDatentypen.Leer_Spieler_Enum
              );
   
   function KannTransportiertWerden
     (LadungExtern : in EinheitenRecords.SpeziesEinheitnummerRecord;
      TransporterExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
      return Boolean
     with
       Pre => (
                 LadungExtern.Nummer in EinheitenKonstanten.AnfangNummer .. LeseGrenzen.Einheitengrenze (SpeziesExtern => LadungExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => LadungExtern.Spezies) /= SpeziesDatentypen.Leer_Spieler_Enum
               and
                 TransporterExtern.Nummer in EinheitenKonstanten.AnfangNummer .. LeseGrenzen.Einheitengrenze (SpeziesExtern => TransporterExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => TransporterExtern.Spezies) /= SpeziesDatentypen.Leer_Spieler_Enum
              );
   
private
   use type KartenDatentypen.Kartenfeld;
   
   Transporterkapazität : EinheitenDatentypen.Transportplätze;
   
   TransporterID : EinheitenDatentypen.EinheitenIDMitNullWert;
   LadungID : EinheitenDatentypen.EinheitenIDMitNullWert;
   
   AktuelleLadung : EinheitenDatentypen.MaximaleEinheitenMitNullWert;
   
   EinheitVorhanden : EinheitenRecords.SpeziesEinheitnummerRecord;
   
   TransporterKoordinaten : KartenRecords.AchsenKartenfeldNaturalRecord;
   KartenWert : KartenRecords.AchsenKartenfeldNaturalRecord;
   
   procedure TransporterUmgebung
     (TranspoterKoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      LadungExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
     with
       Pre => (
                 LadungExtern.Nummer in EinheitenKonstanten.AnfangNummer .. LeseGrenzen.Einheitengrenze (SpeziesExtern => LadungExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => LadungExtern.Spezies) /= SpeziesDatentypen.Leer_Spieler_Enum
               and
                 TranspoterKoordinatenExtern.YAchse <= LeseWeltkarteneinstellungen.YAchse
               and
                 TranspoterKoordinatenExtern.XAchse <= LeseWeltkarteneinstellungen.XAchse
              );
   
   
   
   function Entladung
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      LadungExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
      return Boolean
     with
       Pre => (
                 LadungExtern.Nummer in EinheitenKonstanten.AnfangNummer .. LeseGrenzen.Einheitengrenze (SpeziesExtern => LadungExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => LadungExtern.Spezies) /= SpeziesDatentypen.Leer_Spieler_Enum
               and
                 KoordinatenExtern.YAchse <= LeseWeltkarteneinstellungen.YAchse
               and
                 KoordinatenExtern.XAchse <= LeseWeltkarteneinstellungen.XAchse
              );

end EinheitentransporterLogik;
