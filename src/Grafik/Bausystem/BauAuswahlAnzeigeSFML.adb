pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Sf.Graphics.RenderWindow;
with Sf.Graphics.Text;

with TextKonstanten;
with GrafikDatentypen;
with GlobaleTexte;
with TextnummernKonstanten;
with TextaccessVariablen;
with Views;

with LeseStadtGebaut;

with GrafikEinstellungenSFML;
with TextberechnungenBreiteSFML;
with InteraktionAuswahl;
with TextberechnungenHoeheSFML;
with GebaeudebeschreibungenSFML;
with EinheitenbeschreibungenSFML;
with HintergrundSFML;
with TexteinstellungenSFML;
with ViewsEinstellenSFML;
with AllgemeineViewsSFML;
with BeschreibungenZeilenumbruchSFML;

package body BauAuswahlAnzeigeSFML is

   procedure BauAuswahlAnzeige
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord;
      AktuelleAuswahlExtern : in StadtRecords.BauprojektRecord)
   is begin
      
      AllgemeineViewsSFML.Überschrift (ÜberschriftExtern => To_Wide_Wide_String (Source => GlobaleTexte.Frage (TextnummernKonstanten.FrageBauprojekt)),
                                        HintergrundExtern => GrafikDatentypen.Bauen_Hintergrund_Enum);
      
      Gebäude (AuswahlExtern    => AktuelleAuswahlExtern.Gebäude,
                ViewnummerExtern => 1,
                RasseExtern      => StadtRasseNummerExtern.Rasse);
      Einheiten (AuswahlExtern    => AktuelleAuswahlExtern.Einheit,
                 ViewnummerExtern => 2,
                 RasseExtern      => StadtRasseNummerExtern.Rasse);
      InformationenGebäude (AuswahlExtern    => AktuelleAuswahlExtern.Gebäude,
                             ViewnummerExtern => 3,
                             RasseExtern      => StadtRasseNummerExtern.Rasse);
      InformationenEinheiten (AuswahlExtern    => AktuelleAuswahlExtern.Einheit,
                              ViewnummerExtern => 4,
                              RasseExtern      => StadtRasseNummerExtern.Rasse);
      Aktuell (StadtRasseNummerExtern => StadtRasseNummerExtern,
               ViewnummerExtern       => 5);
      
   end BauAuswahlAnzeige;
   
   
   
   procedure Gebäude
     (AuswahlExtern : in StadtDatentypen.GebäudeIDMitNullwert;
      ViewnummerExtern : in Positive;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      Viewfläche (ViewnummerExtern) := ViewsEinstellenSFML.ViewflächeVariabelAnpassen (ViewflächeExtern => Viewfläche (ViewnummerExtern),
                                                                                         VerhältnisExtern => (0.50, 1.00));
      
      ViewsEinstellenSFML.ViewEinstellen (ViewExtern           => Views.BauviewAccesse (ViewnummerExtern),
                                          GrößeExtern          => Viewfläche (ViewnummerExtern),
                                          AnzeigebereichExtern => GrafikRecordKonstanten.Baumenübereich (ViewnummerExtern));
      
      HintergrundSFML.MenüHintergrund (HintergrundExtern => GrafikDatentypen.Bauen_Hintergrund_Enum,
                                        AbmessungenExtern => Viewfläche (ViewnummerExtern));
      
      Textposition := TextKonstanten.StartpositionText;
      Textposition.y := Textposition.y + TextberechnungenHoeheSFML.KleinerZeilenabstand;
      
      Textposition.x := TextberechnungenBreiteSFML.MittelpositionBerechnen (TextAccessExtern => TextaccessVariablen.GebäudetextAccess (RasseExtern, TextaccessVariablen.GebäudetextAccess'First (2)),
                                                                            ViewbreiteExtern => Viewfläche (ViewnummerExtern).x);

      Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.GebäudetextAccess (RasseExtern, TextaccessVariablen.GebäudetextAccess'First (2)),
                                    position => Textposition);
      Sf.Graphics.Text.setColor (text  => TextaccessVariablen.GebäudetextAccess (RasseExtern, TextaccessVariablen.GebäudetextAccess'First (2)),
                                 color => Farbe);
         
      Textposition.y := Textposition.y + TextberechnungenHoeheSFML.Zeilenabstand;
               
      Sf.Graphics.RenderWindow.drawText (renderWindow => GrafikEinstellungenSFML.FensterAccess,
                                         text         => TextaccessVariablen.GebäudetextAccess (RasseExtern, TextaccessVariablen.GebäudetextAccess'First (2)));
      
      AktuelleTextbreite := TextKonstanten.LeerTextbreite;
      AktuelleTextbreite := TextberechnungenBreiteSFML.NeueTextbreiteErmitteln (TextAccessExtern => TextaccessVariablen.GebäudetextAccess (RasseExtern, TextaccessVariablen.GebäudetextAccess'First (2)),
                                                                                TextbreiteExtern => AktuelleTextbreite);
      Textposition.y := Textposition.y + TextberechnungenHoeheSFML.KleinerZeilenabstand;
            
      GebäudeSchleife:
      for GebäudeSchleifenwert in StadtDatentypen.GebäudeID'Range loop
         
         case
           InteraktionAuswahl.MöglicheGebäude (GebäudeSchleifenwert)
         is
            when True =>
               if
                 AuswahlExtern = GebäudeSchleifenwert
               then
                  Farbe := TexteinstellungenSFML.Schriftfarben.FarbeAusgewähltText;
            
               else
                  Farbe := TexteinstellungenSFML.Schriftfarben.FarbeStandardText;
               end if;
               
               Textposition.x := TextberechnungenBreiteSFML.MittelpositionBerechnen (TextAccessExtern => TextaccessVariablen.GebäudetextAccess (RasseExtern, GebäudeSchleifenwert),
                                                                                     ViewbreiteExtern => Viewfläche (ViewnummerExtern).x);

               Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.GebäudetextAccess (RasseExtern, GebäudeSchleifenwert),
                                             position => Textposition);
               Sf.Graphics.Text.setColor (text  => TextaccessVariablen.GebäudetextAccess (RasseExtern, GebäudeSchleifenwert),
                                          color => Farbe);
         
               Textposition.y := Textposition.y + TextberechnungenHoeheSFML.Zeilenabstand;
               
               AktuelleTextbreite := TextberechnungenBreiteSFML.NeueTextbreiteErmitteln (TextAccessExtern => TextaccessVariablen.GebäudetextAccess (RasseExtern, GebäudeSchleifenwert),
                                                                                         TextbreiteExtern => AktuelleTextbreite);
               
               InteraktionAuswahl.PositionenGebäudeBauen (GebäudeSchleifenwert) := Sf.Graphics.Text.getGlobalBounds (text => TextaccessVariablen.GebäudetextAccess (RasseExtern, GebäudeSchleifenwert));
               
               Sf.Graphics.RenderWindow.drawText (renderWindow => GrafikEinstellungenSFML.FensterAccess,
                                                  text         => TextaccessVariablen.GebäudetextAccess (RasseExtern, GebäudeSchleifenwert));

            when False =>
               null;
         end case;
               
      end loop GebäudeSchleife;
      
      Viewfläche (ViewnummerExtern) := (AktuelleTextbreite, Textposition.y);
      
   end Gebäude;
   
   
   
   procedure Einheiten
     (AuswahlExtern : in EinheitenDatentypen.EinheitenIDMitNullWert;
      ViewnummerExtern : in Positive;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      Viewfläche (ViewnummerExtern) := ViewsEinstellenSFML.ViewflächeVariabelAnpassen (ViewflächeExtern => Viewfläche (ViewnummerExtern),
                                                                                         VerhältnisExtern => (0.50, 1.00));
      
      ViewsEinstellenSFML.ViewEinstellen (ViewExtern           => Views.BauviewAccesse (ViewnummerExtern),
                                          GrößeExtern          => Viewfläche (ViewnummerExtern),
                                          AnzeigebereichExtern => GrafikRecordKonstanten.Baumenübereich (ViewnummerExtern));
      
      HintergrundSFML.MenüHintergrund (HintergrundExtern => GrafikDatentypen.Bauen_Hintergrund_Enum,
                                        AbmessungenExtern => Viewfläche (ViewnummerExtern));
      
      Textposition := TextKonstanten.StartpositionText;
      Textposition.y := Textposition.y + TextberechnungenHoeheSFML.KleinerZeilenabstand;
      
      Textposition.x := TextberechnungenBreiteSFML.MittelpositionBerechnen (TextAccessExtern => TextaccessVariablen.EinheitentextAccess (RasseExtern, TextaccessVariablen.EinheitentextAccess'First (2)),
                                                                            ViewbreiteExtern => Viewfläche (ViewnummerExtern).x);

      Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.EinheitentextAccess (RasseExtern, TextaccessVariablen.EinheitentextAccess'First (2)),
                                    position => Textposition);
      Sf.Graphics.Text.setColor (text  => TextaccessVariablen.EinheitentextAccess (RasseExtern, TextaccessVariablen.EinheitentextAccess'First (2)),
                                 color => Farbe);
      
      Textposition.y := Textposition.y + TextberechnungenHoeheSFML.Zeilenabstand;
               
      Sf.Graphics.RenderWindow.drawText (renderWindow => GrafikEinstellungenSFML.FensterAccess,
                                         text         => TextaccessVariablen.EinheitentextAccess (RasseExtern, TextaccessVariablen.EinheitentextAccess'First (2)));
      
      Textposition.y := Textposition.y + TextberechnungenHoeheSFML.KleinerZeilenabstand;
      
      AktuelleTextbreite := TextKonstanten.LeerTextbreite;
      AktuelleTextbreite := TextberechnungenBreiteSFML.NeueTextbreiteErmitteln (TextAccessExtern => TextaccessVariablen.EinheitentextAccess (RasseExtern, TextaccessVariablen.EinheitentextAccess'First (2)),
                                                                                TextbreiteExtern => AktuelleTextbreite);
          
      EinheitenSchleife:
      for EinheitenSchleifenwert in EinheitenDatentypen.EinheitenID'Range loop
         
         case
           InteraktionAuswahl.MöglicheEinheiten (EinheitenSchleifenwert)
         is
            when True =>
               if
                 AuswahlExtern = EinheitenSchleifenwert
               then
                  Farbe := TexteinstellungenSFML.Schriftfarben.FarbeAusgewähltText;
            
               else
                  Farbe := TexteinstellungenSFML.Schriftfarben.FarbeStandardText;
               end if;
               
               Textposition.x := TextberechnungenBreiteSFML.MittelpositionBerechnen (TextAccessExtern => TextaccessVariablen.EinheitentextAccess (RasseExtern, EinheitenSchleifenwert),
                                                                                     ViewbreiteExtern => Viewfläche (ViewnummerExtern).x);

               Sf.Graphics.Text.setColor (text  => TextaccessVariablen.EinheitentextAccess (RasseExtern, EinheitenSchleifenwert),
                                          color => Farbe);
               Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.EinheitentextAccess (RasseExtern, EinheitenSchleifenwert),
                                             position => Textposition);
               
               Textposition.y := Textposition.y + TextberechnungenHoeheSFML.Zeilenabstand;
               
               AktuelleTextbreite := TextberechnungenBreiteSFML.NeueTextbreiteErmitteln (TextAccessExtern => TextaccessVariablen.EinheitentextAccess (RasseExtern, EinheitenSchleifenwert),
                                                                                         TextbreiteExtern => AktuelleTextbreite);
               
               InteraktionAuswahl.PositionenEinheitenBauen (EinheitenSchleifenwert) := Sf.Graphics.Text.getGlobalBounds (text => TextaccessVariablen.EinheitentextAccess (RasseExtern, EinheitenSchleifenwert));
               
               Sf.Graphics.RenderWindow.drawText (renderWindow => GrafikEinstellungenSFML.FensterAccess,
                                                  text         => TextaccessVariablen.EinheitentextAccess (RasseExtern, EinheitenSchleifenwert));

            when False =>
               null;
         end case;
         
      end loop EinheitenSchleife;
      
      Viewfläche (ViewnummerExtern) := (AktuelleTextbreite, Textposition.y);
      
   end Einheiten;



   procedure InformationenGebäude
     (AuswahlExtern : in StadtDatentypen.GebäudeIDMitNullwert;
      ViewnummerExtern : in Positive;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      case
        AuswahlExtern
      is
         when 0 =>
            ViewsEinstellenSFML.ViewEinstellen (ViewExtern           => Views.BauviewAccesse (ViewnummerExtern),
                                                GrößeExtern          => Viewfläche (ViewnummerExtern),
                                                AnzeigebereichExtern => KeineAnzeige);
            return;
            
         when others =>
            Viewfläche (ViewnummerExtern) := ViewsEinstellenSFML.ViewflächeVariabelAnpassen (ViewflächeExtern => Viewfläche (ViewnummerExtern),
                                                                                               VerhältnisExtern => (0.50, 1.00));
      
            ViewsEinstellenSFML.ViewEinstellen (ViewExtern           => Views.BauviewAccesse (ViewnummerExtern),
                                                GrößeExtern          => Viewfläche (ViewnummerExtern),
                                                AnzeigebereichExtern => GrafikRecordKonstanten.Baumenübereich (ViewnummerExtern));
      
            HintergrundSFML.MenüHintergrund (HintergrundExtern => GrafikDatentypen.Bauen_Hintergrund_Enum,
                                              AbmessungenExtern => Viewfläche (ViewnummerExtern));
      
            Textposition := TextKonstanten.StartpositionText;
            Textposition.y := Textposition.y + TextberechnungenHoeheSFML.KleinerZeilenabstand;
      
            Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.GebäudezusatztextAccess (RasseExtern, AuswahlExtern),
                                          position => Textposition);
      end case;
            
      Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.GebäudezusatztextAccess (RasseExtern, AuswahlExtern),
                                         str  => BeschreibungenZeilenumbruchSFML.ZeilenumbruchBerechnen (TextExtern   => GebaeudebeschreibungenSFML.BeschreibungLang (IDExtern    => AuswahlExtern,
                                                                                                                                                                      RasseExtern => RasseExtern),
                                                                                                         BreiteExtern => GrafikRecordKonstanten.Baumenübereich (ViewnummerExtern).width));
         
      Sf.Graphics.RenderWindow.drawText (renderWindow => GrafikEinstellungenSFML.FensterAccess,
                                         text         => TextaccessVariablen.GebäudezusatztextAccess (RasseExtern, AuswahlExtern));
      
      AktuelleTextbreite := TextKonstanten.LeerTextbreite;
      AktuelleTextbreite := TextberechnungenBreiteSFML.NeueTextbreiteErmitteln (TextAccessExtern => TextaccessVariablen.GebäudezusatztextAccess (RasseExtern, AuswahlExtern),
                                                                                TextbreiteExtern => AktuelleTextbreite);
      
      Textposition.y := Textposition.y + Sf.Graphics.Text.getGlobalBounds (text => TextaccessVariablen.GebäudezusatztextAccess (RasseExtern, AuswahlExtern)).height + TextberechnungenHoeheSFML.Zeilenabstand;
      
      Viewfläche (ViewnummerExtern) := (AktuelleTextbreite, Textposition.y);
            
   end InformationenGebäude;



   procedure InformationenEinheiten
     (AuswahlExtern : in EinheitenDatentypen.EinheitenIDMitNullWert;
      ViewnummerExtern : in Positive;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      case
        AuswahlExtern
      is
         when 0 =>
            ViewsEinstellenSFML.ViewEinstellen (ViewExtern           => Views.BauviewAccesse (ViewnummerExtern),
                                                GrößeExtern          => Viewfläche (ViewnummerExtern),
                                                AnzeigebereichExtern => KeineAnzeige);
            return;
            
         when others =>
            Viewfläche (ViewnummerExtern) := ViewsEinstellenSFML.ViewflächeVariabelAnpassen (ViewflächeExtern => Viewfläche (ViewnummerExtern),
                                                                                               VerhältnisExtern => (0.50, 1.00));
      
            ViewsEinstellenSFML.ViewEinstellen (ViewExtern           => Views.BauviewAccesse (ViewnummerExtern),
                                                GrößeExtern          => Viewfläche (ViewnummerExtern),
                                                AnzeigebereichExtern => GrafikRecordKonstanten.Baumenübereich (ViewnummerExtern));
      
            HintergrundSFML.MenüHintergrund (HintergrundExtern => GrafikDatentypen.Bauen_Hintergrund_Enum,
                                              AbmessungenExtern => Viewfläche (ViewnummerExtern));
            
            Textposition := TextKonstanten.StartpositionText;
            Textposition.y := Textposition.y + TextberechnungenHoeheSFML.KleinerZeilenabstand;
            
            Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.EinheitenzusatztextAccess (RasseExtern, AuswahlExtern),
                                          position => Textposition);
      end case;
            
      Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.EinheitenzusatztextAccess (RasseExtern, AuswahlExtern),
                                         str  => BeschreibungenZeilenumbruchSFML.ZeilenumbruchBerechnen (TextExtern   => EinheitenbeschreibungenSFML.BeschreibungLang (IDExtern    => AuswahlExtern,
                                                                                                                                                                       RasseExtern => RasseExtern),
                                                                                                         BreiteExtern => GrafikRecordKonstanten.Baumenübereich (ViewnummerExtern).width));
         
      Sf.Graphics.RenderWindow.drawText (renderWindow => GrafikEinstellungenSFML.FensterAccess,
                                         text         => TextaccessVariablen.EinheitenzusatztextAccess (RasseExtern, AuswahlExtern));
      
      AktuelleTextbreite := TextKonstanten.LeerTextbreite;
      AktuelleTextbreite := TextberechnungenBreiteSFML.NeueTextbreiteErmitteln (TextAccessExtern => TextaccessVariablen.EinheitenzusatztextAccess (RasseExtern, AuswahlExtern),
                                                                                TextbreiteExtern => AktuelleTextbreite);
      
      Textposition.y := Textposition.y + Sf.Graphics.Text.getGlobalBounds (text => TextaccessVariablen.EinheitenzusatztextAccess (RasseExtern, AuswahlExtern)).height + TextberechnungenHoeheSFML.Zeilenabstand;
      
      Viewfläche (ViewnummerExtern) := (AktuelleTextbreite, Textposition.y);
      
   end InformationenEinheiten;
   
   
   
   procedure Aktuell
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord;
      ViewnummerExtern : in Positive)
   is begin
      
      -- Sieht auch ohne Anpassung ganz gut aus.
      -- Viewfläche (ViewnummerExtern) := ViewsEinstellenSFML.ViewflächeVariabelAnpassen (ViewflächeExtern => Viewfläche (ViewnummerExtern),
      --                                                                                    VerhältnisExtern => (0.10, 0.10));
      
      ViewsEinstellenSFML.ViewEinstellen (ViewExtern           => Views.BauviewAccesse (ViewnummerExtern),
                                          GrößeExtern          => Viewfläche (ViewnummerExtern),
                                          AnzeigebereichExtern => GrafikRecordKonstanten.Baumenübereich (ViewnummerExtern));
      
      HintergrundSFML.MenüHintergrund (HintergrundExtern => GrafikDatentypen.Bauen_Hintergrund_Enum,
                                        AbmessungenExtern => Viewfläche (ViewnummerExtern));
      
      Textposition := TextKonstanten.StartpositionText;
      AktuelleTextbreite := TextKonstanten.LeerTextbreite;
      
      AktuellesBauprojekt := LeseStadtGebaut.Bauprojekt (StadtRasseNummerExtern => StadtRasseNummerExtern);
      
      if
        AktuellesBauprojekt.Gebäude /= 0
      then
         Text := GlobaleTexte.Zeug (TextnummernKonstanten.ZeugBauprojekt) & " " & GebaeudebeschreibungenSFML.BeschreibungKurz (IDExtern    => AktuellesBauprojekt.Gebäude,
                                                                                                                               RasseExtern => StadtRasseNummerExtern.Rasse);
         
      elsif
        AktuellesBauprojekt.Einheit /= 0
      then
         Text := GlobaleTexte.Zeug (TextnummernKonstanten.ZeugBauprojekt) & " " & EinheitenbeschreibungenSFML.BeschreibungKurz (IDExtern    => AktuellesBauprojekt.Einheit,
                                                                                                                                RasseExtern => StadtRasseNummerExtern.Rasse);
         
            
      else
         Text := GlobaleTexte.Zeug (TextnummernKonstanten.ZeugBauprojekt) & " " & GlobaleTexte.Zeug (TextnummernKonstanten.ZeugKeines);
      end if;
      
      Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.ForschungsmenüErmöglichtAccess,
                                         str  => To_Wide_Wide_String (Source => Text));
      
      Textposition.x := TextberechnungenBreiteSFML.MittelpositionBerechnen (TextAccessExtern => TextaccessVariablen.ForschungsmenüErmöglichtAccess,
                                                                            ViewbreiteExtern => Viewfläche (ViewnummerExtern).x);
      
      Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.ForschungsmenüErmöglichtAccess,
                                    position => Textposition);
      
      Sf.Graphics.RenderWindow.drawText (renderWindow => GrafikEinstellungenSFML.FensterAccess,
                                         text         => TextaccessVariablen.ForschungsmenüErmöglichtAccess);
      
      AktuelleTextbreite := TextberechnungenBreiteSFML.NeueTextbreiteErmitteln (TextAccessExtern => TextaccessVariablen.ForschungsmenüErmöglichtAccess,
                                                                                TextbreiteExtern => AktuelleTextbreite);
      Textposition.y := Textposition.y + TextberechnungenHoeheSFML.KleinerZeilenabstand;
      
      Text := GlobaleTexte.Zeug (TextnummernKonstanten.ZeugVerbleibendeBauzeit) & LeseStadtGebaut.Bauzeit (StadtRasseNummerExtern => StadtRasseNummerExtern)'Wide_Wide_Image;
      
      Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.ForschungsmenüErmöglichtAccess,
                                         str  => To_Wide_Wide_String (Source => Text));
      
      Textposition.x := TextberechnungenBreiteSFML.MittelpositionBerechnen (TextAccessExtern => TextaccessVariablen.ForschungsmenüErmöglichtAccess,
                                                                            ViewbreiteExtern => Viewfläche (ViewnummerExtern).x);
      
      Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.ForschungsmenüErmöglichtAccess,
                                    position => Textposition);
      
      Sf.Graphics.RenderWindow.drawText (renderWindow => GrafikEinstellungenSFML.FensterAccess,
                                         text         => TextaccessVariablen.ForschungsmenüErmöglichtAccess);
      
      AktuelleTextbreite := TextberechnungenBreiteSFML.NeueTextbreiteErmitteln (TextAccessExtern => TextaccessVariablen.ForschungsmenüErmöglichtAccess,
                                                                                TextbreiteExtern => AktuelleTextbreite);
      Textposition.y := Textposition.y + TextberechnungenHoeheSFML.KleinerZeilenabstand;
            
      Viewfläche (ViewnummerExtern) := (AktuelleTextbreite, Textposition.y);
      
   end Aktuell;

end BauAuswahlAnzeigeSFML;
