pragma SPARK_Mode (On);

with KartenDatentypen; use KartenDatentypen;

with LeseKarten;
with LeseEinheitenGebaut;

with Aufgaben;

package body KIAufgabeUmsetzen is
   
   function WelcheVerbesserungAnlegen
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
      return Boolean
   is begin
      
      case
        LeseKarten.VerbesserungGebiet (PositionExtern => LeseEinheitenGebaut.Position (EinheitRasseNummerExtern => EinheitRasseNummerExtern))
      is
         when KartenDatentypen.Leer =>
            if
              VerbesserungGebiet (EinheitRasseNummerExtern => EinheitRasseNummerExtern) = True
            then
               return True;
               
            else
               null;
            end if;
      
         when others =>
            null;
      end case;
      
      case
        LeseKarten.VerbesserungWeg (PositionExtern => LeseEinheitenGebaut.Position (EinheitRasseNummerExtern => EinheitRasseNummerExtern))
      is
         when KartenDatentypen.Leer =>
            return Aufgaben.VerbesserungAnlegen (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                 BefehlExtern             => SystemKonstanten.StraßeBauenKonstante);
            
         when others =>
            null;
      end case;
      
      return False;
      
   end WelcheVerbesserungAnlegen;
   
   
   
   function VerbesserungGebiet
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
      return Boolean
   is begin
      
      Grund := LeseKarten.Grund (PositionExtern => LeseEinheitenGebaut.Position (EinheitRasseNummerExtern => EinheitRasseNummerExtern));
         
      if
        (Grund = KartenDatentypen.Hügel
         or
           Grund = KartenDatentypen.Gebirge
         or
           Grund = KartenDatentypen.Kohle
         or
           Grund = KartenDatentypen.Eisen
         or
           Grund = KartenDatentypen.Gold
         or
           LeseKarten.Hügel (PositionExtern => LeseEinheitenGebaut.Position (EinheitRasseNummerExtern => EinheitRasseNummerExtern)) = True)
        and
          Aufgaben.VerbesserungTesten (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                       BefehlExtern             => SystemKonstanten.MineBauenKonstante)
        = True
      then
         Befehl := SystemKonstanten.MineBauenKonstante;
         
      elsif
        Grund = KartenDatentypen.Eis
        and
          Aufgaben.VerbesserungTesten (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                       BefehlExtern             => SystemKonstanten.FestungBauenKonstante)
        = True
      then
         Befehl := SystemKonstanten.FestungBauenKonstante;
         
      elsif
        Aufgaben.VerbesserungTesten (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                     BefehlExtern             => SystemKonstanten.FarmBauenKonstante)
        = True
      then
         Befehl := SystemKonstanten.FarmBauenKonstante;
            
      else
         return False;
      end if;
      
      return Aufgaben.VerbesserungAnlegen (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                           BefehlExtern             => Befehl);
      
   end VerbesserungGebiet;
      
      

   function EinheitVerbessern
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
      return Boolean
   is begin
      
      NullWert := Aufgaben.VerbesserungAnlegen (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                BefehlExtern             => SystemKonstanten.EinheitVerbessernKonstante);
      
      return False;
      
   end EinheitVerbessern;

end KIAufgabeUmsetzen;
