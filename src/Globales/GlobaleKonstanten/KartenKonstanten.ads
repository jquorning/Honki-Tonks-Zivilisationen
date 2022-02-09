pragma SPARK_Mode (On);

with SystemDatentypen;
with KartenRecords;
with SystemKonstanten;
with KartenDatentypen;
with EinheitStadtDatentypen;
with StadtKonstanten;

with DatenbankRecords;

package KartenKonstanten is
   
   -- Für Karteneinstellungen
   Kartengröße2020Konstante : constant KartenDatentypen.Kartengröße_Standard_Enum := SystemDatentypen.Karte_Größe_20_20;
   Kartengröße4040Konstante : constant KartenDatentypen.Kartengröße_Standard_Enum := SystemDatentypen.Karte_Größe_40_40;
   Kartengröße8080Konstante : constant KartenDatentypen.Kartengröße_Standard_Enum := SystemDatentypen.Karte_Größe_80_80;
   Kartengröße12080Konstante : constant KartenDatentypen.Kartengröße_Standard_Enum := SystemDatentypen.Karte_Größe_120_80;
   Kartengröße120160Konstante : constant KartenDatentypen.Kartengröße_Standard_Enum := SystemDatentypen.Karte_Größe_120_160;
   Kartengröße160160Konstante : constant KartenDatentypen.Kartengröße_Standard_Enum := SystemDatentypen.Karte_Größe_160_160;
   Kartengröße240240Konstante : constant KartenDatentypen.Kartengröße_Standard_Enum := SystemDatentypen.Karte_Größe_240_240;
   Kartengröße320320Konstante : constant KartenDatentypen.Kartengröße_Standard_Enum := SystemDatentypen.Karte_Größe_320_320;
   Kartengröße10001000Konstante : constant KartenDatentypen.Kartengröße_Standard_Enum := SystemDatentypen.Karte_Größe_1000_1000;
   KartengrößeNutzerKonstante : constant KartenDatentypen.Kartengröße_Verwendet_Enum := SystemDatentypen.Karte_Größe_Nutzer;
   KartengrößeZufallKonstante : constant KartenDatentypen.Kartengröße_Enum := SystemDatentypen.Karte_Größe_Zufall;
   
   KartenartInselnKonstante : constant KartenDatentypen.Kartenart_Verwendet_Enum := SystemDatentypen.Karte_Art_Inseln;
   KartenartKontinenteKonstante : constant KartenDatentypen.Kartenart_Verwendet_Enum := SystemDatentypen.Karte_Art_Kontinente;
   KartenartPangäaKonstante : constant KartenDatentypen.Kartenart_Verwendet_Enum := SystemDatentypen.Karte_Art_Pangäa;
   KartenartLandKonstante : constant KartenDatentypen.Kartenart_Verwendet_Enum := SystemDatentypen.Karte_Art_Nur_Land;
   KartenartChaosKonstante : constant KartenDatentypen.Kartenart_Verwendet_Enum := SystemDatentypen.Karte_Art_Chaos;
   
   KartenformXZylinderKonstante : constant KartenDatentypen.Kartenform_Verwendet_Enum := SystemDatentypen.Karte_Form_X_Zylinder;
   KartenformYZylinderKonstante : constant KartenDatentypen.Kartenform_Verwendet_Enum := SystemDatentypen.Karte_Form_Y_Zylinder;
   KartenformTorusKonstante : constant KartenDatentypen.Kartenform_Verwendet_Enum := SystemDatentypen.Karte_Form_Torus;
   KartenformKugelKonstante : constant KartenDatentypen.Kartenform_Verwendet_Enum := SystemDatentypen.Karte_Form_Kugel;
   KartenformViereckKonstante : constant KartenDatentypen.Kartenform_Verwendet_Enum := SystemDatentypen.Karte_Form_Viereck;
   KartenformKugelGedrehtKonstante : constant KartenDatentypen.Kartenform_Verwendet_Enum := SystemDatentypen.Karte_Form_Kugel_Gedreht;
   KartenformTugelKonstante : constant KartenDatentypen.Kartenform_Verwendet_Enum := SystemDatentypen.Karte_Form_Tugel;
   KartenformTugelGedrehtKonstante : constant KartenDatentypen.Kartenform_Verwendet_Enum := SystemDatentypen.Karte_Form_Tugel_Gedreht;
   KartenformTugelExtremKonstante : constant KartenDatentypen.Kartenform_Verwendet_Enum := SystemDatentypen.Karte_Form_Tugel_Extrem;
   
   KartenformStandard : constant KartenRecords.KartenformRecord := (SystemDatentypen.Karte_E_Achse_Fest,
                                                                    SystemDatentypen.Karte_Y_Achse_Fest,
                                                                    SystemDatentypen.Karte_X_Achse_Normaler_Übergang);
   
   TemperaturKaltKonstante : constant KartenDatentypen.Kartentemperatur_Verwendet_Enum := SystemDatentypen.Karte_Temperatur_Kalt;
   TemperaturGemäßigtKonstante : constant KartenDatentypen.Kartentemperatur_Verwendet_Enum := SystemDatentypen.Karte_Temperatur_Gemäßigt;
   TemperaturHeißKonstante : constant KartenDatentypen.Kartentemperatur_Verwendet_Enum := SystemDatentypen.Karte_Temperatur_Heiß;
   TemperaturEiszeitKonstante : constant KartenDatentypen.Kartentemperatur_Verwendet_Enum := SystemDatentypen.Karte_Temperatur_Eiszeit;
   TemperaturWüsteKonstante : constant KartenDatentypen.Kartentemperatur_Verwendet_Enum := SystemDatentypen.Karte_Temperatur_Wüste;
   
   RessourcenArmKonstante : constant KartenDatentypen.Kartenressourcen_Verwendet_Enum := SystemDatentypen.Karte_Ressource_Arm;
   RessourcenWenigKonstante : constant KartenDatentypen.Kartenressourcen_Verwendet_Enum := SystemDatentypen.Karte_Ressource_Wenig;
   RessourcenMittelKonstante : constant KartenDatentypen.Kartenressourcen_Verwendet_Enum := SystemDatentypen.Karte_Ressource_Mittel;
   RessourcenVielKonstante : constant KartenDatentypen.Kartenressourcen_Verwendet_Enum := SystemDatentypen.Karte_Ressource_Viel;
   RessourcenÜberflussKonstante : constant KartenDatentypen.Kartenressourcen_Verwendet_Enum := SystemDatentypen.Karte_Ressource_Überfluss;
   -- Für Karteneinstellungen
   
   

   LeerVorhandeneEAchse : constant KartenDatentypen.EbeneVorhanden := KartenDatentypen.EbeneVorhanden'First;
   LeerEAchse : constant KartenDatentypen.Ebene := KartenDatentypen.Ebene'First;
   LeerYAchse : constant KartenDatentypen.KartenfeldPositivMitNullwert := KartenDatentypen.KartenfeldPositivMitNullwert'First;
   LeerXAchse : constant KartenDatentypen.KartenfeldPositivMitNullwert := KartenDatentypen.KartenfeldPositivMitNullwert'First;

   LeerKartenPosition : constant KartenRecords.AchsenKartenfeldPositivRecord := (EAchse => LeerEAchse,
                                                                                 YAchse => LeerYAchse,
                                                                                 XAchse => LeerXAchse);
   
   LeerKartenGrafik : constant Wide_Wide_Character := SystemKonstanten.LeerZeichen;
   LeerPassierbarkeit : constant Boolean := False;
      
   LeerBewertung : constant KartenDatentypen.BewertungFeld := 0;
   LeerWirtschaft : constant EinheitStadtDatentypen.ProduktionElement := 0;
   LeerKampf : constant EinheitStadtDatentypen.Kampfwerte := EinheitStadtDatentypen.Kampfwerte'First;
   
   LeerKartenListe : constant DatenbankRecords.KartenListeRecord := (
                                                                     KartenGrafik   => LeerKartenGrafik,
                                                                     Passierbarkeit => (others => LeerPassierbarkeit),
                                                                     Bewertung      => (others => LeerBewertung),
                                                                     Wirtschaft     => (others => (others => LeerWirtschaft)),
                                                                     Kampf          => (others => (others => LeerKampf))
                                                                    );
   
   LeerGrund : constant KartenDatentypen.Karten_Grund_Enum := KartenDatentypen.Leer;
   LeerHügel : constant Boolean := False;
   LeerSichtbar : constant Boolean := False;
   LeerFluss : constant KartenDatentypen.Karten_Grund_Enum := KartenDatentypen.Leer;
   LeerVerbesserungWeg : constant KartenDatentypen.Karten_Verbesserung_Enum := KartenDatentypen.Leer;
   LeerVerbesserungGebiet : constant KartenDatentypen.Karten_Verbesserung_Enum := KartenDatentypen.Leer;
   LeerRessource : constant KartenDatentypen.Karten_Grund_Enum := KartenDatentypen.Leer;
   LeerDurchStadtBelegterGrund : constant KartenRecords.BelegterGrundRecord := (StadtKonstanten.LeerRasse, StadtKonstanten.LeerNummer);
   LeerFelderwertung : constant KartenDatentypen.GesamtbewertungFeld := 0;

   LeerWeltkarte : constant KartenRecords.KartenRecord := (
                                                           Grund                   => LeerGrund,
                                                           Hügel                   => LeerHügel,
                                                           Sichtbar                => (others => LeerSichtbar),
                                                           Fluss                   => LeerFluss,
                                                           VerbesserungWeg         => LeerVerbesserungWeg,
                                                           VerbesserungGebiet      => LeerVerbesserungGebiet,
                                                           Ressource               => LeerRessource,
                                                           DurchStadtBelegterGrund => LeerDurchStadtBelegterGrund,
                                                           Felderwertung           => (others => LeerFelderwertung)
                                                          );
   
   LeerVerbesserungGrafik : constant Wide_Wide_Character := SystemKonstanten.LeerZeichen;
      
   LeerVerbesserungBewertung : constant KartenDatentypen.BewertungFeld := 0;
   LeerVerbesserungWirtschaft : constant EinheitStadtDatentypen.ProduktionElement := 0;
   LeerVerbesserungKampf : constant EinheitStadtDatentypen.Kampfwerte := EinheitStadtDatentypen.Kampfwerte'First;

   LeerVerbesserungListe : constant DatenbankRecords.VerbesserungListeRecord := (
                                                                                 VerbesserungGrafik => LeerVerbesserungGrafik,
                                                                                 Passierbarkeit     => (others => LeerPassierbarkeit),
                                                                                 Bewertung          => (others => LeerVerbesserungBewertung),
                                                                                 Wirtschaft         => (others => (others => LeerVerbesserungWirtschaft)),
                                                                                 Kampf              => (others => (others => LeerVerbesserungKampf))
                                                                                );
   
   type EisgebietArray is array (KartenDatentypen.Kartengröße_Verwendet_Enum'Range) of KartenDatentypen.KartenfeldPositiv;
   Eisrand : constant EisgebietArray := (
                                         SystemDatentypen.Karte_Größe_20_20     => 1,
                                         SystemDatentypen.Karte_Größe_40_40     => 1,
                                         SystemDatentypen.Karte_Größe_80_80     => 2,
                                         SystemDatentypen.Karte_Größe_120_80    => 3,
                                         SystemDatentypen.Karte_Größe_120_160   => 3,
                                         SystemDatentypen.Karte_Größe_160_160   => 4,
                                         SystemDatentypen.Karte_Größe_240_240   => 6,
                                         SystemDatentypen.Karte_Größe_320_320   => 8,
                                         SystemDatentypen.Karte_Größe_1000_1000 => 24,
                                         SystemDatentypen.Karte_Größe_Nutzer    => 1
                                        );

   Eisschild : constant EisgebietArray := (
                                           SystemDatentypen.Karte_Größe_20_20     => 3,
                                           SystemDatentypen.Karte_Größe_40_40     => 3,
                                           SystemDatentypen.Karte_Größe_80_80     => 6,
                                           SystemDatentypen.Karte_Größe_120_80    => 9,
                                           SystemDatentypen.Karte_Größe_120_160   => 9,
                                           SystemDatentypen.Karte_Größe_160_160   => 12,
                                           SystemDatentypen.Karte_Größe_240_240   => 18,
                                           SystemDatentypen.Karte_Größe_320_320   => 24,
                                           SystemDatentypen.Karte_Größe_1000_1000 => 72,
                                           SystemDatentypen.Karte_Größe_Nutzer    => 1
                                          );
   
   WirtschaftNahrung : constant KartenDatentypen.Wirtschaft_Enum := KartenDatentypen.Nahrung;
   WirtschaftProduktion : constant KartenDatentypen.Wirtschaft_Enum := KartenDatentypen.Produktion;
   WirtschaftGeld : constant KartenDatentypen.Wirtschaft_Enum := KartenDatentypen.Geld;
   WirtschaftForschung : constant KartenDatentypen.Wirtschaft_Enum := KartenDatentypen.Forschung;
   KampfVerteidigung : constant KartenDatentypen.Kampf_Enum := KartenDatentypen.Verteidigung;
   KampfAngriff : constant KartenDatentypen.Kampf_Enum := KartenDatentypen.Angriff;

end KartenKonstanten;
