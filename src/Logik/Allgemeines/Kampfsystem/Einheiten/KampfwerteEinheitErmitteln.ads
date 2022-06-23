pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with RassenDatentypen; use RassenDatentypen;
with EinheitenRecords;
with SonstigeVariablen;
with SpielVariablen;
with KampfDatentypen;

package KampfwerteEinheitErmitteln is

   function AktuelleVerteidigungEinheit
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      AngreiferExtern : in Boolean)
      return KampfDatentypen.Kampfwerte
     with
       Pre => (
                 SonstigeVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) /= RassenDatentypen.Leer_Spieler_Enum
               and
                 EinheitRasseNummerExtern.Nummer in SpielVariablen.EinheitenGebautArray'First (2) .. SpielVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
              );
   
   function AktuellerAngriffEinheit
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      AngreiferExtern : in Boolean)
      return KampfDatentypen.Kampfwerte
     with
       Pre => (
                 SonstigeVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) /= RassenDatentypen.Leer_Spieler_Enum
               and
                 EinheitRasseNummerExtern.Nummer in SpielVariablen.EinheitenGebautArray'First (2) .. SpielVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
              );
   
private
   
   VerschanzungBonus : constant Float := 1.25;
   StadtBonus : constant Float := 1.25;
   -- Drin lassen? Anders gestalten?
   AngriffBonus : constant Float := 1.25;
   
   VerteidigungWert : KampfDatentypen.Kampfwerte;
   AngriffWert : KampfDatentypen.Kampfwerte;
   Bonus : KampfDatentypen.Kampfwerte;
   
   VerteidigungWertFloat : Float;
   AngriffWertFloat : Float;
   
   function VerteidigungsbonusVerteidiger
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return KampfDatentypen.Kampfwerte
     with
       Pre => (
                 SonstigeVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) /= RassenDatentypen.Leer_Spieler_Enum
               and
                 EinheitRasseNummerExtern.Nummer in SpielVariablen.EinheitenGebautArray'First (2) .. SpielVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
              );
   
   function VerteidigungsbonusAngreifer
     return KampfDatentypen.Kampfwerte;
   
   function AngriffsbonusAngreifer
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return KampfDatentypen.Kampfwerte
     with
       Pre => (
                 SonstigeVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) /= RassenDatentypen.Leer_Spieler_Enum
               and
                 EinheitRasseNummerExtern.Nummer in SpielVariablen.EinheitenGebautArray'First (2) .. SpielVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
              );
   
   function AngriffsbonusVerteidiger
     return KampfDatentypen.Kampfwerte;

end KampfwerteEinheitErmitteln;
