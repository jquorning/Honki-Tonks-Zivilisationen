with EinheitenDatentypen;
with DiplomatieDatentypen;
with KartenKonstanten;
with EinheitenKonstanten;
with StadtKonstanten;
with StadtDatentypen;

with LeseWeltkarte;
with LeseEinheitenGebaut;
with LeseStadtGebaut;
with LeseGrenzen;
with LeseDiplomatie;

with KartenkoordinatenberechnungssystemLogik;
with EinheitSuchenLogik;
with MeldungenSetzenLogik;

package body EinheitInUmgebungLogik is

   procedure EinheitInUmgebung
   is begin
      
      RassenSchleife:
      for RasseSchleifenwert in RassenDatentypen.Rassen_Verwendet_Enum'Range loop
         
         case
           LeseRassenbelegung.Belegung (RasseExtern => RasseSchleifenwert)
         is
            when RassenDatentypen.Mensch_Spieler_Enum =>
               UmgebungStadt (RasseExtern => RasseSchleifenwert);
               UmgebungEinheit (RasseExtern => RasseSchleifenwert);
               
            when others =>
               null;
         end case;
         
      end loop RassenSchleife;
      
   end EinheitInUmgebung;
   
   
   
   procedure UmgebungStadt
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      StadtSchleife:
      for StadtSchleifenwert in StadtKonstanten.AnfangNummer .. LeseGrenzen.Städtegrenzen (RasseExtern => RasseExtern) loop
                  
         case
           LeseStadtGebaut.ID (StadtRasseNummerExtern => (RasseExtern, StadtSchleifenwert))
         is
            when StadtKonstanten.LeerID =>
               null;
                        
            when others =>
               if
                 True = EinheitFinden (KoordinatenExtern => LeseStadtGebaut.Koordinaten (StadtRasseNummerExtern => (RasseExtern, StadtSchleifenwert)),
                                       UmgebungExtern    => LeseStadtGebaut.UmgebungGröße (StadtRasseNummerExtern => (RasseExtern, StadtSchleifenwert)) + 1,
                                       RasseExtern       => RasseExtern)
               then
                  MeldungenSetzenLogik.StadtmeldungSetzen (StadtRasseNummerExtern => (RasseExtern, StadtSchleifenwert),
                                                           EreignisExtern         => StadtDatentypen.Fremde_Einheit_Nahe_Stadt_Enum);
                           
               else
                  null;
               end if;
         end case;
                  
      end loop StadtSchleife;
      
   end UmgebungStadt;
   
   
   
   procedure UmgebungEinheit
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      EinheitenSchleife:
      for EinheitSchleifenwert in EinheitenKonstanten.AnfangNummer .. LeseGrenzen.Einheitengrenze (RasseExtern => RasseExtern) loop
                  
         case
           LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => (RasseExtern, EinheitSchleifenwert))
         is
            when EinheitenKonstanten.LeerID =>
               null;
                        
            when others =>
               if
                 True = EinheitFinden (KoordinatenExtern => LeseEinheitenGebaut.Koordinaten (EinheitRasseNummerExtern => (RasseExtern, EinheitSchleifenwert)),
                                       UmgebungExtern    => 3,
                                       RasseExtern       => RasseExtern)
               then
                  MeldungenSetzenLogik.EinheitmeldungSetzen (EinheitRasseNummerExtern => (RasseExtern, EinheitSchleifenwert),
                                                             EreignisExtern           => EinheitenDatentypen.Fremde_Einheit_Nahe_Enum);
                           
               else
                  null;
               end if;
         end case;
                  
      end loop EinheitenSchleife;
      
   end UmgebungEinheit;
   
   
   
   function EinheitFinden
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      UmgebungExtern : in KartenDatentypen.Sichtweite;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return Boolean
   is
      use type EinheitenDatentypen.MaximaleEinheitenMitNullWert;
      use type DiplomatieDatentypen.Status_Untereinander_Enum;
   begin
      
      YAchseSchleife:
      for YAchseSchleifenwert in -UmgebungExtern .. UmgebungExtern loop
         XAchseSchleife:
         for XAchseSchleifenwert in -UmgebungExtern .. UmgebungExtern loop
      
            KartenWert := KartenkoordinatenberechnungssystemLogik.Kartenkoordinatenberechnungssystem (KoordinatenExtern => KoordinatenExtern,
                                                                                                      ÄnderungExtern    => (KartenKonstanten.LeerEAchseÄnderung, YAchseSchleifenwert, XAchseSchleifenwert),
                                                                                                      LogikGrafikExtern => True);
            
            if
              KartenWert.XAchse = KartenKonstanten.LeerXAchse
            then
               null;
               
            elsif
              False = LeseWeltkarte.Sichtbar (KoordinatenExtern => KartenWert,
                                              RasseExtern       => RasseExtern)
            then
               null;
               
            else
               AndereEinheit := EinheitSuchenLogik.KoordinatenEinheitOhneSpezielleRasseSuchen (RasseExtern       => RasseExtern,
                                                                                               KoordinatenExtern => KartenWert,
                                                                                               LogikGrafikExtern => True);
               
               if
                 AndereEinheit.Nummer = EinheitenKonstanten.LeerNummer
               then
                  null;
                    
               elsif
                 DiplomatieDatentypen.Nichtangriffspakt_Enum = LeseDiplomatie.AktuellerZustand (RasseEinsExtern => RasseExtern,
                                                                                                RasseZweiExtern => AndereEinheit.Rasse)
               then
                  null;
                  
               else
                  return True;
               end if;
            end if;
            
         end loop XAchseSchleife;
      end loop YAchseSchleife;
      
      return False;
      
   end EinheitFinden;

end EinheitInUmgebungLogik;
