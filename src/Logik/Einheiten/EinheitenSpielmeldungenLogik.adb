pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with EinheitenDatentypen; use EinheitenDatentypen;
with TextnummernKonstanten;
with EinheitenKonstanten;

with LeseEinheitenGebaut;
with LeseEinheitenDatenbank;

with MeldungFestlegenLogik;

package body EinheitenSpielmeldungenLogik is

   function BewegungspunkteMeldung
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return Boolean
   is begin
      
      if
        LeseEinheitenGebaut.Bewegungspunkte (EinheitRasseNummerExtern => EinheitRasseNummerExtern) = EinheitenKonstanten.LeerBewegungspunkte
      then
         MeldungFestlegenLogik.MeldungFestlegen (MeldungExtern => TextnummernKonstanten.MeldungBewegungspunkte);
         return False;
                     
      else
         return True;
      end if;
      
   end BewegungspunkteMeldung;
   
   
   
   function ArbeiteraufgabeMeldung
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return Boolean
   is begin
      
      case
        LeseEinheitenDatenbank.EinheitArt (RasseExtern => EinheitRasseNummerExtern.Rasse,
                                           IDExtern    => LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => EinheitRasseNummerExtern))
      is
         when EinheitenDatentypen.Arbeiter_Enum =>
            return True;
         
         when others =>
            MeldungFestlegenLogik.MeldungFestlegen (MeldungExtern => TextnummernKonstanten.MeldungBefehl);
            return False;
      end case;
      
   end ArbeiteraufgabeMeldung;
   
end EinheitenSpielmeldungenLogik;
