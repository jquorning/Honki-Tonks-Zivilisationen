pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with RueckgabeDatentypen;

package KartenDatentypen is

   -- Das hier dann in KartenfeldYAchse umbenennen?
   type Kartenfeld is range -1_000 .. 1_000;
   subtype KartenfeldPositivMitNullwert is Kartenfeld range 0 .. Kartenfeld'Last;
   subtype KartenfeldPositiv is KartenfeldPositivMitNullwert range 1 .. KartenfeldPositivMitNullwert'Last;
   subtype Stadtfeld is KartenfeldPositiv range KartenfeldPositiv'First .. 20;
   subtype SichtweiteMitNullwert is KartenfeldPositivMitNullwert range KartenfeldPositivMitNullwert'First .. 10;
   subtype Sichtweite is SichtweiteMitNullwert range 1 .. SichtweiteMitNullwert'Last;
   subtype UmgebungsbereichDrei is Kartenfeld range -3 .. 3;
   subtype UmgebungsbereichZwei is UmgebungsbereichDrei range -2 .. 2;
   subtype UmgebungsbereichEins is UmgebungsbereichZwei range -1 .. 1;
   
   ------------------ Eventuell mal zwei Kartenfeldertypen anlegen mit den gleichen Eigenschaften und eines für die YAchse und das Andere für die XAchse verwenden?
   -- Könnte Verwechslungen zwischen den beiden Achsen verringern/vermeiden und wenn es zu einer Gleichbenennung kommen würde, dann sollte es immer noch funktionieren weil die Datentypen ja unterschiedlich sind.
   type KartenfeldXAchse is new Kartenfeld;
   subtype KartenfeldPositivMitNullwertXAchse is KartenfeldXAchse range KartenfeldXAchse (KartenfeldPositivMitNullwert'First) .. KartenfeldXAchse (KartenfeldPositivMitNullwert'Last);
   subtype KartenfeldPositivXAchse is KartenfeldPositivMitNullwertXAchse range KartenfeldPositivMitNullwertXAchse (KartenfeldPositiv'First) .. KartenfeldPositivMitNullwertXAchse (KartenfeldPositiv'Last);
   subtype StadtfeldXAchse is KartenfeldPositivXAchse range KartenfeldPositivXAchse (Stadtfeld'First) .. KartenfeldPositivXAchse (Stadtfeld'Last);
   subtype SichtweiteMitNullwertXAchse is KartenfeldPositivMitNullwertXAchse range KartenfeldPositivMitNullwertXAchse (SichtweiteMitNullwert'First) .. KartenfeldPositivMitNullwertXAchse (SichtweiteMitNullwert'Last);
   subtype SichtweiteXAchse is SichtweiteMitNullwertXAchse range SichtweiteMitNullwertXAchse (Sichtweite'First) .. SichtweiteMitNullwertXAchse (Sichtweite'Last);
   subtype UmgebungsbereichDreiXAchse is KartenfeldXAchse range KartenfeldXAchse (UmgebungsbereichDrei'First) .. KartenfeldXAchse (UmgebungsbereichDrei'Last);
   subtype UmgebungsbereichZweiXAchse is UmgebungsbereichDreiXAchse range UmgebungsbereichDreiXAchse (UmgebungsbereichZwei'First) .. UmgebungsbereichDreiXAchse (UmgebungsbereichZwei'Last);
   subtype UmgebungsbereichEinsXAchse is UmgebungsbereichZweiXAchse range UmgebungsbereichZweiXAchse (UmgebungsbereichEins'First) .. UmgebungsbereichZweiXAchse (UmgebungsbereichEins'Last);
   
   -- Rückgabewert, Planeteninneres, Unterirdisch/Unterwasser, Oberfläche, Himmel, Weltraum/Orbit
   subtype Ebene is UmgebungsbereichDrei range -3 .. 2;
   subtype EbeneVorhanden is Ebene range -2 .. 2;
   
   type SichtbereichAnfangEndeArray is array (1 .. 4) of Kartenfeld;
   
   -- Neue Kartengrößen immer zwischen 20 und 1.000 einfügen um Anpassungen in KartenDatentypen zu vermeiden, außer die minimale oder maximale Kartengröße soll verändert werden.
   type Kartengröße_Enum is (
                               Kartengröße_20_20_Enum, Kartengröße_40_40_Enum, Kartengröße_80_80_Enum, Kartengröße_120_80_Enum, Kartengröße_120_160_Enum, Kartengröße_160_160_Enum, Kartengröße_240_240_Enum,
                               Kartengröße_320_320_Enum, Kartengröße_1000_1000_Enum, Kartengröße_Nutzer_Enum, Kartengröße_Zufall_Enum
                              );
   pragma Ordered (Kartengröße_Enum);
   
   subtype Kartengröße_Verwendet_Enum is Kartengröße_Enum range Kartengröße_20_20_Enum .. Kartengröße_Nutzer_Enum;
   subtype Kartengröße_Standard_Enum is Kartengröße_Verwendet_Enum range Kartengröße_20_20_Enum .. Kartengröße_1000_1000_Enum;
                                
   -- Neue Kartenarten immer vor Chaos einfügen um Anpassungen in KartenDatentypen zu vermeiden.
   type Kartenart_Enum is (
                           Kartenart_Inseln_Enum, Kartenart_Kontinente_Enum, Kartenart_Pangäa_Enum, Kartenart_Nur_Land_Enum, Kartenart_Chaos_Enum
                          );
   pragma Ordered (Kartenart_Enum);
                                 
   -- Karte_E_Achse_Kein_Übergang_Enum, Karte_E_Achse_Übergang_Enum,
   -- Karte_Y_Achse_Kein_Übergang_Enum, Karte_Y_Achse_Übergang_Enum, Karte_Y_Achse_Rückwärts_Verschobener_Übergang_Enum, Karte_Y_Achse_Verschobener_Übergang_Enum,
   -- Karte_X_Achse_Kein_Übergang_Enum, Karte_X_Achse_Übergang_Enum, Karte_X_Achse_Rückwärts_Verschobener_Übergang_Enum, Karte_X_Achse_Verschobener_Übergang_Enum,      
   subtype Kartenform_Verwendet_Enum is RueckgabeDatentypen.Rückgabe_Werte_Enum range RueckgabeDatentypen.Karte_Form_X_Zylinder_Enum .. RueckgabeDatentypen.Karte_Form_Tugel_Extrem_Enum;
   subtype Kartenform_Einstellbar_Enum is RueckgabeDatentypen.Rückgabe_Werte_Enum range RueckgabeDatentypen.Karte_E_Achse_Kein_Übergang_Enum .. RueckgabeDatentypen.Karte_X_Achse_Verschobener_Übergang_Enum;
   subtype Kartenform_E_Achse_Einstellbar_Enum is Kartenform_Einstellbar_Enum range RueckgabeDatentypen.Karte_E_Achse_Kein_Übergang_Enum .. RueckgabeDatentypen.Karte_E_Achse_Übergang_Enum;
   subtype Kartenform_Y_Achse_Einstellbar_Enum is Kartenform_Einstellbar_Enum range RueckgabeDatentypen.Karte_Y_Achse_Kein_Übergang_Enum .. RueckgabeDatentypen.Karte_Y_Achse_Verschobener_Übergang_Enum;
   subtype Kartenform_X_Achse_Einstellbar_Enum is Kartenform_Einstellbar_Enum range RueckgabeDatentypen.Karte_X_Achse_Kein_Übergang_Enum .. RueckgabeDatentypen.Karte_X_Achse_Verschobener_Übergang_Enum;
                                 
   -- Neue Kartentemperaturen immer vor Wüste einfügen um Anpassungen in KartenDatentypen zu vermeiden.
   -- Kartentemperatur_Kalt_Enum, Kartentemperatur_Gemäßigt_Enum, Kartentemperatur_Heiß_Enum, Kartentemperatur_Eiszeit_Enum, Kartentemperatur_Wüste_Enum,
   subtype Kartentemperatur_Verwendet_Enum is RueckgabeDatentypen.Rückgabe_Werte_Enum range RueckgabeDatentypen.Kartentemperatur_Kalt_Enum .. RueckgabeDatentypen.Kartentemperatur_Wüste_Enum;
                                
   -- Neue Kartenressorucen immer vor Überfluss einfügen um Anpassungen in KartenDatentypen zu vermeiden.
   -- Kartenressourcen_Arm_Enum, Kartenressourcen_Wenig_Enum, Kartenressourcen_Mittel_Enum, Kartenressourcen_Viel_Enum, Kartenressourcen_Überfluss_Enum,
   subtype Kartenressourcen_Verwendet_Enum is RueckgabeDatentypen.Rückgabe_Werte_Enum range RueckgabeDatentypen.Kartenressourcen_Arm_Enum .. RueckgabeDatentypen.Kartenressourcen_Überfluss_Enum;
                                 
   -- Neue Kartenpole immer vor Karten_Pole_Beide einfügen um Anpassungen in KartenDatentypen zu vermeiden.
   ------------------------- Pole auch nur auf einer Seite ermöglichen?
   -- Karten_Pole_Keine, Karten_Pole_YAchse, Karten_Pole_XAchse, Karten_Pole_Beide,
   subtype Kartenpole_Verwendet_Enum is RueckgabeDatentypen.Rückgabe_Werte_Enum range RueckgabeDatentypen.Karten_Pole_Keine .. RueckgabeDatentypen.Karten_Pole_Beide;
   
   type GesamtbewertungFeld is range -100 .. 100;
   subtype BewertungFeld is GesamtbewertungFeld range -10 .. 10;

   type Wirtschaft_Enum is (
                            Nahrung, Produktion, Geld, Forschung
                           );
   type Kampf_Enum is (
                       Verteidigung, Angriff
                      );

end KartenDatentypen;
