pragma SPARK_Mode (On);

package body EinheitenMeldungenSetzen is

   procedure EinheitenMeldungenSetzenRundenEnde
   is begin
      
      RassenSchleife:
      for RasseSchleifenwert in GlobaleDatentypen.Rassen_Verwendet_Enum'Range loop
         
         case
           GlobaleVariablen.RassenImSpiel (RasseSchleifenwert)
         is
            when GlobaleDatentypen.Leer =>
               null;
               
            when others =>
               EinheitenSchleife:
               for EinheitSchleifenwert in GlobaleVariablen.EinheitenGebautArray'First (2) .. GlobaleVariablen.Grenzen (RasseSchleifenwert).Einheitengrenze loop
                  
                  GlobaleVariablen.EinheitenGebaut (RasseSchleifenwert, EinheitSchleifenwert).Meldungen := (others => GlobaleDatentypen.Leer);
                  
               end loop EinheitenSchleife;
         end case;
         
      end loop RassenSchleife;
      
   end EinheitenMeldungenSetzenRundenEnde;
   
   
   procedure EinheitMeldungSetzenEreignis
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      EreignisExtern : in GlobaleDatentypen.Einheit_Meldung_Verwendet_Enum)
   is begin
      
      case
        EreignisExtern
      is
         when Aufgabe_Abgeschlossen =>
            ArtDerMeldung := GlobaleDatentypen.Aufgabe_Fertig;
            
         when GlobaleDatentypen.Fremde_Einheit_Nahe =>
            ArtDerMeldung := GlobaleDatentypen.Einheit_In_Der_Nähe;
      end case;
      
      GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Meldungen (ArtDerMeldung) := EreignisExtern;
      
   end EinheitMeldungSetzenEreignis;

end EinheitenMeldungenSetzen;