with Sf.Graphics.RenderWindow;
with Sf.Graphics;
with Sf.Graphics.Text;

with Meldungstexte;
with TextnummernKonstanten;
with Views;
with GrafikDatentypen;
with TextKonstanten;
with ForschungKonstanten;
with ViewKonstanten;

with LeseWichtiges;
with LeseGrenzen;
with LeseAllgemeines;

with ForschungsbeschreibungenGrafik;
with EinstellungenGrafik;
with TextberechnungenHoeheGrafik;
with TextberechnungenBreiteGrafik;
with HintergrundGrafik;
with ViewsEinstellenGrafik;

package body WichtigesSeitenleisteGrafik is

   procedure WichtigesInformationen
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
   is begin
      
      Viewfläche := ViewsEinstellenGrafik.ViewflächeVariabelAnpassen (ViewflächeExtern => Viewfläche,
                                                                        VerhältnisExtern => (GrafikRecordKonstanten.Weltkartenbereich (ViewKonstanten.WeltWichtiges).width,
                                                                                              GrafikRecordKonstanten.Weltkartenbereich (ViewKonstanten.WeltWichtiges).height));
      
      ViewsEinstellenGrafik.ViewEinstellen (ViewExtern           => Views.WeltkarteAccess (ViewKonstanten.WeltWichtiges),
                                            GrößeExtern          => Viewfläche,
                                            AnzeigebereichExtern => GrafikRecordKonstanten.Weltkartenbereich (ViewKonstanten.WeltWichtiges));
      
      HintergrundGrafik.Hintergrund (HintergrundExtern => GrafikDatentypen.Seitenleiste_Hintergrund_Enum,
                                     AbmessungenExtern => Viewfläche);
      
      Textbreite := 0.00;
      Textposition.x := TextberechnungenBreiteGrafik.KleinerSpaltenabstandVariabel;
      Textposition.y := TextberechnungenHoeheGrafik.KleinerZeilenabstandVariabel;
      
      FestzulegenderText (1) := Meldungstexte.Zeug (TextnummernKonstanten.ZeugAktuellePosition) & " " & ZahlAlsStringEbeneVorhanden (ZahlExtern => KoordinatenExtern.EAchse) & "," & KoordinatenExtern.YAchse'Wide_Wide_Image
        & "," & KoordinatenExtern.XAchse'Wide_Wide_Image;
      
      FestzulegenderText (2) := Rundenanzahl (RasseExtern => RasseExtern);
      
      FestzulegenderText (3) := Geld (RasseExtern => RasseExtern); 
      FestzulegenderText (4) := Forschung (RasseExtern => RasseExtern);
            
      TextSchleife:
      for TextSchleifenwert in TextaccessVariablen.KarteWichtigesAccess'Range loop
         
         Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.KarteWichtigesAccess (TextSchleifenwert),
                                            str  => To_Wide_Wide_String (Source => FestzulegenderText (TextSchleifenwert)));
         
         Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.KarteWichtigesAccess (TextSchleifenwert),
                                       position => Textposition);
         
         Sf.Graphics.RenderWindow.drawText (renderWindow => EinstellungenGrafik.FensterAccess,
                                            text         => TextaccessVariablen.KarteWichtigesAccess (TextSchleifenwert));
                  
         Textbreite := TextberechnungenBreiteGrafik.NeueTextbreiteErmitteln (TextAccessExtern => TextaccessVariablen.KarteWichtigesAccess (TextSchleifenwert),
                                                                             TextbreiteExtern => Textbreite);
         Textposition.y := TextberechnungenHoeheGrafik.NeueTextposition (PositionExtern   => Textposition.y,
                                                                         TextAccessExtern => TextaccessVariablen.KarteWichtigesAccess (TextSchleifenwert),
                                                                         ZusatzwertExtern => TextberechnungenHoeheGrafik.KleinerZeilenabstandVariabel);
         
      end loop TextSchleife;
      
      Viewfläche := (Textbreite, Textposition.y + TextberechnungenHoeheGrafik.ZeilenabstandVariabel);
            
   end WichtigesInformationen;
   
   
   
   -- Wieso gibt es keine Lese/Schreibefunktion für die Rundenanzahl? äöü
   -- Vermutlich weil sie meistens nur gelesen und nur am Rundenende oder beim Standard setzen aufgerufen wird? äöü
   function Rundenanzahl
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return Unbounded_Wide_Wide_String
   is begin
      
      AktuelleRundenanzahl := LeseAllgemeines.Rundenanzahl;
                  
      case
        LeseGrenzen.Rassenrundengrenze (RasseExtern => RasseExtern)
      is
         when ZahlenDatentypen.EigenesNatural'First =>
            Rundengrenze := LeseAllgemeines.Rundengrenze;
            
         when others =>
            return Meldungstexte.Zeug (TextnummernKonstanten.ZeugAktuelleRunde) & AktuelleRundenanzahl'Wide_Wide_Image & TextKonstanten.Trennzeichen
              & ZahlAlsStringPositive (ZahlExtern => LeseGrenzen.Rassenrundengrenze (RasseExtern => RasseExtern));
      end case;
      
      case
        Rundengrenze
      is
         when ZahlenDatentypen.EigenesNatural'First =>
            return Meldungstexte.Zeug (TextnummernKonstanten.ZeugAktuelleRunde) & AktuelleRundenanzahl'Wide_Wide_Image;
            
         when others =>
            return Meldungstexte.Zeug (TextnummernKonstanten.ZeugAktuelleRunde) & AktuelleRundenanzahl'Wide_Wide_Image & TextKonstanten.Trennzeichen
              & ZahlAlsStringPositive (ZahlExtern => Rundengrenze);
      end case;
      
   end Rundenanzahl;
   
   
   
   function Geld
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return Unbounded_Wide_Wide_String
   is
      use type ProduktionDatentypen.Produktion;
   begin
      
      case
        RasseExtern
      is
         when RassenDatentypen.Ekropa_Enum =>
            return TextKonstanten.LeerUnboundedString;
            
         when others =>
            Geldzuwachs := LeseWichtiges.GeldZugewinnProRunde (RasseExtern => RasseExtern);
      end case;
      
      if
        Geldzuwachs = 0
      then
         return Meldungstexte.Zeug (TextnummernKonstanten.ZeugAktuelleGeldmenge) & LeseWichtiges.Geldmenge (RasseExtern => RasseExtern)'Wide_Wide_Image;
           
      elsif
        Geldzuwachs > 0
      then
         return Meldungstexte.Zeug (TextnummernKonstanten.ZeugAktuelleGeldmenge) & LeseWichtiges.Geldmenge (RasseExtern => RasseExtern)'Wide_Wide_Image & TextKonstanten.StandardAbstand & "+"
           & ZahlAlsStringKostenLager (ZahlExtern => LeseWichtiges.GeldZugewinnProRunde (RasseExtern => RasseExtern));
         
      else
         return Meldungstexte.Zeug (TextnummernKonstanten.ZeugAktuelleGeldmenge) & LeseWichtiges.Geldmenge (RasseExtern => RasseExtern)'Wide_Wide_Image & TextKonstanten.StandardAbstand
           & ZahlAlsStringKostenLager (ZahlExtern => LeseWichtiges.GeldZugewinnProRunde (RasseExtern => RasseExtern));
      end if;
      
   end Geld;
   
   
   
   function Forschung
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return Unbounded_Wide_Wide_String
   is begin
      
      Forschungsprojekt := LeseWichtiges.Forschungsprojekt (RasseExtern => RasseExtern);
      
      case
        Forschungsprojekt
      is
         when ForschungKonstanten.LeerForschung =>
            return TextKonstanten.LeerUnboundedString;
            
         when others =>
            Forschungszeit := LeseWichtiges.VerbleibendeForschungszeit (RasseExtern => RasseExtern);
      end case;
      
      case
        Forschungszeit
      is
         when ProduktionDatentypen.Lagermenge'Last =>
            return Meldungstexte.Zeug (TextnummernKonstanten.ZeugAktuellesForschungsprojekt) & TextKonstanten.UmbruchAbstand & ForschungsbeschreibungenGrafik.Kurzbeschreibung (IDExtern    => Forschungsprojekt,
                                                                                                                                                                                RasseExtern => RasseExtern)
              & " (∞)";
            
         when others =>
            return Meldungstexte.Zeug (TextnummernKonstanten.ZeugAktuellesForschungsprojekt) & TextKonstanten.UmbruchAbstand & ForschungsbeschreibungenGrafik.Kurzbeschreibung (IDExtern    => Forschungsprojekt,
                                                                                                                                                                                RasseExtern => RasseExtern)
              & " (" & ZahlAlsStringKostenLager (ZahlExtern => Forschungszeit) & ")";
      end case;
            
   end Forschung;

end WichtigesSeitenleisteGrafik;
