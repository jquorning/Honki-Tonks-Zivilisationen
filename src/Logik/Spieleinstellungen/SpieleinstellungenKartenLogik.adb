pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KartenDatentypen; use KartenDatentypen;
with MenueDatentypen;
with KartenRecordKonstanten;
with TextnummernKonstanten;
with KartenKonstanten;
with KartengeneratorRecordKonstanten;

with Weltkarte;
with ZahleneingabeLogik;
with ZufallsgeneratorenSpieleinstellungen;
with AuswahlaufteilungLogik;
with Fehler;
with KartengeneratorVariablen;
with UmwandlungenVerschiedeneDatentypen;
with KartentestsLogik;

package body SpieleinstellungenKartenLogik is
   
   procedure KartenpoleWählen
   is begin
      
      KartenpoleSchleife:
      loop
         
         KartenpoleAuswahl := AuswahlaufteilungLogik.AuswahlMenüsAufteilung (WelchesMenüExtern => MenueDatentypen.Kartenpole_Menü_Enum);
         
         case
           KartenpoleAuswahl
         is
            when RueckgabeDatentypen.Auswahl_Eins_Enum =>
               KartengeneratorVariablen.Polgrößen (KartenDatentypen.Norden_Enum) := Polgrößen (YAchseXAchseExtern => True);
               KartengeneratorVariablen.Kartenparameter.Kartenpole.Nordpol := KartentestsLogik.KartenpolePrüfen (PolgrößeExtern => KartengeneratorVariablen.Polgrößen (KartenDatentypen.Norden_Enum));
               
            when RueckgabeDatentypen.Auswahl_Zwei_Enum =>
               KartengeneratorVariablen.Polgrößen (KartenDatentypen.Süden_Enum) := Polgrößen (YAchseXAchseExtern => True);
               KartengeneratorVariablen.Kartenparameter.Kartenpole.Südpol := KartentestsLogik.KartenpolePrüfen (PolgrößeExtern => KartengeneratorVariablen.Polgrößen (KartenDatentypen.Süden_Enum));
               
            when RueckgabeDatentypen.Auswahl_Drei_Enum =>
               KartengeneratorVariablen.Polgrößen (KartenDatentypen.Westen_Enum) := Polgrößen (YAchseXAchseExtern => False);
               KartengeneratorVariablen.Kartenparameter.Kartenpole.Westpol := KartentestsLogik.KartenpolePrüfen (PolgrößeExtern => KartengeneratorVariablen.Polgrößen (KartenDatentypen.Westen_Enum));
               
            when RueckgabeDatentypen.Auswahl_Vier_Enum =>
               KartengeneratorVariablen.Polgrößen (KartenDatentypen.Osten_Enum) := Polgrößen (YAchseXAchseExtern => False);
               KartengeneratorVariablen.Kartenparameter.Kartenpole.Ostpol := KartentestsLogik.KartenpolePrüfen (PolgrößeExtern => KartengeneratorVariablen.Polgrößen (KartenDatentypen.Osten_Enum));
               
            when RueckgabeDatentypen.Auswahl_Fünf_Enum =>
               ZufallsgeneratorenSpieleinstellungen.ZufälligePole;
               
            when RueckgabeDatentypen.Auswahl_Sechs_Enum =>
               KartengeneratorVariablen.Kartenparameter.Kartenpole := KartenRecordKonstanten.KartenpoleStandard;
               KartengeneratorVariablen.Polgrößen := KartengeneratorRecordKonstanten.Eisrand;
               
            when RueckgabeDatentypen.Fertig_Enum | RueckgabeDatentypen.Zurück_Enum =>
               return;
               
            when others =>
               Fehler.LogikFehler (FehlermeldungExtern => "SpielEinstellungenKarten.KartenpoleWählen: Falsche Auswahl: " & KartenpoleAuswahl'Wide_Wide_Image);
         end case;
         
      end loop KartenpoleSchleife;
      
   end KartenpoleWählen;
   
   
   
   function Polgrößen
     (YAchseXAchseExtern : in Boolean)
      return KartenDatentypen.KartenfeldNatural
   is begin
      
      case
        YAchseXAchseExtern
      is
         when True =>
            MaximaleEisdicke := KartengeneratorVariablen.Kartenparameter.Kartengröße.YAchse / 2;

         when False =>
            MaximaleEisdicke := KartengeneratorVariablen.Kartenparameter.Kartengröße.XAchse / 2;
      end case;

      BenutzerdefinierteGröße := ZahleneingabeLogik.Zahleneingabe (ZahlenMinimumExtern => 0,
                                                                     ZahlenMaximumExtern => Positive (MaximaleEisdicke),
                                                                     WelcheFrageExtern   => TextnummernKonstanten.FrageEisschicht);
      
      if
        BenutzerdefinierteGröße.ErfolgreichAbbruch = False
        or
          BenutzerdefinierteGröße.EingegebeneZahl = 0
      then
         return 0;
         
      else
         return KartenDatentypen.KartenfeldNatural (BenutzerdefinierteGröße.EingegebeneZahl);
      end if;
      
   end Polgrößen;
   
   

   procedure KartengrößeWählen
   is begin
            
      KartengrößeSchleife:
      loop
         
         KartengrößeAuswahl := AuswahlaufteilungLogik.AuswahlMenüsAufteilung (WelchesMenüExtern => MenueDatentypen.Kartengröße_Menü_Enum);
                  
         case
           KartengrößeAuswahl
         is
            when RueckgabeDatentypen.Kartengrößen_Standard_Enum'Range =>
               KartengeneratorVariablen.Kartenparameter.Kartengröße := KartenKonstanten.StandardKartengrößen (KartengrößeAuswahl);

            when RueckgabeDatentypen.Auswahl_Zehn_Enum =>
               KartengeneratorVariablen.Kartenparameter.Kartengröße := GrößeSelbstBestimmen;
               
            when RueckgabeDatentypen.Auswahl_Elf_Enum =>
               KartengeneratorVariablen.Kartenparameter.Kartengröße := KartenKonstanten.StandardKartengrößen (ZufallsgeneratorenSpieleinstellungen.ZufälligeVordefinierteKartengröße);
               
            when RueckgabeDatentypen.Auswahl_Zwölf_Enum =>
               KartengeneratorVariablen.Kartenparameter.Kartengröße := ZufallsgeneratorenSpieleinstellungen.ZufälligeKartengröße;
               
            when RueckgabeDatentypen.Fertig_Enum | RueckgabeDatentypen.Zurück_Enum =>
               return;
               
            when others =>
               Fehler.LogikFehler (FehlermeldungExtern => "SpielEinstellungenKarten.KartengrößeWählen: Falsche Auswahl: " & KartengrößeAuswahl'Wide_Wide_Image);
         end case;

         KartentestsLogik.Größenanpassung;
         
      end loop KartengrößeSchleife;
      
   end KartengrößeWählen;
   
   
   
   function GrößeSelbstBestimmen
     return KartenRecords.YXAchsenKartenfeldPositivRecord
   is begin
            
      BenutzerdefinierteGröße := ZahleneingabeLogik.Zahleneingabe (ZahlenMinimumExtern => 20,
                                                                     ZahlenMaximumExtern => Positive (KartenDatentypen.KartenfeldPositiv'Last),
                                                                     WelcheFrageExtern   => TextnummernKonstanten.FrageYAchsengrößeEingeben);
      case
        BenutzerdefinierteGröße.ErfolgreichAbbruch
      is
         when False =>
            return (Weltkarte.Karteneinstellungen.Kartengröße.YAchse, Weltkarte.Karteneinstellungen.Kartengröße.XAchse);
            
         when True =>
            null;
      end case;
      
      YAchse := KartenDatentypen.KartenfeldPositiv (BenutzerdefinierteGröße.EingegebeneZahl);
      
      BenutzerdefinierteGröße := ZahleneingabeLogik.Zahleneingabe (ZahlenMinimumExtern => 20,
                                                                     ZahlenMaximumExtern => Positive (KartenDatentypen.KartenfeldPositiv'Last),
                                                                     WelcheFrageExtern   => TextnummernKonstanten.FrageXAchsengrößeEingeben);
      
      case
        BenutzerdefinierteGröße.ErfolgreichAbbruch
      is
         when False =>
            return (Weltkarte.Karteneinstellungen.Kartengröße.YAchse, Weltkarte.Karteneinstellungen.Kartengröße.XAchse);
            
         when True =>
            XAchse := KartenDatentypen.KartenfeldPositiv (BenutzerdefinierteGröße.EingegebeneZahl);
      end case;
      
      return (YAchse, XAchse);
      
   end GrößeSelbstBestimmen;



   procedure KartenartWählen
   is begin
            
      KartenartSchleife:
      loop

         KartenartAuswahl := AuswahlaufteilungLogik.AuswahlMenüsAufteilung (WelchesMenüExtern => MenueDatentypen.Kartenart_Menü_Enum);
         
         case
           KartenartAuswahl
         is
            when RueckgabeDatentypen.Auswahl_Eins_Enum =>
               KartengeneratorVariablen.Landgrößen := KartengeneratorRecordKonstanten.Inselgröße;
               
            when RueckgabeDatentypen.Auswahl_Zwei_Enum =>
               KartengeneratorVariablen.Landgrößen := KartengeneratorRecordKonstanten.Kontinentgröße;
               
            when RueckgabeDatentypen.Auswahl_Drei_Enum =>
               KartengeneratorVariablen.Landgrößen := KartengeneratorRecordKonstanten.Pangäagröße;
               
            when RueckgabeDatentypen.Auswahl_Vier_Enum =>
               KartengeneratorVariablen.Kartenparameter.Kartenart := KartenDatentypen.Kartenart_Nutzerdefiniert_Enum;
               KartenartNutzerdefinition;
               
            when RueckgabeDatentypen.Auswahl_Fünf_Enum =>
               KartengeneratorVariablen.Kartenparameter.Kartenart := ZufallsgeneratorenSpieleinstellungen.ZufälligeVordefinierteKartenart;
               
            when RueckgabeDatentypen.Auswahl_Sechs_Enum =>
               KartengeneratorVariablen.Kartenparameter.Kartenart := KartenDatentypen.Kartenart_Nutzerdefiniert_Enum;
               ZufallsgeneratorenSpieleinstellungen.ZufälligeKartenart;
               
            when RueckgabeDatentypen.Auswahl_Sieben_Enum =>
               KartenartStandard;
               
            when RueckgabeDatentypen.Fertig_Enum | RueckgabeDatentypen.Zurück_Enum =>
               return;
               
            when others =>
               Fehler.LogikFehler (FehlermeldungExtern => "SpielEinstellungenKarten.KartenartWählen: Falsche Auswahl: " & KartenartAuswahl'Wide_Wide_Image);
         end case;
                      
      end loop KartenartSchleife;
      
   end KartenartWählen;
   
   
   
   procedure KartenartNutzerdefinition
   is begin
      
      BenutzerdefinierteKartenart := ZahleneingabeLogik.Zahleneingabe (ZahlenMinimumExtern => 1,
                                                                       ZahlenMaximumExtern => Positive (KartengeneratorVariablen.Kartenparameter.Kartengröße.YAchse / 2),
                                                                       WelcheFrageExtern   => TextnummernKonstanten.FrageMinimaleLandhöhe);
      
      case
        BenutzerdefinierteKartenart.ErfolgreichAbbruch
      is
         when False =>
            KartenartStandard;
            return;
            
         when True =>
            KartengeneratorVariablen.Landgrößen.MinimaleYAchse := KartenDatentypen.KartenfeldPositiv (BenutzerdefinierteKartenart.EingegebeneZahl);
            ZwischenwertKartenart := BenutzerdefinierteKartenart.EingegebeneZahl;
      end case;
            
      BenutzerdefinierteKartenart := ZahleneingabeLogik.Zahleneingabe (ZahlenMinimumExtern => ZwischenwertKartenart,
                                                                       ZahlenMaximumExtern => Positive (KartengeneratorVariablen.Kartenparameter.Kartengröße.YAchse / 2),
                                                                       WelcheFrageExtern   => TextnummernKonstanten.FrageMaximaleLandhöhe);
      
      case
        BenutzerdefinierteKartenart.ErfolgreichAbbruch
      is
         when False =>
            KartenartStandard;
            return;
            
         when True =>
            KartengeneratorVariablen.Landgrößen.MaximaleYAchse := KartenDatentypen.KartenfeldPositiv (BenutzerdefinierteKartenart.EingegebeneZahl);
      end case;
      
      
      
      BenutzerdefinierteKartenart := ZahleneingabeLogik.Zahleneingabe (ZahlenMinimumExtern => 1,
                                                                       ZahlenMaximumExtern => Positive (KartengeneratorVariablen.Kartenparameter.Kartengröße.XAchse / 2),
                                                                       WelcheFrageExtern   => TextnummernKonstanten.FrageMinimaleLandbreite);
      
      case
        BenutzerdefinierteKartenart.ErfolgreichAbbruch
      is
         when False =>
            KartenartStandard;
            return;
            
         when True =>
            KartengeneratorVariablen.Landgrößen.MinimaleXAchse := KartenDatentypen.KartenfeldPositiv (BenutzerdefinierteKartenart.EingegebeneZahl);
            ZwischenwertKartenart := BenutzerdefinierteKartenart.EingegebeneZahl;
      end case;
            
      BenutzerdefinierteKartenart := ZahleneingabeLogik.Zahleneingabe (ZahlenMinimumExtern => ZwischenwertKartenart,
                                                                       ZahlenMaximumExtern => Positive (KartengeneratorVariablen.Kartenparameter.Kartengröße.XAchse / 2),
                                                                       WelcheFrageExtern   => TextnummernKonstanten.FrageMaximaleLandbreite);
      
      case
        BenutzerdefinierteKartenart.ErfolgreichAbbruch
      is
         when False =>
            KartenartStandard;
            return;
            
         when True =>
            KartengeneratorVariablen.Landgrößen.MaximaleXAchse := KartenDatentypen.KartenfeldPositiv (BenutzerdefinierteKartenart.EingegebeneZahl);
      end case;
      
   end KartenartNutzerdefinition;



   procedure KartenartStandard
   is begin

      KartengeneratorVariablen.Kartenparameter.Kartenart := KartenKonstanten.StandardKartenart;
      KartengeneratorVariablen.Landgrößen := KartengeneratorRecordKonstanten.Kontinentgröße;

   end KartenartStandard;
   
   
   
   procedure KartenformWählen
   is begin
      
      KartenformSchleife:
      loop

         KartenformAuswahl := AuswahlaufteilungLogik.AuswahlMenüsAufteilung (WelchesMenüExtern => MenueDatentypen.Kartenform_Menü_Enum);
         
         case
           KartenformAuswahl
         is
            when RueckgabeDatentypen.Kartenform_Enum'Range =>
               KartenformZuweisen (WelcheAchseExtern => KartenformAuswahl);
               
            when RueckgabeDatentypen.Auswahl_Sieben_Enum =>
               ZufallsgeneratorenSpieleinstellungen.ZufälligeKartenform;
               
            when RueckgabeDatentypen.Auswahl_Acht_Enum =>
               KartengeneratorVariablen.Kartenparameter.Kartenform := KartenRecordKonstanten.KartenformStandard;
               
            when RueckgabeDatentypen.Fertig_Enum | RueckgabeDatentypen.Zurück_Enum =>
               return;
               
            when others =>
               Fehler.LogikFehler (FehlermeldungExtern => "SpielEinstellungenKarten.KartenformWählen: Falsche Auswahl: " & KartenformAuswahl'Wide_Wide_Image);
         end case;

      end loop KartenformSchleife;
      
   end KartenformWählen;
   
   
   
   procedure KartenformZuweisen
     (WelcheAchseExtern : in RueckgabeDatentypen.Kartenform_Enum)
   is begin
      
      case
        WelcheAchseExtern
      is
         when RueckgabeDatentypen.Auswahl_Eins_Enum =>
            if
              KartengeneratorVariablen.Kartenparameter.Kartenform.EAchseOben = KartenDatentypen.Kartenform_E_Einstellbar_Enum'Last
            then
               KartengeneratorVariablen.Kartenparameter.Kartenform.EAchseOben := KartenDatentypen.Kartenform_E_Einstellbar_Enum'First;
               
            else
               KartengeneratorVariablen.Kartenparameter.Kartenform.EAchseOben
                 := KartenDatentypen.Kartenform_E_Einstellbar_Enum'Val (KartenDatentypen.Kartenform_E_Einstellbar_Enum'Pos (KartengeneratorVariablen.Kartenparameter.Kartenform.EAchseOben) + 1);
            end if;
            
         when RueckgabeDatentypen.Auswahl_Zwei_Enum =>
            if
              KartengeneratorVariablen.Kartenparameter.Kartenform.EAchseUnten = KartenDatentypen.Kartenform_E_Einstellbar_Enum'Last
            then
               KartengeneratorVariablen.Kartenparameter.Kartenform.EAchseUnten := KartenDatentypen.Kartenform_E_Einstellbar_Enum'First;
               
            else
               KartengeneratorVariablen.Kartenparameter.Kartenform.EAchseUnten
                 := KartenDatentypen.Kartenform_E_Einstellbar_Enum'Val (KartenDatentypen.Kartenform_E_Einstellbar_Enum'Pos (KartengeneratorVariablen.Kartenparameter.Kartenform.EAchseUnten) + 1);
            end if;
            
         when RueckgabeDatentypen.Auswahl_Drei_Enum =>
            if
              KartengeneratorVariablen.Kartenparameter.Kartenform.YAchseNorden = KartenDatentypen.Kartenform_Y_Einstellbar_Enum'Last
            then
               KartengeneratorVariablen.Kartenparameter.Kartenform.YAchseNorden := KartenDatentypen.Kartenform_Y_Einstellbar_Enum'First;
               
            else
               KartengeneratorVariablen.Kartenparameter.Kartenform.YAchseNorden
                 := KartenDatentypen.Kartenform_Y_Einstellbar_Enum'Val (KartenDatentypen.Kartenform_Y_Einstellbar_Enum'Pos (KartengeneratorVariablen.Kartenparameter.Kartenform.YAchseNorden) + 1);
            end if;
            
         when RueckgabeDatentypen.Auswahl_Vier_Enum =>
            if
              KartengeneratorVariablen.Kartenparameter.Kartenform.YAchseSüden = KartenDatentypen.Kartenform_Y_Einstellbar_Enum'Last
            then
               KartengeneratorVariablen.Kartenparameter.Kartenform.YAchseSüden := KartenDatentypen.Kartenform_Y_Einstellbar_Enum'First;
               
            else
               KartengeneratorVariablen.Kartenparameter.Kartenform.YAchseSüden
                 := KartenDatentypen.Kartenform_Y_Einstellbar_Enum'Val (KartenDatentypen.Kartenform_Y_Einstellbar_Enum'Pos (KartengeneratorVariablen.Kartenparameter.Kartenform.YAchseSüden) + 1);
            end if;
            
         when RueckgabeDatentypen.Auswahl_Fünf_Enum =>
            if
              KartengeneratorVariablen.Kartenparameter.Kartenform.XAchseWesten = KartenDatentypen.Kartenform_X_Einstellbar_Enum'Last
            then
               KartengeneratorVariablen.Kartenparameter.Kartenform.XAchseWesten := KartenDatentypen.Kartenform_X_Einstellbar_Enum'First;
               
            else
               KartengeneratorVariablen.Kartenparameter.Kartenform.XAchseWesten
                 := KartenDatentypen.Kartenform_X_Einstellbar_Enum'Val (KartenDatentypen.Kartenform_X_Einstellbar_Enum'Pos (KartengeneratorVariablen.Kartenparameter.Kartenform.XAchseWesten) + 1);
            end if;
            
         when RueckgabeDatentypen.Auswahl_Sechs_Enum =>
            if
              KartengeneratorVariablen.Kartenparameter.Kartenform.XAchseOsten = KartenDatentypen.Kartenform_X_Einstellbar_Enum'Last
            then
               KartengeneratorVariablen.Kartenparameter.Kartenform.XAchseOsten := KartenDatentypen.Kartenform_X_Einstellbar_Enum'First;
               
            else
               KartengeneratorVariablen.Kartenparameter.Kartenform.XAchseOsten
                 := KartenDatentypen.Kartenform_X_Einstellbar_Enum'Val (KartenDatentypen.Kartenform_X_Einstellbar_Enum'Pos (KartengeneratorVariablen.Kartenparameter.Kartenform.XAchseOsten) + 1);
            end if;
      end case;
      
   end KartenformZuweisen;



   procedure KartentemperaturWählen
   is begin
            
      KartentemperaturSchleife:
      loop

         KartentemperaturAuswahl := AuswahlaufteilungLogik.AuswahlMenüsAufteilung (WelchesMenüExtern => MenueDatentypen.Kartentemperatur_Menü_Enum);
                  
         case
           KartentemperaturAuswahl
         is
            when RueckgabeDatentypen.Kartentemperatur_Enum'Range =>
               KartengeneratorVariablen.Kartenparameter.Kartentemperatur := UmwandlungenVerschiedeneDatentypen.KartentemperaturrückgabeNachKartentemperatur (RückgabeExtern => KartentemperaturAuswahl);
               
            when RueckgabeDatentypen.Auswahl_Sechs_Enum =>
               KartengeneratorVariablen.Kartenparameter.Kartentemperatur := ZufallsgeneratorenSpieleinstellungen.ZufälligeKartentemperatur;
               
            when RueckgabeDatentypen.Fertig_Enum | RueckgabeDatentypen.Zurück_Enum =>
               return;
               
            when others =>
               Fehler.LogikFehler (FehlermeldungExtern => "SpielEinstellungenKarten.KartentemperaturWählen: Falsche Auswahl: " & KartentemperaturAuswahl'Wide_Wide_Image);
         end case;
         
      end loop KartentemperaturSchleife;
      
   end KartentemperaturWählen;
   
   
   
   procedure KartenressourcenWählen
   is begin
      
      KartenressourcenSchleife:
      loop

         KartenressourcenAuswahl := AuswahlaufteilungLogik.AuswahlMenüsAufteilung (WelchesMenüExtern => MenueDatentypen.Kartenressourcen_Menü_Enum);
         
         case
           KartenressourcenAuswahl
         is
            when RueckgabeDatentypen.Kartenressourcen_Enum'Range =>
               KartengeneratorVariablen.Kartenparameter.Kartenressourcen := UmwandlungenVerschiedeneDatentypen.KartenressourcenrückgabeNachKartenressource (RückgabeExtern => KartenressourcenAuswahl);
               
            when RueckgabeDatentypen.Auswahl_Sechs_Enum =>
               KartengeneratorVariablen.Kartenparameter.Kartenressourcen := ZufallsgeneratorenSpieleinstellungen.ZufälligeKartenressourcen;
               
            when RueckgabeDatentypen.Fertig_Enum | RueckgabeDatentypen.Zurück_Enum =>
               return;
               
            when others =>
               Fehler.LogikFehler (FehlermeldungExtern => "SpielEinstellungenKarten.KartenressourcenWählen: Falsche Auswahl: " & KartenressourcenAuswahl'Wide_Wide_Image);
         end case;
                  
      end loop KartenressourcenSchleife;
      
   end KartenressourcenWählen;

end SpieleinstellungenKartenLogik;
