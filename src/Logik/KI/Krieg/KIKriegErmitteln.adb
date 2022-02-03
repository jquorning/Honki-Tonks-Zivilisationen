pragma SPARK_Mode (On);

with EinheitStadtDatentypen; use EinheitStadtDatentypen;
with EinheitenKonstanten;

with DiplomatischerZustand;

package body KIKriegErmitteln is

   function IstImKrieg
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
      return Boolean
   is begin
      
      RassenSchleife:
      for RasseSchleifenwert in SystemDatentypen.Rassen_Verwendet_Enum'Range loop
         
         if
           RasseSchleifenwert = RasseExtern
           or
             GlobaleVariablen.RassenImSpiel (RasseSchleifenwert) = SystemKonstanten.LeerSpielerKonstante
         then
            null;
            
         elsif
           DiplomatischerZustand.DiplomatischenStatusPrüfen (EigeneRasseExtern => RasseExtern,
                                                              FremdeRasseExtern => RasseSchleifenwert)
           = SystemDatentypen.Krieg
         then
            return True;
                  
         else
            null;
         end if;
         
      end loop RassenSchleife;
      
      return False;
      
   end IstImKrieg;
   
   
   
   function KriegAnfangen
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
      return SystemDatentypen.Rassen_Enum
   is begin
      
      case
        RasseExtern
      is
         when SystemKonstanten.EkropaKonstante =>
            return EinheitenKonstanten.LeerRasse;
            
         when others =>
            null;
      end case;
      
      RasseGewählt := EinheitenKonstanten.LeerRasse;
      Bewertungen := (others => 0);
      
      RassenSchleife:
      for RasseSchleifenwert in SystemDatentypen.Rassen_Verwendet_Enum'Range loop
         
         if
           RasseSchleifenwert = RasseExtern
           or
             GlobaleVariablen.RassenImSpiel (RasseSchleifenwert) = SystemKonstanten.LeerSpielerKonstante
         then
            null;
            
         else
            RasseGewählt := StärkeVerhältnisErmitteln (EigeneRasseExtern => RasseExtern,
                                                          FremdeRasseExtern => RasseSchleifenwert);
         end if;
         
      end loop RassenSchleife;
      
      return RasseGewählt;
      
   end KriegAnfangen;
   
   
   
   function StärkeVerhältnisErmitteln
     (EigeneRasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum;
      FremdeRasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
      return SystemDatentypen.Rassen_Enum
   is begin
      
      Bewertung := 0;
      
      if
        EigeneRasseExtern = FremdeRasseExtern
      then
         null;
         
      else
         Bewertung := 1;
      end if;
      
      if
        Bewertung > NotwendigeBewertung (EigeneRasseExtern)
      then
         null;
         
      else
         return EinheitenKonstanten.LeerRasse;
      end if;
      
      if
        RasseGewählt = EinheitenKonstanten.LeerRasse
      then
         Bewertungen (FremdeRasseExtern) := Bewertung;
         
      elsif
        Bewertungen (RasseGewählt) < Bewertung
      then
         Bewertungen (FremdeRasseExtern) := Bewertung;
         Bewertungen (RasseGewählt) := 0;
         
      else
         null;
      end if;
      
      return FremdeRasseExtern;
      
   end StärkeVerhältnisErmitteln;

end KIKriegErmitteln;
