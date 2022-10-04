pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Sf.Window.Keyboard;

with TastenbelegungDatentypen;
with BefehleDatentypen;

-- Später so aufteilen wie die Kartendatenbanken und die Standardeinstellungen in eigene Dateien schieben? äöü
package TastenbelegungVariablen is
   
   type AllgemeineBelegungArray is array (TastenbelegungDatentypen.Allgemeine_Belegung_Vorhanden_Enum'Range) of Sf.Window.Keyboard.sfKeyCode;
   AllgemeineBelegung : AllgemeineBelegungArray;
   
   type EinheitenbelegungArray is array (BefehleDatentypen.Einheitenbelegung_Vorhanden_Enum'Range) of Sf.Window.Keyboard.sfKeyCode;
   Einheitenbelegung : EinheitenbelegungArray;
   
   procedure StandardTastenbelegungLaden;
   
private
   
   AllgemeineBelegungStandard : constant AllgemeineBelegungArray := (
                                                                     -- Bewegung auch mit einbauen. äöü
                                                                     -- Anstelle die aktuelle Koordionate zu verschieben, kann ich doch auch einfach die Alte verschieben. äöü
                                                                     -- Dann sollte man auch mit Tasten scrollen können. äöü
                                                                     TastenbelegungDatentypen.Oben_Enum                           => Sf.Window.Keyboard.sfKeyNumpad8,
                                                                     TastenbelegungDatentypen.Links_Enum                          => Sf.Window.Keyboard.sfKeyNumpad4,
                                                                     TastenbelegungDatentypen.Unten_Enum                          => Sf.Window.Keyboard.sfKeyNumpad2,
                                                                     TastenbelegungDatentypen.Rechts_Enum                         => Sf.Window.Keyboard.sfKeyNumpad6,
                                                                     TastenbelegungDatentypen.Links_Oben_Enum                     => Sf.Window.Keyboard.sfKeyNumpad7,
                                                                     TastenbelegungDatentypen.Rechts_Oben_Enum                    => Sf.Window.Keyboard.sfKeyNumpad9,
                                                                     TastenbelegungDatentypen.Links_Unten_Enum                    => Sf.Window.Keyboard.sfKeyNumpad1,
                                                                     TastenbelegungDatentypen.Rechts_Unten_Enum                   => Sf.Window.Keyboard.sfKeyNumpad3,
                                                                     TastenbelegungDatentypen.Ebene_Hoch_Enum                     => Sf.Window.Keyboard.sfKeyAdd,
                                                                     TastenbelegungDatentypen.Ebene_Runter_Enum                   => Sf.Window.Keyboard.sfKeySubtract,
                                
                                                                     -- Ab hier auswählbar.
                                                                     TastenbelegungDatentypen.Forschung_Enum                      => Sf.Window.Keyboard.sfKeyT,
                                                                
                                                                     TastenbelegungDatentypen.Nächste_Stadt_Enum                  => Sf.Window.Keyboard.sfKeyUnknown,
                                                                     TastenbelegungDatentypen.Einheit_Mit_Bewegungspunkte_Enum    => Sf.Window.Keyboard.sfKeyUnknown,
                                                                     TastenbelegungDatentypen.Alle_Einheiten_Enum                 => Sf.Window.Keyboard.sfKeyUnknown,
                                                                     TastenbelegungDatentypen.Einheiten_Ohne_Bewegungspunkte_Enum => Sf.Window.Keyboard.sfKeyUnknown,
                                                                     TastenbelegungDatentypen.Nächste_Stadt_Mit_Meldung_Enum      => Sf.Window.Keyboard.sfKeyUnknown,
                                                                     TastenbelegungDatentypen.Nächste_Einheit_Mit_Meldung_Enum    => Sf.Window.Keyboard.sfKeyO,
                                                                     
                                                                     -- Sonstiges
                                                                     TastenbelegungDatentypen.Diplomatie_Enum                     => Sf.Window.Keyboard.sfKeyD,
                                                                     TastenbelegungDatentypen.Gehe_Zu_Enum                        => Sf.Window.Keyboard.sfKeyG,
                                
                                                                     -- Stadt
                                                                     TastenbelegungDatentypen.Stadt_Suchen_Enum                   => Sf.Window.Keyboard.sfKeyY,
                                
                                                                     TastenbelegungDatentypen.Runde_Beenden_Enum                  => Sf.Window.Keyboard.sfKeyR,
                                                                     TastenbelegungDatentypen.Debugmenü_Enum                      => Sf.Window.Keyboard.sfKeyPause,
                                                                     
                                                                     TastenbelegungDatentypen.Auswählen_Enum                      => Sf.Window.Keyboard.sfKeyUnknown,
                                                                     TastenbelegungDatentypen.Abwählen_Enum                       => Sf.Window.Keyboard.sfKeyEscape
                                                                    );
   
   
   
   EinheitenbelegungStandard : constant EinheitenbelegungArray := (
                                                                   BefehleDatentypen.Auswählen_Enum          => Sf.Window.Keyboard.sfKeyUnknown,
                                
                                                                   -- Bewegung
                                                                   BefehleDatentypen.Oben_Enum               => Sf.Window.Keyboard.sfKeyNumpad8,
                                                                   BefehleDatentypen.Links_Enum              => Sf.Window.Keyboard.sfKeyNumpad4,
                                                                   BefehleDatentypen.Unten_Enum              => Sf.Window.Keyboard.sfKeyNumpad2,
                                                                   BefehleDatentypen.Rechts_Enum             => Sf.Window.Keyboard.sfKeyNumpad6,
                                                                   BefehleDatentypen.Links_Oben_Enum         => Sf.Window.Keyboard.sfKeyNumpad7,
                                                                   BefehleDatentypen.Rechts_Oben_Enum        => Sf.Window.Keyboard.sfKeyNumpad9,
                                                                   BefehleDatentypen.Links_Unten_Enum        => Sf.Window.Keyboard.sfKeyNumpad1,
                                                                   BefehleDatentypen.Rechts_Unten_Enum       => Sf.Window.Keyboard.sfKeyNumpad3,
                                                                   BefehleDatentypen.Ebene_Hoch_Enum         => Sf.Window.Keyboard.sfKeyAdd,
                                                                   BefehleDatentypen.Ebene_Runter_Enum       => Sf.Window.Keyboard.sfKeySubtract,
                                
                                                                   -- Einheitenbefehle Verbesserungen
                                                                   BefehleDatentypen.Bauen_Enum              => Sf.Window.Keyboard.sfKeyB,
                                                                
                                                                   BefehleDatentypen.Straße_Bauen_Enum       => Sf.Window.Keyboard.sfKeyL,
                                                                   BefehleDatentypen.Mine_Bauen_Enum         => Sf.Window.Keyboard.sfKeyM,
                                                                   BefehleDatentypen.Farm_Bauen_Enum         => Sf.Window.Keyboard.sfKeyF,
                                                                   BefehleDatentypen.Festung_Bauen_Enum      => Sf.Window.Keyboard.sfKeyU,
                                                                   BefehleDatentypen.Wald_Aufforsten_Enum    => Sf.Window.Keyboard.sfKeyZ,
                                                                   BefehleDatentypen.Roden_Trockenlegen_Enum => Sf.Window.Keyboard.sfKeyP,
                                                                   
                                                                   -- Einheitenbefehle Allgemein
                                                                   BefehleDatentypen.Heilen_Enum             => Sf.Window.Keyboard.sfKeyH,
                                                                   BefehleDatentypen.Verschanzen_Enum        => Sf.Window.Keyboard.sfKeyV,
                                                                   BefehleDatentypen.Plündern_Enum           => Sf.Window.Keyboard.sfKeyJ,
                                                                   BefehleDatentypen.Auflösen_Enum           => Sf.Window.Keyboard.sfKeyK,
                                                                   BefehleDatentypen.Einheit_Verbessern_Enum => Sf.Window.Keyboard.sfKeyA,
                                                                   BefehleDatentypen.Heimatstadt_Ändern_Enum => Sf.Window.Keyboard.sfKeyC,
                                                                   BefehleDatentypen.Entladen_Enum           => Sf.Window.Keyboard.sfKeyE,
                                   
                                                                   BefehleDatentypen.Abwählen_Enum           => Sf.Window.Keyboard.sfKeyEscape
                                                                  );
   
end TastenbelegungVariablen;
