pragma SPARK_Mode (On);

with SystemDatentypen; use SystemDatentypen;
with EinheitStadtRecords;
with GlobaleVariablen;
with EinheitStadtDatentypen;
with SystemKonstanten;

package KampfsystemEinheiten is

   function KampfsystemNahkampf
     (AngreiferExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      VerteidigerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
      return Boolean
     with
       Pre =>
         (AngreiferExtern.Rasse /= VerteidigerExtern.Rasse
          and
            GlobaleVariablen.RassenImSpiel (AngreiferExtern.Rasse) /= SystemKonstanten.LeerSpielerKonstante
          and
            GlobaleVariablen.RassenImSpiel (VerteidigerExtern.Rasse) /= SystemKonstanten.LeerSpielerKonstante
          and
            VerteidigerExtern.Platznummer in GlobaleVariablen.EinheitenGebautArray'First (2) .. GlobaleVariablen.Grenzen (VerteidigerExtern.Rasse).Einheitengrenze
          and
            AngreiferExtern.Platznummer in GlobaleVariablen.EinheitenGebautArray'First (2) .. GlobaleVariablen.Grenzen (AngreiferExtern.Rasse).Einheitengrenze);

   procedure KampfBerechnung
     (VerteidigerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      AngriffExtern : in EinheitStadtDatentypen.Kampfwerte;
      VerteidigungExtern : in EinheitStadtDatentypen.Kampfwerte)
     with
       Pre =>
         (VerteidigerExtern.Platznummer in GlobaleVariablen.EinheitenGebautArray'First (2) .. GlobaleVariablen.Grenzen (VerteidigerExtern.Rasse).Einheitengrenze
          and
            GlobaleVariablen.RassenImSpiel (VerteidigerExtern.Rasse) /= SystemKonstanten.LeerSpielerKonstante);

private

   AngerichteterSchaden : EinheitStadtDatentypen.MaximaleStädteMitNullWert;

   KampfwerteVerteidiger : EinheitStadtRecords.KampfwerteRecord;
   KampfwerteAngreifer : EinheitStadtRecords.KampfwerteRecord;

   Kampfglück : Float;

   -- Die Werte gelten immer aus Sicht des Angreifers
   type Kampf_Unterschiede_Enum is (Gleich, Stärker, Extrem_Stärker, Schwächer, Extrem_Schwächer);

   WelcherFall : Kampf_Unterschiede_Enum;

   type SchadenAngerichtetArray is array (Kampf_Unterschiede_Enum'Range, EinheitStadtDatentypen.MaximaleStädte'First .. 3) of Float;
   SchadenAngerichtet : constant SchadenAngerichtetArray := (
                                                             Gleich           =>
                                                               (1 => 0.40,
                                                                2 => 0.75,
                                                                3 => 0.90),
                                                             Stärker          =>
                                                               (1 => 0.30,
                                                                2 => 0.65,
                                                                3 => 0.80),
                                                             Extrem_Stärker   =>
                                                               (1 => 0.20,
                                                                2 => 0.50,
                                                                3 => 0.70),
                                                             Schwächer        =>
                                                               (1 => 0.55,
                                                                2 => 0.85,
                                                                3 => 0.95),
                                                             Extrem_Schwächer =>
                                                               (1 => 0.70,
                                                                2 => 0.90,
                                                                3 => 0.98)
                                                            );

   function Kampf
     (VerteidigerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      AngreiferExtern : in EinheitStadtRecords.RassePlatznummerRecord)
      return Boolean
     with
       Pre =>
         (AngreiferExtern.Rasse /= VerteidigerExtern.Rasse
          and
            GlobaleVariablen.RassenImSpiel (AngreiferExtern.Rasse) /= SystemKonstanten.LeerSpielerKonstante
          and
            GlobaleVariablen.RassenImSpiel (VerteidigerExtern.Rasse) /= SystemKonstanten.LeerSpielerKonstante
          and
            VerteidigerExtern.Platznummer in GlobaleVariablen.EinheitenGebautArray'First (2) .. GlobaleVariablen.Grenzen (VerteidigerExtern.Rasse).Einheitengrenze
          and
            AngreiferExtern.Platznummer in GlobaleVariablen.EinheitenGebautArray'First (2) .. GlobaleVariablen.Grenzen (AngreiferExtern.Rasse).Einheitengrenze);

end KampfsystemEinheiten;