package ChangelogOktober2022 is

   -- Version 0.04. => 0.04. (31.10.2022):
   
   -- 
   -- Kleinigkeiten korrigiert.
   
   

   -- Version 0.04. => 0.04. (30.10.2022):
   
   -- 
   -- Kleinigkeiten korrigiert.
   
   

   -- Version 0.04. => 0.04. (29.10.2022):
   
   -- 
   -- Kleinigkeiten korrigiert.
   
   

   -- Version 0.04. => 0.04. (28.10.2022):
   
   -- 
   -- Kleinigkeiten korrigiert.
   
   

   -- Version 0.04. => 0.04. (27.10.2022):
   
   -- 
   -- Kleinigkeiten korrigiert.
   
   

   -- Version 0.04. => 0.04. (26.10.2022):
   
   -- 
   -- Kleinigkeiten korrigiert.
   
   

   -- Version 0.04. => 0.04. (25.10.2022):
   
   -- 
   -- Kleinigkeiten korrigiert.
   
   

   -- Version 0.04. => 0.04. (24.10.2022):
   
   -- 
   -- Kleinigkeiten korrigiert.
   
   

   -- Version 0.04. => 0.04. (23.10.2022):
   
   -- 
   -- Kleinigkeiten korrigiert.
   
   

   -- Version 0.04. => 0.04. (22.10.2022):
   
   -- 
   -- Kleinigkeiten korrigiert.
   
   

   -- Version 0.04. => 0.04. (21.10.2022):
   
   -- 
   -- Kleinigkeiten korrigiert.
   
   

   -- Version 0.04. => 0.04. (20.10.2022):
   
   -- 
   -- Kleinigkeiten korrigiert.
   
   

   -- Version 0.04. => 0.04. (19.10.2022):
   
   -- 
   -- Kleinigkeiten korrigiert.
   
   

   -- Version 0.04. => 0.04. (18.10.2022):
   
   -- 
   -- Kleinigkeiten korrigiert.
   
   

   -- Version 0.04. => 0.04. (17.10.2022):
   
   -- 
   -- Kleinigkeiten korrigiert.
   
   

   -- Version 0.04. => 0.04. (16.10.2022):
   
   -- 
   -- Kleinigkeiten korrigiert.
   
   

   -- Version 0.04. => 0.04. (15.10.2022):
   
   -- 
   -- Kleinigkeiten korrigiert.
   
   

   -- Version 0.04. => 0.04. (14.10.2022):
   
   -- 
   -- Kleinigkeiten korrigiert.
   
   

   -- Version 0.04. => 0.04. (13.10.2022):
   
   -- 
   -- Kleinigkeiten korrigiert.
   
   

   -- Version 0.04. => 0.04. (12.10.2022):
   
   -- 
   -- Kleinigkeiten korrigiert.
   
   

   -- Version 0.04. => 0.04. (11.10.2022):
   
   -- 
   -- Kleinigkeiten korrigiert.
   
   

   -- Version 0.04. => 0.04. (10.10.2022):
   
   -- 
   -- Kleinigkeiten korrigiert.
   
   

   -- Version 0.04. => 0.04. (09.10.2022):
   
   -- 
   -- Kleinigkeiten korrigiert.
   
   

   -- Version 0.04. => 0.04. (08.10.2022):
   
   -- 
   -- Kleinigkeiten korrigiert.
   
   

   -- Version 0.04. => 0.04. (07.10.2022):
   
   -- 
   -- Kleinigkeiten korrigiert.
   
   

   -- Version 0.04.0975 => 0.04. (06.10.2022):
   
   -- 
   -- Kleinigkeiten korrigiert.
   
   

   -- Version 0.04.0875 => 0.04.0975 (05.10.2022):
   
   -- Fehler im neuen Eingabesystem korrigiert, welcher dazu führte das Auswählen permanent aktiv war.
   -- Unnötigen Code gelöscht.
   -- Code zusammengeführt.
   -- Logik- und Grafiktask noch besser voneinander getrennt.
   -- Es ist jetzt nicht mehr möglich teilweise aus der Karte rauszuscrollen, wenn man die Tastatur zum scrollen verwendet.
   -- Neues Steuerungsmenü gebaut, was mehrere Kategorien zulässt und mit der neuen Steuerungsaufteilung funktioniert.
   -- Tastenbelegung durch den Nutzer an die neue Steuerungsaufteilung angepasst.
   -- Wenn die Sichtweite größer ist als die Kartengröße, dann wird die Karte jetzt, unter Berücksichtigung der Kartenarteinstellungen, mittig zentriert.
   -- Contracts, Kommentare und Kleinigkeiten korrigiert/angepasst/überarbeitet.
   
   

   -- Version 0.04.0750 => 0.04.0875 (04.10.2022):
   
   -- GNAT auf Version Debian 12.2.0-5 aktualisiert.
   -- Transporter werden jetzt nicht mehr automatisch entladen wenn man sie auf eine Stadt bewegt.
   -- Man kann jetzt über einen Befehlsknopf alle Arten von Transportern entladen.
   -- Angefangen die Tastenbelegung in eine Allgemeines und eine Einheiten Belegung umzubauen.
   -- Einheitenbefehle haben jetzt eine eigene Tastenbelegung und können nur noch mit ausgewählter Einheit durchgeführt werden.
   -- Allgemeine Befehle haben jetzt eine eigene Tastenbelegung.
   -- Es ist jetzt wieder möglich mit der Tastatur die Karte zu scrollen, wenn keine Einheit ausgewählt ist.
   -- Unnötigen Code gelöscht.
   -- Code zusammengeführt.
   -- Vereinfachte Tasteneingabe eingebaut.
   -- Contracts, Kommentare und Kleinigkeiten korrigiert/überarbeitet/angepasst/optimiert.
   
   

   -- Version 0.04.0670 => 0.04.0750 (03.10.2022):
   
   -- Noch mehr Tests und Einstellungen durchgeführt um eine vollständig plattformunabhängige Version zu bekommen, aber der scheiß funktioniert einfach nicht so wie ich das haben will.
   -- Diverse Prüfungen eingebaut um Abstürze zu verhindern.
   -- Passierbarkeitssystem überarbeitet, Passierbarkeit wird jetzt immer korrekt auf Basis des Grunds, vorhandener Stadt und vorhandenem Weg geprüft.
   -- Fehler korrigiert, welcher das Einlesen einiger Standarddatenbanken verhinderte.
   -- Fehler korrigiert, welcher es ermöglichte Einheiten den Platz tauschen zu lassen, auch wenn der Grund der einen Einheit von der anderen Einheit gar nicht betretbar war.
   -- Angefangen das automatische Ausladen wenn ein beladener Transporter sich auf eine Stadt bewegt durch eine Befehl auszutauschen welcher den Transporter automatisch vollständig entlädt.
   -- Contracts, Kommentare und Kleinigkeiten korrigiert/überarbeitet/angepasst.
   
   

   -- Version 0.04.0595 => 0.04.0670 (02.10.2022):
   
   -- Diverse Spieletest unter Linux und Windows durchgeführt.
   -- Die Linux- und Windowsversion besser aufgeteilt.
   -- Weiteres virtuelles System mit Debian Bullseye aufgesetzt um Bibliotheken mit älteren Versionen kompilieren zu können.
   -- Satisch gelinkte Versionen aller Bibliotheken auf Basis der Entwicklungsdateien aus Debian Bullseye erstellt und getestet.
   -- Mehrfaches, vollständiges Backup erstellt.
   -- Kommentare und Kleinigkeiten korrigiert.
   
   

   -- Version 0.04.0550 => 0.04.0595 (01.10.2022):
   
   -- Die Bewegungskostenberechnung für Einheiten überarbeitet.
   -- Die VerbesserungenDatenbank überarbeitet.
   -- Unnötigen Code gelöscht.
   -- Contracts, Kommentare und Kleinigkeiten korrigiert.

end ChangelogOktober2022;
