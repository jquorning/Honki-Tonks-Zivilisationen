package ChangelogNovember2021 is

   -- Version 0.00.9 => 0.00.9 (30.11.2021):
   
   -- 
   -- Kleinigkeiten korrigiert.
   
   
   
   -- Version 0.00.9 => 0.00.9 (29.11.2021):
   
   -- 
   -- Kleinigkeiten korrigiert.
   
   
   
   -- Version 0.00.9 => 0.00.9 (28.11.2021):
   
   -- 
   -- Kleinigkeiten korrigiert.
   
   
   
   -- Version 0.00.9 => 0.00.9 (27.11.2021):
   
   -- 
   -- Kleinigkeiten korrigiert.
   
   
   
   -- Version 0.00.9 => 0.00.9 (26.11.2021):
   
   -- 
   -- Kleinigkeiten korrigiert.
   
   
   
   -- Version 0.00.9 => 0.00.9 (25.11.2021):
   
   -- 
   -- Kleinigkeiten korrigiert.
   
   
   
   -- Version 0.00.9 => 0.00.9 (24.11.2021):
   
   -- 
   -- Kleinigkeiten korrigiert.
   
   
   
   -- Version 0.00.94 => 0.00.9 (23.11.2021):
   
   -- 
   -- Kleinigkeiten korrigiert.
   
   
   
   -- Version 0.00.94 => 0.00.94 (22.11.2021):
   
   -- 
   -- Kleinigkeiten korrigiert.
   
   
   
   -- Version 0.00.94 => 0.00.94 (21.11.2021):
   
   -- 
   -- Kleinigkeiten korrigiert.
   
   
   
   -- Version 0.00.9390 => 0.00.94 (20.11.2021):
   
   -- 
   -- Kleinigkeiten korrigiert.
   
   
   
   -- Version 0.00.9380 => 0.00.9390 (19.11.2021):
   
   -- Bei manueller Änderung der Fenstergröße wird die SFML Anzeige jetzt korrekt angepasst.
   -- Fehler korrigiert der dazu führte dass das Spiel versuchte Text außerhalb des Spiels anzuzeigen und gestoppt wurde.
   -- Geschwindigkeit der Textanzeige bei langen Texten verbessert.
   -- Erneut angefangen die Art und Weise wie die Anzeige durch die SFML stattfindet zu ändern.
   -- Angefangen eine halbwegs brauchbare? Lösung zu bauen, welche die Spielelogik, die Grafik und den Sound voneinander trennen.
   -- Kleinigkeiten korrigiert/überarbeitet.
   
   
   
   -- Version 0.00.9360 => 0.00.9380 (18.11.2021):
   
   -- Diverse Änderungen an der Art und Weise wie die Anzeige durch die SFML stattfindet getestet und dann frustriert alle rückgängig gemacht.
   -- Eine Prüfung für die aktuellen Fenstereinstellungen einzubauen und alle aktuellen Fensterprüfungen/berechnungen angepasst.
   -- Versucht herauszufinden warum die Anzeigeposition/bestimmung immer noch nicht passt.
   -- Kleinigkeiten korrigiert.
   
   
   
   -- Version 0.00.9350 => 0.00.9360 (17.11.2021):
   
   -- Die Steuerung von Einheiten erweitert, so dass die Einheit jetzt auch auf Tastenbefehle reagiert, wenn sie mit der Maus ausgewählt ist.
   -- Goto auf der Karte funktioniert jetzt wieder korrekt.
   -- Code vereinfacht/zusammengefasst.
   -- Angefangen die Darstellung durch die SFML besser einzubauen.
   -- Kleinigkeiten korrigiert/angepasst.
   
   
   
   -- Version 0.00.9320 => 0.00.9350 (16.11.2021):
   
   -- Anzeige der Karte in der Konsole vorübergehend entfernt, da es Abstürze verursacht.
   -- Doppelten Code zusammengeführt.
   -- Unnötigen Code gelöscht.
   -- Mausbewegungen am Kartenrand führt jetzt zum korrekten Scrollen und nicht mehr zum Verschieben des ganzen Bildes.
   -- Scrollen funktioniert jetzt mit allen Kartengrößen/Sichtbereichen.
   -- Diverse Fehler korrigiert die zu einer Fehlplatzierung des Cursors oder von Kartenfelder führen konnten.
   -- Durch das Festlegen von 0 Runden bis zum Autospeichern wird das Autospeichern jetzt ebenfalls deaktiviert.
   -- Englische Übersetzung an das neue System angepasst und Kleinigkeiten korrigiert.
   -- Fehler im Chaoskartengenerator korrigiert, welcher zu falsch gesetzten Werten und Abstürzen führte.
   -- Code vereinfacht.
   -- Es ist jetzt mit der SFML Version möglich die Steuerungsbelegung zu ändern.
   -- Wenn man über das Spielmenü auf die Optionen zugreift landet man jetzt bei der Verwengung von Zurück wieder im Spielmenü und nicht mehr direkt im Spiel.
   -- Angefangen eine SFML Version für die Anzeige der Stadt zu bauen.
   -- Angefangen BewegungEinheit in eine Konsolen- und eine SFML-Version aufzuteilen.
   -- Angefangen eine Funktion einzubauen, durch die man die Einheitenbefehle auch mit der Maus eingeben kann.
   -- Es ist jetzt möglich die Einheiten durch Benutzung der Maus zu verschieben.
   -- Leichte Anpassungen an der aktuellen Flussanzeige.
   -- Contracts und Kleinigkeiten korrigiert/angepasst/überarbeitet/erweitert.
   
   
   
   -- Version 0.00.9290 => 0.00.9320 (15.11.2021):
   
   -- Einlesen von Grafiken/Texturen überarbeitet und sinnvoller aufgeteilt.
   -- Festlegen der Grafikeinstellungen und Einlesen der Nutzereinstellungen überarbeitet.
   -- Unnötigen Code gelöscht.
   -- Es ist jetzt möglich bei der Kartengröße sowohl eine zufällige vordefinierte Größe, als auch eine komplett zufällige Größe auszuwählen.
   -- Einstellungen zur Kartengenerierung wieder vervollständigt und fehlerbereinigt.
   -- Die Bewegung des Cursor mittels Tasteneingabe durch eine Positionsbestimmung anhand der Mausposition ersetzt.
   -- Eingabe über die SFML vereinfacht.
   -- Angefangen die SFML Kartenanzeige zu überarbeiten.
   -- Kartenfelder sollten jetzt immer die gleiche Größe haben und sich nicht mehr auf Basis der Zeigerposition verändern.
   -- Die Bestimmung der Zeigerposition an die neue Kartenfeldergrößenermittlung angepasst.
   -- Wenn als Anzeigeart Beides ausgewählt ist, dann wird jetzt auch die Karte in der Konsole angezeigt.
   -- Angefangen die SFML Version der Stadtkartenanzeige zu programmieren.
   -- Angefangen die Cursorbewegung in eine Konsolen- und eine SFML-Version aufzuteilen.
   -- Angefangen das Scrollen mit dem Mauscursor so umzubauen, dass am Rand gescrollt und nicht komplett neu die Mausposition festgelegt wird.
   -- Kommentare und Kleinigkeiten korrigiert/angepasst/überarbeitet.
   
   
   
   -- Version 0.00.9280 => 0.00.9290 (14.11.2021):
   
   -- Bildrate ist jetzt einstellbar.
   -- Grafikeinstellungen können jetzt gespeichert werden und werden zum Programmstart automatisch geladen.
   -- Leichte Anpassungen in der Darstellungen des Einstellungenerklärtextes.
   -- Kleinigkeiten korrigiert/angepasst.
   
   
   
   -- Version 0.00.9280 => 0.00.9280 (13.11.2021):
   
   -- null.
   
   
   
   -- Version 0.00.9270 => 0.00.9280 (12.11.2021):
   
   -- Das Einlesen von Texten erzeugt jetzt keinen Programmstopp mehr wenn nicht genug Zeilen in der Textdatei sind sondern füllt diese nun mit einem Standardtext.
   -- Menüs an die SFML angepasst.
   -- Kleinigkeiten korrigiert/angepasst.
   
   
   
   -- Version 0.00.9270 => 0.00.9270 (11.11.2021):
   
   -- null.
   
   
   
   -- Version 0.00.9260 => 0.00.9270 (10.11.2021):
   
   -- Die Rückgabewerte vorerst überall auf das neue Enum umgebaut.
   -- Das Optionsmenü auf die SFML umgebaut.
   -- Angefangen ein Grafikmenü einzubauen.
   -- Kleinigkeiten korrigiert.
   
   
   
   -- Version 0.00.9250 => 0.00.9260 (09.11.2021):
   
   -- Zeilenumbrüche in die Textanzeige eingebaut.
   -- Angefangen die Befehle nach Darstellungsart aufzuteilen.
   -- Kommentare und Kleinigkeiten korrigiert.
   
   
   
   -- Version 0.00.9240 => 0.00.9250 (08.11.2021):
   
   -- Auswahlmenü um diverse Funktionen/Anzeigen erweitert und verbessert.
   -- Kleinigkeiten korrigiert.
   
   
   
   -- Version 0.00.9230 => 0.00.9240 (07.11.2021):
   
   -- Die Rassen/Spielerauswahl weiter überarbeitet.
   -- Angefangen die Textanzeige in den Menüs zu erweitern und verbessern.
   -- Kleinigkeiten korrigiert.
   
   
   
   -- Version 0.00.9220 => 0.00.9230 (06.11.2021):
   
   -- Menüanzeige- und auswahl durch die SFML verbessert/erweitert.
   -- Zahleneingabe über die SFML verbessert.
   -- Angefangen die Rassen- und Spieleranzahlauswahl zu überarbeiten.
   -- Kleinigkeiten korrigiert.
   
   
   
   -- Version 0.00.9220 => 0.00.9220 (05.11.2021):
   
   -- null.
   
   
   
   -- Version 0.00.9220 => 0.00.9220 (04.11.2021):
   
   -- null.
   
   
   
   -- Version 0.00.9210 => 0.00.9220 (03.11.2021):
   
   -- SonstigeDatentypen vollständig in SystemDatentypen integriert.
   -- Einige Leerwerte durch Konstante ersetzt.
   -- SFML Anzeige für die Eingabe von Zahlen verbessert.
   -- Kommentare und Kleinigkeiten korrigiert/angepasst.
   
   
   
   -- Version 0.00.9190 => 0.00.9210 (02.11.2021):
   
   -- Fehler in der Erzeugung von zufälligen Kartengrößen entdeckt.
   -- Angefangen SonstigeDatentypen in SystemDatentypen zu integrieren.
   -- Unnötigen Code gelöscht.
   -- Code an die neuen Rückgabewerte und dadurch notwendigen Datentypen angepasst.
   -- Speicherung der Kartenfelderbelegung durch Städte neu geschrieben.
   -- Neues Menüsystem vollständig eingebaut.
   -- Kleinigkeiten korrigiert/überarbeitet.
   
   

   -- Version 0.00.9180 => 0.00.9190 (01.11.2021):
   
   -- Mausauswahl in Menüs verbessert.
   -- Angefangen weitere Menüs auf das neue System umzubauen und die Rückgabewerte auf Enum umzuschreiben.
   -- Angefangen die englische Übersetzung an das neue System anzupassen.
   -- Kleinigkeiten korrigiert/überarbeitet.

end ChangelogNovember2021;
