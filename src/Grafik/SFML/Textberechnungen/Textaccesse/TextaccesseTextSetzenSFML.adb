pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

with Sf.Graphics.Text;

with TextaccessVariablen;
with GlobaleTexte;
with TextnummernKonstanten;
with ForschungenDatentypen;
with SonstigesKonstanten;

package body TextaccesseTextSetzenSFML is

   procedure TextSetzen
   is begin
      
      Allgemeines;
      MenüsEinfach;
      ZusatztextRassenmenü;
      ZusatztextKartengröße;
      Baumenü;
      Forschungsmenü;
      Sprachauswahl;
      Kartenformauswahl;
      StadtInformationen;
      EinheitenInformationen;
      KarteWichtiges;
      KarteAllgemeines;
      Karte;
      Zahleneingabe;
      EinheitStadtAuswahl;
      AnzeigeEingabe;
      Ladezeiten;
      
   end TextSetzen;
   
   
   
   procedure Allgemeines
   is begin
      
      Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.VersionsnummerAccess,
                                         str  => "Version: " & SonstigesKonstanten.Versionsnummer);
      
   end Allgemeines;
   
   
   
   procedure MenüsEinfach
   is begin
      
      null;
      
   end MenüsEinfach;
      
      
   
   procedure ZusatztextRassenmenü
   is begin
      
      null;
      
   end ZusatztextRassenmenü;
      
      
   
   procedure ZusatztextKartengröße
   is begin
      
      null;
      
   end ZusatztextKartengröße;
      
      
   
   procedure Baumenü
   is begin
      
      GebäudetextSchleife:
      for GebäudetextSchleifenwert in TextaccessVariablen.GebäudetextAccessArray'Range loop
         
         case
           GebäudetextSchleifenwert
         is
            when TextaccessVariablen.GebäudetextAccessArray'First =>
               Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.GebäudetextAccess (GebäudetextSchleifenwert),
                                                  str  => To_Wide_Wide_String (Source => GlobaleTexte.Frage (TextnummernKonstanten.FrageBauprojekt)));
               
            when others =>
               Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.GebäudetextAccess (GebäudetextSchleifenwert),
                                                  str  => To_Wide_Wide_String (Source => GlobaleTexte.Gebäude (2 * Positive (GebäudetextSchleifenwert) - 1)));
         
               Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.GebäudezusatztextAccess (GebäudetextSchleifenwert),
                                                  str  => To_Wide_Wide_String (Source => GlobaleTexte.Gebäude (2 * Positive (GebäudetextSchleifenwert))));
         end case;
            
      end loop GebäudetextSchleife;
      
      
      
      EinheitentextSchleife:
      for EinheitentextSchleifenwert in TextaccessVariablen.EinheitentextAccessArray'Range loop
         
         case
           EinheitentextSchleifenwert
         is
            when TextaccessVariablen.EinheitentextAccessArray'First =>
               Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.EinheitentextAccess (EinheitentextSchleifenwert),
                                                  str  => To_Wide_Wide_String (Source => GlobaleTexte.Zeug (TextnummernKonstanten.ZeugEinheiten)));
               
            when others =>
               Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.EinheitentextAccess (EinheitentextSchleifenwert),
                                                  str  => To_Wide_Wide_String (Source => GlobaleTexte.Einheiten (2 * Positive (EinheitentextSchleifenwert) - 1)));
         
               Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.EinheitenzusatztextAccess (EinheitentextSchleifenwert),
                                                  str  => To_Wide_Wide_String (Source => GlobaleTexte.Einheiten (2 * Positive (EinheitentextSchleifenwert))));
         end case;
         
      end loop EinheitentextSchleife;
      
   end Baumenü;
      
      
   
   procedure Forschungsmenü
   is begin
            
      ForschungenSchleife:
      for ForschungSchleifenwert in ForschungenDatentypen.ForschungID'Range loop
         
         Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.ForschungsmenüAccess (ForschungSchleifenwert),
                                            str  => To_Wide_Wide_String (Source => GlobaleTexte.Forschungen (2 * Positive (ForschungSchleifenwert) - 1)));
         
         Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.ForschungsmenüZusatztextAccess (ForschungSchleifenwert),
                                            str  => To_Wide_Wide_String (Source => GlobaleTexte.Forschungen (2 * Positive (ForschungSchleifenwert))));
         
      end loop ForschungenSchleife;
      
   end Forschungsmenü;
      
      
   
   procedure Sprachauswahl
   is begin
      
      null;
      
   end Sprachauswahl;
   
   
   
   procedure Kartenformauswahl
   is begin
      
      null;
      
   end Kartenformauswahl;
   
   
   
   procedure StadtInformationen
   is begin
      
      null;
      
   end StadtInformationen;
   
   
   
   procedure EinheitenInformationen
   is begin
      
      null;
      
   end EinheitenInformationen;
   
   
   
   procedure KarteWichtiges
   is begin
      
      null;
      
   end KarteWichtiges;
   
   
   
   procedure KarteAllgemeines
   is begin
      
      null;
      
   end KarteAllgemeines;
   
   
   
   
   procedure Karte
   is begin
      
      null;
      
   end Karte;
   
   
   
   procedure Zahleneingabe
   is begin
      
      null;
      
   end Zahleneingabe;
   
   
   
   procedure EinheitStadtAuswahl
   is begin
      
      null;
      
   end EinheitStadtAuswahl;
   
   
   procedure AnzeigeEingabe
   is begin
      
      AnzeigeEingabeSchleife:
      for AnzeigeEingabeSchleifenwert in TextaccessVariablen.JaNeinAccessArray'First + 1 .. TextaccessVariablen.JaNeinAccessArray'Last loop
         
         Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.JaNeinAccess (AnzeigeEingabeSchleifenwert),
                                            str  => To_Wide_Wide_String (Source => GlobaleTexte.JaNein (AnzeigeEingabeSchleifenwert - 1)));
         
      end loop AnzeigeEingabeSchleife;
         
   end AnzeigeEingabe;
   
   
   
   procedure Ladezeiten
   is begin
      
      Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.LadezeitenAccess (TextaccessVariablen.LadezeitenAccess'First),
                                         str  => To_Wide_Wide_String (Source => GlobaleTexte.Ladezeit (TextaccessVariablen.LadezeitenAccess'First)));
      
      
            
      Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.KIZeitenAccess (TextaccessVariablen.KIZeitenAccessArray'First),
                                         str  => To_Wide_Wide_String (Source => GlobaleTexte.Ladezeit (TextaccessVariablen.KIZeitenAccessArray'First)));
      
      
      
      Sf.Graphics.Text.setUnicodeString (text  => TextaccessVariablen.RundenendeAccess (TextaccessVariablen.RundenendeAccessArray'First),
                                         str  => To_Wide_Wide_String (Source => GlobaleTexte.Ladezeit (16)));
      
      
      
      Sf.Graphics.Text.setUnicodeString (text  => TextaccessVariablen.SpeichernLadenAccess (TextaccessVariablen.SpeichernLadenAccessArray'First),
                                         str  => To_Wide_Wide_String (Source => GlobaleTexte.Ladezeit (17)));
      
   end Ladezeiten;

end TextaccesseTextSetzenSFML;
