pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KartenDatentypen; use KartenDatentypen;
with KartengrundDatentypen;
with KartenRecords;

with Karten;

package KartengeneratorRessourcenOberflaecheWasser is

   procedure KartengeneratorRessourcenOberflächeWasser
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldVorhandenRecord)
     with
       Pre =>
         (KoordinatenExtern.YAchse <= Karten.Karteneinstellungen.Kartengröße.YAchse
          and
            KoordinatenExtern.XAchse <= Karten.Karteneinstellungen.Kartengröße.XAchse);

private

   WelcheRessource : KartengrundDatentypen.Kartenressourcen_Enum;

   type KartenressourceWahrscheinlichkeitArray is array (KartengrundDatentypen.Kartenressourcen_Oberfläche_Wasser_Enum'Range) of KartenDatentypen.Auswahlbereich;
   KartenressourceWahrscheinlichkeit : KartenressourceWahrscheinlichkeitArray := (
                                                                                  KartengrundDatentypen.Fisch_Enum => 2,
                                                                                  KartengrundDatentypen.Wal_Enum   => 2
                                                                                 );
   GezogeneZahlen : KartenressourceWahrscheinlichkeitArray;

   type WelcheMöglichkeitenArray is array (KartenressourceWahrscheinlichkeitArray'Range) of Boolean;
   WelcheMöglichkeiten : WelcheMöglichkeitenArray;



   function RessourceZusatzberechnungen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldVorhandenRecord;
      RessourceExtern : in KartengrundDatentypen.Kartenressourcen_Oberfläche_Wasser_Enum)
      return KartengrundDatentypen.Kartenressourcen_Enum
     with
       Pre =>
         (KoordinatenExtern.YAchse <= Karten.Karteneinstellungen.Kartengröße.YAchse
          and
            KoordinatenExtern.XAchse <= Karten.Karteneinstellungen.Kartengröße.XAchse);

   function ZusatzberechnungFisch
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldVorhandenRecord;
      RessourceExtern : in KartengrundDatentypen.Kartenressourcen_Oberfläche_Wasser_Enum)
      return KartengrundDatentypen.Kartenressourcen_Enum
     with
       Pre =>
         (KoordinatenExtern.YAchse <= Karten.Karteneinstellungen.Kartengröße.YAchse
          and
            KoordinatenExtern.XAchse <= Karten.Karteneinstellungen.Kartengröße.XAchse);

   function ZusatzberechnungWal
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldVorhandenRecord;
      RessourceExtern : in KartengrundDatentypen.Kartenressourcen_Oberfläche_Wasser_Enum)
      return KartengrundDatentypen.Kartenressourcen_Enum
     with
       Pre =>
         (KoordinatenExtern.YAchse <= Karten.Karteneinstellungen.Kartengröße.YAchse
          and
            KoordinatenExtern.XAchse <= Karten.Karteneinstellungen.Kartengröße.XAchse);

end KartengeneratorRessourcenOberflaecheWasser;
