pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Ada.Calendar; use Ada.Calendar;

with SystemDatentypen;

package LadezeitenDatentypen is

   type Spielwelt_Erstellen_Zeit_Enum is (Leer, Gesamtzeit, Generiere_Normal_Himmel_Weltraum_Planeteninneres, Generiere_Küstengewässer, Generiere_Landschaft_Ebene_Oberfläche, Generiere_Unterwasser_Unterirdisch,
                                          Generiere_Flüsse, Generiere_Ressourcen, Kartenfelder_Bewerten, Spieler_Platzieren);
   subtype Spielwelt_Erstellen_Zeit_Verwendet_Enum is Spielwelt_Erstellen_Zeit_Enum range Gesamtzeit .. Spielwelt_Erstellen_Zeit_Enum'Last;
   subtype Gesamtzeit_Enum is Spielwelt_Erstellen_Zeit_Verwendet_Enum range Generiere_Normal_Himmel_Weltraum_Planeteninneres .. Spielwelt_Erstellen_Zeit_Verwendet_Enum'Last;
   
   type SpielweltErstellenZeitArray is array (Spielwelt_Erstellen_Zeit_Verwendet_Enum'Range, SystemDatentypen.Anfang_Ende_Enum'Range) of Time;
   SpielweltErstellenZeit : SpielweltErstellenZeitArray;
   
   type Einzelne_Zeiten_Enum is (Startzeit, Zwischen_Runden, Speicherzeit, Ladezeit);
   type EinzelneZeitenArray is array (Einzelne_Zeiten_Enum'Range, SystemDatentypen.Anfang_Ende_Enum'Range) of Time;
   EinzelneZeiten : EinzelneZeitenArray;
   
   type KIZeitenArray is array (SystemDatentypen.Rassen_Enum, SystemDatentypen.Anfang_Ende_Enum'Range) of Time;
   KIZeiten : KIZeitenArray;
   
   -- Für die Textausgabe, irgendwann einmal an das neue Textsystem anpassen.
   type AufschlagArray is array (Einzelne_Zeiten_Enum'Range) of Positive;
   Aufschlag : constant AufschlagArray := (
                                           Startzeit       => 10,
                                           Zwischen_Runden => 11,
                                           Speicherzeit    => 12,
                                           Ladezeit        => 13
                                          );
   
   type KITextArray is array (SystemDatentypen.Rassen_Enum'Range) of Positive;
   KIText : KITextArray := (32, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31);

end LadezeitenDatentypen;
