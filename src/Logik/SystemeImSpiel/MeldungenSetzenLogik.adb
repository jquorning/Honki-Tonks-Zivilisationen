with SchreibeEinheitenGebaut;
with SchreibeStadtGebaut;

package body MeldungenSetzenLogik is

   procedure MeldungenRundenende
   is begin
      
      SpeziesSchleife:
      for SpeziesSchleifenwert in SpeziesDatentypen.Spezies_Verwendet_Enum'Range loop
         
         case
           LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesSchleifenwert)
         is
            when SpeziesDatentypen.Leer_Spieler_Enum =>
               null;
               
            when others =>
               StadtSchleife:
               for StadtSchleifenwert in StadtKonstanten.AnfangNummer .. LeseGrenzen.Städtegrenzen (SpeziesExtern => SpeziesSchleifenwert) loop
                  
                  SchreibeStadtGebaut.LeerMeldungen (StadtSpeziesNummerExtern => (SpeziesSchleifenwert, StadtSchleifenwert));
                  
               end loop StadtSchleife;
                                             
               EinheitenSchleife:
               for EinheitSchleifenwert in EinheitenKonstanten.AnfangNummer .. LeseGrenzen.Einheitengrenze (SpeziesExtern => SpeziesSchleifenwert) loop
                  
                  SchreibeEinheitenGebaut.LeerMeldungen (EinheitSpeziesNummerExtern => (SpeziesSchleifenwert, EinheitSchleifenwert));
                  
               end loop EinheitenSchleife;
         end case;
         
      end loop SpeziesSchleife;
      
   end MeldungenRundenende;
   
   
   
   procedure StadtmeldungSetzen
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord;
      EreignisExtern : in StadtDatentypen.Stadt_Meldungen_Verwendet_Enum)
   is begin
      
      case
        EreignisExtern
      is
         when StadtDatentypen.Produktion_Abgeschlossen_Enum | StadtDatentypen.Einheit_Unplatzierbar_Enum =>
            StadtMeldung := StadtDatentypen.Produktion_Fertig_Enum;
            
         when StadtDatentypen.Einwohner_Wachstum_Enum | StadtDatentypen.Einwohner_Reduktion_Enum =>
            StadtMeldung := StadtDatentypen.Hungersnot_Enum;
            
         when StadtDatentypen.Fremde_Einheit_Nahe_Stadt_Enum =>
            StadtMeldung := StadtDatentypen.Einheit_In_Stadtnähe_Enum;
      end case;
      
      SchreibeStadtGebaut.Meldungen (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern,
                                     WelcheMeldungExtern    => StadtMeldung,
                                     MeldungExtern          => EreignisExtern);
      
   end StadtmeldungSetzen;
   
   
   
   procedure EinheitmeldungSetzen
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord;
      EreignisExtern : in EinheitenDatentypen.Einheit_Meldung_Verwendet_Enum)
   is begin
      
      case
        EreignisExtern
      is
         when EinheitenDatentypen.Aufgabe_Abgeschlossen_Enum =>
            EinheitMeldung := EinheitenDatentypen.Aufgabe_Fertig_Enum;
            
         when EinheitenDatentypen.Fremde_Einheit_Nahe_Enum =>
            EinheitMeldung := EinheitenDatentypen.Einheit_In_Der_Nähe_Enum;
      end case;
      
      SchreibeEinheitenGebaut.Meldungen (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                                         MeldungExtern            => EreignisExtern,
                                         WelcheMeldungExtern      => EinheitMeldung);
      
   end EinheitmeldungSetzen;

end MeldungenSetzenLogik;
