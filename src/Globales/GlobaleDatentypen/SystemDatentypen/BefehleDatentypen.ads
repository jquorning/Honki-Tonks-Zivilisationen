pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

package BefehleDatentypen is

   type Stadtbefehle_Enum is (
                              Leer_Enum,
                              
                              Bauen_Enum, Verkaufen_Enum, Umbenennen_Enum, Auflösen_Enum, Verlassen_Enum
                             );
   
   subtype Stadtbefehle_Vorhanden_Enum is Stadtbefehle_Enum range Bauen_Enum .. Stadtbefehle_Enum'Last;
   
   
   
   type Einheitenbelegung_Enum is (
                                   Leer_Einheitenbelegung_Enum,
                                   
                                   Auswählen_Enum,
                                
                                   -- Bewegung
                                   Oben_Enum, Links_Enum, Unten_Enum, Rechts_Enum, Links_Oben_Enum, Rechts_Oben_Enum, Links_Unten_Enum, Rechts_Unten_Enum,
                                   Ebene_Hoch_Enum, Ebene_Runter_Enum,
                                
                                   -- Einheitenbefehle Verbesserungen
                                   Bauen_Enum,
                                
                                   Straße_Bauen_Enum,
                                   Mine_Bauen_Enum, Farm_Bauen_Enum, Festung_Bauen_Enum,
                                   Wald_Aufforsten_Enum, Roden_Trockenlegen_Enum,
                                
                                   -- Einheitenbefehle Allgemein
                                   Heilen_Enum, Verschanzen_Enum, Plündern_Enum, Auflösen_Enum, Einheit_Verbessern_Enum,
                                   Heimatstadt_Ändern_Enum, Entladen_Enum,
                                   
                                   Abwählen_Enum
                                  );
   
   subtype Einheitenbelegung_Vorhanden_Enum is Einheitenbelegung_Enum range Auswählen_Enum .. Einheitenbelegung_Enum'Last;
   subtype Belegung_Auswählen_Enum is Einheitenbelegung_Vorhanden_Enum range Oben_Enum .. Entladen_Enum;
   
   subtype Einheiten_Bewegung_Enum is Belegung_Auswählen_Enum range Oben_Enum .. Ebene_Runter_Enum;
   
   -- Mit dem neuen System könnte man Heimatstadt ändern und Entladen auch in die Aufgaben schieben? äöü
   subtype Einheiten_Aufgaben_Enum is Belegung_Auswählen_Enum range Bauen_Enum .. Entladen_Enum;
   subtype Einheiten_Aufgaben_Klein_Enum is Einheiten_Aufgaben_Enum range Bauen_Enum .. Einheit_Verbessern_Enum;
   subtype Einheiten_Aufgaben_Baulos_Enum is Einheiten_Aufgaben_Enum range Straße_Bauen_Enum .. Einheit_Verbessern_Enum;
   subtype Einheiten_Allgemeine_Befehle_Enum is Einheiten_Aufgaben_Baulos_Enum range Heilen_Enum .. Einheit_Verbessern_Enum;
   
   subtype Siedler_Aufgaben_Enum is Belegung_Auswählen_Enum range Bauen_Enum .. Roden_Trockenlegen_Enum;
   subtype Siedler_Verbesserung_Enum is Siedler_Aufgaben_Enum range Straße_Bauen_Enum .. Roden_Trockenlegen_Enum;
   subtype Siedler_Konstruktionen_Enum is Siedler_Verbesserung_Enum range Mine_Bauen_Enum .. Festung_Bauen_Enum;
   
   subtype Kampf_Aufgaben_Enum is Belegung_Auswählen_Enum range Plündern_Enum .. Plündern_Enum;
   
   
   
   type Befehlsknöpfe_Enum is (
                                Einheitenknöpfe_Enum, Kartenknöpfe_Enum, -- , Stadtknöpfe_Enum
                                
                                Roter_Knopf_Enum
                               );

end BefehleDatentypen;
