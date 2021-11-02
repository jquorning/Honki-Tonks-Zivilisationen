pragma SPARK_Mode (On);

with KartenRecords; use KartenRecords;
with EinheitStadtDatentypen; use EinheitStadtDatentypen;
with EinheitenKonstanten;

with KIDatentypen; use KIDatentypen;
with KIKonstanten;

with LeseEinheitenGebaut;

with KIBewegungDurchfuehren;
with KIAufgabenPlanung;
with KIGefahrErmitteln;

package body KIEinheitHandlungen is

   procedure EinheitHandlungen
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
   is begin
      
      FeindlicheEinheit := KIGefahrErmitteln.GefahrErmitteln (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
            
      case
        FeindlicheEinheit.Rasse
      is
         when SystemDatentypen.Keine_Rasse =>
            NormaleHandlungen (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
            
         when others =>
            GefahrenHandlungen (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                FeindlicheEinheitExtern  => FeindlicheEinheit);
      end case;
      
   end EinheitHandlungen;
   
   
   
   procedure NormaleHandlungen
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
   is begin
      
      AktivitätSchleife:
      for Schleifenwert in SystemDatentypen.NotAusKlein'Range loop
         
         exit AktivitätSchleife when HandlungBeendet (EinheitRasseNummerExtern => EinheitRasseNummerExtern) = True;
         
         BewegungAufgabenplanung (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
         
         exit AktivitätSchleife when HandlungBeendet (EinheitRasseNummerExtern => EinheitRasseNummerExtern) = True;
         
         if
           LeseEinheitenGebaut.KIZielKoordinaten (EinheitRasseNummerExtern => EinheitRasseNummerExtern) /= KIKonstanten.LeerKoordinate
         then
            KIBewegungDurchfuehren.KIBewegungNeu (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
            
         elsif
           LeseEinheitenGebaut.KIBeschäftigt (EinheitRasseNummerExtern => EinheitRasseNummerExtern) /= KIDatentypen.Tut_Nichts
           and
             LeseEinheitenGebaut.Beschäftigung (EinheitRasseNummerExtern => EinheitRasseNummerExtern) = SystemDatentypen.Leer
         then
            KIAufgabenPlanung.AufgabeUmsetzen (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
         
         else
            return;
         end if;
         
      end loop AktivitätSchleife;
      
   end NormaleHandlungen;
   
   
   
   procedure BewegungAufgabenplanung
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
   is begin
      
      if
        LeseEinheitenGebaut.KIZielKoordinaten (EinheitRasseNummerExtern => EinheitRasseNummerExtern) /= KIKonstanten.LeerKoordinate
      then
         KIBewegungDurchfuehren.KIBewegungNeu (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
         
      elsif
        LeseEinheitenGebaut.Beschäftigung (EinheitRasseNummerExtern => EinheitRasseNummerExtern) = SystemDatentypen.Leer
        and
          LeseEinheitenGebaut.KIBeschäftigt (EinheitRasseNummerExtern => EinheitRasseNummerExtern) = KIDatentypen.Tut_Nichts
      then
         KIAufgabenPlanung.AufgabeErmitteln (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
         
      else
         null;
      end if;
      
   end BewegungAufgabenplanung;
   
   
   
   procedure GefahrenHandlungen
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      FeindlicheEinheitExtern : in EinheitStadtRecords.RassePlatznummerRecord)
   is begin
      
      if
        FeindlicheEinheitExtern.Rasse = SystemDatentypen.Keine_Rasse
      then
         null;
         
      else
         null;
      end if;
      
      AktivitätSchleife:
      for Schleifenwert in SystemDatentypen.NotAusKlein'Range loop
         
         exit AktivitätSchleife when HandlungBeendet (EinheitRasseNummerExtern => EinheitRasseNummerExtern) = True;
         
         BewegungAufgabenplanung (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
         
         exit AktivitätSchleife when HandlungBeendet (EinheitRasseNummerExtern => EinheitRasseNummerExtern) = True;
         
         if
           LeseEinheitenGebaut.KIZielKoordinaten (EinheitRasseNummerExtern => EinheitRasseNummerExtern) /= KIKonstanten.LeerKoordinate
         then
            KIBewegungDurchfuehren.KIBewegungNeu (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
            
         elsif
           LeseEinheitenGebaut.KIBeschäftigt (EinheitRasseNummerExtern => EinheitRasseNummerExtern) /= KIDatentypen.Tut_Nichts
           and
             LeseEinheitenGebaut.Beschäftigung (EinheitRasseNummerExtern => EinheitRasseNummerExtern) = SystemDatentypen.Leer
         then
            KIAufgabenPlanung.AufgabeUmsetzen (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
         
         else
            return;
         end if;
         
      end loop AktivitätSchleife;
      
   end GefahrenHandlungen;
   
   
   
   function HandlungBeendet
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
      return Boolean
   is begin
      
      if
        LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => EinheitRasseNummerExtern) = EinheitenKonstanten.LeerEinheit.ID
        or
          LeseEinheitenGebaut.Bewegungspunkte (EinheitRasseNummerExtern => EinheitRasseNummerExtern) <= EinheitenKonstanten.LeerEinheit.Bewegungspunkte
      then
         return True;
         
      elsif
        LeseEinheitenGebaut.KIBeschäftigt (EinheitRasseNummerExtern => EinheitRasseNummerExtern) = KIDatentypen.Stadt_Bewachen
        and
          LeseEinheitenGebaut.KIZielKoordinaten (EinheitRasseNummerExtern => EinheitRasseNummerExtern) = KIKonstanten.LeerKoordinate
      then
         return True;
            
      else
         return False;
      end if;
      
   end HandlungBeendet;

end KIEinheitHandlungen;
