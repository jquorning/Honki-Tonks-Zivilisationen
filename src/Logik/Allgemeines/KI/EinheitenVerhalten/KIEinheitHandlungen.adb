pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with AufgabenDatentypen; use AufgabenDatentypen;
with KartenRecords; use KartenRecords;
with EinheitenKonstanten;
with KartenRecordKonstanten;

with LeseEinheitenGebaut;

with Vergleiche;
with BewegungEinheiten;

with KIDatentypen; use KIDatentypen;

with KIBewegungDurchfuehren;
with KIAufgabenPlanung;
with KIAufgabenUmsetzung;

---------------------------------- Besseren Namen geben?
package body KIEinheitHandlungen is

   function HandlungBeendet
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return Boolean
   is begin
      
      if
        LeseEinheitenGebaut.KIBeschäftigt (EinheitRasseNummerExtern => EinheitRasseNummerExtern) = KIDatentypen.Tut_Nichts_Enum
        or
          LeseEinheitenGebaut.Beschäftigung (EinheitRasseNummerExtern => EinheitRasseNummerExtern) /= EinheitenKonstanten.LeerBeschäftigung
      then
         return True;
         
      elsif
        LeseEinheitenGebaut.KIBeschäftigt (EinheitRasseNummerExtern => EinheitRasseNummerExtern) = KIDatentypen.Stadt_Bewachen_Enum
        and
          LeseEinheitenGebaut.KIZielKoordinaten (EinheitRasseNummerExtern => EinheitRasseNummerExtern) = KartenRecordKonstanten.LeerKoordinate
      then
         return True;
            
      else
         -- Muss hier not sein wegen den Rückgabewerten in der Funktion selbst, die nicht geändert werden können wegen der Einbindung im Bewegungssystem.
         return not BewegungEinheiten.NochBewegungspunkte (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      end if;
      
   end HandlungBeendet;
           
      
   
   -- Muss auch eine Funktion sein, es könnte ja als Aufgabe Stadt_Bewachen_Enum festgelegt werden für den Ort an dem sich die Einheit gerade befindet.
   function Aufgabenplanung
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return Boolean
   is begin
      
      if
        LeseEinheitenGebaut.Beschäftigung (EinheitRasseNummerExtern => EinheitRasseNummerExtern) = EinheitenKonstanten.LeerBeschäftigung
        and
          LeseEinheitenGebaut.KIBeschäftigt (EinheitRasseNummerExtern => EinheitRasseNummerExtern) = KIDatentypen.Leer_Aufgabe_Enum
      then
         KIAufgabenPlanung.AufgabeErmitteln (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
         return HandlungBeendet (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
         
      else
         return False;
      end if;
      
   end Aufgabenplanung;
   
   
   
   function Bewegen
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return Boolean
   is begin
      
      case
        Vergleiche.KoordinateLeervergleich (KoordinateExtern => LeseEinheitenGebaut.KIZielKoordinaten (EinheitRasseNummerExtern => EinheitRasseNummerExtern))
      is
         when False =>
            KIBewegungDurchfuehren.KIBewegung (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
            return HandlungBeendet (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
            
         when True =>
            return False;
      end case;
      
   end Bewegen;
   
   
   
   function Aufgabenumsetzung
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return Boolean
   is begin
      
      if
        LeseEinheitenGebaut.KIBeschäftigt (EinheitRasseNummerExtern => EinheitRasseNummerExtern) /= KIDatentypen.Tut_Nichts_Enum
        and
          LeseEinheitenGebaut.KIBeschäftigt (EinheitRasseNummerExtern => EinheitRasseNummerExtern) /= KIDatentypen.Leer_Aufgabe_Enum
        and
          LeseEinheitenGebaut.Beschäftigung (EinheitRasseNummerExtern => EinheitRasseNummerExtern) = EinheitenKonstanten.LeerBeschäftigung
      then
         KIAufgabenUmsetzung.AufgabeUmsetzen (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
         return HandlungBeendet (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
         
      else
         return False;
      end if;
      
   end Aufgabenumsetzung;

end KIEinheitHandlungen;
