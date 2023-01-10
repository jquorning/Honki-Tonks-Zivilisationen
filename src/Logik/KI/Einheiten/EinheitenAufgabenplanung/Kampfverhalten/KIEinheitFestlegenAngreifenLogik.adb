with DiplomatieDatentypen;
with KartenKonstanten;

with SchreibeEinheitenGebaut;
with LeseEinheitenGebaut;
with LeseDiplomatie;

with KIDatentypen;

with KIEinheitSuchenLogik;
with KIStadtSuchenLogik;

package body KIEinheitFestlegenAngreifenLogik is

   function Angreifen
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
      return Boolean
   is begin
      
      WenAngreifen := ZielErmitteln (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies);
      
      case
        WenAngreifen
      is
         when EinheitenKonstanten.LeerSpezies =>
            return False;
            
         when others =>
            KoordinatenFeind := KIEinheitSuchenLogik.FeindlicheEinheitInUmgebungSuchen (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                                                                                        FeindExtern              => WenAngreifen);
      end case;
            
      case
        KoordinatenFeind.XAchse
      is
         when KartenKonstanten.LeerXAchse =>
            null;
            
         when others =>
            SchreibeEinheitenGebaut.KIBeschäftigt (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                                                    AufgabeExtern            => KIDatentypen.Angreifen_Enum);
            SchreibeEinheitenGebaut.KIZielKoordinaten (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                                                       KoordinatenExtern        => KoordinatenFeind);
            return True;
      end case;
      
      KoordinatenFeind := KIStadtSuchenLogik.NähesteFeindlicheStadtSuchen (SpeziesExtern             => WenAngreifen,
                                                                            AnfangKoordinatenExtern => LeseEinheitenGebaut.Koordinaten (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern));
      
      case
        KoordinatenFeind.XAchse
      is
         when KartenKonstanten.LeerXAchse =>
            return False;
            
         when others =>
            SchreibeEinheitenGebaut.KIBeschäftigt (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                                                    AufgabeExtern            => KIDatentypen.Angreifen_Enum);
            SchreibeEinheitenGebaut.KIZielKoordinaten (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                                                       KoordinatenExtern        => KoordinatenFeind);
            return True;
      end case;
   end Angreifen;
   
   
   
   function ZielErmitteln
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
      return SpeziesDatentypen.Spezies_Enum
   is
      use type DiplomatieDatentypen.Status_Untereinander_Enum;
      use type SpeziesDatentypen.Spezies_Enum;
   begin
      
      Ziel := EinheitenKonstanten.LeerSpezies;
      
      SpeziesSchleife:
      for SpeziesSchleifenwert in SpeziesDatentypen.Spezies_Verwendet_Enum'Range loop
         
         if
           LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesSchleifenwert) = SpeziesDatentypen.Leer_Spieler_Enum
           or
             SpeziesSchleifenwert = SpeziesExtern
         then
            null;
            
         elsif
           DiplomatieDatentypen.Krieg_Enum = LeseDiplomatie.AktuellerZustand (SpeziesEinsExtern => SpeziesExtern,
                                                                              SpeziesZweiExtern => SpeziesSchleifenwert)
         then
            -- Es sollte auch noch Prüfungen auf die Stärke der feindlichen Spezies erfolgen. äöü
            Ziel := SpeziesSchleifenwert;
            exit SpeziesSchleife;
            
         else
            null;
         end if;
         
      end loop SpeziesSchleife;
      
      return Ziel;
      
   end ZielErmitteln;

end KIEinheitFestlegenAngreifenLogik;
