pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KartenDatentypen; use KartenDatentypen;

private with RassenDatentypen;
private with RueckgabeDatentypen;
private with KartenRecords;
private with ZahlenDatentypen;
private with Weltkarte;

package SpieleinstellungenRasseLogik is
   
   procedure StartwerteErmitteln;
   procedure RassenWählen;
   procedure RasseAutomatischBelegen;
   procedure RasseBelegenSchnellstart;
   
   
   
   function EineRasseBelegt
     return Boolean;
   
private
      
   FreieFelder : KartenDatentypen.SichtweiteNatural;
   
   RassenAuswahl : RueckgabeDatentypen.Rückgabe_Werte_Enum;
   SpielerartAuswahl : RueckgabeDatentypen.Rückgabe_Werte_Enum;
   SpieleranzahlAuswahl : RueckgabeDatentypen.Rückgabe_Werte_Enum;
   
   RasseMenschSchnellstart : RassenDatentypen.Rassen_Verwendet_Enum;
   RasseKISchnellstart : RassenDatentypen.Rassen_Verwendet_Enum;
   
   GezogeneKoordinate : KartenRecords.AchsenKartenfeldNaturalRecord;
   KartenWert : KartenRecords.AchsenKartenfeldNaturalRecord;
   Zusatzkoordinate : KartenRecords.AchsenKartenfeldNaturalRecord;
      
   type KoordinatenArray is array (1 .. 2) of KartenRecords.AchsenKartenfeldNaturalRecord;
   StartKoordinaten : KoordinatenArray;
   
   procedure BelegungÄndern
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum);

   procedure StartpunktFestlegen
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      StartkoordinateEinsExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      StartkoordinateZweiExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
     with
       Pre => (
                 StartkoordinateEinsExtern.YAchse <= Weltkarte.Karteneinstellungen.Kartengröße.YAchse
               and
                 StartkoordinateEinsExtern.XAchse <= Weltkarte.Karteneinstellungen.Kartengröße.XAchse
               and
                 StartkoordinateZweiExtern.YAchse <= Weltkarte.Karteneinstellungen.Kartengröße.YAchse
               and
                 StartkoordinateZweiExtern.XAchse <= Weltkarte.Karteneinstellungen.Kartengröße.XAchse
              );
   
   

   function StartpunktPrüfen
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      NotAusExtern : in ZahlenDatentypen.NotAus)
      return Boolean;
   
   function ZusatzfeldBestimmen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      NotAusExtern : in ZahlenDatentypen.NotAus)
      return KartenRecords.AchsenKartenfeldNaturalRecord
     with
       Pre => (
                 KoordinatenExtern.YAchse <= Weltkarte.Karteneinstellungen.Kartengröße.YAchse
               and
                 KoordinatenExtern.XAchse <= Weltkarte.Karteneinstellungen.Kartengröße.XAchse
              ),
   
       Post => (
                  ZusatzfeldBestimmen'Result.YAchse <= Weltkarte.Karteneinstellungen.Kartengröße.YAchse
                and
                  ZusatzfeldBestimmen'Result.XAchse <= Weltkarte.Karteneinstellungen.Kartengröße.XAchse
               );

end SpieleinstellungenRasseLogik;
