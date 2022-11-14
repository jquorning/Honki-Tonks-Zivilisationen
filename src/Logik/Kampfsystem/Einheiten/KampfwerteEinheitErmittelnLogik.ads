with RassenDatentypen;
with EinheitenRecords;
with SpielVariablen;
with KampfDatentypen;

package KampfwerteEinheitErmittelnLogik is
   pragma Elaborate_Body;
   use type RassenDatentypen.Rassen_Enum;
   use type RassenDatentypen.Spieler_Enum;
   
   function Gesamtverteidigung
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return KampfDatentypen.KampfwerteGroß
     with
       Pre => (
                 SpielVariablen.Rassenbelegung (EinheitRasseNummerExtern.Rasse).Belegung /= RassenDatentypen.Leer_Spieler_Enum
               and
                 EinheitRasseNummerExtern.Nummer in SpielVariablen.EinheitenGebautArray'First (2) .. SpielVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
              );
   
   function Gesamtangriff
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return KampfDatentypen.KampfwerteGroß
     with
       Pre => (
                 SpielVariablen.Rassenbelegung (EinheitRasseNummerExtern.Rasse).Belegung /= RassenDatentypen.Leer_Spieler_Enum
               and
                 EinheitRasseNummerExtern.Nummer in SpielVariablen.EinheitenGebautArray'First (2) .. SpielVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
              );
   
private
   
   Grundverteidigung : KampfDatentypen.KampfwerteEinheiten;
   Bonusverteidigung : KampfDatentypen.KampfwerteAllgemein;
   GesamteVerteidigung : KampfDatentypen.KampfwerteGroß;
   Grundangriff : KampfDatentypen.KampfwerteEinheiten;
   Bonusangriff : KampfDatentypen.KampfwerteAllgemein;
   GesamterAngriff : KampfDatentypen.KampfwerteGroß;
   
   Verschanzungsbonus : constant Float := 1.25;

end KampfwerteEinheitErmittelnLogik;
