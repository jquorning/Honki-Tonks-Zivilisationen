with KartenDatentypen; use KartenDatentypen;
with KartenKonstanten;

with LeseEinheitenGebaut;
with SchreibeEinheitenGebaut;

with KartenkoordinatenberechnungssystemLogik;
with PassierbarkeitspruefungLogik;

with KIAufgabenVerteiltLogik;

package body KIEinheitFestlegenPlatzMachenLogik is
   
   -- War vorher für die Berechnung der Aufgabenwerte zuständig, kann vermutlich nach einer Anpassung der Festlegung weg. äöü
   -- function PlatzMachen
   --   (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
   -- return KIDatentypen.AufgabenWichtigkeitKlein
   -- is begin
      
   --    EinheitenKoordinaten := LeseEinheitenGebaut.Koordinaten (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      
   --    BlockiertSchleife:
   --    for BlockiertSchleifenwert in SpielVariablen.EinheitenGebautArray'Range (2) loop
         
   --      case
   --        Vergleiche.Koordinatenvergleich (KoordinateEinsExtern  => EinheitenKoordinaten,
   -- KoordinatenZweiExtern => LeseEinheitenGebaut.KIZielKoordinaten (EinheitRasseNummerExtern => (EinheitRasseNummerExtern.Rasse, BlockiertSchleifenwert)))
   --      is
   --        when True =>
   --          return KIKonstanten.PlatzFreiMachen;
               
   --       when False =>
   --         null;
   --      end case;
         
   --   end loop BlockiertSchleife;
      
   --   return KIKonstanten.UnmöglichAufgabenbewertung;
      
   -- end PlatzMachen;
   
   

   function PlatzMachen
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return Boolean
   is begin
      
      Einheitenkoordinaten := LeseEinheitenGebaut.Koordinaten (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      
      EAchseSchleife:
      for EAchseSchleifenwert in KartenDatentypen.EbenenbereichEins'Range loop
         YAchseSchleife:
         for YAchseSchleifenwert in KartenDatentypen.UmgebungsbereichDrei'Range loop
            XAchseSchleife:
            for XAchseSchleifenwert in KartenDatentypen.UmgebungsbereichDrei'Range loop
               
               Kartenwert := KartenkoordinatenberechnungssystemLogik.Kartenkoordinatenberechnungssystem (KoordinatenExtern => Einheitenkoordinaten,
                                                                                                         ÄnderungExtern    => (EAchseSchleifenwert, YAchseSchleifenwert, XAchseSchleifenwert),
                                                                                                         LogikGrafikExtern => True);
               
               if
                 Kartenwert.XAchse = KartenKonstanten.LeerXAchse
               then
                  null;
                  
               elsif
                 True = PassierbarkeitspruefungLogik.PassierbarkeitPrüfenNummer (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                                                  NeueKoordinatenExtern    => Kartenwert)
                 and
                   False = KIAufgabenVerteiltLogik.EinheitZiel (RasseExtern           => EinheitRasseNummerExtern.Rasse,
                                                                ZielKoordinatenExtern => Kartenwert)
               then
                  SchreibeEinheitenGebaut.KIZielKoordinaten (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                             KoordinatenExtern        => Kartenwert);
                  return True;
                 
               else
                  null;
               end if;
               
            end loop XAchseSchleife;
         end loop YAchseSchleife;
      end loop EAchseSchleife;
      
      return False;
      
   end PlatzMachen;

end KIEinheitFestlegenPlatzMachenLogik;
