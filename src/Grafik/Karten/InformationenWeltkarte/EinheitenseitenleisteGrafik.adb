with Sf.Graphics.RenderWindow;
with Sf.Graphics;
with Sf.Graphics.Text;

with Meldungstexte;
with StadtKonstanten;
with TextnummernKonstanten;
with TextKonstanten;
with KampfKonstanten;
with ViewKonstanten;

with LeseEinheitenGebaut;
with LeseEinheitenDatenbank;
with LeseStadtGebaut;

with EinheitenbeschreibungenGrafik;
with EinstellungenGrafik;
with TextberechnungenHoeheGrafik;
with TextberechnungenBreiteGrafik;
with KartenfelderwerteLogik;
with DebugobjekteLogik;
with SeitenleisteLeerenGrafik;

package body EinheitenseitenleisteGrafik is

   procedure Einheiten
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
      EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord;
      StadtVorhandenExtern : in Boolean)
   is
      use type SpeziesDatentypen.Spezies_Enum;
   begin
      
      Viewfläche := SeitenleisteLeerenGrafik.Leer (AnzeigebereichExtern => ViewKonstanten.WeltEinheit,
                                                    ViewflächeExtern     => Viewfläche);
      
      case
        StadtVorhandenExtern
      is
         when True =>
            null;
            
         when False =>
            Viewfläche := SeitenleisteLeerenGrafik.Leer (AnzeigebereichExtern => ViewKonstanten.WeltStadt,
                                                          ViewflächeExtern     => Viewfläche);
      end case;
      
      Textposition.x := TextberechnungenBreiteGrafik.KleinerSpaltenabstandVariabel;
      Textposition.y := TextberechnungenHoeheGrafik.KleinerZeilenabstandVariabel;
      Textbreite := 0.00;
      -- Diese Zuweisung ist wichtig weil die gefundene Einheit eventuell auf einem Transporter ist.
      EinheitSpeziesNummer.Nummer := LeseEinheitenGebaut.WirdTransportiert (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern);
      
      case
        EinheitSpeziesNummer.Nummer
      is
         when EinheitenKonstanten.LeerWirdTransportiert =>
            EinheitSpeziesNummer := EinheitSpeziesNummerExtern;
                        
         when others =>
            EinheitSpeziesNummer.Spezies := EinheitSpeziesNummerExtern.Spezies;
      end case;
      
      IDEinheit := LeseEinheitenGebaut.ID (EinheitSpeziesNummerExtern => EinheitSpeziesNummer);
      
      case
        IDEinheit
      is
         when EinheitenKonstanten.LeerID =>
            return;
            
         when others =>
            FestzulegenderText (1) := To_Unbounded_Wide_Wide_String (Source => EinheitenbeschreibungenGrafik.Kurzbeschreibung (IDExtern    => IDEinheit,
                                                                                                                               SpeziesExtern => EinheitSpeziesNummer.Spezies));
            FestzulegenderText (2) := Meldungstexte.Zeug (TextnummernKonstanten.ZeugLebenspunkte) & " " & LeseEinheitenGebaut.Lebenspunkte (EinheitSpeziesNummerExtern => EinheitSpeziesNummer)'Wide_Wide_Image
              & TextKonstanten.Trennzeichen & ZahlAlsStringLebenspunkte (ZahlExtern => LeseEinheitenDatenbank.MaximaleLebenspunkte (SpeziesExtern => EinheitSpeziesNummer.Spezies,
                                                                                                                                    IDExtern    => IDEinheit));
      end case;
      
      if
        SpeziesExtern = EinheitSpeziesNummer.Spezies
        or
          DebugobjekteLogik.Debug.VolleInformation
      then
         FestzulegenderText (3) := Meldungstexte.Zeug (TextnummernKonstanten.ZeugBewegungspunkte) & LeseEinheitenGebaut.Bewegungspunkte (EinheitSpeziesNummerExtern => EinheitSpeziesNummer)'Wide_Wide_Image
           & TextKonstanten.Trennzeichen & ZahlAlsStringBewegungspunkte (ZahlExtern => LeseEinheitenDatenbank.MaximaleBewegungspunkte (SpeziesExtern => EinheitSpeziesNummer.Spezies,
                                                                                                                                       IDExtern    => IDEinheit));
         FestzulegenderText (4) := Meldungstexte.Zeug (TextnummernKonstanten.ZeugErfahrungspunkte) & LeseEinheitenGebaut.Erfahrungspunkte (EinheitSpeziesNummerExtern => EinheitSpeziesNummer)'Wide_Wide_Image
           & TextKonstanten.Trennzeichen & ZahlAlsStringErfahrungspunkte (ZahlExtern => LeseEinheitenDatenbank.Beförderungsgrenze (SpeziesExtern => EinheitSpeziesNummer.Spezies,
                                                                                                                                    IDExtern    => IDEinheit));
         FestzulegenderText (5) := Meldungstexte.Zeug (TextnummernKonstanten.ZeugRang) & LeseEinheitenGebaut.Rang (EinheitSpeziesNummerExtern => EinheitSpeziesNummer)'Wide_Wide_Image & TextKonstanten.Trennzeichen
           & ZahlAlsStringRang (ZahlExtern => LeseEinheitenDatenbank.MaximalerRang (SpeziesExtern => EinheitSpeziesNummer.Spezies,
                                                                                    IDExtern    => IDEinheit));
         FestzulegenderText (6) := Aufgabe (EinheitSpeziesNummerExtern => EinheitSpeziesNummer);
         FestzulegenderText (7) := Kampfwerte (IDExtern                 => IDEinheit,
                                               KoordinatenExtern        => LeseEinheitenGebaut.Koordinaten (EinheitSpeziesNummerExtern => EinheitSpeziesNummer),
                                               EinheitSpeziesNummerExtern => EinheitSpeziesNummer);
         FestzulegenderText (8) := Heimatstadt (EinheitSpeziesNummerExtern => EinheitSpeziesNummer);
         FestzulegenderText (9) := Ladung (EinheitSpeziesNummerExtern => EinheitSpeziesNummer,
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
         
         if
           TextSchleifenwert = FestzulegenderTextArray'Last - 1
           and
             To_Wide_Wide_String (Source => FestzulegenderText (TextSchleifenwert))'Length >= 50
         then
            null;
                  
         else
            Textbreite := TextberechnungenBreiteGrafik.NeueTextbreiteErmitteln (TextAccessExtern => TextaccessVariablen.EinheitenInformationenAccess (TextSchleifenwert),
                                                                                TextbreiteExtern => Textbreite);
         end if;
         
         Textposition.y := TextberechnungenHoeheGrafik.NeueTextposition (PositionExtern   => Textposition.y,
                                                                         TextAccessExtern => TextaccessVariablen.EinheitenInformationenAccess (TextSchleifenwert),
                                                                         ZusatzwertExtern => TextberechnungenHoeheGrafik.KleinerZeilenabstandVariabel);
         
      end loop TextSchleife;
      
      case
        DebugobjekteLogik.Debug.VolleInformation
      is
         when True =>
            Viewfläche := PlanZielKoordinaten (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                                                TextwerteExtern          => (Textbreite, Textposition.y));
            
         when False =>
            Viewfläche := (Textbreite, Textposition.y + TextberechnungenHoeheGrafik.KleinerZeilenabstandVariabel);
      end case;
            
   end Einheiten;
   
   
   
   function Aufgabe
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
      return Unbounded_Wide_Wide_String
   is begin
      
      Beschäftigung := LeseEinheitenGebaut.Beschäftigung (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern);
      
      case
        Beschäftigung
      is
         when AufgabenDatentypen.Leer_Aufgabe_Enum =>
            return TextKonstanten.LeerUnboundedString;
            
         when others =>
            return Meldungstexte.Zeug (TextnummernKonstanten.ZeugBeschäftigung) & TextKonstanten.UmbruchAbstand & EinheitenbeschreibungenGrafik.KurzbeschreibungBeschäftigung (Beschäftigung) & " (" &
              ZahlAlsStringArbeitszeit (ZahlExtern => LeseEinheitenGebaut.Beschäftigungszeit (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern)) & ")";
      end case;
      
   end Aufgabe;
   
   
   
   function Kampfwerte
     (IDExtern : in EinheitenDatentypen.EinheitenID;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
      return Unbounded_Wide_Wide_String
   is
      use type KampfDatentypen.KampfwerteGroß;
      use type AufgabenDatentypen.Einheiten_Aufgaben_Enum;
   begin
      
      Kampftext := Meldungstexte.Zeug (TextnummernKonstanten.ZeugKampfwerte) & LeseEinheitenDatenbank.Angriff (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies,
                                                                                                               IDExtern    => IDExtern)'Wide_Wide_Image;
      
      Angriffsbonus := KartenfelderwerteLogik.FeldAngriff (KoordinatenExtern => KoordinatenExtern,
                                                           SpeziesExtern       => EinheitSpeziesNummerExtern.Spezies);
        
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
      
      Kampftext := Kampftext & " " & TextKonstanten.TrennzeichenUnterschiedlich & " " & LeseEinheitenDatenbank.Verteidigung (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies,
                                                                                                                             IDExtern    => IDExtern)'Wide_Wide_Image;
      
      Verteidigungsbonus := KartenfelderwerteLogik.FeldAngriff (KoordinatenExtern => KoordinatenExtern,
                                                                SpeziesExtern       => EinheitSpeziesNummerExtern.Spezies);
      
      case
        Verteidigungsbonus
      is
         when KampfKonstanten.LeerKampfwert =>
            null;
            
         when others =>
            if
              LeseEinheitenGebaut.Beschäftigung (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern) = AufgabenDatentypen.Verschanzen_Enum
              and
                Verteidigungsbonus > 0
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
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
      return Unbounded_Wide_Wide_String
   is begin

      Stadtnummer := LeseEinheitenGebaut.Heimatstadt (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern);
         
      case
        Stadtnummer
      is
         when StadtKonstanten.LeerNummer =>
            return TextKonstanten.LeerUnboundedString;
               
         when others =>
            return Meldungstexte.Zeug (TextnummernKonstanten.ZeugHeimatstadt) & " " & LeseStadtGebaut.Name (StadtSpeziesNummerExtern => (EinheitSpeziesNummerExtern.Spezies, Stadtnummer));
      end case;
      
   end Heimatstadt;
   
   
   
   function Ladung
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord;
      IDExtern : in EinheitenDatentypen.EinheitenID)
      return Unbounded_Wide_Wide_String
   is
      use type EinheitenDatentypen.MaximaleEinheitenMitNullWert;
   begin
      
      case
        LeseEinheitenDatenbank.KannTransportieren (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies,
                                                   IDExtern    => IDExtern)
      is
         when EinheitenKonstanten.LeerKannTransportieren =>
            return TextKonstanten.LeerUnboundedString;
            
         when others =>
            Beladen := False;
            Ladungstext := Meldungstexte.Zeug (TextnummernKonstanten.ZeugAktuelleLadung);
      end case;
                        
      LadungSchleife:
      for LadungSchleifenwert in EinheitenRecords.TransporterArray'First .. LeseEinheitenDatenbank.Transportkapazität (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies,
                                                                                                                        IDExtern    => IDExtern) loop
         
         Ladungsnummer := LeseEinheitenGebaut.Transportiert (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                                                             PlatzExtern              => LadungSchleifenwert);
         
         if
           Ladungsnummer /= EinheitenKonstanten.LeerTransportiert
         then
            Beladen := True;
            Ladungstext := Ladungstext & TextKonstanten.UmbruchAbstand
              & EinheitenbeschreibungenGrafik.Kurzbeschreibung (IDExtern    => LeseEinheitenGebaut.ID (EinheitSpeziesNummerExtern => (EinheitSpeziesNummerExtern.Spezies, Ladungsnummer)),
                                                                SpeziesExtern => EinheitSpeziesNummerExtern.Spezies);
            
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
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord;
      TextwerteExtern : in Sf.System.Vector2.sfVector2f)
      return Sf.System.Vector2.sfVector2f
   is
      use type EinheitenDatentypen.BewegungsplanVorhanden;
   begin
      
      case
        LeseSpeziesbelegung.Belegung (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies)
      is
         when SpeziesDatentypen.Mensch_Spieler_Enum =>
            return TextwerteExtern;
            
         when others =>
            TextpositionDebug.x := TextberechnungenBreiteGrafik.KleinerSpaltenabstandVariabel;
            TextpositionDebug.y := TextwerteExtern.y;
            TextbreiteDebug := TextwerteExtern.x;
      
            Koordinaten := LeseEinheitenGebaut.KIZielKoordinaten (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern);
      
            Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.TextAccess,
                                               str  => "Nr:" & EinheitSpeziesNummerExtern.Nummer'Wide_Wide_Image & " Z:" & Koordinaten.EAchse'Wide_Wide_Image & "," & Koordinaten.YAchse'Wide_Wide_Image & ","
                                               & Koordinaten.XAchse'Wide_Wide_Image & " Au:" & LeseEinheitenGebaut.KIBeschäftigt (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern)'Wide_Wide_Image);
            Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.TextAccess,
                                          position => TextpositionDebug);
            
            Sf.Graphics.RenderWindow.drawText (renderWindow => EinstellungenGrafik.FensterAccess,
                                               text         => TextaccessVariablen.TextAccess);
      
            TextbreiteDebug := TextberechnungenBreiteGrafik.NeueTextbreiteErmitteln (TextAccessExtern => TextaccessVariablen.TextAccess,
                                                                                     TextbreiteExtern => TextbreiteDebug);
      end case;
      
      PlanSchleife:
      for PlanSchleifenwert in EinheitenDatentypen.BewegungsplanVorhanden'First .. 10 loop
         
         case
           PlanSchleifenwert mod 2
         is
            when 0 =>
               TextpositionDebug.x := TextbreiteDebug / 2.00;
               
            when others =>
               TextpositionDebug.x := TextberechnungenBreiteGrafik.KleinerSpaltenabstandVariabel;
               TextpositionDebug.y := TextberechnungenHoeheGrafik.NeueTextposition (PositionExtern   => TextpositionDebug.y,
                                                                                    TextAccessExtern => TextaccessVariablen.TextAccess,
                                                                                    ZusatzwertExtern => TextberechnungenHoeheGrafik.KleinerZeilenabstandVariabel);
         end case;
         
         Koordinaten := LeseEinheitenGebaut.KIBewegungPlan (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                                                            PlanschrittExtern        => PlanSchleifenwert);
         
         Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.TextAccess,
                                            str  => "Schritt" & PlanSchleifenwert'Wide_Wide_Image & ":" & Koordinaten.EAchse'Wide_Wide_Image & "," & Koordinaten.YAchse'Wide_Wide_Image & ","
                                            & Koordinaten.XAchse'Wide_Wide_Image);
         Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.TextAccess,
                                       position => TextpositionDebug);
            
         Sf.Graphics.RenderWindow.drawText (renderWindow => EinstellungenGrafik.FensterAccess,
                                            text         => TextaccessVariablen.TextAccess);
      
         TextbreiteDebug := TextberechnungenBreiteGrafik.NeueTextbreiteErmitteln (TextAccessExtern => TextaccessVariablen.TextAccess,
                                                                                  TextbreiteExtern => TextbreiteDebug);
         
      end loop PlanSchleife;
      
      return (TextbreiteDebug, TextpositionDebug.y + TextberechnungenHoeheGrafik.ZeilenabstandVariabel);
      
   end PlanZielKoordinaten;
   
end EinheitenseitenleisteGrafik;
