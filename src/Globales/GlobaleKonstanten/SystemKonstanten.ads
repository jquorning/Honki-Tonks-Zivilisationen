pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with SystemDatentypen;

package SystemKonstanten is

   LeerAuswahl : constant Natural := 0;

   LängstesMenü : constant Positive := 27;

   ------------------------- Diese Konstanten nicht nur für die Menüarrays anlegen sondern für alle?
   type EndeMenüArray is array (SystemDatentypen.Welches_Menü_Vorhanden_Enum'Range) of Positive;
   EndeMenü : constant EndeMenüArray := (
                                           -- Einfache Auswahl, keine Überschrift und kein Zusatztext.
                                           SystemDatentypen.Haupt_Menü_Enum              => 7,
                                           SystemDatentypen.Spiel_Menü_Enum              => 6,

                                           -- Einfache Auswahl und kein Zusatztext.
                                           SystemDatentypen.Optionen_Menü_Enum           => 7,
                                           SystemDatentypen.Einstellungen_Menü_Enum      => 11,
                                           SystemDatentypen.Editoren_Menü_Enum           => 17,
                                           SystemDatentypen.Sonstiges_Menü_Enum          => 7,

                                           SystemDatentypen.Kartenart_Menü_Enum          => 8,
                                           SystemDatentypen.Kartentemperatur_Menü_Enum   => 8,
                                           SystemDatentypen.Kartenressourcen_Menü_Enum   => 8,
                                           SystemDatentypen.Schwierigkeitsgrad_Menü_Enum => 6,

                                           -- Einfache Auswahl.
                                           SystemDatentypen.Kartengröße_Menü_Enum        => 15,
                                           SystemDatentypen.Rassen_Menü_Enum             => 21,

                                           -- Komplexe Auswahl.
                                           SystemDatentypen.Kartenform_Menü_Enum         => 23,

                                           -- Unsortiert.
                                           SystemDatentypen.Grafik_Menü_Enum             => 15,
                                           SystemDatentypen.Sound_Menü_Enum              => 7,
                                           SystemDatentypen.Steuerung_Menü_Enum          => 91
                                          );

end SystemKonstanten;
