pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KartenDatentypen; use KartenDatentypen;
with KartenRecords;
with Weltkarte;

private with KartengrundDatentypen;
private with SystemDatentypen;

package KartengeneratorUnterlandressourcenLogik is
   pragma Elaborate_Body;

   procedure KartengeneratorUnterlandressourcen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldVorhandenRecord)
     with
       Pre => (
                 KoordinatenExtern.YAchse <= Weltkarte.Karteneinstellungen.Kartengröße.YAchse
               and
                 KoordinatenExtern.XAchse <= Weltkarte.Karteneinstellungen.Kartengröße.XAchse
              );

private

   WelcheRessource : KartengrundDatentypen.Kartenressourcen_Enum;

   type KartenressourceWahrscheinlichkeitArray is array (KartengrundDatentypen.Kartenressourcen_Unterfläche_Land_Enum'Range) of SystemDatentypen.NullBisHundert;
   KartenressourceWahrscheinlichkeit : KartenressourceWahrscheinlichkeitArray := (
                                                                                  KartengrundDatentypen.Kohle_Enum              => 2,
                                                                                  KartengrundDatentypen.Eisen_Enum              => 2,
                                                                                  KartengrundDatentypen.Öl_Enum                 => 2,
                                                                                  KartengrundDatentypen.Hochwertiger_Boden_Enum => 2,
                                                                                  KartengrundDatentypen.Gold_Enum               => 2
                                                                                 );
   GezogeneZahlen : KartenressourceWahrscheinlichkeitArray;

   type WelcheMöglichkeitenArray is array (KartenressourceWahrscheinlichkeitArray'Range) of Boolean;
   WelcheMöglichkeiten : WelcheMöglichkeitenArray;



   function RessourceZusatzberechnungen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldVorhandenRecord;
      RessourceExtern : in KartengrundDatentypen.Kartenressourcen_Unterfläche_Land_Enum)
      return KartengrundDatentypen.Kartenressourcen_Enum
     with
       Pre => (
                 KoordinatenExtern.YAchse <= Weltkarte.Karteneinstellungen.Kartengröße.YAchse
               and
                 KoordinatenExtern.XAchse <= Weltkarte.Karteneinstellungen.Kartengröße.XAchse
              );

   function ZusatzberechnungKohle
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldVorhandenRecord;
      RessourceExtern : in KartengrundDatentypen.Kartenressourcen_Unterfläche_Land_Enum)
      return KartengrundDatentypen.Kartenressourcen_Enum
     with
       Pre => (
                 KoordinatenExtern.YAchse <= Weltkarte.Karteneinstellungen.Kartengröße.YAchse
               and
                 KoordinatenExtern.XAchse <= Weltkarte.Karteneinstellungen.Kartengröße.XAchse
              );

   function ZusatzberechnungEisen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldVorhandenRecord;
      RessourceExtern : in KartengrundDatentypen.Kartenressourcen_Unterfläche_Land_Enum)
      return KartengrundDatentypen.Kartenressourcen_Enum
     with
       Pre => (
                 KoordinatenExtern.YAchse <= Weltkarte.Karteneinstellungen.Kartengröße.YAchse
               and
                 KoordinatenExtern.XAchse <= Weltkarte.Karteneinstellungen.Kartengröße.XAchse
              );

   function ZusatzberechnungÖl
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldVorhandenRecord;
      RessourceExtern : in KartengrundDatentypen.Kartenressourcen_Unterfläche_Land_Enum)
      return KartengrundDatentypen.Kartenressourcen_Enum
     with
       Pre => (
                 KoordinatenExtern.YAchse <= Weltkarte.Karteneinstellungen.Kartengröße.YAchse
               and
                 KoordinatenExtern.XAchse <= Weltkarte.Karteneinstellungen.Kartengröße.XAchse
              );

   function ZusatzberechnungHochwertigerBoden
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldVorhandenRecord;
      RessourceExtern : in KartengrundDatentypen.Kartenressourcen_Unterfläche_Land_Enum)
      return KartengrundDatentypen.Kartenressourcen_Enum
     with
       Pre => (
                 KoordinatenExtern.YAchse <= Weltkarte.Karteneinstellungen.Kartengröße.YAchse
               and
                 KoordinatenExtern.XAchse <= Weltkarte.Karteneinstellungen.Kartengröße.XAchse
              );

   function ZusatzberechnungGold
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldVorhandenRecord;
      RessourceExtern : in KartengrundDatentypen.Kartenressourcen_Unterfläche_Land_Enum)
      return KartengrundDatentypen.Kartenressourcen_Enum
     with
       Pre => (
                 KoordinatenExtern.YAchse <= Weltkarte.Karteneinstellungen.Kartengröße.YAchse
               and
                 KoordinatenExtern.XAchse <= Weltkarte.Karteneinstellungen.Kartengröße.XAchse
              );

end KartengeneratorUnterlandressourcenLogik;
