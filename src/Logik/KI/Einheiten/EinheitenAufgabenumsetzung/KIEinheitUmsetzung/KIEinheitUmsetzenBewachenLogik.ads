with RassenDatentypen;
with SpielVariablen;
with EinheitenRecords;

package KIEinheitUmsetzenBewachenLogik is
   pragma Elaborate_Body;
   use type RassenDatentypen.Spieler_Enum;

   function StadtBewachen
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return Boolean
     with
       Pre => (
                 EinheitRasseNummerExtern.Nummer in SpielVariablen.EinheitenGebautArray'First (2) .. SpielVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
               and
                 SpielVariablen.Rassenbelegung (EinheitRasseNummerExtern.Rasse).Belegung = RassenDatentypen.KI_Spieler_Enum
              );

end KIEinheitUmsetzenBewachenLogik;