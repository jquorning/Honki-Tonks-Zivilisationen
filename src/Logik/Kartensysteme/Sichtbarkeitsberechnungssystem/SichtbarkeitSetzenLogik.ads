pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with RassenDatentypen; use RassenDatentypen;
with KartenRecords;
with SpielVariablen;
with Weltkarte;
with KartenDatentypen;

private with StadtRecords;
private with EinheitenRecords;
private with KartengrundDatentypen;

package SichtbarkeitSetzenLogik is
   
   procedure SichtbarkeitSetzen
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
     with
       Pre => (
                 KoordinatenExtern.YAchse in Weltkarte.KarteArray'First (2) .. Weltkarte.Karteneinstellungen.Kartengröße.YAchse
               and
                 KoordinatenExtern.XAchse in Weltkarte.KarteArray'First (3) .. Weltkarte.Karteneinstellungen.Kartengröße.XAchse
               and
                 SpielVariablen.Rassenbelegung (RasseExtern).Belegung /= RassenDatentypen.Leer_Spieler_Enum
              );

   procedure EbenenBerechnungen
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
     with
       Pre => (
                 KoordinatenExtern.YAchse in Weltkarte.KarteArray'First (2) .. Weltkarte.Karteneinstellungen.Kartengröße.YAchse
               and
                 KoordinatenExtern.XAchse in Weltkarte.KarteArray'First (3) .. Weltkarte.Karteneinstellungen.Kartengröße.XAchse
               and
                 SpielVariablen.Rassenbelegung (RasseExtern).Belegung /= RassenDatentypen.Leer_Spieler_Enum
              );
   
private
      
   EAchseAnfang : KartenDatentypen.EbeneVorhanden;
   EAchseEnde : KartenDatentypen.EbeneVorhanden;

   AktuellerGrund : KartengrundDatentypen.Kartengrund_Vorhanden_Enum;
   BasisGrund : KartengrundDatentypen.Kartengrund_Vorhanden_Enum;

   FremdeStadt : StadtRecords.RasseStadtnummerRecord;

   FremdeEinheit : EinheitenRecords.RasseEinheitnummerRecord;

end SichtbarkeitSetzenLogik;