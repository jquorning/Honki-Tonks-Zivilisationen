pragma SPARK_Mode (On);

with KIDatentypen;

with LeseEinheitenGebaut, LeseEinheitenDatenbank;

with DiplomatischerZustand, EinheitSuchen, StadtSuchen;

package body KIBewegungAllgemein is

   -- -1 = Belegt und Angriff, 0 = Unbelegt, 1 = Belegt und kein Angriff
   function FeldBetreten
     (FeldPositionExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord;
      EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
      return GlobaleDatentypen.LoopRangeMinusEinsZuEins
   is begin
      
      BlockierendeEinheit := EinheitSuchen.KoordinatenEinheitOhneRasseSuchen (KoordinatenExtern => FeldPositionExtern).Rasse;
      BlockierendeStadt := StadtSuchen.KoordinatenStadtOhneRasseSuchen (KoordinatenExtern => FeldPositionExtern).Rasse;
      
      if
        BlockierendeEinheit = GlobaleDatentypen.Leer
        and
          BlockierendeStadt = GlobaleDatentypen.Leer
      then
         return 0;
         
      elsif
        BlockierendeEinheit = EinheitRasseNummerExtern.Rasse
      then
         return 1;
         
      elsif
        BlockierendeStadt = EinheitRasseNummerExtern.Rasse
      then
         return 0;
         
      else
         null;
      end if;
      
      case
        LeseEinheitenDatenbank.EinheitArt (RasseExtern => EinheitRasseNummerExtern.Rasse,
                                           IDExtern    => LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => EinheitRasseNummerExtern))
      is
         when GlobaleDatentypen.Leer | GlobaleDatentypen.Arbeiter =>
            return 1;
            
         when others =>
            null;
      end case;
      
      if
        BlockierendeEinheit = GlobaleDatentypen.Leer
        and then
          DiplomatischerZustand.DiplomatischenStatusPrüfen (EigeneRasseExtern => EinheitRasseNummerExtern.Rasse,
                                                             FremdeRasseExtern => BlockierendeStadt)
        /= GlobaleDatentypen.Krieg
      then
         return 1;
         
      elsif
        BlockierendeStadt = GlobaleDatentypen.Leer
        and then
          DiplomatischerZustand.DiplomatischenStatusPrüfen (EigeneRasseExtern => EinheitRasseNummerExtern.Rasse,
                                                             FremdeRasseExtern => BlockierendeEinheit)
        /= GlobaleDatentypen.Krieg
      then
         return 1;
         
      else
         null;
      end if;
      
      case
        LeseEinheitenGebaut.KIBeschäftigt (EinheitRasseNummerExtern => EinheitRasseNummerExtern)
      is
         when KIDatentypen.Angreifen | KIDatentypen.Verbesserung_Zerstören | KIDatentypen.Erkunden | KIDatentypen.Verteidigen =>
            return -1;
            
         when others =>
            return 1;
      end case;
      
   end FeldBetreten;

end KIBewegungAllgemein;