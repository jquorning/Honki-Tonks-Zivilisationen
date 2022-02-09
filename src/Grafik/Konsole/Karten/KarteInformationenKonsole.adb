pragma SPARK_Mode (On);

with Ada.Wide_Wide_Text_IO; use Ada.Wide_Wide_Text_IO;
with Ada.Integer_Wide_Wide_Text_IO;

with EinheitStadtDatentypen; use EinheitStadtDatentypen;
with GlobaleTexte;
with EinheitenKonstanten;
with StadtKonstanten;

with LeseKarten;

with TextAnzeigeKonsole;
with DebugPlatzhalter;
with EinheitSuchen;
with StadtSuchen;
with StadtInformationenKonsole;
with AufgabenAllgemein;
with KartenAllgemein;
with GesamtwerteFeld;
with InformationenWichtigesKonsole;
with InformationenEinheitenKonsole;
     
package body KarteInformationenKonsole is

   procedure KarteInformationenKonsole
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      InformationenWichtigesKonsole.Wichtiges (RasseExtern => RasseExtern);
      InformationenSichtbar (RasseExtern => RasseExtern);
      Kartenposition (RasseExtern => RasseExtern);
      DebugInformationen (RasseExtern => RasseExtern);
      
   end KarteInformationenKonsole;
   
   
   
   procedure InformationenSichtbar
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      Sichtbar := LeseKarten.Sichtbar (PositionExtern => GlobaleVariablen.CursorImSpiel (RasseExtern).Position,
                                       RasseExtern    => RasseExtern);
      
      case
        Sichtbar
      is
         when True =>
            EinheitRasseNummer := EinheitSuchen.KoordinatenEinheitOhneRasseSuchen (KoordinatenExtern => GlobaleVariablen.CursorImSpiel (RasseExtern).Position);
            
            if
              EinheitRasseNummer.Platznummer = EinheitenKonstanten.LeerNummer
            then
               null;
                
            else
               InformationenEinheitenKonsole.Einheiten (RasseExtern              => RasseExtern,
                                                        EinheitRasseNummerExtern => EinheitRasseNummer);
            end if;
            
         when False =>
            null;
      end case;
      
      case
        Sichtbar
      is
         when True =>
            StadtRasseNummer := StadtSuchen.KoordinatenStadtOhneRasseSuchen (KoordinatenExtern => GlobaleVariablen.CursorImSpiel (RasseExtern).Position);

            if
              StadtRasseNummer.Platznummer = StadtKonstanten.LeerNummer
            then
               null;
                     
            else
               InformationenStadt (RasseExtern            => RasseExtern,
                                   StadtRasseNummerExtern => StadtRasseNummer);
            end if;
            
         when False =>
            null;
      end case;
      
      case
        Sichtbar
      is
         when True =>
            InformationenAllgemein (RasseExtern => RasseExtern);
            
         when False =>
            null;
      end case;
      
      New_Line;
      
   end InformationenSichtbar;
   
         
   
   procedure InformationenStadt
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum;
      StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
   is begin
      
      StadtInformationenKonsole.Stadt (RasseExtern            => RasseExtern,
                                       StadtRasseNummerExtern => StadtRasseNummerExtern);

      -- Debuginformationen.
      case
        DebugPlatzhalter.FeindlicheInformationenSehen
      is
         when False =>
            null;
                                 
         when True =>
            DebugPlatzhalter.KarteStadtInfos (StadtRasseNummerExtern => StadtRasseNummerExtern);
      end case;
      
   end InformationenStadt;
   
   
   
   procedure InformationenAllgemein
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      Hügel (RasseExtern => RasseExtern);
      Put (Item => KartenAllgemein.Beschreibung (KartenGrundExtern => LeseKarten.Ressource (PositionExtern => GlobaleVariablen.CursorImSpiel (RasseExtern).Position)));
      Put_Line (Item => AufgabenAllgemein.Beschreibung (KartenVerbesserungExtern => LeseKarten.VerbesserungGebiet (PositionExtern => GlobaleVariablen.CursorImSpiel (RasseExtern).Position)));
      Put_Line (Item => AufgabenAllgemein.Beschreibung (KartenVerbesserungExtern => LeseKarten.VerbesserungWeg (PositionExtern => GlobaleVariablen.CursorImSpiel (RasseExtern).Position)));
      Put (Item => KartenAllgemein.Beschreibung (KartenGrundExtern => LeseKarten.Fluss (PositionExtern => GlobaleVariablen.CursorImSpiel (RasseExtern).Position)));
      New_Line;
            
      FeldVerteidigung (RasseExtern => RasseExtern);
      FeldAngriff (RasseExtern => RasseExtern);
      FeldNahrung (RasseExtern => RasseExtern);
      FeldProduktion (RasseExtern => RasseExtern);
      FeldGeld (RasseExtern => RasseExtern);
      FeldWissen (RasseExtern => RasseExtern);
      
   end InformationenAllgemein;
   
   
   
   procedure Hügel
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      if
        LeseKarten.Hügel (PositionExtern => GlobaleVariablen.CursorImSpiel (RasseExtern).Position) = True
      then
         TextAnzeigeKonsole.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleTexte.Leer,
                                                   TextDateiExtern        => GlobaleTexte.Beschreibungen_Kartenfelder_Kurz,
                                                   ÜberschriftZeileExtern => 0,
                                                   ErsteZeileExtern       => KartenDatentypen.Karten_Grund_Enum'Pos (KartenDatentypen.Hügel_Mit),
                                                   LetzteZeileExtern      => KartenDatentypen.Karten_Grund_Enum'Pos (KartenDatentypen.Hügel_Mit),
                                                   AbstandAnfangExtern    => GlobaleTexte.Leer,
                                                   AbstandMitteExtern     => GlobaleTexte.Leer,
                                                   AbstandEndeExtern      => GlobaleTexte.Leer);
         
      else
         null;
      end if;
         
      Put (Item => KartenAllgemein.Beschreibung (KartenGrundExtern => LeseKarten.Grund (PositionExtern => GlobaleVariablen.CursorImSpiel (RasseExtern).Position)));
      
   end Hügel;
   
   
   
   procedure FeldVerteidigung
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      TextAnzeigeKonsole.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleTexte.Leer,
                                                TextDateiExtern        => GlobaleTexte.Zeug,
                                                ÜberschriftZeileExtern => 0,
                                                ErsteZeileExtern       => 19,
                                                LetzteZeileExtern      => 19,
                                                AbstandAnfangExtern    => GlobaleTexte.Großer_Abstand,
                                                AbstandMitteExtern     => GlobaleTexte.Leer,
                                                AbstandEndeExtern      => GlobaleTexte.Kleiner_Abstand);
      Ada.Integer_Wide_Wide_Text_IO.Put (Item  => Integer (GesamtwerteFeld.FeldVerteidigung (KoordinatenExtern => GlobaleVariablen.CursorImSpiel (RasseExtern).Position,
                                                                                             RasseExtern       => RasseExtern)),
                                         Width => 1);
      
   end FeldVerteidigung;
   
   
   
   procedure FeldAngriff
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      TextAnzeigeKonsole.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleTexte.Leer,
                                                TextDateiExtern        => GlobaleTexte.Zeug,
                                                ÜberschriftZeileExtern => 0,
                                                ErsteZeileExtern       => 59,
                                                LetzteZeileExtern      => 59,
                                                AbstandAnfangExtern    => GlobaleTexte.Großer_Abstand,
                                                AbstandMitteExtern     => GlobaleTexte.Leer,
                                                AbstandEndeExtern      => GlobaleTexte.Kleiner_Abstand);
      Ada.Integer_Wide_Wide_Text_IO.Put (Item  => Integer (GesamtwerteFeld.FeldAngriff (KoordinatenExtern => GlobaleVariablen.CursorImSpiel (RasseExtern).Position,
                                                                                        RasseExtern       => RasseExtern)),
                                         Width => 1);
      
   end FeldAngriff;
   
   
   
   procedure FeldNahrung
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      TextAnzeigeKonsole.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleTexte.Leer,
                                                TextDateiExtern        => GlobaleTexte.Zeug,
                                                ÜberschriftZeileExtern => 0,
                                                ErsteZeileExtern       => 20,
                                                LetzteZeileExtern      => 20,
                                                AbstandAnfangExtern    => GlobaleTexte.Großer_Abstand,
                                                AbstandMitteExtern     => GlobaleTexte.Leer,
                                                AbstandEndeExtern      => GlobaleTexte.Kleiner_Abstand);
      Ada.Integer_Wide_Wide_Text_IO.Put (Item  => Integer (GesamtwerteFeld.FeldNahrung (KoordinatenExtern => GlobaleVariablen.CursorImSpiel (RasseExtern).Position,
                                                                                        RasseExtern       => RasseExtern)),
                                         Width => 1);
      New_Line;
      
   end FeldNahrung;
   
   
   
   procedure FeldProduktion
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      TextAnzeigeKonsole.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleTexte.Leer,
                                                TextDateiExtern        => GlobaleTexte.Zeug,
                                                ÜberschriftZeileExtern => 0,
                                                ErsteZeileExtern       => 21,
                                                LetzteZeileExtern      => 21,
                                                AbstandAnfangExtern    => GlobaleTexte.Großer_Abstand,
                                                AbstandMitteExtern     => GlobaleTexte.Leer,
                                                AbstandEndeExtern      => GlobaleTexte.Kleiner_Abstand);
      Ada.Integer_Wide_Wide_Text_IO.Put (Item  => Integer (GesamtwerteFeld.FeldProduktion (KoordinatenExtern => GlobaleVariablen.CursorImSpiel (RasseExtern).Position,
                                                                                           RasseExtern       => RasseExtern)),
                                         Width => 1);
      
   end FeldProduktion;
   
   
   
   procedure FeldGeld
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      TextAnzeigeKonsole.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleTexte.Leer,
                                                TextDateiExtern        => GlobaleTexte.Zeug,
                                                ÜberschriftZeileExtern => 0,
                                                ErsteZeileExtern       => 22,
                                                LetzteZeileExtern      => 22,
                                                AbstandAnfangExtern    => GlobaleTexte.Großer_Abstand,
                                                AbstandMitteExtern     => GlobaleTexte.Leer,
                                                AbstandEndeExtern      => GlobaleTexte.Kleiner_Abstand);
      Ada.Integer_Wide_Wide_Text_IO.Put (Item  => Integer (GesamtwerteFeld.FeldGeld (KoordinatenExtern => GlobaleVariablen.CursorImSpiel (RasseExtern).Position,
                                                                                     RasseExtern       => RasseExtern)),
                                         Width => 1);
      
   end FeldGeld;
   
   
   
   procedure FeldWissen
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      TextAnzeigeKonsole.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleTexte.Leer,
                                                TextDateiExtern        => GlobaleTexte.Zeug,
                                                ÜberschriftZeileExtern => 0,
                                                ErsteZeileExtern       => 23,
                                                LetzteZeileExtern      => 23,
                                                AbstandAnfangExtern    => GlobaleTexte.Großer_Abstand,
                                                AbstandMitteExtern     => GlobaleTexte.Leer,
                                                AbstandEndeExtern      => GlobaleTexte.Kleiner_Abstand);
      Ada.Integer_Wide_Wide_Text_IO.Put (Item  => Integer (GesamtwerteFeld.FeldWissen (KoordinatenExtern => GlobaleVariablen.CursorImSpiel (RasseExtern).Position,
                                                                                       RasseExtern       => RasseExtern)),
                                         Width => 1);
      New_Line;
      
   end FeldWissen;
   
   
   
   procedure Kartenposition
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      TextAnzeigeKonsole.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleTexte.Leer,
                                                TextDateiExtern        => GlobaleTexte.Zeug,
                                                ÜberschriftZeileExtern => 0,
                                                ErsteZeileExtern       => 57,
                                                LetzteZeileExtern      => 57,
                                                AbstandAnfangExtern    => GlobaleTexte.Leer,
                                                AbstandMitteExtern     => GlobaleTexte.Leer,
                                                AbstandEndeExtern      => GlobaleTexte.Kleiner_Abstand);
      
      WertOhneTrennzeichen := ZahlAlsStringEbeneVorhanden (ZahlExtern => GlobaleVariablen.CursorImSpiel (RasseExtern).Position.EAchse);
      YAchsenWert := ZahlAlsStringKartenfeldPositivMitNullwert (ZahlExtern => GlobaleVariablen.CursorImSpiel (RasseExtern).Position.YAchse);
      XAchsenWert := ZahlAlsStringKartenfeldPositivMitNullwert (ZahlExtern => GlobaleVariablen.CursorImSpiel (RasseExtern).Position.XAchse);
      
      Put_Line (Item => To_Wide_Wide_String (Source => WertOhneTrennzeichen) & ", " & To_Wide_Wide_String (Source => YAchsenWert) & ", " & To_Wide_Wide_String (Source => XAchsenWert));
      New_Line;
      
   end Kartenposition;
   
   
   
   procedure DebugInformationen
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      case
        DebugPlatzhalter.FeindlicheInformationenSehen
      is
         when False =>
            null;
            
         when True =>
            DebugPlatzhalter.KarteInfosFeld (RasseExtern => RasseExtern);
      end case;
      
   end DebugInformationen;

end KarteInformationenKonsole;