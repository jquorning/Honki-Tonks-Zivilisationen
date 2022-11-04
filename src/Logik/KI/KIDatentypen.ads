pragma Warnings (Off, "*array aggregate*");

package KIDatentypen is
   pragma Pure;

   type Einheit_Aufgabe_Enum is (
                                 Leer_Aufgabe_Enum,

                                 Stadt_Bauen_Enum, Flucht_Enum, Erkunden_Enum, Verbesserung_Anlegen_Enum, Angreifen_Enum, Verteidigen_Enum, Einheit_Heilen_Enum, Einheit_Auflösen_Enum,
                                 Einheit_Festsetzen_Enum, Einheit_Verbessern_Enum, Stadt_Bewachen_Enum, Verbesserung_Zerstören_Enum, Auf_Transporter_Warten_Enum,
                                 Angriffskrieg_Vorbereiten_Enum, Verteidigungskrieg_Vorbereiten_Enum, Platz_Machen_Enum, -- Abholen_Enum,

                                 Planet_Vernichten_Enum
                                );
   -- Diesen Anfang mal überall einbauen wo es sinnvoll ist. äöü
   subtype Einheit_Aufgabe_Vorhanden_Enum is Einheit_Aufgabe_Enum range Einheit_Aufgabe_Enum'Val (Einheit_Aufgabe_Enum'Pos (Einheit_Aufgabe_Enum'First) + 1) .. Einheit_Aufgabe_Enum'Last;

   type Stadt_Aufgabe_Enum is (
                               Keine_Aufgabe_Enum,

                               Einheit_Bauen_Enum, Gebäude_Bauen_Enum, Gefahr_Einheit_Bauen_Enum
                              );

   type Bewegung_Enum is (
                          Belegt_Angriff_Enum, Unbelegt_Enum, Belegt_Kein_Angriff_Enum, Einheiten_Tauschen_Enum
                         );

   -- Größe später besser anpassen. äöü
   type BauenBewertung is range -500 .. 500;
   subtype BewegungBewertung is BauenBewertung range 0 .. 20;

   -- Die beiden Bewertungen zusammenführen, warum sind die überhaupt getrennt? äöü
   type AufgabenWichtigkeit is range -100 .. 100;
   subtype AufgabenWichtigkeitKlein is AufgabenWichtigkeit range -1 .. 100;

   type KINotAus is range 1 .. 50;

end KIDatentypen;
