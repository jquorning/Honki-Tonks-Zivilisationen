pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Sf.Graphics.RenderWindow;
with Sf.Graphics;
with Sf.Graphics.Text;

with EinheitStadtDatentypen; use EinheitStadtDatentypen;
with ProduktionDatentypen; use ProduktionDatentypen;
with GlobaleTexte;
with StadtKonstanten;
with KartenVerbesserungDatentypen;
with TextKonstanten;
with TextaccessVariablen;

with LeseStadtGebaut;

with GesamtwerteFeld;
with KampfwerteStadtErmitteln;
with DebugPlatzhalter;
with GrafikEinstellungenSFML;
with Fehler;

package body StadtInformationenSFML is

   function Stadt
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      StadtRasseNummerExtern : in EinheitStadtRecords.RasseEinheitnummerRecord;
      AnzeigeAnfangenExtern : in Sf.System.Vector2.sfVector2f)
      return Sf.System.Vector2.sfVector2f
   is begin
      
      TextPosition := AnzeigeAnfangenExtern;
      Zeilenabstand := Float (GrafikEinstellungenSFML.Schriftgrößen.SchriftgrößeStandard) * 0.15;
      
      -- Allgemeine Stadtinformationen, nur sichtbar wenn das Kartenfeld aufgedeckt ist und sich dort eine Stadt befindet.
      StadtartName (RasseExtern            => RasseExtern,
                    StadtRasseNummerExtern => StadtRasseNummerExtern);
      Einwohner (StadtRasseNummerExtern => StadtRasseNummerExtern);

      -- Volle Stadtinformationen, nur sichtbar wenn eigene Stadt oder durch Debug.
      if
        StadtRasseNummerExtern.Rasse = RasseExtern
        or
          DebugPlatzhalter.FeindlicheInformationenSehen
      then
         AktuelleNahrungsmittel (StadtRasseNummerExtern => StadtRasseNummerExtern);
         AktuelleNahrungsproduktion (StadtRasseNummerExtern => StadtRasseNummerExtern);
                                 
         AktuelleProduktionrate (StadtRasseNummerExtern => StadtRasseNummerExtern);
         AktuelleGeldgewinnung (StadtRasseNummerExtern => StadtRasseNummerExtern);
         AktuelleForschungsrate (StadtRasseNummerExtern => StadtRasseNummerExtern);
                  
         AktuelleVerteidigung (StadtRasseNummerExtern => StadtRasseNummerExtern);
         AktuellerAngriff (StadtRasseNummerExtern => StadtRasseNummerExtern);
         
         Korruption (StadtRasseNummerExtern => StadtRasseNummerExtern);
         EinwohnerOhneArbeit (StadtRasseNummerExtern => StadtRasseNummerExtern);
                        
         AktuellesBauprojekt (StadtRasseNummerExtern => StadtRasseNummerExtern);

      else
         null;
      end if;
      
      TextSchleife:
      for TextSchleifenwert in TextaccessVariablen.StadtInformationenAccessArray'Range loop
         
         Sf.Graphics.RenderWindow.drawText (renderWindow => GrafikEinstellungenSFML.FensterAccess,
                                            text         => TextaccessVariablen.StadtInformationenAccess (TextSchleifenwert));
         
      end loop TextSchleife;
      
      return TextPosition;
      
   end Stadt;
   
   

   procedure StadtartName
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      StadtRasseNummerExtern : in EinheitStadtRecords.RasseEinheitnummerRecord)
   is begin
      
      -- Diese Anzeige komplett in die Kartenanzeige verschieben? 
      case
        LeseStadtGebaut.ID (StadtRasseNummerExtern => StadtRasseNummerExtern)
      is
         when KartenVerbesserungDatentypen.Leer_Verbesserung_Enum =>
            Fehler.GrafikFehler (FehlermeldungExtern => "StadtInformationenSFML.StadtartName - Stadt sollte existieren tut sie aber nicht.");
            
         when KartenVerbesserungDatentypen.Eigene_Hauptstadt_Enum =>
            if
              RasseExtern = StadtRasseNummerExtern.Rasse
            then
               Stadtart := 1;

            else
               Stadtart := 3;
            end if;
            
         when KartenVerbesserungDatentypen.Eigene_Stadt_Enum =>
            if
              RasseExtern = StadtRasseNummerExtern.Rasse
            then
               Stadtart := 2;
               
            else
               Stadtart := 4;
            end if;
      end case;
      
      Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.StadtInformationenAccess (1),
                                         str  => To_Wide_Wide_String (Source => GlobaleTexte.Zeug (Stadtart)) & " " & StadtName (StadtRasseNummerExtern => StadtRasseNummerExtern));
      Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.StadtInformationenAccess (1),
                                    position => TextPosition);
      
      TextPosition.y := TextPosition.y + Zeilenabstand + Sf.Graphics.Text.getLocalBounds (text => TextaccessVariablen.StadtInformationenAccess (1)).height;
      
   end StadtartName;
   
   
   
   function StadtName
     (StadtRasseNummerExtern : in EinheitStadtRecords.RasseEinheitnummerRecord)
      return Wide_Wide_String
   is begin
      
      return To_Wide_Wide_String (Source => LeseStadtGebaut.Name (StadtRasseNummerExtern => StadtRasseNummerExtern));
      
   end StadtName;
   
   
   
   procedure Einwohner
     (StadtRasseNummerExtern : in EinheitStadtRecords.RasseEinheitnummerRecord)
   is begin
      
      WertOhneTrennzeichen := ZahlAlsStringProduktionFeld (ZahlExtern => LeseStadtGebaut.EinwohnerArbeiter (StadtRasseNummerExtern  => StadtRasseNummerExtern,
                                                                                                            EinwohnerArbeiterExtern => True));
      
      Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.StadtInformationenAccess (2),
                                         str  => To_Wide_Wide_String (Source => GlobaleTexte.Zeug (TextKonstanten.ZeugEinwohner)) & " " & To_Wide_Wide_String (Source => WertOhneTrennzeichen));
      Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.StadtInformationenAccess (2),
                                    position => TextPosition);
      
      TextPosition.y := TextPosition.y + Zeilenabstand + Sf.Graphics.Text.getLocalBounds (text => TextaccessVariablen.StadtInformationenAccess (2)).height;
      
   end Einwohner;
   
   
   
   procedure AktuelleNahrungsmittel
     (StadtRasseNummerExtern : in EinheitStadtRecords.RasseEinheitnummerRecord)
   is begin
      
      WertOhneTrennzeichen := ZahlAlsStringGesamtproduktionStadt (ZahlExtern => LeseStadtGebaut.Nahrungsmittel (StadtRasseNummerExtern => StadtRasseNummerExtern));
      
      Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.StadtInformationenAccess (3),
                                         str  => To_Wide_Wide_String (Source => GlobaleTexte.Zeug (TextKonstanten.ZeugNahrungsmittel)) & " " & To_Wide_Wide_String (Source => WertOhneTrennzeichen));
      Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.StadtInformationenAccess (3),
                                    position => TextPosition);
      
      TextPosition.y := TextPosition.y + Zeilenabstand + Sf.Graphics.Text.getLocalBounds (text => TextaccessVariablen.StadtInformationenAccess (3)).height;
      
   end AktuelleNahrungsmittel;
   
   
   
   procedure AktuelleNahrungsproduktion
     (StadtRasseNummerExtern : in EinheitStadtRecords.RasseEinheitnummerRecord)
   is begin
      
      WertOhneTrennzeichen := ZahlAlsStringGesamtproduktionStadt (ZahlExtern => LeseStadtGebaut.Nahrungsproduktion (StadtRasseNummerExtern => StadtRasseNummerExtern));
      
      Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.StadtInformationenAccess (4),
                                         str  => To_Wide_Wide_String (Source => GlobaleTexte.Zeug (TextKonstanten.ZeugNahrungsproduktion)) & " " & To_Wide_Wide_String (Source => WertOhneTrennzeichen));
      Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.StadtInformationenAccess (4),
                                    position => TextPosition);
      
      TextPosition.y := TextPosition.y + Zeilenabstand + Sf.Graphics.Text.getLocalBounds (text => TextaccessVariablen.StadtInformationenAccess (4)).height;
      
   end AktuelleNahrungsproduktion;
   
   
   
   procedure AktuelleProduktionrate
     (StadtRasseNummerExtern : in EinheitStadtRecords.RasseEinheitnummerRecord)
   is begin
      
      WertOhneTrennzeichen := ZahlAlsStringGesamtproduktionStadt (ZahlExtern => LeseStadtGebaut.Produktionrate (StadtRasseNummerExtern => StadtRasseNummerExtern));
      
      Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.StadtInformationenAccess (5),
                                         str  => To_Wide_Wide_String (Source => GlobaleTexte.Zeug (TextKonstanten.ZeugRessourcenproduktion)) & " " & To_Wide_Wide_String (Source => WertOhneTrennzeichen));
      Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.StadtInformationenAccess (5),
                                    position => TextPosition);
      
      TextPosition.y := TextPosition.y + Zeilenabstand + Sf.Graphics.Text.getLocalBounds (text => TextaccessVariablen.StadtInformationenAccess (5)).height;
      
   end AktuelleProduktionrate;
   
   
   
   procedure AktuelleGeldgewinnung
     (StadtRasseNummerExtern : in EinheitStadtRecords.RasseEinheitnummerRecord)
   is begin
      
      WertOhneTrennzeichen := ZahlAlsStringGesamtproduktionStadt (ZahlExtern => LeseStadtGebaut.Geldgewinnung (StadtRasseNummerExtern => StadtRasseNummerExtern));
      
      Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.StadtInformationenAccess (6),
                                         str  => To_Wide_Wide_String (Source => GlobaleTexte.Zeug (TextKonstanten.ZeugGeldproduktion)) & " " & To_Wide_Wide_String (Source => WertOhneTrennzeichen));
      Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.StadtInformationenAccess (6),
                                    position => TextPosition);
      
      TextPosition.y := TextPosition.y + Zeilenabstand + Sf.Graphics.Text.getLocalBounds (text => TextaccessVariablen.StadtInformationenAccess (6)).height;
      
   end AktuelleGeldgewinnung;
   
   
   
   procedure AktuelleForschungsrate
     (StadtRasseNummerExtern : in EinheitStadtRecords.RasseEinheitnummerRecord)
   is begin
      
      WertOhneTrennzeichen := ZahlAlsStringGesamtproduktionStadt (ZahlExtern => LeseStadtGebaut.Forschungsrate (StadtRasseNummerExtern => StadtRasseNummerExtern));
      
      Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.StadtInformationenAccess (7),
                                         str  => To_Wide_Wide_String (Source => GlobaleTexte.Zeug (TextKonstanten.ZeugWissensproduktion)) & " " & To_Wide_Wide_String (Source => WertOhneTrennzeichen));
      Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.StadtInformationenAccess (7),
                                    position => TextPosition);
      
      TextPosition.y := TextPosition.y + Zeilenabstand + Sf.Graphics.Text.getLocalBounds (text => TextaccessVariablen.StadtInformationenAccess (7)).height;
      
   end AktuelleForschungsrate;
   
   
   
   procedure AktuelleVerteidigung
     (StadtRasseNummerExtern : in EinheitStadtRecords.RasseEinheitnummerRecord)
   is begin
      
      WertOhneTrennzeichen := ZahlAlsStringKampfwerte (ZahlExtern => KampfwerteStadtErmitteln.AktuelleVerteidigungStadt (StadtRasseNummerExtern => StadtRasseNummerExtern));
      
      Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.StadtInformationenAccess (8),
                                         str  => To_Wide_Wide_String (Source => GlobaleTexte.Zeug (TextKonstanten.ZeugVerteidigung)) & " " & To_Wide_Wide_String (Source => WertOhneTrennzeichen));
      Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.StadtInformationenAccess (8),
                                    position => TextPosition);
      
      TextPosition.y := TextPosition.y + Zeilenabstand + Sf.Graphics.Text.getLocalBounds (text => TextaccessVariablen.StadtInformationenAccess (8)).height;
      
   end AktuelleVerteidigung;
   
   
   
   procedure AktuellerAngriff
     (StadtRasseNummerExtern : in EinheitStadtRecords.RasseEinheitnummerRecord)
   is begin
      
      WertOhneTrennzeichen := ZahlAlsStringKampfwerte (ZahlExtern => KampfwerteStadtErmitteln.AktuellerAngriffStadt (StadtRasseNummerExtern => StadtRasseNummerExtern));
      
      Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.StadtInformationenAccess (9),
                                         str  => To_Wide_Wide_String (Source => GlobaleTexte.Zeug (TextKonstanten.ZeugAngriff)) & " " & To_Wide_Wide_String (Source => WertOhneTrennzeichen));
      Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.StadtInformationenAccess (9),
                                    position => TextPosition);
      
      TextPosition.y := TextPosition.y + Zeilenabstand + Sf.Graphics.Text.getLocalBounds (text => TextaccessVariablen.StadtInformationenAccess (9)).height;
      
   end AktuellerAngriff;
   
   
   
   procedure Korruption
     (StadtRasseNummerExtern : in EinheitStadtRecords.RasseEinheitnummerRecord)
   is begin
      
      WertOhneTrennzeichen := ZahlAlsStringGesamtproduktionStadt (ZahlExtern => LeseStadtGebaut.Korruption (StadtRasseNummerExtern => StadtRasseNummerExtern));
      
      Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.StadtInformationenAccess (10),
                                         str  => To_Wide_Wide_String (Source => GlobaleTexte.Zeug (TextKonstanten.ZeugKorruption)) & " " & To_Wide_Wide_String (Source => WertOhneTrennzeichen));
      Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.StadtInformationenAccess (10),
                                    position => TextPosition);
      
      TextPosition.y := TextPosition.y + Zeilenabstand + Sf.Graphics.Text.getLocalBounds (text => TextaccessVariablen.StadtInformationenAccess (10)).height;
      
   end Korruption;
   
   
   
   procedure EinwohnerOhneArbeit
     (StadtRasseNummerExtern : in EinheitStadtRecords.RasseEinheitnummerRecord)
   is begin
      
      WertOhneTrennzeichen := ZahlAlsStringProduktionFeld (ZahlExtern => LeseStadtGebaut.EinwohnerArbeiter (StadtRasseNummerExtern  => StadtRasseNummerExtern,
                                                                                                            EinwohnerArbeiterExtern => True)
                                                           - LeseStadtGebaut.EinwohnerArbeiter (StadtRasseNummerExtern  => StadtRasseNummerExtern,
                                                                                                EinwohnerArbeiterExtern => False));
      
      Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.StadtInformationenAccess (11),
                                         str  => To_Wide_Wide_String (Source => GlobaleTexte.Zeug (TextKonstanten.ZeugVerfügbareArbeiter)) & " " & To_Wide_Wide_String (Source => WertOhneTrennzeichen));
      Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.StadtInformationenAccess (11),
                                    position => TextPosition);
      
      TextPosition.y := TextPosition.y + Zeilenabstand + Sf.Graphics.Text.getLocalBounds (text => TextaccessVariablen.StadtInformationenAccess (11)).height;
      
   end EinwohnerOhneArbeit;
   
   
   
   procedure AktuellesBauprojekt
     (StadtRasseNummerExtern : in EinheitStadtRecords.RasseEinheitnummerRecord)
   is begin
      
      if
        LeseStadtGebaut.Bauprojekt (StadtRasseNummerExtern => StadtRasseNummerExtern).Nummer = StadtKonstanten.LeerBauprojekt.Nummer
      then
         Text := GlobaleTexte.Zeug (28);
            
      elsif
        LeseStadtGebaut.Bauprojekt (StadtRasseNummerExtern => StadtRasseNummerExtern).GebäudeEinheit = True
      then
         Text := GlobaleTexte.Gebäude (2 * Natural (LeseStadtGebaut.Bauprojekt (StadtRasseNummerExtern => StadtRasseNummerExtern).Nummer) - 1);

      else
         Text := GlobaleTexte.Einheiten (2 * Natural (LeseStadtGebaut.Bauprojekt (StadtRasseNummerExtern => StadtRasseNummerExtern).Nummer) - 1);
      end if;
      
      Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.StadtInformationenAccess (12),
                                         str  => To_Wide_Wide_String (Source => GlobaleTexte.Zeug (TextKonstanten.ZeugBauprojekt)) & " " & To_Wide_Wide_String (Source => Text));
      Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.StadtInformationenAccess (12),
                                    position => TextPosition);
      
      TextPosition.y := TextPosition.y + Zeilenabstand + Sf.Graphics.Text.getLocalBounds (text => TextaccessVariablen.StadtInformationenAccess (12)).height;
      
      
      
      WertOhneTrennzeichen := ZahlAlsStringKostenLager (ZahlExtern => LeseStadtGebaut.Bauzeit (StadtRasseNummerExtern => StadtRasseNummerExtern));
      
      Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.StadtInformationenAccess (13),
                                         str  => To_Wide_Wide_String (Source => GlobaleTexte.Zeug (TextKonstanten.ZeugVerbleibendeBauzeit)) & " " & To_Wide_Wide_String (Source => WertOhneTrennzeichen));
      Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.StadtInformationenAccess (13),
                                    position => TextPosition);
      
      TextPosition.y := TextPosition.y + Zeilenabstand + Sf.Graphics.Text.getLocalBounds (text => TextaccessVariablen.StadtInformationenAccess (13)).height;
      
   end AktuellesBauprojekt;
   
   
   
   procedure EinzelnesFeldNahrungsgewinnung
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      WertOhneTrennzeichen := ZahlAlsStringProduktionFeld (ZahlExtern => GesamtwerteFeld.FeldNahrung (KoordinatenExtern => KoordinatenExtern,
                                                                                                      RasseExtern       => RasseExtern));
      
      Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.StadtInformationenAccess (14),
                                         str  => To_Wide_Wide_String (Source => GlobaleTexte.Zeug (TextKonstanten.ZeugNahrungsgewinnung)) & " " & To_Wide_Wide_String (Source => WertOhneTrennzeichen));
      Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.StadtInformationenAccess (14),
                                    position => TextPosition);
      
      TextPosition.y := TextPosition.y + Zeilenabstand + Sf.Graphics.Text.getLocalBounds (text => TextaccessVariablen.StadtInformationenAccess (14)).height;
      
   end EinzelnesFeldNahrungsgewinnung;
   
   
   
   procedure EinzelnesFeldRessourcengewinnung
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      WertOhneTrennzeichen := ZahlAlsStringProduktionFeld (ZahlExtern => GesamtwerteFeld.FeldProduktion (KoordinatenExtern => KoordinatenExtern,
                                                                                                         RasseExtern       => RasseExtern));
      
      Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.StadtInformationenAccess (15),
                                         str  => To_Wide_Wide_String (Source => GlobaleTexte.Zeug (TextKonstanten.ZeugRessourcengewinnung)) & " " & To_Wide_Wide_String (Source => WertOhneTrennzeichen));
      Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.StadtInformationenAccess (15),
                                    position => TextPosition);
      
      TextPosition.y := TextPosition.y + Zeilenabstand + Sf.Graphics.Text.getLocalBounds (text => TextaccessVariablen.StadtInformationenAccess (15)).height;
      
   end EinzelnesFeldRessourcengewinnung;
   
   
   
   procedure EinzelnesFeldGeldgewinnung
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      WertOhneTrennzeichen := ZahlAlsStringProduktionFeld (ZahlExtern => GesamtwerteFeld.FeldGeld (KoordinatenExtern => KoordinatenExtern,
                                                                                                   RasseExtern       => RasseExtern));
      
      Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.StadtInformationenAccess (16),
                                         str  => To_Wide_Wide_String (Source => GlobaleTexte.Zeug (TextKonstanten.ZeugGeldgewinnung)) & " " & To_Wide_Wide_String (Source => WertOhneTrennzeichen));
      Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.StadtInformationenAccess (16),
                                    position => TextPosition);
      
      TextPosition.y := TextPosition.y + Zeilenabstand + Sf.Graphics.Text.getLocalBounds (text => TextaccessVariablen.StadtInformationenAccess (16)).height;
      
   end EinzelnesFeldGeldgewinnung;
   
   
   
   procedure EinzelnesFeldWissensgewinnung
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      WertOhneTrennzeichen := ZahlAlsStringProduktionFeld (ZahlExtern => GesamtwerteFeld.FeldWissen (KoordinatenExtern => KoordinatenExtern,
                                                                                                     RasseExtern       => RasseExtern));
      
      Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.StadtInformationenAccess (17),
                                         str  => To_Wide_Wide_String (Source => GlobaleTexte.Zeug (TextKonstanten.ZeugWissensgewinnung)) & " " & To_Wide_Wide_String (Source => WertOhneTrennzeichen));
      Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.StadtInformationenAccess (17),
                                    position => TextPosition);
      
      TextPosition.y := TextPosition.y + Zeilenabstand + Sf.Graphics.Text.getLocalBounds (text => TextaccessVariablen.StadtInformationenAccess (17)).height;
      
   end EinzelnesFeldWissensgewinnung;
   
end StadtInformationenSFML;