package ChangelogNovember2022 is

   -- Version 0.04. => 0.04. (30.11.2022):
   
   -- 
   -- Kleinigkeiten korrigiert.
   
   

   -- Version 0.04. => 0.04. (29.11.2022):
   
   -- 
   -- Kleinigkeiten korrigiert.
   
   

   -- Version 0.04. => 0.04. (28.11.2022):
   
   -- 
   -- Kleinigkeiten korrigiert.
   
   

   -- Version 0.04. => 0.04. (27.11.2022):
   
   -- 
   -- Kleinigkeiten korrigiert.
   
   

   -- Version 0.04. => 0.04. (26.11.2022):
   
   -- 
   -- Kleinigkeiten korrigiert.
   
   

   -- Version 0.04. => 0.04. (25.11.2022):
   
   -- 
   -- Kleinigkeiten korrigiert.
   
   

   -- Version 0.04. => 0.04. (24.11.2022):
   
   -- 
   -- Kleinigkeiten korrigiert.
   
   

   -- Version 0.04. => 0.04. (23.11.2022):
   
   -- 
   -- Kleinigkeiten korrigiert.
   
   

   -- Version 0.04.4140 => 0.04. (22.11.2022):
   
   -- 
   -- Kleinigkeiten korrigiert.
   
   

   -- Version 0.04.4035 => 0.04.4140 (21.11.2022):
   
   -- Weiter daran gearbeitet den Zugriff auf die SpielVariablen nur noch durch Lese- und Schreibesystem zu erlauben.
   -- Fehler im Diplomatiesystem korrigiert der dazu führte das eine nicht belegte Rasse berücksichtigt wurde.
   -- Unnötigen Code gelöscht.
   -- Zusätzliche Überlaufprüfungen eingebaut.
   -- Zusätzliche Sicherheitsprüfungen eingebaut.
   -- Interne Sturktur überarbeitet.
   -- Teile des Debugsystems und des Fehlermeldungssystem miteinander verschmolzen.
   -- Doppelten Code zusammengeführt.
   -- Contracts, Kommentare und Kleinigkeiten korrigiert/angepasst/überarbeitet/entfernt.
   
   

   -- Version 0.04.3935 => 0.04.4035 (20.11.2022):
   
   -- Schreibe- und Lesesystem für die Weltkarte auf die Karteneinstellungen erweitert.
   -- Sämtliche Zugriffe auf die Weltkarte und ihre Einstellungen erfolgen jetzt über das dazugehörige Lese- und Schreibesystem.
   -- Wenn man mit den Bewegungstasten eine Einheit aus dem Bild bewegt wird jetzt das Bild korrekt mitgescrollt.
   -- Die Menge an Kartenfelder die die KI in ihren Berechnungen nutzt ist jetzt abhängig vom Schwierigkeitsgrad.
   -- KI überarbeitet.
   -- Angefangen den Zugriff auf die SpielVariablen nur noch durch Lese- und Schreibesystem zu erlauben.
   -- Generische Überlaufprüfung angelegt und angefangen einzubauen.
   -- Fehler korrigiert der dazu führte dass die Anzahl der eingesetzten PZB beim Start eines weiteren Spieles nicht zurückgesetzt wurde.
   -- Contracts, Kommentare und Kleinigkeiten korrigiert/überarbeitet/angepasst.
   
   

   -- Version 0.04.3895 => 0.04.3935 (19.11.2022):
   
   -- Schreibe- und Lesesystem für die Weltkarte auf die Karteneinstellungen erweitert.
   -- Interne Struktur überarbeitet.
   -- Contracts, Kommentare und Kleinigkeiten korrigiert/überarbeitet.
   
   

   -- Version 0.04.3815 => 0.04.3895 (18.11.2022):
   
   -- Anpassungen an den gpr Dateien vorgenommen.
   -- Zusätzliche Sicherheitsprüfungen eingebaut.
   -- Diverse Zahlen in Konstante umgewandelt.
   -- Fehler- und Warnsystem erweitert.
   -- Fehler- und Warnsystem zusammengeführt.
   -- Fehler korrigiert der beim Tauschen von Einheiten durch die KI zu einem Absturz führte.
   -- Contarcts, Kommentare und Kleinigkeiten korrigiert/überarbeitet.
   
   

   -- Version 0.04.3640 => 0.04.3815 (17.11.2022):
   
   -- Anpassungen an den gpr Dateien vorgenommen.
   -- Dateien zum Kompilieren einer Windowsversion zu GitHub hinzugefügt.
   -- Alle Dateien sollten jetzt wirklich soweit möglich Pure, Preelaborate oder Elaborate_Body enthalten.
   -- Teile des Codes überarbeitet damit nirgendwo mehr im Kreis gelinkt wird.
   -- Einheitenbewegungssystem überarbeitet.
   -- Unnötigen Code gelöscht.
   -- Die notwendigen Bewegungspunkte und Bonusbewegungspunkte für ein Feld/Weg werden jetzt in den Kartengrund- und Wegedatenbanken gespeichert.
   -- Die notwendigen Bewegungspunkte um ein Feld zu betreten können jetzt rassenspezifisch eingestellt werden.
   -- Zusätzliche Sicherheitsprüfungen eingebaut.
   -- Fehler korrigiert der dazu führte dass die KI versuchte mit sehr vielen Einheiten eine Stadt zu bewachen.
   -- Fehler korrigiert der es der KI erlaubte Einheiten zu bewegen die keine Bewegungspunkte mehr hatten.
   -- KI überarbeitet
   -- Bewegungsplanberechnung der KI überarbeitet.
   -- Die KI ist jetzt besser darin unnötige Einheitenzüge zum Ziel zu vermeiden.
   -- Die KI ist jetzt in der Lage nebeneinander liegende Einheiten die Plätze tauschen zu lassen.
   -- Contracts, Kommentare und Kleinigkeiten korrigiert/angepasst/überarbeitet/erweitert.
   
   

   -- Version 0.04.3605 => 0.04.3640 (16.11.2022):
   
   -- Einige vergessene Dateien um pragma Pure, Preelaborate oder Elaborate_Body erweitert.
   -- Einige vergessene Einbindungen auf private gesetzt.
   -- Kommenatare und Kleinigkeiten korrigiert.
   
   

   -- Version 0.04.3520 => 0.04.3605 (15.11.2022):
   
   -- Anpassungen an den gpr Dateien vorgenommen.
   -- Alle Dateien sollten jetzt soweit möglich Pure, Preelaborate oder Elaborate_Body enthalten.
   -- Teile des Codes überarbeitet damit nicht mehr im Kreis gelinkt wird.
   -- Datenbanken können jetzt wieder einzeln geschrieben werden.
   -- Datenbanken bearbeitet.
   -- Die KI ist jetzt in der Lage die Einheiten zu verbessern welche ihre Städte schützt.
   -- KI überarbeitet.
   -- Kommentare und Kleinigkeiten korrigiert/überarbeitet.
   
   

   -- Version 0.04.3460 => 0.04.3520 (14.11.2022):
   
   -- KI überarbeitet.
   -- Die KI Berechnungen für den Standort einer neuen Stadt um einen Zufallsfaktor erweitert.
   -- Bevor die KI jetzt eine Stadt baut prüft sie erneut ob immer noch ausreichend Platz vorhanden ist.
   -- Das Erkunden durch die KI um einen Zufallsfaktor erweitert.
   -- Contracts, Kommentare und Kleinigkeiten korrigiert/angepasst/überarbeitet.
   
   

   -- Version 0.04.3410 => 0.04.3460 (13.11.2022):
   
   -- Die Sichtbarkeit von vielen Programmteilen reduziert durch das Ersetzen von 'use' durch 'use type'.
   -- Die Sichtbarkeit von einigen Programmteilen reduziert durch das Verschieben nach private.
   -- Unnötigen Code gelöscht.
   -- Contarcs, Kommentare und Kleinigkeiten korrigiert/angepasst.
   
   

   -- Version 0.04.3390 => 0.04.3410 (12.11.2022):
   
   -- Kleinigkeiten korrigiert.
   
   

   -- Version 0.04.3320 => 0.04.3390 (11.11.2022):
   
   -- KI überarbeitet.
   -- Bewegungsplanberechnung der KI überarbeitet.
   -- Angefangen die Berechnungen der KI weniger vorhersagbar zu gestalten.
   -- Die KI ist jetzt besser in der Lage einen Weg zu Berechnen, wenn beliebige Übergängsarten für die Achsen eingestellt sind.
   -- Aufgabenprüfung der KI überarbeitet.
   -- Kommentare und Kleinigkeiten korrigiert/überarbeitet/angepasst.
   
   

   -- Version 0.04.3220 => 0.04.3320 (10.11.2022):
   
   -- Fehler behoben durch den die Ekropa Schiffe über Schienen bewegen konnten.
   -- Versionsnummerberechnung angepasst.
   -- pragma Warnings (Off, "*array aggregate*"); in eine Datei ausgelagert.
   -- Unnötigen Code gelöscht.
   -- KI überarbeitet.
   -- Bewegungsplanberechnung der KI überarbeitet.
   -- Die KI ist jetzt besser in der Lage einen Weg zu Berechnen, wenn normale Übergänge für die XAchse oder YAchse eingestellt sind.
   -- Fehler korrigiert der dazu führte dass die KI unnötig viele Einheiten verwendete um eine einzelne Aufgabe durchzuführen.
   -- Contracts, Kommentare und Kleinigkeiten korrigiert/überarbeitet/angepasst.
   
   

   -- Version 0.04.3130 => 0.04.3220 (09.11.2022):
   
   -- Hochwertiges Holz als Ressource hinzugefügt.
   -- KI überarbeitet.
   -- Berechnungssystem für das Anlegen von Verbesserungen durch die KI überarbeitet.
   -- KI entfernt jetzt keinen Wald mehr wenn sich auf diesem hochwertiges Holz befindet.
   -- Das Eentfernen eines Waldes/Dschungels entfernt jetzt auch hochwertiges Holz.
   -- Bewegungsplanberechnung der KI überarbeitet.
   -- Fehler korrigiert der es erlaubte mehr als das Maximum an Ressourcen in einer Stadt zu haben und dadurch zu einem Absturz führte.
   -- Contracts, Kommentare und Kleinigkeiten korrigiert/überarbeitet/angepasst.
   
   

   -- Version 0.04.3130 => 0.04.3130 (08.11.2022):
   
   -- null.
   
   

   -- Version 0.04.3130 => 0.04.3130 (07.11.2022):
   
   -- null.
   
   

   -- Version 0.04.3130 => 0.04.3130 (06.11.2022):
   
   -- null.
   
   

   -- Version 0.04.3040 => 0.04.3130 (05.11.2022):
   
   -- Angriff- und Verteidigungswerte überarbeitet, so dass die Kartenfelder jetzt besser Bonus und Malus geben können.
   -- Kampfsystem überarbeitet.
   -- Der Einsatz einer PZB wird jetzt auch korrekt erkannt wenn sie gegen eine Stadt eingesetzt wird.
   -- Theoretische Endloskampfsituation entfernt.
   -- Mehr OO in Form von tagged Records entfernt.
   -- Seitenleiste überarbeitet.
   -- Speicherverbrauch um rund 65 MB reduziert.
   -- Contracts, Kommentare und Kleinigkeiten korrigiert/angepasst/zusammengefasst.
   
   

   -- Version 0.04.2960 => 0.04.3040 (04.11.2022):
   
   -- Versionsnummerberechnung angepasst.
   -- GNAT von 12.2.0-7 auf GNAT 12.2.0-9 aktualisiert.
   -- Berechnung von Bonuswerte im Kampf überarbeitet.
   -- Fehler korrigiert der dazu führte das Einheiten weniger als einen Lebenspunkt haben konnten.
   -- Unnötigen Code gelöscht.
   -- Seitenleiste überarbeitet.
   -- Contracts, Kommentare und Kleinigkeiten korrigiert/überarbeitet.
   
   

   -- Version 0.04.2785 => 0.04.2960 (03.11.2022):
   
   -- Weiter an der KI gearbeitet.
   -- SPARK_Mode (On/Off) entfernt, wird vermutlich niemals gebraucht werden.
   -- Neue Version der Siedleraufgabenplanung für die KI gebaut.
   -- Unnötigen Code gelöscht.
   -- Code zusammengeführt.
   -- Neue Version der Nahkämpferaufgabenplanung für die KI gebaut.
   -- Die KI kann jetzt in Kriegen eine PZB einsetzen.
   -- Die KI baut jetzt Städte in anderen Ebenen.
   -- Fehler behoben der die vorhandenen Einheiten falsch zählte und so unter bestimmten Bedingungen einen Absturz erzeugen konnte.
   -- Interne Struktur überarbeitet.
   -- Contracts, Kommentare und Kleinigkeiten korrigiert/angepasst/überarbeitet/erweitert.
   
   

   -- Version 0.04.2785 => 0.04.2785 (02.11.2022):
   
   -- null.
   
   

   -- Version 0.04.2785 => 0.04.2785 (01.11.2022):
   
   -- null.

end ChangelogNovember2022;
