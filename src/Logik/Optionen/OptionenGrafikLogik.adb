with GrafikDatentypen;
with TextnummernKonstanten;
with MenueDatentypen;
with ZeitKonstanten;
with GrafikKonstanten;
with ZahlenDatentypen;

with SchreibeEinstellungenGrafik;
with LeseEinstellungenGrafik;

with NachGrafiktask;
with NachLogiktask;
with AuswahlaufteilungLogik;
with ZahleneingabeLogik;
with SchreibenEinstellungenLogik;
with Fehlermeldungssystem;

package body OptionenGrafikLogik is

   function OptionenGrafik
     return RueckgabeDatentypen.Rückgabe_Werte_Enum
   is begin
            
      GrafikSchleife:
      loop
         
         AuswahlWert := AuswahlaufteilungLogik.AuswahlMenüsAufteilung (WelchesMenüExtern => MenueDatentypen.Grafik_Menü_Enum);
         
         case
           AuswahlWert
         is
            when RueckgabeDatentypen.Auswahl_Eins_Enum =>
               AuflösungÄndern;
            
            when RueckgabeDatentypen.Auswahl_Zwei_Enum =>
               VollbildFenster;
               
            when RueckgabeDatentypen.Auswahl_Drei_Enum =>
               BildrateÄndern;
               
            when RueckgabeDatentypen.Auswahl_Vier_Enum =>
               SchreibeEinstellungenGrafik.EbenenUnterhalbSichtbar;
               
            when RueckgabeDatentypen.Auswahl_Fünf_Enum =>
               SchreibenEinstellungenLogik.Grafikeinstellungen;
               
            when RueckgabeDatentypen.Zurück_Beenden_Enum'Range =>
               return AuswahlWert;
               
            when others =>
               Fehlermeldungssystem.Logik (FehlermeldungExtern => "OptionenGrafikLogik.OptionenGrafik: Falsche Auswahl: " & AuswahlWert'Wide_Wide_Image);
         end case;
         
      end loop GrafikSchleife;
      
   end OptionenGrafik;
   
   
   
   procedure AuflösungÄndern
   is begin
      
      EingabeAuflösung := ZahleneingabeLogik.Zahleneingabe (ZahlenMinimumExtern => ZahlenDatentypen.EigenesPositive (GrafikKonstanten.MinimaleAuflösungsbreite),
                                                            ZahlenMaximumExtern => ZahlenDatentypen.EigenesPositive (GrafikKonstanten.MaximaleAuflösungsbreite),
                                                            WelcheFrageExtern   => TextnummernKonstanten.FrageAuflösungsbreite);
      
      if
        EingabeAuflösung.ErfolgreichAbbruch
      then
         NeueAuflösung.x := Sf.sfUint32 (EingabeAuflösung.EingegebeneZahl);
           
      else
         return;
      end if;
      
      EingabeAuflösung := ZahleneingabeLogik.Zahleneingabe (ZahlenMinimumExtern => ZahlenDatentypen.EigenesPositive (GrafikKonstanten.MinimaleAuflösunghöhe),
                                                             ZahlenMaximumExtern => ZahlenDatentypen.EigenesPositive (GrafikKonstanten.MaximaleAuflösungshöhe),
                                                             WelcheFrageExtern   => TextnummernKonstanten.FrageAuflösungshöhe);
      
      if
        EingabeAuflösung.ErfolgreichAbbruch
      then
         NeueAuflösung.y := Sf.sfUint32 (EingabeAuflösung.EingegebeneZahl);
           
      else
         NeueAuflösung.x := 0;
         return;
      end if;
      
      SchreibeEinstellungenGrafik.Auflösung (AuflösungExtern => NeueAuflösung);
      
      NachLogiktask.Warten := True;
      NachGrafiktask.FensterVerändert := GrafikDatentypen.Auflösung_Verändert_Enum;
      
      ErzeugungNeuesFensterAbwartenSchleife:
      while NachLogiktask.Warten loop
         
         delay ZeitKonstanten.WartezeitLogik;
         
      end loop ErzeugungNeuesFensterAbwartenSchleife;
            
   end AuflösungÄndern;
   
   
   
   procedure BildrateÄndern
   is
      use type GrafikDatentypen.Fenster_Ändern_Enum;
   begin
      
      EingabeBildrate := ZahleneingabeLogik.Zahleneingabe (ZahlenMinimumExtern => ZahlenDatentypen.EigenesPositive (GrafikKonstanten.MinimaleBildrate),
                                                           ZahlenMaximumExtern => ZahlenDatentypen.EigenesPositive (GrafikKonstanten.MaximaleBildrate),
                                                           WelcheFrageExtern   => TextnummernKonstanten.FrageBildrate);
      
      if
        EingabeBildrate.ErfolgreichAbbruch
      then
         return;
         
      else
         SchreibeEinstellungenGrafik.Bildrate (BildrateExtern => Sf.sfUint32 (EingabeBildrate.EingegebeneZahl));
         NachGrafiktask.FensterVerändert := GrafikDatentypen.Bildrate_Ändern_Enum;
      end if;
            
      NeueBildrateAbwartenSchleife:
      while NachGrafiktask.FensterVerändert = GrafikDatentypen.Bildrate_Ändern_Enum loop
         
         delay ZeitKonstanten.WartezeitLogik;
         
      end loop NeueBildrateAbwartenSchleife;
      
   end BildrateÄndern;
   
   
   
   procedure VollbildFenster
   is
      use type GrafikDatentypen.Fenster_Ändern_Enum;
   begin
      
      -- Wenn ich weitere Fenstermodis einbauen will muss ich das hier umbauen. äöü
      case
        LeseEinstellungenGrafik.Fenstermodus
      is
         when 7 =>
            SchreibeEinstellungenGrafik.Fenstermodus (FenstermodusExtern => 8);
            
         when 8 =>
            SchreibeEinstellungenGrafik.Fenstermodus (FenstermodusExtern => 7);
            
         when others =>
            Fehlermeldungssystem.Logik (FehlermeldungExtern => "OptionenGrafikLogik.VollbildFenster: Unbekannter Fenstermodus: " & LeseEinstellungenGrafik.Fenstermodus'Wide_Wide_Image);
      end case;
      
      NachGrafiktask.FensterVerändert := GrafikDatentypen.Modus_Verändert_Enum;
      
      ErzeugungNeuesFensterAbwartenSchleife:
      while NachGrafiktask.FensterVerändert = GrafikDatentypen.Modus_Verändert_Enum loop
         
         delay ZeitKonstanten.WartezeitLogik;
         
      end loop ErzeugungNeuesFensterAbwartenSchleife;
      
   end VollbildFenster;

end OptionenGrafikLogik;
