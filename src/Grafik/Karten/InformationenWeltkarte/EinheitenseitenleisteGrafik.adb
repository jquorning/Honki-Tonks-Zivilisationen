with Sf.Graphics.RenderWindow;
with Sf.Graphics;
with Sf.Graphics.Text;

with Meldungstexte;
with StadtKonstanten;
with TextnummernKonstanten;
with Views;
with TextKonstanten;
with GrafikDatentypen;
with KampfKonstanten;

with LeseEinheitenGebaut;
with LeseEinheitenDatenbank;
with LeseStadtGebaut;

with EinheitenbeschreibungenGrafik;
with EinstellungenGrafik;
with TextberechnungenHoeheGrafik;
with ViewsEinstellenGrafik;
with HintergrundGrafik;
with TextberechnungenBreiteGrafik;
with KartenfelderwerteLogik;
with DebugobjekteLogik;

package body EinheitenseitenleisteGrafik is
   
   procedure Leer
     (AnzeigebereichExtern : in Positive)
   is begin
      
      Viewfläche := ViewsEinstellenGrafik.ViewflächeVariabelAnpassen (ViewflächeExtern => Viewfläche,
                                                                        VerhältnisExtern => (GrafikRecordKonstanten.SeitenleisteWeltkartenbereich (AnzeigebereichExtern).width,
                                                                                              GrafikRecordKonstanten.SeitenleisteWeltkartenbereich (AnzeigebereichExtern).height));
      
      ViewsEinstellenGrafik.ViewEinstellen (ViewExtern           => Views.SeitenleisteWeltkarteAccesse (AnzeigebereichExtern),
                                            GrößeExtern          => Viewfläche,
                                            AnzeigebereichExtern => GrafikRecordKonstanten.SeitenleisteWeltkartenbereich (AnzeigebereichExtern));
      
      HintergrundGrafik.Hintergrund (HintergrundExtern => GrafikDatentypen.Seitenleiste_Hintergrund_Enum,
                                     AbmessungenExtern => Viewfläche);
      
   end Leer;
   
   

   procedure Einheiten
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      StadtVorhandenExtern : in Boolean)
   is
      use type RassenDatentypen.Rassen_Enum;
   begin
      
      case
        StadtVorhandenExtern
      is
         when True =>
            Leer (AnzeigebereichExtern => 4);
            
         when False =>
            Leer (AnzeigebereichExtern => 4);
            Leer (AnzeigebereichExtern => 3);
      end case;
      
      Textposition.x := TextberechnungenBreiteGrafik.KleinerSpaltenabstandVariabel;
      Textposition.y := TextberechnungenHoeheGrafik.KleinerZeilenabstandVariabel;
      Textbreite := 0.00;
      -- Diese Zuweisung ist wichtig weil die gefundene Einheit eventuell auf einem Transporter ist.
      EinheitRasseNummer.Nummer := LeseEinheitenGebaut.WirdTransportiert (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      
      case
        EinheitRasseNummer.Nummer
      is
         when EinheitenKonstanten.LeerWirdTransportiert =>
            EinheitRasseNummer := EinheitRasseNummerExtern;
                        
         when others =>
            EinheitRasseNummer.Rasse := EinheitRasseNummerExtern.Rasse;
      end case;
      
      IDEinheit := LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => EinheitRasseNummer);
      
      case
        IDEinheit
      is
         when EinheitenKonstanten.LeerID =>
            return;
            
         when others =>
            FestzulegenderText (1) := To_Unbounded_Wide_Wide_String (Source => EinheitenbeschreibungenGrafik.Kurzbeschreibung (IDExtern    => IDEinheit,
                                                                                                                               RasseExtern => EinheitRasseNummer.Rasse));
            FestzulegenderText (2) := Meldungstexte.Zeug (TextnummernKonstanten.ZeugLebenspunkte) & " " & LeseEinheitenGebaut.Lebenspunkte (EinheitRasseNummerExtern => EinheitRasseNummer)'Wide_Wide_Image
              & TextKonstanten.Trennzeichen & ZahlAlsStringLebenspunkte (ZahlExtern => LeseEinheitenDatenbank.MaximaleLebenspunkte (RasseExtern => EinheitRasseNummer.Rasse,
                                                                                                                                    IDExtern    => IDEinheit));
      end case;
      
      if
        RasseExtern = EinheitRasseNummer.Rasse
        or
          DebugobjekteLogik.Debug.VolleInformation
      then
         FestzulegenderText (3) := Meldungstexte.Zeug (TextnummernKonstanten.ZeugBewegungspunkte) & LeseEinheitenGebaut.Bewegungspunkte (EinheitRasseNummerExtern => EinheitRasseNummer)'Wide_Wide_Image
           & TextKonstanten.Trennzeichen & ZahlAlsStringBewegungspunkte (ZahlExtern => LeseEinheitenDatenbank.MaximaleBewegungspunkte (RasseExtern => EinheitRasseNummer.Rasse,
                                                                                                                                       IDExtern    => IDEinheit));
         FestzulegenderText (4) := Meldungstexte.Zeug (TextnummernKonstanten.ZeugErfahrungspunkte) & LeseEinheitenGebaut.Erfahrungspunkte (EinheitRasseNummerExtern => EinheitRasseNummer)'Wide_Wide_Image
           & TextKonstanten.Trennzeichen & ZahlAlsStringErfahrungspunkte (ZahlExtern => LeseEinheitenDatenbank.Beförderungsgrenze (RasseExtern => EinheitRasseNummer.Rasse,
                                                                                                                                    IDExtern    => IDEinheit));
         FestzulegenderText (5) := Meldungstexte.Zeug (TextnummernKonstanten.ZeugRang) & LeseEinheitenGebaut.Rang (EinheitRasseNummerExtern => EinheitRasseNummer)'Wide_Wide_Image & TextKonstanten.Trennzeichen
           & ZahlAlsStringRang (ZahlExtern => LeseEinheitenDatenbank.MaximalerRang (RasseExtern => EinheitRasseNummer.Rasse,
                                                                                    IDExtern    => IDEinheit));
         FestzulegenderText (6) := Aufgabe (EinheitRasseNummerExtern => EinheitRasseNummer);
         FestzulegenderText (7) := Kampfwerte (IDExtern                 => IDEinheit,
                                               KoordinatenExtern        => LeseEinheitenGebaut.Koordinaten (EinheitRasseNummerExtern => EinheitRasseNummer),
                                               EinheitRasseNummerExtern => EinheitRasseNummer);
         FestzulegenderText (8) := Heimatstadt (EinheitRasseNummerExtern => EinheitRasseNummer);
         FestzulegenderText (9) := Ladung (EinheitRasseNummerExtern => EinheitRasseNummer,
                                           IDExtern                 => IDEinheit);
         
         VolleInformation := True;
         
      else
         VolleInformation := False;
      end if;
            
      TextSchleife:
      for TextSchleifenwert in TextaccessVariablen.EinheitenInformationenAccess'Range loop
                  
         if
           VolleInformation = False
           and
             TextSchleifenwert >= 3
         then
            null;
            
         else
            Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.EinheitenInformationenAccess (TextSchleifenwert),
                                               str  => To_Wide_Wide_String (Source => FestzulegenderText (TextSchleifenwert)));
            Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.EinheitenInformationenAccess (TextSchleifenwert),
                                          position => Textposition);
            
            Sf.Graphics.RenderWindow.drawText (renderWindow => EinstellungenGrafik.FensterAccess,
                                               text         => TextaccessVariablen.EinheitenInformationenAccess (TextSchleifenwert));
         end if;
         
         case
           TextSchleifenwert
         is
            when FestzulegenderTextArray'Last - 1 =>
               null;
                  
            when others =>
               Textbreite := TextberechnungenBreiteGrafik.NeueTextbreiteErmitteln (TextAccessExtern => TextaccessVariablen.EinheitenInformationenAccess (TextSchleifenwert),
                                                                                   TextbreiteExtern => Textbreite);
         end case;
         
         if
           DebugobjekteLogik.Debug.VolleInformation
           and
             TextSchleifenwert = TextaccessVariablen.EinheitenInformationenAccess'Last
         then
            null;
            
         else
            null;
         end if;
         
         Textposition.y := TextberechnungenHoeheGrafik.NeueTextposition (PositionExtern   => Textposition.y,
                                                                         TextAccessExtern => TextaccessVariablen.EinheitenInformationenAccess (TextSchleifenwert),
                                                                         ZusatzwertExtern => TextberechnungenHoeheGrafik.KleinerZeilenabstandVariabel);
         
      end loop TextSchleife;
      
      case
        DebugobjekteLogik.Debug.VolleInformation
      is
         when True =>
            Viewfläche := PlanZielKoordinaten (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                TextwerteExtern          => (Textbreite, Textposition.y));
            
         when False =>
            Viewfläche := (Textbreite, Textposition.y + TextberechnungenHoeheGrafik.KleinerZeilenabstandVariabel);
      end case;
            
   end Einheiten;
   
   
   
   function Aufgabe
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return Unbounded_Wide_Wide_String
   is begin
      
      Beschäftigung := LeseEinheitenGebaut.Beschäftigung (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      
      case
        Beschäftigung
      is
         when AufgabenDatentypen.Leer_Aufgabe_Enum =>
            return TextKonstanten.LeerUnboundedString;
            
         when others =>
            return Meldungstexte.Zeug (TextnummernKonstanten.ZeugBeschäftigung) & TextKonstanten.UmbruchAbstand & EinheitenbeschreibungenGrafik.KurzbeschreibungBeschäftigung (Beschäftigung) & " (" &
              ZahlAlsStringArbeitszeit (ZahlExtern => LeseEinheitenGebaut.Beschäftigungszeit (EinheitRasseNummerExtern => EinheitRasseNummerExtern)) & ")";
      end case;
      
   end Aufgabe;
   
   
   
   function Kampfwerte
     (IDExtern : in EinheitenDatentypen.EinheitenID;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return Unbounded_Wide_Wide_String
   is
      use type KampfDatentypen.KampfwerteGroß;
      use type AufgabenDatentypen.Einheiten_Aufgaben_Enum;
   begin
      
      Kampftext := Meldungstexte.Zeug (TextnummernKonstanten.ZeugKampfwerte) & LeseEinheitenDatenbank.Angriff (RasseExtern => EinheitRasseNummerExtern.Rasse,
                                                                                                               IDExtern    => IDExtern)'Wide_Wide_Image;
      
      Angriffsbonus := KartenfelderwerteLogik.FeldAngriff (KoordinatenExtern => KoordinatenExtern,
                                                           RasseExtern       => EinheitRasseNummerExtern.Rasse);
        
      if
        Angriffsbonus < KampfKonstanten.LeerKampfwert
      then
         Kampftext := Kampftext & " " & ZahlAlsStringKampfwerte (ZahlExtern => Angriffsbonus);
         
      elsif
        Angriffsbonus > KampfKonstanten.LeerKampfwert
      then
         Kampftext := Kampftext & " +" & ZahlAlsStringKampfwerte (ZahlExtern => Angriffsbonus);
         
      else
         null;
      end if;
      
      Kampftext := Kampftext & " " & TextKonstanten.TrennzeichenUnterschiedlich & " " & LeseEinheitenDatenbank.Verteidigung (RasseExtern => EinheitRasseNummerExtern.Rasse,
                                                                                                                             IDExtern    => IDExtern)'Wide_Wide_Image;
      
      Verteidigungsbonus := KartenfelderwerteLogik.FeldAngriff (KoordinatenExtern => KoordinatenExtern,
                                                                RasseExtern       => EinheitRasseNummerExtern.Rasse);
      
      case
        Verteidigungsbonus
      is
         when KampfKonstanten.LeerKampfwert =>
            null;
            
         when others =>
            if
              LeseEinheitenGebaut.Beschäftigung (EinheitRasseNummerExtern => EinheitRasseNummerExtern) = AufgabenDatentypen.Verschanzen_Enum
            then
               Verteidigungsbonus := KampfDatentypen.KampfwerteGroß (Float (Verteidigungsbonus) * 1.25);
               
            else
               null;
            end if;
            
            if
              Verteidigungsbonus < KampfKonstanten.LeerKampfwert
            then
               Kampftext := Kampftext & " " & ZahlAlsStringKampfwerte (ZahlExtern => Verteidigungsbonus);
               
            elsif
              Verteidigungsbonus > KampfKonstanten.LeerKampfwert
            then
               Kampftext := Kampftext & " +" & ZahlAlsStringKampfwerte (ZahlExtern => Verteidigungsbonus);
               
            else
               null;
            end if;
      end case;
      
      return Kampftext;
      
   end Kampfwerte;
   
   
   
   function Heimatstadt
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return Unbounded_Wide_Wide_String
   is begin

      Stadtnummer := LeseEinheitenGebaut.Heimatstadt (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
         
      case
        Stadtnummer
      is
         when StadtKonstanten.LeerNummer =>
            return TextKonstanten.LeerUnboundedString;
               
         when others =>
            return Meldungstexte.Zeug (TextnummernKonstanten.ZeugHeimatstadt) & " " & LeseStadtGebaut.Name (StadtRasseNummerExtern => (EinheitRasseNummerExtern.Rasse, Stadtnummer));
      end case;
      
   end Heimatstadt;
   
   
   
   function Ladung
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      IDExtern : in EinheitenDatentypen.EinheitenID)
      return Unbounded_Wide_Wide_String
   is
      use type EinheitenDatentypen.MaximaleEinheitenMitNullWert;
   begin
      
      case
        LeseEinheitenDatenbank.KannTransportieren (RasseExtern => EinheitRasseNummerExtern.Rasse,
                                                   IDExtern    => IDExtern)
      is
         when EinheitenKonstanten.LeerKannTransportieren =>
            return TextKonstanten.LeerUnboundedString;
            
         when others =>
            Beladen := False;
            Ladungstext := Meldungstexte.Zeug (TextnummernKonstanten.ZeugAktuelleLadung);
      end case;
                        
      LadungSchleife:
      for LadungSchleifenwert in EinheitenRecords.TransporterArray'First .. LeseEinheitenDatenbank.Transportkapazität (RasseExtern => EinheitRasseNummerExtern.Rasse,
                                                                                                                        IDExtern    => IDExtern) loop
         
         Ladungsnummer := LeseEinheitenGebaut.Transportiert (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                             PlatzExtern              => LadungSchleifenwert);
         
         if
           Ladungsnummer /= EinheitenKonstanten.LeerTransportiert
         then
            Beladen := True;
            Ladungstext := Ladungstext & TextKonstanten.UmbruchAbstand
              & EinheitenbeschreibungenGrafik.Kurzbeschreibung (IDExtern    => LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => (EinheitRasseNummerExtern.Rasse, Ladungsnummer)),
                                                                RasseExtern => EinheitRasseNummerExtern.Rasse);
            
         else
            null;
         end if;
            
      end loop LadungSchleife;
      
      case
        Beladen
      is
         when True =>
            return Ladungstext;
            
         when False =>
            return TextKonstanten.LeerUnboundedString;
      end case;
      
   end Ladung;
   
   
   
   function PlanZielKoordinaten
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      TextwerteExtern : in Sf.System.Vector2.sfVector2f)
      return Sf.System.Vector2.sfVector2f
   is
      use type EinheitenDatentypen.BewegungsplanVorhanden;
   begin
      
      case
        LeseRassenbelegung.Belegung (RasseExtern => EinheitRasseNummerExtern.Rasse)
      is
         when RassenDatentypen.Mensch_Spieler_Enum =>
            return TextwerteExtern;
            
         when others =>
            Textposition.x := TextberechnungenBreiteGrafik.KleinerSpaltenabstandVariabel;
            Textposition.y := TextwerteExtern.y;
            Textbreite := TextwerteExtern.x;
      
            Koordinaten := LeseEinheitenGebaut.KIZielKoordinaten (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      
            Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.TextAccess,
                                               str  => "Nr:" & EinheitRasseNummerExtern.Nummer'Wide_Wide_Image & " Z:" & Koordinaten.EAchse'Wide_Wide_Image & "," & Koordinaten.YAchse'Wide_Wide_Image & ","
                                               & Koordinaten.XAchse'Wide_Wide_Image & " Au:" & LeseEinheitenGebaut.KIBeschäftigt (EinheitRasseNummerExtern => EinheitRasseNummerExtern)'Wide_Wide_Image);
            Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.TextAccess,
                                          position => Textposition);
            
            Sf.Graphics.RenderWindow.drawText (renderWindow => EinstellungenGrafik.FensterAccess,
                                               text         => TextaccessVariablen.TextAccess);
      
            Textbreite := TextberechnungenBreiteGrafik.NeueTextbreiteErmitteln (TextAccessExtern => TextaccessVariablen.TextAccess,
                                                                                TextbreiteExtern => Textbreite);
      end case;
      
      PlanSchleife:
      for PlanSchleifenwert in EinheitenDatentypen.BewegungsplanVorhanden'Range loop
         
         case
           PlanSchleifenwert mod 2
         is
            when 0 =>
               Textposition.x := Textbreite / 2.00;
               
            when others =>
               Textposition.x := TextberechnungenBreiteGrafik.KleinerSpaltenabstandVariabel;
               Textposition.y := TextberechnungenHoeheGrafik.NeueTextposition (PositionExtern   => Textposition.y,
                                                                               TextAccessExtern => TextaccessVariablen.TextAccess,
                                                                               ZusatzwertExtern => TextberechnungenHoeheGrafik.KleinerZeilenabstandVariabel);
         end case;
         
         Koordinaten := LeseEinheitenGebaut.KIBewegungPlan (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                            PlanschrittExtern        => PlanSchleifenwert);
         
         Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.TextAccess,
                                            str  => "Schritt" & PlanSchleifenwert'Wide_Wide_Image & ":" & Koordinaten.EAchse'Wide_Wide_Image & "," & Koordinaten.YAchse'Wide_Wide_Image & ","
                                            & Koordinaten.XAchse'Wide_Wide_Image);
         Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.TextAccess,
                                       position => Textposition);
            
         Sf.Graphics.RenderWindow.drawText (renderWindow => EinstellungenGrafik.FensterAccess,
                                            text         => TextaccessVariablen.TextAccess);
      
         Textbreite := TextberechnungenBreiteGrafik.NeueTextbreiteErmitteln (TextAccessExtern => TextaccessVariablen.TextAccess,
                                                                             TextbreiteExtern => Textbreite);
         
      end loop PlanSchleife;
      
      return (Textbreite, Textposition.y + TextberechnungenHoeheGrafik.KleinerZeilenabstandVariabel);
      
   end PlanZielKoordinaten;
   
end EinheitenseitenleisteGrafik;
