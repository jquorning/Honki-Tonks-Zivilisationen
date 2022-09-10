pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with EinheitenDatentypen; use EinheitenDatentypen;
with TastenbelegungDatentypen; use TastenbelegungDatentypen;
with AufgabenDatentypen; use AufgabenDatentypen;
with StadtDatentypen; use StadtDatentypen;
with RueckgabeDatentypen; use RueckgabeDatentypen;
with EinheitenKonstanten;
with StadtKonstanten;
with TextnummernKonstanten;

with LeseEinheitenGebaut;

with StadtmenueLogik;
with BewegungCursor;
with NaechstesObjekt;
with AufgabenLogik;
with Diplomatie;
with DebugmenueLogik;
with StadtBauen;
with EinheitSuchen;
with StadtSuchen;
with TasteneingabeLogik;
with StadtEntfernen;
with TransporterSuchen;
with EinheitenModifizieren;
with AufgabenAllgemeinLogik;
with EinheitenkontrollsystemLogik;
with AuswahlStadtEinheitLogik;
with NachGrafiktask;
with JaNeinLogik;
with EinheitenSpielmeldungenLogik;
with ForschungsauswahlLogik;
with StadtAllgemeinLogik;

-- Hier auch mal überarbeiten, vor allem die Prozeduren weiter unten. äöü
package body BefehleLogik is
   
   -- Kann man nicht auch hier eine Schleife einbauen und sich das Zurückgehen sparen? äöü
   function Befehle
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return RueckgabeDatentypen.Rückgabe_Werte_Enum
   is begin
                               
      Befehl := TasteneingabeLogik.Tastenwert;

      case
        Befehl
      is
         when TastenbelegungDatentypen.Tastenbelegung_Bewegung_Ebene_Enum'Range =>
            BewegungCursor.CursorbewegungBerechnen (RichtungExtern => Befehl,
                                                    RasseExtern    => RasseExtern);
            
         when TastenbelegungDatentypen.Auswählen_Enum =>
            AuswahlEinheitStadt (RasseExtern => RasseExtern);
            
         when TastenbelegungDatentypen.Menü_Zurück_Enum =>
            return RueckgabeDatentypen.Spielmenü_Enum;

         when TastenbelegungDatentypen.Bauen_Enum =>
            BaueStadt (RasseExtern => RasseExtern);
           
         when TastenbelegungDatentypen.Forschung_Enum =>
            ForschungsauswahlLogik.Forschung (RasseExtern => RasseExtern);
            
            -- Die folgenden vier Befehle scheinen gar nicht mehr zu funktionieren. äöü
            -- So anpassen wie GeheZu. äöü
         when TastenbelegungDatentypen.Nächste_Stadt_Enum =>
            NaechstesObjekt.NächsteStadt (RasseExtern => RasseExtern);
            
         when TastenbelegungDatentypen.Einheit_Mit_Bewegungspunkte_Enum =>
            NaechstesObjekt.NächsteEinheit (RasseExtern           => RasseExtern,
                                             BewegungspunkteExtern => NaechstesObjekt.Hat_Bewegungspunkte);
            
         when TastenbelegungDatentypen.Alle_Einheiten_Enum =>
            NaechstesObjekt.NächsteEinheit (RasseExtern           => RasseExtern,
                                             BewegungspunkteExtern => NaechstesObjekt.Egal_Bewegeungspunkte);
            
         when TastenbelegungDatentypen.Einheiten_Ohne_Bewegungspunkte_Enum =>
            NaechstesObjekt.NächsteEinheit (RasseExtern           => RasseExtern,
                                             BewegungspunkteExtern => NaechstesObjekt.Keine_Bewegungspunkte);
            
         when TastenbelegungDatentypen.Tastenbelegung_Befehle_Enum'Range =>
            if
              Befehl = TastenbelegungDatentypen.Auflösen_Enum
            then
               WasWirdEntfernt (RasseExtern => RasseExtern);
               
            else
               EinheitBefehle (RasseExtern  => RasseExtern,
                               BefehlExtern => Befehl);
            end if;

         when TastenbelegungDatentypen.Diplomatie_Enum =>
            Diplomatie.DiplomatieMöglich (RasseExtern => RasseExtern);

         when TastenbelegungDatentypen.Gehe_Zu_Enum =>
            BewegungCursor.GeheZu;

         when TastenbelegungDatentypen.Stadt_Umbenennen_Enum =>
            StadtUmbenennen (RasseExtern => RasseExtern);
            
         when TastenbelegungDatentypen.Stadt_Suchen_Enum =>
            StadtSuchenNachNamen := StadtSuchen.StadtNachNamenSuchen;
            
         when TastenbelegungDatentypen.Nächste_Stadt_Mit_Meldung_Enum =>
            NaechstesObjekt.NächsteStadtMeldung (RasseExtern => RasseExtern);
            
         when TastenbelegungDatentypen.Nächste_Einheit_Mit_Meldung_Enum =>
            NaechstesObjekt.NächsteEinheitMeldung (RasseExtern => RasseExtern);
            
         when TastenbelegungDatentypen.Heimatstadt_Ändern_Enum =>
            EinheitenModifizieren.HeimatstadtÄndern (EinheitRasseNummerExtern => (RasseExtern, 0));
            
         when TastenbelegungDatentypen.Runde_Beenden_Enum =>
            return RueckgabeDatentypen.Runde_Beenden_Enum;
            
         when TastenbelegungDatentypen.Debugmenü_Enum =>
            DebugmenueLogik.Debugmenü (RasseExtern => RasseExtern);
            
         when TastenbelegungDatentypen.Leer_Tastenbelegung_Enum | TastenbelegungDatentypen.Tastenbelegung_Bewegung_Numblock_Enum'Range =>
            null;
      end case;
      
      return RueckgabeDatentypen.Start_Weiter_Enum;
      
   end Befehle;
   
   
   
   procedure WasWirdEntfernt
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      EinheitNummer := EinheitSuchen.KoordinatenEinheitMitRasseSuchen (RasseExtern       => RasseExtern,
                                                                       KoordinatenExtern => SpielVariablen.CursorImSpiel (RasseExtern).KoordinatenAktuell,
                                                                       LogikGrafikExtern => True);
      StadtNummer := StadtSuchen.KoordinatenStadtMitRasseSuchen (RasseExtern       => RasseExtern,
                                                                 KoordinatenExtern => SpielVariablen.CursorImSpiel (RasseExtern).KoordinatenAktuell);
      
      if
        EinheitNummer /= EinheitenDatentypen.MaximaleEinheitenMitNullWert'First
        and
          StadtNummer /= StadtDatentypen.MaximaleStädteMitNullWert'First
      then
         -- Transporter sollten in der Stadt nicht beladen sein, deswegen es hier keine Prüfung auf Transporter braucht.
         case
           AuswahlStadtEinheitLogik.AuswahlStadtEinheit (RasseExtern         => RasseExtern,
                                                         StadtNummerExtern   => StadtNummer,
                                                         EinheitNummerExtern => EinheitNummer)
         is
            when 0 =>
               LeerRückgabewert := StadtEntfernen.StadtAbreißen (StadtRasseNummerExtern => (RasseExtern, StadtNummer));
               
            when 1 =>
               EinheitBefehle (RasseExtern  => RasseExtern,
                               BefehlExtern => TastenbelegungDatentypen.Auflösen_Enum);
               
            when others =>
               null;
         end case;
         
      elsif
        StadtNummer /= StadtDatentypen.MaximaleStädteMitNullWert'First
      then
         LeerRückgabewert := StadtEntfernen.StadtAbreißen (StadtRasseNummerExtern => (RasseExtern, StadtNummer));
         
      elsif
        EinheitNummer /= EinheitenDatentypen.MaximaleEinheitenMitNullWert'First
      then
         EinheitBefehle (RasseExtern  => RasseExtern,
                         BefehlExtern => TastenbelegungDatentypen.Auflösen_Enum);
               
      else
         null;
      end if;
      
   end WasWirdEntfernt;
   
   
   
   procedure AuswahlEinheitStadt
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      EinheitNummer := EinheitSuchen.KoordinatenEinheitMitRasseSuchen (RasseExtern       => RasseExtern,
                                                                       KoordinatenExtern => SpielVariablen.CursorImSpiel (RasseExtern).KoordinatenAktuell,
                                                                       LogikGrafikExtern => True);
      StadtNummer := StadtSuchen.KoordinatenStadtMitRasseSuchen (RasseExtern       => RasseExtern,
                                                                 KoordinatenExtern => SpielVariablen.CursorImSpiel (RasseExtern).KoordinatenAktuell);

      if
        EinheitNummer /= EinheitenDatentypen.MaximaleEinheitenMitNullWert'First
        and
          StadtNummer /= StadtDatentypen.MaximaleStädteMitNullWert'First
      then
         -- Transporter sollten in der Stadt nicht beladen sein, deswegen es hier keine Prüfung auf Transporter braucht.
         EinheitOderStadt (RasseExtern         => RasseExtern,
                           StadtNummerExtern   => StadtNummer,
                           EinheitNummerExtern => EinheitNummer);
         
      elsif
        StadtNummer /= StadtDatentypen.MaximaleStädteMitNullWert'First
      then
         StadtmenueLogik.Stadtmenü (StadtRasseNummerExtern => (RasseExtern, StadtNummer));
         
      elsif
        EinheitNummer /= EinheitenDatentypen.MaximaleEinheitenMitNullWert'First
      then
         AuswahlEinheitTransporter (EinheitRasseNummerExtern => (RasseExtern, EinheitNummer));
               
      else
         null;
      end if;
      
   end AuswahlEinheitStadt;
   
   
   
   procedure AuswahlEinheitTransporter
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
   is begin
      
      Transportiert := TransporterSuchen.HatTransporterLadung (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      
      if
        LeseEinheitenGebaut.WirdTransportiert (EinheitRasseNummerExtern => EinheitRasseNummerExtern) = EinheitenKonstanten.LeerWirdTransportiert
        and
          Transportiert = False
      then
         TransporterNummer := EinheitRasseNummerExtern.Nummer;
         AusgewählteEinheit := 0;

      elsif
        LeseEinheitenGebaut.WirdTransportiert (EinheitRasseNummerExtern => EinheitRasseNummerExtern) /= EinheitenKonstanten.LeerWirdTransportiert
      then
         TransporterNummer := LeseEinheitenGebaut.WirdTransportiert (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
         AusgewählteEinheit := AuswahlStadtEinheitLogik.AuswahlStadtEinheit (RasseExtern         => EinheitRasseNummerExtern.Rasse,
                                                                              StadtNummerExtern   => StadtDatentypen.MaximaleStädteMitNullWert'First,
                                                                              EinheitNummerExtern => TransporterNummer);

      else
         TransporterNummer := EinheitRasseNummerExtern.Nummer;
         AusgewählteEinheit := AuswahlStadtEinheitLogik.AuswahlStadtEinheit (RasseExtern         => EinheitRasseNummerExtern.Rasse,
                                                                              StadtNummerExtern   => StadtDatentypen.MaximaleStädteMitNullWert'First,
                                                                              EinheitNummerExtern => TransporterNummer);
      end if;
      
      case
        AusgewählteEinheit
      is
         when 0 =>
            EinheitSteuern (EinheitRasseNummerExtern => (EinheitRasseNummerExtern.Rasse, TransporterNummer));
            
         when Positive (EinheitenRecords.TransporterArray'First) .. Positive (EinheitenRecords.TransporterArray'Last) =>
            EinheitSteuern (EinheitRasseNummerExtern => (EinheitRasseNummerExtern.Rasse, LeseEinheitenGebaut.Transportiert (EinheitRasseNummerExtern => (EinheitRasseNummerExtern.Rasse, TransporterNummer),
                                                                                                                            PlatzExtern              => EinheitenDatentypen.Transportplätze (AusgewählteEinheit))));
            
         when others =>
            null;
      end case;
      
   end AuswahlEinheitTransporter;



   procedure EinheitOderStadt
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      StadtNummerExtern : in StadtDatentypen.MaximaleStädteMitNullWert;
      EinheitNummerExtern : in EinheitenDatentypen.MaximaleEinheitenMitNullWert)
   is begin
      
      case
        AuswahlStadtEinheitLogik.AuswahlStadtEinheit (RasseExtern         => RasseExtern,
                                                      StadtNummerExtern   => StadtNummerExtern,
                                                      EinheitNummerExtern => EinheitNummerExtern)
      is
         when 0 =>
            StadtmenueLogik.Stadtmenü (StadtRasseNummerExtern => (RasseExtern, StadtNummerExtern));
            
         when 1 =>
            EinheitSteuern (EinheitRasseNummerExtern => (RasseExtern, EinheitNummerExtern));
               
         when others =>
            null;
      end case;
      
   end EinheitOderStadt;
   
   
   
   procedure EinheitSteuern
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
   is begin
      
      NachGrafiktask.AktuelleEinheit := EinheitRasseNummerExtern.Nummer;
      
      if
        LeseEinheitenGebaut.Beschäftigung (EinheitRasseNummerExtern => EinheitRasseNummerExtern) /= EinheitenKonstanten.LeerBeschäftigung
        and then
          JaNeinLogik.JaNein (FrageZeileExtern => TextnummernKonstanten.FrageBeschäftigungAbbrechen) = True
      then
         AufgabenAllgemeinLogik.Nullsetzung (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
         EinheitenkontrollsystemLogik.Einheitenkontrolle (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
         NachGrafiktask.AktuelleEinheit := EinheitenKonstanten.LeerNummer;
         return;
         
      else
         null;
      end if;
      
      case
        EinheitenSpielmeldungenLogik.BewegungspunkteMeldung (EinheitRasseNummerExtern => EinheitRasseNummerExtern)
      is
         when True =>
            EinheitenkontrollsystemLogik.Einheitenkontrolle (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
            
         when False =>
            null;
      end case;
      
      NachGrafiktask.AktuelleEinheit := EinheitenKonstanten.LeerNummer;
      
   end EinheitSteuern;
   
   
   
   procedure BaueStadt
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      EinheitNummer := EinheitSuchen.KoordinatenEinheitMitRasseSuchen (RasseExtern       => RasseExtern,
                                                                       KoordinatenExtern => SpielVariablen.CursorImSpiel (RasseExtern).KoordinatenAktuell,
                                                                       LogikGrafikExtern => True);
      case
        EinheitNummer
      is
         when EinheitenKonstanten.LeerNummer =>
            return;
            
         when others =>
            null;
      end case;
      
      case
        EinheitenSpielmeldungenLogik.BewegungspunkteMeldung (EinheitRasseNummerExtern => (RasseExtern, EinheitNummer))
      is
         when True =>
            LeerRückgabewert := StadtBauen.StadtBauen (EinheitRasseNummerExtern => (RasseExtern, EinheitNummer));
            
         when False =>
            null;
      end case;
      
   end BaueStadt;
   
   
   
   procedure EinheitBefehle
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      BefehlExtern : in TastenbelegungDatentypen.Tastenbelegung_Befehle_Enum)
   is begin
                     
      EinheitNummer := EinheitSuchen.KoordinatenEinheitMitRasseSuchen (RasseExtern       => RasseExtern,
                                                                       KoordinatenExtern => SpielVariablen.CursorImSpiel (RasseExtern).KoordinatenAktuell,
                                                                       LogikGrafikExtern => True);
      
      case
        EinheitNummer
      is
         when EinheitenKonstanten.LeerNummer =>
            return;
                  
         when others =>
            null;
      end case;
      
      case
        EinheitenSpielmeldungenLogik.BewegungspunkteMeldung (EinheitRasseNummerExtern => (RasseExtern, EinheitNummer))
      is
         when True =>
            LeerRückgabewert := AufgabenLogik.Aufgabe (EinheitRasseNummerExtern => (RasseExtern, EinheitNummer),
                                                        BefehlExtern             => BefehlExtern,
                                                        KoordinatenExtern        => LeseEinheitenGebaut.Koordinaten (EinheitRasseNummerExtern => (RasseExtern, EinheitNummer)));
            
         when False =>
            null;
      end case;
      
   end EinheitBefehle;
   
   
   
   procedure StadtUmbenennen
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      StadtNummer := StadtSuchen.KoordinatenStadtMitRasseSuchen (RasseExtern       => RasseExtern,
                                                                 KoordinatenExtern => SpielVariablen.CursorImSpiel (RasseExtern).KoordinatenAktuell);
      
      case
        StadtNummer
      is
         when StadtKonstanten.LeerNummer =>
            null;
         
         when others =>
            StadtAllgemeinLogik.NeuerStadtname (StadtRasseNummerExtern => (RasseExtern, StadtNummer));
      end case;
      
   end StadtUmbenennen;

end BefehleLogik;
