with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

with KartenverbesserungDatentypen;
with StadtKonstanten;

with LeseStadtGebaut;
with LeseWeltkarte;
  
with TexteingabeLogik;
with NachGrafiktask;

package body StadtSuchenLogik is

   function KoordinatenStadtMitRasseSuchen
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
      return StadtDatentypen.MaximaleStädteMitNullWert
   is
      use type RassenDatentypen.Rassen_Enum;
   begin
      
      case
        LeseWeltkarte.Verbesserung (KoordinatenExtern => KoordinatenExtern)
      is
         when KartenverbesserungDatentypen.Karten_Verbesserung_Städte_Enum'Range =>
            Stadt := LeseWeltkarte.StadtbelegungGrund (KoordinatenExtern => KoordinatenExtern);
            
         when others =>
            return StadtKonstanten.LeerNummer;
      end case;
            
      if
        Stadt.Rasse = RasseExtern
      then
         return Stadt.Nummer;
            
      else
         return StadtKonstanten.LeerNummer;
      end if;
      
   end KoordinatenStadtMitRasseSuchen;
   


   function KoordinatenStadtOhneRasseSuchen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
      return StadtRecords.RasseStadtnummerRecord
   is begin
      
      case
        LeseWeltkarte.Verbesserung (KoordinatenExtern => KoordinatenExtern)
      is
         when KartenverbesserungDatentypen.Karten_Verbesserung_Städte_Enum'Range =>
            return LeseWeltkarte.StadtbelegungGrund (KoordinatenExtern => KoordinatenExtern);
            
         when others =>
            return StadtKonstanten.LeerRasseNummer;
      end case;
      
   end KoordinatenStadtOhneRasseSuchen;
   
   
   
   function KoordinatenStadtOhneSpezielleRasseSuchen
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
      return StadtRecords.RasseStadtnummerRecord
   is
      use type RassenDatentypen.Rassen_Enum;
   begin
      
      case
        LeseWeltkarte.Verbesserung (KoordinatenExtern => KoordinatenExtern)
      is
         when KartenverbesserungDatentypen.Karten_Verbesserung_Städte_Enum'Range =>
            Stadt := LeseWeltkarte.StadtbelegungGrund (KoordinatenExtern => KoordinatenExtern);
            
         when others =>
            return StadtKonstanten.LeerRasseNummer;
      end case;
      
      if
        Stadt.Rasse = RasseExtern
      then
         return StadtKonstanten.LeerRasseNummer;
         
      else
         return Stadt;
      end if;
      
   end KoordinatenStadtOhneSpezielleRasseSuchen;
   

   
   procedure StadtNachNamenSuchen
   is
      use type KartenverbesserungDatentypen.Karten_Verbesserung_Enum;
   begin
      
      StadtName := TexteingabeLogik.StadtName (StadtRasseNummerExtern => StadtKonstanten.LeerRasseNummer,
                                               BauenExtern            => False);
      
      case
        StadtName.ErfolgreichAbbruch
      is
         when False =>
            return;
            
         when True =>
            null;
      end case;
      
      RasseSchleife:
      for RasseSchleifenwert in RassenDatentypen.Rassen_Verwendet_Enum'Range loop
         
         case
           LeseRassenbelegung.Belegung (RasseExtern => RasseSchleifenwert)
         is
            when RassenDatentypen.Leer_Spieler_Enum =>
               null;
               
            when others =>
               StadtSchleife:
               for StadtNummerSchleifenwert in StadtKonstanten.AnfangNummer .. LeseGrenzen.Städtegrenzen (RasseExtern => RasseSchleifenwert) loop
                  
                  if
                    LeseStadtGebaut.ID (StadtRasseNummerExtern => (RasseSchleifenwert, StadtNummerSchleifenwert)) = StadtKonstanten.LeerID
                  then
                     null;
                     
                  elsif
                    LeseStadtGebaut.Name (StadtRasseNummerExtern => (RasseSchleifenwert, StadtNummerSchleifenwert)) = StadtName.EingegebenerText
                  then
                     NachGrafiktask.GeheZu := LeseStadtGebaut.Koordinaten (StadtRasseNummerExtern => (RasseSchleifenwert, StadtNummerSchleifenwert));
                     return;
               
                  else
                     null;
                  end if;
            
               end loop StadtSchleife;
         end case;
         
      end loop RasseSchleife;
      
   end StadtNachNamenSuchen;

end StadtSuchenLogik;
