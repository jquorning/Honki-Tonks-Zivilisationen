pragma SPARK_Mode (On);

with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

with SystemDatentypen;

package SystemKonstanten is

   -- Für die Auswahl
   LeerRückgabeKonstante : constant SystemDatentypen.Rückgabe_Werte_Enum := SystemDatentypen.Leer;
   StartWeiterKonstante : constant SystemDatentypen.Rückgabe_Werte_Enum := SystemDatentypen.Start_Weiter;
   ZurückKonstante : constant SystemDatentypen.Rückgabe_Werte_Enum := SystemDatentypen.Zurück;
   HauptmenüKonstante : constant SystemDatentypen.Rückgabe_Werte_Enum := SystemDatentypen.Hauptmenü;
   SpielBeendenKonstante : constant SystemDatentypen.Rückgabe_Werte_Enum := SystemDatentypen.Spiel_Beenden;
   JaKonstante : constant SystemDatentypen.Rückgabe_Werte_Enum := SystemDatentypen.Ja;
   NeinKonstante : constant SystemDatentypen.Rückgabe_Werte_Enum := SystemDatentypen.Nein;
   SpeichernKonstante : constant SystemDatentypen.Rückgabe_Werte_Enum := SystemDatentypen.Speichern;
   LadenKonstante : constant SystemDatentypen.Rückgabe_Werte_Enum := SystemDatentypen.Laden;
   OptionenKonstante : constant SystemDatentypen.Rückgabe_Werte_Enum := SystemDatentypen.Optionen;
   InformationenKonstante : constant SystemDatentypen.Rückgabe_Werte_Enum := SystemDatentypen.Informationen;
   WiederherstellenKonstante : constant SystemDatentypen.Rückgabe_Werte_Enum := SystemDatentypen.Wiederherstellen;
   WürdigungenKonstante : constant SystemDatentypen.Rückgabe_Werte_Enum := SystemDatentypen.Würdigungen;
   RundeBeendenKonstante : constant SystemDatentypen.Rückgabe_Werte_Enum := SystemDatentypen.Runde_Beenden;
   SiegKonstante : constant SystemDatentypen.Rückgabe_Werte_Enum := SystemDatentypen.Sieg;
   VernichtungKonstante : constant SystemDatentypen.Rückgabe_Werte_Enum := SystemDatentypen.Vernichtung;
   ZufallKonstante : constant SystemDatentypen.Rückgabe_Werte_Enum := SystemDatentypen.Zufall;
   EingabeKonstante : constant SystemDatentypen.Rückgabe_Werte_Enum := SystemDatentypen.Eingabe;
   GrafikKonstante : constant SystemDatentypen.Rückgabe_Werte_Enum := SystemDatentypen.Grafik;
   SoundKonstante : constant SystemDatentypen.Rückgabe_Werte_Enum := SystemDatentypen.Sound;
   SteuerungKonstante : constant SystemDatentypen.Rückgabe_Werte_Enum := SystemDatentypen.Steuerung;
   SonstigesKonstante : constant SystemDatentypen.Rückgabe_Werte_Enum := SystemDatentypen.Sonstiges;
   FertigKonstante : constant SystemDatentypen.Rückgabe_Werte_Enum := SystemDatentypen.Fertig;
   SchleifeVerlassenKonstante : constant SystemDatentypen.Rückgabe_Werte_Enum := SystemDatentypen.Schleife_Verlassen;
   AnzahlSpeicherständeKonstante : constant SystemDatentypen.Rückgabe_Werte_Enum := SystemDatentypen.Anzahl_Speicherstände;
   RundenBisAutospeichernKonstante : constant SystemDatentypen.Rückgabe_Werte_Enum := SystemDatentypen.Runden_Bis_Autospeichern;
   SpracheKonstante : constant SystemDatentypen.Rückgabe_Werte_Enum := SystemDatentypen.Sprache;
   SpielmenüKonstante : constant SystemDatentypen.Rückgabe_Werte_Enum := SystemDatentypen.Spielmenü;

   -- Grafikmenü
   AuflösungÄndernKonstante : constant SystemDatentypen.Rückgabe_Werte_Enum := SystemDatentypen.Auflösung_Ändern;
   VollbildFensterKonstante : constant SystemDatentypen.Rückgabe_Werte_Enum := SystemDatentypen.Vollbild_Fenster;
   BildrateÄndernKonstante : constant SystemDatentypen.Rückgabe_Werte_Enum := SystemDatentypen.Bildrate_Ändern;
   SchriftgrößeKonstante : constant SystemDatentypen.Rückgabe_Werte_Enum := SystemDatentypen.Schriftgröße;

   -- Soundmenü


   -- Editoren
   EditorenKonstante : constant SystemDatentypen.Rückgabe_Werte_Enum := SystemDatentypen.Editoren;
   KartenfeldEditorKonstante : constant SystemDatentypen.Rückgabe_Werte_Enum := SystemDatentypen.Kartenfeld_Editor;
   EinheitenEditorKonstante : constant SystemDatentypen.Rückgabe_Werte_Enum := SystemDatentypen.Einheiten_Editor;
   GebäudeEditorKonstante : constant SystemDatentypen.Rückgabe_Werte_Enum := SystemDatentypen.Gebäude_Editor;
   ForschungEditorKonstante : constant SystemDatentypen.Rückgabe_Werte_Enum := SystemDatentypen.Forschung_Editor;
   VerbesserungenEditorKonstante : constant SystemDatentypen.Rückgabe_Werte_Enum := SystemDatentypen.Verbesserungen_Editor;

   -- Karteneinstellungen
   AuswahlKartengrößeKonstante : constant SystemDatentypen.Rückgabe_Werte_Enum := SystemDatentypen.Auswahl_Kartengröße;
   AuswahlKartenartKonstante : constant SystemDatentypen.Rückgabe_Werte_Enum := SystemDatentypen.Auswahl_Kartenart;
   AuswahlKartenformKonstante : constant SystemDatentypen.Rückgabe_Werte_Enum := SystemDatentypen.Auswahl_Kartenform;
   AuswahlKartentemperaturKonstante : constant SystemDatentypen.Rückgabe_Werte_Enum := SystemDatentypen.Auswahl_Kartentemperatur;
   AuswahlRassenKonstante : constant SystemDatentypen.Rückgabe_Werte_Enum := SystemDatentypen.Auswahl_Rassen;
   AuswahlSchwierigkeitsgradKonstante : constant SystemDatentypen.Rückgabe_Werte_Enum := SystemDatentypen.Auswahl_Schwierigkeitsgrad;
   AuswahlKartenressourcenKonstante : constant SystemDatentypen.Rückgabe_Werte_Enum := SystemDatentypen.Auswahl_Kartenressourcen;
   -- Für die Auswahl



   -- Wird das so überhaupt benötigt?
   -- Wartezeiten
   WartezeitLogik : constant Duration := 0.20;
   WartezeitGrafik : constant Duration := 0.0002;
   WartezeitMusik : constant Duration := 0.20;
   WartezeitSound : constant Duration := 0.20;

   WartezeitMinimal : constant Duration := 0.000000002;
   -- Wartezeiten



   LeerString : constant Wide_Wide_String := "";
   LeerUnboundedString : constant Unbounded_Wide_Wide_String := To_Unbounded_Wide_Wide_String (Source => LeerString);
   LeerZeichen : constant Wide_Wide_Character := ' ';



   -- Für Spieleinstellungen
   SchwierigkeitLeichtKonstante : constant SystemDatentypen.Schwierigkeitsgrad_Verwendet_Enum := SystemDatentypen.Schwierigkeit_Leicht;
   SchwierigkeitMittelKonstante : constant SystemDatentypen.Schwierigkeitsgrad_Verwendet_Enum := SystemDatentypen.Schwierigkeit_Mittel;
   SchwierigkeitSchwerKonstante : constant SystemDatentypen.Schwierigkeitsgrad_Verwendet_Enum := SystemDatentypen.Schwierigkeit_Schwer;
   -- Für Spieleinstellungen



   -- Für Rassenoptionen
   LeerRasse : constant SystemDatentypen.Rassen_Enum := SystemDatentypen.Keine_Rasse;

   MenschenKonstante : constant SystemDatentypen.Rassen_Verwendet_Enum := SystemDatentypen.Menschen;
   KasrodiahKonstante : constant SystemDatentypen.Rassen_Verwendet_Enum := SystemDatentypen.Kasrodiah;
   LasupinKonstante : constant SystemDatentypen.Rassen_Verwendet_Enum := SystemDatentypen.Lasupin;
   LamustraKonstante : constant SystemDatentypen.Rassen_Verwendet_Enum := SystemDatentypen.Lamustra;
   ManukyKonstante : constant SystemDatentypen.Rassen_Verwendet_Enum := SystemDatentypen.Manuky;
   SurokaKonstante : constant SystemDatentypen.Rassen_Verwendet_Enum := SystemDatentypen.Suroka;
   PryolonKonstante : constant SystemDatentypen.Rassen_Verwendet_Enum := SystemDatentypen.Pryolon;
   TalbidahrKonstante : constant SystemDatentypen.Rassen_Verwendet_Enum := SystemDatentypen.Talbidahr;
   MoruPhisihlKonstante : constant SystemDatentypen.Rassen_Verwendet_Enum := SystemDatentypen.Moru_Phisihl;
   LarinosLotarisKonstante : constant SystemDatentypen.Rassen_Verwendet_Enum := SystemDatentypen.Larinos_Lotaris;
   CarupexKonstante : constant SystemDatentypen.Rassen_Verwendet_Enum := SystemDatentypen.Carupex;
   AlaryKonstante : constant SystemDatentypen.Rassen_Verwendet_Enum := SystemDatentypen.Alary;
   TesorahnKonstante : constant SystemDatentypen.Rassen_Verwendet_Enum := SystemDatentypen.Tesorahn;
   NatriesZermanisKonstante : constant SystemDatentypen.Rassen_Verwendet_Enum := SystemDatentypen.Natries_Zermanis;
   TridatusKonstante : constant SystemDatentypen.Rassen_Verwendet_Enum := SystemDatentypen.Tridatus;
   SenelariKonstante : constant SystemDatentypen.Rassen_Verwendet_Enum := SystemDatentypen.Senelari;
   Aspari2Konstante : constant SystemDatentypen.Rassen_Verwendet_Enum := SystemDatentypen.Aspari_2;
   EkropaKonstante : constant SystemDatentypen.Rassen_Verwendet_Enum := SystemDatentypen.Ekropa;
   -- Für Rassenoptionen

end SystemKonstanten;
