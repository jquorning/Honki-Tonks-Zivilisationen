pragma SPARK_Mode (On);

with GlobaleVariablen, GlobaleRecords, GlobaleDatentypen;
use GlobaleDatentypen;

with Karten;

package EinheitenAllgemein is

   procedure Beschreibung
     (IDExtern : in GlobaleDatentypen.EinheitenID);
   
   procedure HeilungBewegungspunkteNeueRundeErmitteln;
   
   procedure EinheitErzeugen
     (KoordinatenExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord;
      EinheitNummerExtern : in GlobaleDatentypen.MaximaleEinheiten;
      IDExtern : in GlobaleDatentypen.EinheitenID;
      StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (StadtRasseNummerExtern.Rasse) /= GlobaleDatentypen.Leer
          and
            KoordinatenExtern.YAchse <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße
          and
            KoordinatenExtern.XAchse <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße);

   procedure EinheitEntfernen
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
     with
       Pre =>
         (EinheitRasseNummerExtern.Platznummer in GlobaleVariablen.EinheitenGebautArray'First (2) .. GlobaleVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
          and
            GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) /= GlobaleDatentypen.Leer);
   
   procedure Beschäftigung
     (ArbeitExtern : in GlobaleDatentypen.Tastenbelegung_Enum);
   
   procedure HeimatstadtÄndern
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) /= GlobaleDatentypen.Leer);
   
   

   function BeschäftigungAbbrechenVerbesserungErsetzenBrandschatzenEinheitAuflösen
     (WelcheAuswahlExtern : in Natural)
      return Boolean;
   
   function EinheitTransporterAuswählen
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
      return GlobaleDatentypen.MaximaleEinheitenMitNullWert     
     with
       Pre =>
         (EinheitRasseNummerExtern.Platznummer in GlobaleVariablen.EinheitenGebautArray'First (2) .. GlobaleVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
          and
            GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) /= GlobaleDatentypen.Leer);
   
   function KannTransportiertWerden
     (LadungExtern, TransporterExtern : in GlobaleRecords.RassePlatznummerRecord)
      return Boolean
     with
       Pre =>
         (LadungExtern.Platznummer in GlobaleVariablen.EinheitenGebautArray'First (2) .. GlobaleVariablen.Grenzen (LadungExtern.Rasse).Einheitengrenze
          and
            GlobaleVariablen.RassenImSpiel (LadungExtern.Rasse) /= GlobaleDatentypen.Leer
          and
            TransporterExtern.Platznummer in GlobaleVariablen.EinheitenGebautArray'First (2) .. GlobaleVariablen.Grenzen (TransporterExtern.Rasse).Einheitengrenze
          and
            GlobaleVariablen.RassenImSpiel (TransporterExtern.Rasse) /= GlobaleDatentypen.Leer);
   
   function IDTransporterAusLadung
     (LadungExtern : in GlobaleRecords.RassePlatznummerRecord)
      return GlobaleDatentypen.EinheitenIDMitNullWert
     with
       Pre =>
         (LadungExtern.Platznummer in GlobaleVariablen.EinheitenGebautArray'First (2) .. GlobaleVariablen.Grenzen (LadungExtern.Rasse).Einheitengrenze
          and
            GlobaleVariablen.RassenImSpiel (LadungExtern.Rasse) /= GlobaleDatentypen.Leer);

private
   
   StadtNummer : GlobaleDatentypen.MaximaleStädteMitNullWert;
   
   Heilungsrate : constant GlobaleDatentypen.MaximaleStädte := 10;
   
   ErhalteneErfahrungspunkte : GlobaleDatentypen.MaximaleStädte;
   
   AktuelleAuswahl : GlobaleDatentypen.EinheitenIDMitNullWert;
   Ende : GlobaleDatentypen.EinheitenIDMitNullWert;
   AktuellePosition : GlobaleDatentypen.EinheitenIDMitNullWert;
   
   EinheitNummer : GlobaleDatentypen.MaximaleEinheitenMitNullWert;
   StadtNummerAlt : GlobaleDatentypen.MaximaleStädteMitNullWert;
   StadtNummerNeu : GlobaleDatentypen.MaximaleStädteMitNullWert;

   Position : GlobaleRecords.AchsenKartenfeldPositivRecord;

   procedure HeilungBewegungspunkteNeueRundeSetzen
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
     with
       Pre =>
         (EinheitRasseNummerExtern.Platznummer in GlobaleVariablen.EinheitenGebautArray'First (2) .. GlobaleVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
          and
            GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) /= GlobaleDatentypen.Leer);
   
   procedure PermanenteKostenDurchEinheitÄndern
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      IDExtern : in GlobaleDatentypen.EinheitenID;
      VorzeichenWechselExtern : in GlobaleDatentypen.LoopRangeMinusEinsZuEins)
     with
       Pre =>
         (VorzeichenWechselExtern /= 0);

end EinheitenAllgemein;
