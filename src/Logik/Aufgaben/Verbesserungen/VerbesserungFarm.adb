pragma SPARK_Mode (On);

with KartenDatentypen; use KartenDatentypen;

with SchreibeEinheitenGebaut;
with LeseKarten;
with LeseEinheitenGebaut;

with EinheitenBeschreibungen;
with VerbesserungRoden;
with AufgabenAllgemein;

package body VerbesserungFarm is

   function VerbesserungFarm
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      GrundExtern : in KartenDatentypen.Karten_Grund_Enum;
      AnlegenTestenExtern : in Boolean)
      return Boolean
   is begin

      if
        LeseKarten.VerbesserungGebiet (KoordinatenExtern => LeseEinheitenGebaut.Koordinaten (EinheitRasseNummerExtern => EinheitRasseNummerExtern)) = KartenDatentypen.Farm
      then
         return False;

      elsif
        LeseKarten.Grund (KoordinatenExtern => LeseEinheitenGebaut.Koordinaten (EinheitRasseNummerExtern => EinheitRasseNummerExtern)) = KartenDatentypen.Eis
      then
         return False;

      elsif
        LeseKarten.VerbesserungGebiet (KoordinatenExtern => LeseEinheitenGebaut.Koordinaten (EinheitRasseNummerExtern => EinheitRasseNummerExtern))
      in
        KartenDatentypen.Karten_Verbesserung_Gebilde_Enum'Range
        and
          GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) = SystemKonstanten.SpielerMenschKonstante
      then
         case
           EinheitenBeschreibungen.BeschäftigungAbbrechenVerbesserungErsetzenBrandschatzenEinheitAuflösen (WelcheAuswahlExtern => 8)
         is
            when True =>
               null;
               
            when False =>
               return False;
         end case;

      else
         null;
      end if;

      case
        GrundExtern
      is
         when KartenDatentypen.Flachland | KartenDatentypen.Tundra | KartenDatentypen.Wüste | KartenDatentypen.Hügel
            | KartenDatentypen.Karten_Grund_Fluss_Enum'Range | KartenDatentypen.Karten_Grund_Ressourcen_Land'Range =>
            SchreibeEinheitenGebaut.Beschäftigung (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                    BeschäftigungExtern     => SystemKonstanten.FarmBauenKonstante);
            SchreibeEinheitenGebaut.Beschäftigungszeit (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                         ZeitExtern               => 3,
                                                         RechnenSetzenExtern      => 0);

         when KartenDatentypen.Gebirge =>
            SchreibeEinheitenGebaut.Beschäftigung (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                    BeschäftigungExtern     => SystemKonstanten.FarmBauenKonstante);
            SchreibeEinheitenGebaut.Beschäftigungszeit (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                         ZeitExtern               => 5,
                                                         RechnenSetzenExtern      => 0);

         when KartenDatentypen.Wald | KartenDatentypen.Dschungel | KartenDatentypen.Sumpf =>
            if
              VerbesserungRoden.VerbesserungRoden (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                   GrundExtern              => GrundExtern,
                                                   AnlegenTestenExtern      => AnlegenTestenExtern) = True
            then
               SchreibeEinheitenGebaut.BeschäftigungNachfolger (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                                 BeschäftigungExtern     => SystemKonstanten.FarmBauenKonstante);
               SchreibeEinheitenGebaut.BeschäftigungszeitNachfolger (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                                      ZeitExtern               => 3,
                                                                      RechnenSetzenExtern      => 0);
               
            else
               return False;
            end if;
               
         when others =>
            return False;
      end case;
      
      case
        AnlegenTestenExtern
      is
         when True =>
            null;
            
         when False =>
            AufgabenAllgemein.Nullsetzung (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      end case;
      
      return True;
      
   end VerbesserungFarm;

end VerbesserungFarm;
