pragma SPARK_Mode (On);

with SystemDatentypen; use SystemDatentypen;
with EinheitStadtRecords;
with GlobaleVariablen;
with EinheitStadtDatentypen;
with SystemKonstanten;

package KampfwerteEinheitErmitteln is

   function AktuelleVerteidigungEinheit
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      AngreiferExtern : in Boolean)
      return EinheitStadtDatentypen.Kampfwerte
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) /= SystemKonstanten.LeerSpielerKonstante
          and
            EinheitRasseNummerExtern.Platznummer in GlobaleVariablen.EinheitenGebautArray'First (2) .. GlobaleVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze);
   
   function AktuellerAngriffEinheit
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      AngreiferExtern : in Boolean)
      return EinheitStadtDatentypen.Kampfwerte
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) /= SystemKonstanten.LeerSpielerKonstante
          and
            EinheitRasseNummerExtern.Platznummer in GlobaleVariablen.EinheitenGebautArray'First (2) .. GlobaleVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze);
   
private
   
   VerschanzungBonus : constant Float := 1.25;
   StadtBonus : constant Float := 1.25;
   -- Drin lassen? Anders gestalten?
   AngriffBonus : constant Float := 1.25;
   
   VerteidigungWert : EinheitStadtDatentypen.Kampfwerte;
   AngriffWert : EinheitStadtDatentypen.Kampfwerte;
   Bonus : EinheitStadtDatentypen.Kampfwerte;
   
   VerteidigungWertFloat : Float;
   AngriffWertFloat : Float;
   
   function VerteidigungsbonusVerteidiger
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
      return EinheitStadtDatentypen.Kampfwerte;
   
   function VerteidigungsbonusAngreifer
     return EinheitStadtDatentypen.Kampfwerte;
   
   function AngriffsbonusAngreifer
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
      return EinheitStadtDatentypen.Kampfwerte;
   
   function AngriffsbonusVerteidiger
     return EinheitStadtDatentypen.Kampfwerte;

end KampfwerteEinheitErmitteln;