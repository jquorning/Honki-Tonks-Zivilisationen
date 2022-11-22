with EinheitenKonstanten;
with EinheitenRecords;
with SpielVariablen;

with LeseEinheitenGebaut;
with LeseGrenzen;

with NachGrafiktask;

package body NaechsteEinheitLogik is

   procedure NächsteEinheit
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      BewegungspunkteExtern : in Bewegungspunkte_Enum)
   is
      use type EinheitenDatentypen.MaximaleEinheitenMitNullWert;
      use type EinheitenDatentypen.EinheitenIDMitNullWert;
      use type EinheitenDatentypen.Bewegungspunkte;
   begin
      
      EinheitSchleifenbegrenzung := 0;
      
      EinheitSuchenSchleife:
      loop

         if
           AktuelleEinheit (RasseExtern) >= LeseGrenzen.Einheitengrenze (RasseExtern => RasseExtern)
         then
            AktuelleEinheit (RasseExtern) := SpielVariablen.EinheitenGebautArray'First (2);
               
         else
            AktuelleEinheit (RasseExtern) := AktuelleEinheit (RasseExtern) + 1;
         end if;
         
         Bewegungspunkte := LeseEinheitenGebaut.Bewegungspunkte (EinheitRasseNummerExtern => (RasseExtern, AktuelleEinheit (RasseExtern)));
               
         if
           LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => (RasseExtern, AktuelleEinheit (RasseExtern))) = EinheitenKonstanten.LeerID
           or
             (Bewegungspunkte <= EinheitenKonstanten.LeerBewegungspunkte
              and
                BewegungspunkteExtern = Hat_Bewegungspunkte_Enum)
           or
             (Bewegungspunkte > EinheitenKonstanten.LeerBewegungspunkte
              and
                BewegungspunkteExtern = Keine_Bewegungspunkte_Enum)
         then
            null;
         
         else
            exit EinheitSuchenSchleife;
         end if;
         
         if
           EinheitSchleifenbegrenzung < LeseGrenzen.Einheitengrenze (RasseExtern => RasseExtern)
         then
            EinheitSchleifenbegrenzung := EinheitSchleifenbegrenzung + 1;
            
         else
            return;
         end if;

      end loop EinheitSuchenSchleife;
      
      NachGrafiktask.GeheZu := LeseEinheitenGebaut.Koordinaten (EinheitRasseNummerExtern => (RasseExtern, AktuelleEinheit (RasseExtern)));
      
   end NächsteEinheit;
   
   
   
   procedure NächsteEinheitMeldung
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
   is
      use type EinheitenDatentypen.MaximaleEinheitenMitNullWert;
      use type EinheitenDatentypen.EinheitenIDMitNullWert;
   begin
      
      MeldungSchleifenbegrenzung := 0;
      
      EinheitSuchenSchleife:
      loop

         if
           AktuelleEinheitMeldung (RasseExtern) >= LeseGrenzen.Einheitengrenze (RasseExtern => RasseExtern)
         then
            AktuelleEinheitMeldung (RasseExtern) := SpielVariablen.EinheitenGebautArray'First (2);
               
         else
            AktuelleEinheitMeldung (RasseExtern) := AktuelleEinheitMeldung (RasseExtern) + 1;
         end if;
               
         if
           LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => (RasseExtern, AktuelleEinheitMeldung (RasseExtern))) = EinheitenKonstanten.LeerID
         then
            null;
         
         else
            MeldungSchleife:
            for MeldungSchleifenwert in EinheitenRecords.EinheitMeldungenArray'Range loop
               
               case
                 LeseEinheitenGebaut.Meldungen (EinheitRasseNummerExtern => (RasseExtern, AktuelleEinheitMeldung (RasseExtern)),
                                                WelcheMeldungExtern      => MeldungSchleifenwert)
               is
                  when EinheitenDatentypen.Leer_Einheit_Meldung_Enum =>
                     null;
                     
                  when others =>
                     exit EinheitSuchenSchleife;
               end case;
               
            end loop MeldungSchleife;
         end if;
         
         if
           MeldungSchleifenbegrenzung < LeseGrenzen.Einheitengrenze (RasseExtern => RasseExtern)
         then
            MeldungSchleifenbegrenzung := MeldungSchleifenbegrenzung + 1;
            
         else
            return;
         end if;

      end loop EinheitSuchenSchleife;
      
      NachGrafiktask.GeheZu := LeseEinheitenGebaut.Koordinaten (EinheitRasseNummerExtern => (RasseExtern, AktuelleEinheitMeldung (RasseExtern)));
      
   end NächsteEinheitMeldung;

end NaechsteEinheitLogik;
