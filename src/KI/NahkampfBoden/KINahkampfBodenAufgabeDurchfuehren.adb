pragma SPARK_Mode (On);

with KIDatentypen;

with Verbesserungen, LeseEinheitenGebaut, SchreibeEinheitenGebaut;

package body KINahkampfBodenAufgabeDurchfuehren is

   procedure NahkampfBodenAufgabeDurchfuehren
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
   is begin
      
      AufgabeDurchführen := True;
      
      case
        LeseEinheitenGebaut.KIBeschäftigt (EinheitRasseNummerExtern => EinheitRasseNummerExtern)
      is
         when KIDatentypen.Stadt_Bewachen =>
            AufgabeDurchführen := Verbesserungen.VerbesserungAnlegen (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                                       BefehlExtern             => GlobaleDatentypen.Verschanzen);
            
         when KIDatentypen.Verbesserung_Zerstören =>
            null;
            
         when KIDatentypen.Flucht =>
            null;
            
         when KIDatentypen.Einheit_Heilen =>
            AufgabeDurchführen := Verbesserungen.VerbesserungAnlegen (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                                       BefehlExtern             => GlobaleDatentypen.Heilen);
            
         when KIDatentypen.Einheit_Festsetzen =>
            AufgabeDurchführen := Verbesserungen.VerbesserungAnlegen (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                                       BefehlExtern             => GlobaleDatentypen.Verschanzen);
            
         when KIDatentypen.Einheit_Verbessern =>
            null;
            
         when KIDatentypen.Angreifen =>
            null;
            
         when KIDatentypen.Erkunden =>
            SchreibeEinheitenGebaut.KIBeschäftigt (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                    AufgabeExtern            => KIDatentypen.Keine_Aufgabe);
            
         when others =>
            null;
      end case;
      
      case
        AufgabeDurchführen
      is
         when True =>
            null;
            
         when False =>
            SchreibeEinheitenGebaut.KIBeschäftigt (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                    AufgabeExtern            => KIDatentypen.Keine_Aufgabe);
      end case;
      
   end NahkampfBodenAufgabeDurchfuehren;

end KINahkampfBodenAufgabeDurchfuehren;
