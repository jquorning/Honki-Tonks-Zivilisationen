pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with EinheitenDatentypen; use EinheitenDatentypen;
with KartenKonstanten;
with EinheitenKonstanten;
with KartenRecordKonstanten;

with LeseKarten;

with Kartenkoordinatenberechnungssystem;
with PassierbarkeitspruefungLogik;
with EinheitSuchen;

package body UmgebungErreichbarTesten is
   
   function UmgebungErreichbarTesten
     (AktuelleKoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      IDExtern : in EinheitenDatentypen.EinheitenIDMitNullWert;
      NotwendigeFelderExtern : in Positive)
      return KartenRecords.AchsenKartenfeldNaturalRecord
   is begin
      
      GefundeneFelder := 1;
      Umgebung := 1;
      BereitsGetestet := Umgebung - 1;
      
      BereichSchleife:
      loop
         YAchseSchleife:
         for YÄnderungSchleifenwert in -Umgebung .. Umgebung loop
            XAchseSchleife:
            for XÄnderungSchleifenwert in -Umgebung .. Umgebung loop
               
               KartenWert := Kartenkoordinatenberechnungssystem.Kartenkoordinatenberechnungssystem (KoordinatenExtern => AktuelleKoordinatenExtern,
                                                                                                    ÄnderungExtern    => (0, YÄnderungSchleifenwert, XÄnderungSchleifenwert),
                                                                                                    LogikGrafikExtern => True);
               
               if
                 KartenWert.XAchse = KartenKonstanten.LeerXAchse
               then
                  null;
                  
               elsif
                 (YÄnderungSchleifenwert = 0
                  and
                    XÄnderungSchleifenwert = 0)
                 or
                   (BereitsGetestet >= abs (YÄnderungSchleifenwert)
                    and
                      BereitsGetestet >= abs (XÄnderungSchleifenwert))
               then
                  null;
                  
               elsif
                 True = LeseKarten.BelegterGrund (RasseExtern       => RasseExtern,
                                                  KoordinatenExtern => KartenWert)
                 and
                   EinheitenKonstanten.LeerNummer = EinheitSuchen.KoordinatenEinheitOhneRasseSuchen (KoordinatenExtern => KartenWert,
                                                                                                     LogikGrafikExtern => True).Nummer
                 and
                   True = PassierbarkeitspruefungLogik.PassierbarkeitPrüfenID (RasseExtern           => RasseExtern,
                                                                                IDExtern              => IDExtern,
                                                                                NeueKoordinatenExtern => KartenWert)
                 and
                   True = NochErreichbar (AktuelleKoordinatenExtern => KartenWert,
                                          RasseExtern               => RasseExtern,
                                          IDExtern                  => IDExtern)
                 and
                   GefundeneFelder < NotwendigeFelderExtern
               then
                  GefundeneFelder := GefundeneFelder + 1;
                  
               elsif
                 True = LeseKarten.BelegterGrund (RasseExtern       => RasseExtern,
                                                  KoordinatenExtern => KartenWert)
                 and
                   EinheitenKonstanten.LeerNummer = EinheitSuchen.KoordinatenEinheitOhneRasseSuchen (KoordinatenExtern => KartenWert,
                                                                                                     LogikGrafikExtern => True).Nummer
                 and
                   True = PassierbarkeitspruefungLogik.PassierbarkeitPrüfenID (RasseExtern           => RasseExtern,
                                                                                IDExtern              => IDExtern,
                                                                                NeueKoordinatenExtern => KartenWert)
                 and
                   True = NochErreichbar (AktuelleKoordinatenExtern => KartenWert,
                                          RasseExtern               => RasseExtern,
                                          IDExtern                  => IDExtern)
               then
                  return KartenWert;
                              
               else
                  null;
               end if;
            
            end loop XAchseSchleife;
         end loop YAchseSchleife;
            
         exit BereichSchleife when Umgebung = KartenDatentypen.UmgebungsbereichDrei'Last;
         
         Umgebung := Umgebung + 1;
         BereitsGetestet := Umgebung - 1;
                     
      end loop BereichSchleife;
      
      return KartenRecordKonstanten.LeerKoordinate;
      
   end UmgebungErreichbarTesten;
   
   
   
   function NochErreichbar
     (AktuelleKoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      IDExtern : in EinheitenDatentypen.EinheitenIDMitNullWert)
      return Boolean
   is begin
      
      YAchseSchleife:
      for YAchseSchleifenwert in KartenDatentypen.UmgebungsbereichEins'Range loop
         XAchseSchleife:
         for XAchseSchleifenwert in KartenDatentypen.UmgebungsbereichEins'Range loop
            
            KartenWertZwei := Kartenkoordinatenberechnungssystem.Kartenkoordinatenberechnungssystem (KoordinatenExtern => AktuelleKoordinatenExtern,
                                                                                                     ÄnderungExtern    => (0, YAchseSchleifenwert, XAchseSchleifenwert),
                                                                                                     LogikGrafikExtern => True);
            
            if
              KartenWertZwei.XAchse = KartenKonstanten.LeerXAchse
            then
               null;
               
            elsif
              YAchseSchleifenwert = 0
              and
                XAchseSchleifenwert = 0
            then
               null;
               
            elsif
              True = LeseKarten.BelegterGrund (RasseExtern       => RasseExtern,
                                               KoordinatenExtern => KartenWertZwei)
              and
                True = PassierbarkeitspruefungLogik.PassierbarkeitPrüfenID (RasseExtern           => RasseExtern,
                                                                             IDExtern              => IDExtern,
                                                                             NeueKoordinatenExtern => KartenWertZwei)
            then
               return True;
               
            else
               null;
            end if;
            
         end loop XAchseSchleife;
      end loop YAchseSchleife;
      
      return False;
        
   end NochErreichbar;

end UmgebungErreichbarTesten;
