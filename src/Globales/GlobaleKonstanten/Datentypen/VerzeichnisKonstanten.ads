package VerzeichnisKonstanten is
   pragma Pure;

   Spielstand : constant String (1 .. 10) := "Spielstand";
   SpielstandStrich : constant String (1 .. 11) := Spielstand & "/";
   
   Datenbanken : constant String (1 .. 11) := "Datenbanken";
   EinheitenDatenbank : constant String (1 .. 30) := Datenbanken & "/EinheitenDatenbank";
   ForschungenDatenbank : constant String (1 .. 32) := Datenbanken & "/ForschungenDatenbank";
   GebaeudeDatenbank : constant String (1 .. 29) := Datenbanken & "/GebaeudeDatenbank";
   KartenDatenbank : constant String (1 .. 27) := Datenbanken & "/KartenDatenbank";
   VerbesserungenDatenbank : constant String (1 .. 35) := Datenbanken & "/VerbesserungenDatenbank";
   SpeziesDatenbank : constant String (1 .. 28) := Datenbanken & "/SpeziesDatenbank";
   
   Nutzereinstellungen : constant String (1 .. 19) := "Nutzereinstellungen";
   Grafikeinstellungen : constant String (1 .. 19) := "Grafikeinstellungen";
   Toneinstellungen : constant String (1 .. 16) := "Toneinstellungen";
   Tastenbelegung : constant String (1 .. 14) := "Tastenbelegung";
   Sprachen : constant String (1 .. 8) := "Sprachen";
   SprachenStrich : constant String (1 .. 9) := Sprachen & "/";
   Schriftart : constant String (1 .. 21) := SprachenStrich & "FreeSans.otf";
   
   NullDatei : constant String (1 .. 2) := "/0";
   Grafik : constant String (1 .. 6) := "Grafik";
   Audio : constant String (1 .. 5) := "Audio";
   Musik : constant String (1 .. 6) := "/Musik";
   Sound : constant String (1 .. 6) := "/Sound";
   
   -- Statt einzelner Teile einfach nur die Gesamtpfade erstellen? äöü
   -- Wäre wahrscheinlich übersichtlicher und weniger Konstanten. äöü
   -- Oder die Nulldateien in den hauptordner schieben und von da alles einlesen? äöü
   System : constant String (1 .. 7) := "/System";
   Hintergrund : constant String (1 .. 12) := "/Hintergrund";
   Basisgrund : constant String (1 .. 11) := "/Basisgrund";
   Zusatzgrund : constant String (1 .. 12) := "/Zusatzgrund";
   Feldeffekte : constant String (1 .. 12) := "/Feldeffekte";
   Kartenfluss : constant String (1 .. 12) := "/Kartenfluss";
   Kartenressourcen : constant String (1 .. 17) := "/Kartenressourcen";
   Kartenverbesserungen : constant String (1 .. 15) := "/Verbesserungen";
   Kartenwege : constant String (1 .. 5) := "/Wege";
   Einheiten : constant String (1 .. 10) := "/Einheiten";
   Bauwerke : constant String (1 .. 9) := "/Bauwerke";
   Spezies : constant String (1 .. 8) := "/Spezies";
   
end VerzeichnisKonstanten;
