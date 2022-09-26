pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KartengrundDatentypen; use KartengrundDatentypen;
with KartenKonstanten;
with EinheitenDatentypen;
with StadtKonstanten;

with SchreibeWeltkarte;
with LeseWeltkarte;
with LeseEinheitenGebaut;
with LeseEinheitenDatenbank;
with LeseStadtGebaut;
  
with KartenkoordinatenberechnungssystemLogik;
with EinheitSuchenLogik;
with KennenlernenLogik;

package body SichtbarkeitLogik is

   -- Einfach immer die Quadranden durchlaufen? Dann müsste mehr gerechnet werden ist aber einfacher zu Programmieren. äöü
   -- geht nicht so einfach, da die Einheitenpassierbarkeit dann nicht korrekt auf Luft/Weltraum geprüft wird. äöü
   procedure SichtbarkeitsprüfungFürEinheit
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
   is begin
      
      SichtweiteObjekt := SichtweiteErmitteln (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      
      case
        SichtweiteObjekt
      is
         when KartenDatentypen.Sichtweite'First =>
            SichtbarkeitsprüfungOhneBlockade (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                               SichtweiteExtern         => SichtweiteObjekt);
            return;
            
         when 3 =>
            if
              (True = LeseEinheitenDatenbank.Passierbarkeit (RasseExtern          => EinheitRasseNummerExtern.Rasse,
                                                             IDExtern             => LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => EinheitRasseNummerExtern),
                                                             WelcheUmgebungExtern => EinheitenDatentypen.Luft_Enum)
               or
                 True = LeseEinheitenDatenbank.Passierbarkeit (RasseExtern          => EinheitRasseNummerExtern.Rasse,
                                                               IDExtern             => LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => EinheitRasseNummerExtern),
                                                               WelcheUmgebungExtern => EinheitenDatentypen.Weltraum_Enum))
              and
                LeseEinheitenGebaut.Koordinaten (EinheitRasseNummerExtern => EinheitRasseNummerExtern).EAchse >= 0
            then
               SichtbarkeitsprüfungOhneBlockade (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                  SichtweiteExtern         => SichtweiteObjekt);
               return;
               
            else
               null;
            end if;
            
         when others =>
            null;
      end case;

      QuadrantenDurchlaufen (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      
   end SichtbarkeitsprüfungFürEinheit;
   
   
   
   function SichtweiteErmitteln
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return KartenDatentypen.Sichtweite
   is begin
      
      KoordinatenEinheit := LeseEinheitenGebaut.Koordinaten (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
            
      if
        (True = LeseEinheitenDatenbank.Passierbarkeit (RasseExtern          => EinheitRasseNummerExtern.Rasse,
                                                       IDExtern             => LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => EinheitRasseNummerExtern),
                                                       WelcheUmgebungExtern => EinheitenDatentypen.Luft_Enum)
         or
           True = LeseEinheitenDatenbank.Passierbarkeit (RasseExtern          => EinheitRasseNummerExtern.Rasse,
                                                         IDExtern             => LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => EinheitRasseNummerExtern),
                                                         WelcheUmgebungExtern => EinheitenDatentypen.Weltraum_Enum))
        and
          KoordinatenEinheit.EAchse >= 0
      then
         return 3;
         
      else
         AktuellerGrund := LeseWeltkarte.AktuellerGrund (KoordinatenExtern => KoordinatenEinheit);
         BasisGrund := LeseWeltkarte.BasisGrund (KoordinatenExtern => KoordinatenEinheit);
      end if;
      
      if
        AktuellerGrund = KartengrundDatentypen.Gebirge_Enum
        or
          AktuellerGrund = KartengrundDatentypen.Hügel_Enum
          or
            BasisGrund = KartengrundDatentypen.Gebirge_Enum
            or
              BasisGrund = KartengrundDatentypen.Hügel_Enum
      then
         return 3;

      elsif
        AktuellerGrund = KartengrundDatentypen.Dschungel_Enum
        or
          AktuellerGrund = KartengrundDatentypen.Sumpf_Enum
          or
            AktuellerGrund = KartengrundDatentypen.Wald_Enum
      then
         return 1;
               
      else
         return 2;
      end if;
      
   end SichtweiteErmitteln;
   
   
   
   -- Das hier Parallelisieren? äöü
   procedure QuadrantenDurchlaufen
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
   is begin
      
      Einheitenkoordinaten := LeseEinheitenGebaut.Koordinaten (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      
      -- Das berücksichtigt noch nicht die Durchsichtigkeit von Wasser, später noch einbauen. äöü
      case
        Einheitenkoordinaten.EAchse
      is
         when 0 =>
            EAchseAnfang := 0;
            EAchseEnde := 1;
            
         when 1 =>
            EAchseAnfang := -1;
            EAchseEnde := 1;
            
         when 2 =>
            EAchseAnfang := -1;
            EAchseEnde := 0;
            
         when others =>
            EAchseAnfang := 0;
            EAchseEnde := 0;
      end case;
      
      EAchseSchleife:
      for EAchseSchleifenwert in EAchseAnfang .. EAchseEnde loop
         YQuadrantSchleife:
         for YQuadrantSchleifenwert in 0 .. SichtweiteObjekt loop
            XQuadrantSchleife:
            for XQuadrantSchleifenwert in 0 .. SichtweiteObjekt loop
            
               QuadrantEins (EinheitRasseNummerExtern  => EinheitRasseNummerExtern,
                             SichtweiteYRichtungExtern => YQuadrantSchleifenwert,
                             SichtweiteXRichtungExtern => XQuadrantSchleifenwert,
                             SichtweiteERichtungExtern => EAchseSchleifenwert,
                             SichtweiteMaximalExtern   => SichtweiteObjekt);
            
               case
                 YQuadrantSchleifenwert
               is
                  when 0 =>
                     null;
                  
                  when others =>
                     QuadrantZwei (EinheitRasseNummerExtern  => EinheitRasseNummerExtern,
                                   SichtweiteYRichtungExtern => YQuadrantSchleifenwert,
                                   SichtweiteXRichtungExtern => XQuadrantSchleifenwert,
                                   SichtweiteERichtungExtern => EAchseSchleifenwert,
                                   SichtweiteMaximalExtern   => SichtweiteObjekt);
               end case;
      
               case
                 XQuadrantSchleifenwert
               is
                  when 0 =>
                     null;
                  
                  when others =>
                     QuadrantDrei (EinheitRasseNummerExtern  => EinheitRasseNummerExtern,
                                   SichtweiteYRichtungExtern => YQuadrantSchleifenwert,
                                   SichtweiteXRichtungExtern => XQuadrantSchleifenwert,
                                   SichtweiteERichtungExtern => EAchseSchleifenwert,
                                   SichtweiteMaximalExtern   => SichtweiteObjekt);
               end case;
      
               if
                 YQuadrantSchleifenwert = 0
                 and
                   XQuadrantSchleifenwert = 0
               then
                  null;
               
               else
                  QuadrantVier (EinheitRasseNummerExtern  => EinheitRasseNummerExtern,
                                SichtweiteYRichtungExtern => YQuadrantSchleifenwert,
                                SichtweiteXRichtungExtern => XQuadrantSchleifenwert,
                                SichtweiteERichtungExtern => EAchseSchleifenwert,
                                SichtweiteMaximalExtern   => SichtweiteObjekt);
               end if;
            
            end loop XQuadrantSchleife;
         end loop YQuadrantSchleife;
      end loop EAchseSchleife;
      
   end QuadrantenDurchlaufen;
   
   
   
   procedure QuadrantEins
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      SichtweiteYRichtungExtern : in KartenDatentypen.SichtweiteNatural;
      SichtweiteXRichtungExtern : in KartenDatentypen.SichtweiteNatural;
      SichtweiteERichtungExtern : in KartenDatentypen.EbeneVorhanden;
      SichtweiteMaximalExtern : in KartenDatentypen.Sichtweite)
   is begin
              
      KartenQuadrantWert := KartenkoordinatenberechnungssystemLogik.Kartenkoordinatenberechnungssystem (KoordinatenExtern => LeseEinheitenGebaut.Koordinaten (EinheitRasseNummerExtern => EinheitRasseNummerExtern),
                                                                                                        ÄnderungExtern    => (SichtweiteERichtungExtern, -SichtweiteYRichtungExtern, SichtweiteXRichtungExtern),
                                                                                                        LogikGrafikExtern => True);
            
      if
        KartenQuadrantWert.XAchse = KartenKonstanten.LeerXAchse
      then
         null;
               
      elsif
        SichtweiteYRichtungExtern <= 1
        and
          SichtweiteXRichtungExtern <= 1
      then
         SichtbarkeitSetzen (RasseExtern       => EinheitRasseNummerExtern.Rasse,
                             KoordinatenExtern => KartenQuadrantWert);
               
      elsif
        SichtweiteYRichtungExtern in 2 .. 3
        and
          SichtweiteXRichtungExtern <= 1
      then
         YÄnderungSchleife:
         for YÄnderungSchleifenwert in 2 .. SichtweiteYRichtungExtern loop
            XÄnderungSchleife:
            for XÄnderungSchleifenwert in 0 .. SichtweiteXRichtungExtern loop
                    
               if
                 False = SichtbarkeitBlockadeTesten (KoordinatenExtern => KartenQuadrantWert,
                                                     YÄnderungExtern   => YÄnderungSchleifenwert - 1,
                                                     XÄnderungExtern   => -XÄnderungSchleifenwert,
                                                     SichtweiteExtern  => SichtweiteMaximalExtern)
               then
                  exit YÄnderungSchleife;
                        
               elsif
                 YÄnderungSchleifenwert = SichtweiteYRichtungExtern
                 and
                   XÄnderungSchleifenwert = SichtweiteXRichtungExtern
               then
                  SichtbarkeitSetzen (RasseExtern       => EinheitRasseNummerExtern.Rasse,
                                      KoordinatenExtern => KartenQuadrantWert);
                        
               else
                  null;
               end if;
                     
            end loop XÄnderungSchleife;
         end loop YÄnderungSchleife;
               
      elsif
        SichtweiteYRichtungExtern <= 1
        and
          SichtweiteXRichtungExtern in 2 .. 3
      then
         YÄnderungSchleife22:
         for YÄnderungSchleifenwert in 0 .. SichtweiteYRichtungExtern loop
            XÄnderungSchleife22:
            for XÄnderungSchleifenwert in 2 .. SichtweiteXRichtungExtern loop
                                 
               if
                 False = SichtbarkeitBlockadeTesten (KoordinatenExtern => KartenQuadrantWert,
                                                     YÄnderungExtern   => YÄnderungSchleifenwert,
                                                     XÄnderungExtern   => -XÄnderungSchleifenwert + 1,
                                                     SichtweiteExtern  => SichtweiteMaximalExtern)
               then
                  exit YÄnderungSchleife22;
                        
               elsif
                 YÄnderungSchleifenwert = SichtweiteYRichtungExtern
                 and
                   XÄnderungSchleifenwert = SichtweiteXRichtungExtern
               then
                  SichtbarkeitSetzen (RasseExtern       => EinheitRasseNummerExtern.Rasse,
                                      KoordinatenExtern => KartenQuadrantWert);
                        
               else
                  null;
               end if;
                     
            end loop XÄnderungSchleife22;
         end loop YÄnderungSchleife22;
               
      else
         YÄnderungSchleife333:
         for YÄnderungSchleifenwert in 2 .. SichtweiteYRichtungExtern loop
            XÄnderungSchleife333:
            for XÄnderungSchleifenwert in 2 .. SichtweiteXRichtungExtern loop
                     
               if
                 False = SichtbarkeitBlockadeTesten (KoordinatenExtern => KartenQuadrantWert,
                                                     YÄnderungExtern   => YÄnderungSchleifenwert - 1,
                                                     XÄnderungExtern   => -XÄnderungSchleifenwert + 1,
                                                     SichtweiteExtern  => SichtweiteMaximalExtern)
               then
                  exit YÄnderungSchleife333;
                        
               elsif
                 YÄnderungSchleifenwert = SichtweiteYRichtungExtern
                 and
                   XÄnderungSchleifenwert = SichtweiteXRichtungExtern
               then
                  SichtbarkeitSetzen (RasseExtern       => EinheitRasseNummerExtern.Rasse,
                                      KoordinatenExtern => KartenQuadrantWert);
                        
               else
                  null;
               end if;
                     
            end loop XÄnderungSchleife333;
         end loop YÄnderungSchleife333;
      end if;
      
   end QuadrantEins;
   
   
   
   procedure QuadrantZwei
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      SichtweiteYRichtungExtern : in KartenDatentypen.SichtweiteNatural;
      SichtweiteXRichtungExtern : in KartenDatentypen.SichtweiteNatural;
      SichtweiteERichtungExtern : in KartenDatentypen.EbeneVorhanden;
      SichtweiteMaximalExtern : in KartenDatentypen.Sichtweite)
   is begin
                    
      KartenQuadrantWert := KartenkoordinatenberechnungssystemLogik.Kartenkoordinatenberechnungssystem (KoordinatenExtern => LeseEinheitenGebaut.Koordinaten (EinheitRasseNummerExtern => EinheitRasseNummerExtern),
                                                                                                        ÄnderungExtern    => (SichtweiteERichtungExtern, SichtweiteYRichtungExtern, SichtweiteXRichtungExtern),
                                                                                                        LogikGrafikExtern => True);
            
      if
        KartenQuadrantWert.XAchse = KartenKonstanten.LeerXAchse
      then
         null;
               
      elsif
        SichtweiteYRichtungExtern <= 1
        and
          SichtweiteXRichtungExtern <= 1
      then
         SichtbarkeitSetzen (RasseExtern       => EinheitRasseNummerExtern.Rasse,
                             KoordinatenExtern => KartenQuadrantWert);
               
      elsif
        SichtweiteYRichtungExtern in 2 .. 3
        and
          SichtweiteXRichtungExtern <= 1
      then
         YÄnderungSchleife:
         for YÄnderungSchleifenwert in 2 .. SichtweiteYRichtungExtern loop
            XÄnderungSchleife:
            for XÄnderungSchleifenwert in 0 .. SichtweiteXRichtungExtern loop
                                         
               if
                 False = SichtbarkeitBlockadeTesten (KoordinatenExtern => KartenQuadrantWert,
                                                     YÄnderungExtern   => -YÄnderungSchleifenwert + 1,
                                                     XÄnderungExtern   => -XÄnderungSchleifenwert,
                                                     SichtweiteExtern  => SichtweiteMaximalExtern)
               then
                  exit YÄnderungSchleife;
                        
               elsif
                 YÄnderungSchleifenwert = SichtweiteYRichtungExtern
                 and
                   XÄnderungSchleifenwert = SichtweiteXRichtungExtern
               then
                  SichtbarkeitSetzen (RasseExtern       => EinheitRasseNummerExtern.Rasse,
                                      KoordinatenExtern => KartenQuadrantWert);
                        
               else
                  null;
               end if;
                     
            end loop XÄnderungSchleife;
         end loop YÄnderungSchleife;
               
      elsif
        SichtweiteYRichtungExtern <= 1
        and
          SichtweiteXRichtungExtern in 2 .. 3
      then
         YÄnderungSchleife22:
         for YÄnderungSchleifenwert in 0 .. SichtweiteYRichtungExtern loop
            XÄnderungSchleife22:
            for XÄnderungSchleifenwert in 2 .. SichtweiteXRichtungExtern loop
                                 
               if
                 False = SichtbarkeitBlockadeTesten (KoordinatenExtern => KartenQuadrantWert,
                                                     YÄnderungExtern   => -YÄnderungSchleifenwert,
                                                     XÄnderungExtern   => -XÄnderungSchleifenwert + 1,
                                                     SichtweiteExtern  => SichtweiteMaximalExtern)
               then
                  exit YÄnderungSchleife22;
                        
               elsif
                 YÄnderungSchleifenwert = SichtweiteYRichtungExtern
                 and
                   XÄnderungSchleifenwert = SichtweiteXRichtungExtern
               then
                  SichtbarkeitSetzen (RasseExtern       => EinheitRasseNummerExtern.Rasse,
                                      KoordinatenExtern => KartenQuadrantWert);
                        
               else
                  null;
               end if;
                     
            end loop XÄnderungSchleife22;
         end loop YÄnderungSchleife22;
               
      else
         YÄnderungSchleife333:
         for YÄnderungSchleifenwert in 2 .. SichtweiteYRichtungExtern loop
            XÄnderungSchleife333:
            for XÄnderungSchleifenwert in 2 .. SichtweiteXRichtungExtern loop
                     
               if
                 False = SichtbarkeitBlockadeTesten (KoordinatenExtern => KartenQuadrantWert,
                                                     YÄnderungExtern   => -YÄnderungSchleifenwert + 1,
                                                     XÄnderungExtern   => -XÄnderungSchleifenwert + 1,
                                                     SichtweiteExtern  => SichtweiteMaximalExtern)
               then
                  exit YÄnderungSchleife333;
                        
               elsif
                 YÄnderungSchleifenwert = SichtweiteYRichtungExtern
                 and
                   XÄnderungSchleifenwert = SichtweiteXRichtungExtern
               then
                  SichtbarkeitSetzen (RasseExtern       => EinheitRasseNummerExtern.Rasse,
                                      KoordinatenExtern => KartenQuadrantWert);
                        
               else
                  null;
               end if;
                     
            end loop XÄnderungSchleife333;
         end loop YÄnderungSchleife333;
      end if;
                  
   end QuadrantZwei;
   
   
   
   procedure QuadrantDrei
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      SichtweiteYRichtungExtern : in KartenDatentypen.SichtweiteNatural;
      SichtweiteXRichtungExtern : in KartenDatentypen.SichtweiteNatural;
      SichtweiteERichtungExtern : in KartenDatentypen.EbeneVorhanden;
      SichtweiteMaximalExtern : in KartenDatentypen.Sichtweite)
   is begin
                    
      KartenQuadrantWert := KartenkoordinatenberechnungssystemLogik.Kartenkoordinatenberechnungssystem (KoordinatenExtern => LeseEinheitenGebaut.Koordinaten (EinheitRasseNummerExtern => EinheitRasseNummerExtern),
                                                                                                        ÄnderungExtern    => (SichtweiteERichtungExtern, SichtweiteYRichtungExtern, -SichtweiteXRichtungExtern),
                                                                                                        LogikGrafikExtern => True);
            
      if
        KartenQuadrantWert.XAchse = KartenKonstanten.LeerXAchse
      then
         null;
               
      elsif
        SichtweiteYRichtungExtern <= 1
        and
          SichtweiteXRichtungExtern <= 1
      then
         SichtbarkeitSetzen (RasseExtern       => EinheitRasseNummerExtern.Rasse,
                             KoordinatenExtern => KartenQuadrantWert);
               
      elsif
        SichtweiteYRichtungExtern in 2 .. 3
        and
          SichtweiteXRichtungExtern <= 1
      then
         YÄnderungSchleife:
         for YÄnderungSchleifenwert in 2 .. SichtweiteYRichtungExtern loop
            XÄnderungSchleife:
            for XÄnderungSchleifenwert in 0 .. SichtweiteXRichtungExtern loop
                    
               if
                 False = SichtbarkeitBlockadeTesten (KoordinatenExtern => KartenQuadrantWert,
                                                     YÄnderungExtern   => -YÄnderungSchleifenwert + 1,
                                                     XÄnderungExtern   => XÄnderungSchleifenwert,
                                                     SichtweiteExtern  => SichtweiteMaximalExtern)
               then
                  exit YÄnderungSchleife;
                        
               elsif
                 YÄnderungSchleifenwert = SichtweiteYRichtungExtern
                 and
                   XÄnderungSchleifenwert = SichtweiteXRichtungExtern
               then
                  SichtbarkeitSetzen (RasseExtern       => EinheitRasseNummerExtern.Rasse,
                                      KoordinatenExtern => KartenQuadrantWert);
                        
               else
                  null;
               end if;
                     
            end loop XÄnderungSchleife;
         end loop YÄnderungSchleife;
               
      elsif
        SichtweiteYRichtungExtern <= 1
        and
          SichtweiteXRichtungExtern in 2 .. 3
      then
         YÄnderungSchleife22:
         for YÄnderungSchleifenwert in 0 .. SichtweiteYRichtungExtern loop
            XÄnderungSchleife22:
            for XÄnderungSchleifenwert in 2 .. SichtweiteXRichtungExtern loop
               
               if
                 False = SichtbarkeitBlockadeTesten (KoordinatenExtern => KartenQuadrantWert,
                                                     YÄnderungExtern   => -YÄnderungSchleifenwert,
                                                     XÄnderungExtern   => XÄnderungSchleifenwert - 1,
                                                     SichtweiteExtern  => SichtweiteMaximalExtern)
               then
                  exit YÄnderungSchleife22;
                        
               elsif
                 YÄnderungSchleifenwert = SichtweiteYRichtungExtern
                 and
                   XÄnderungSchleifenwert = SichtweiteXRichtungExtern
               then
                  SichtbarkeitSetzen (RasseExtern       => EinheitRasseNummerExtern.Rasse,
                                      KoordinatenExtern => KartenQuadrantWert);
                        
               else
                  null;
               end if;
                     
            end loop XÄnderungSchleife22;
         end loop YÄnderungSchleife22;
               
      else
         YÄnderungSchleife333:
         for YÄnderungSchleifenwert in 2 .. SichtweiteYRichtungExtern loop
            XÄnderungSchleife333:
            for XÄnderungSchleifenwert in 2 .. SichtweiteXRichtungExtern loop
                                       
               if
                 False = SichtbarkeitBlockadeTesten (KoordinatenExtern => KartenQuadrantWert,
                                                     YÄnderungExtern   => -YÄnderungSchleifenwert + 1,
                                                     XÄnderungExtern   => XÄnderungSchleifenwert - 1,
                                                     SichtweiteExtern  => SichtweiteMaximalExtern)
               then
                  exit YÄnderungSchleife333;
                        
               elsif
                 YÄnderungSchleifenwert = SichtweiteYRichtungExtern
                 and
                   XÄnderungSchleifenwert = SichtweiteXRichtungExtern
               then
                  SichtbarkeitSetzen (RasseExtern       => EinheitRasseNummerExtern.Rasse,
                                      KoordinatenExtern => KartenQuadrantWert);
                        
               else
                  null;
               end if;
                     
            end loop XÄnderungSchleife333;
         end loop YÄnderungSchleife333;
      end if;
                  
   end QuadrantDrei;
   
   
   
   procedure QuadrantVier
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      SichtweiteYRichtungExtern : in KartenDatentypen.SichtweiteNatural;
      SichtweiteXRichtungExtern : in KartenDatentypen.SichtweiteNatural;
      SichtweiteERichtungExtern : in KartenDatentypen.EbeneVorhanden;
      SichtweiteMaximalExtern : in KartenDatentypen.Sichtweite)
   is begin
                    
      KartenQuadrantWert := KartenkoordinatenberechnungssystemLogik.Kartenkoordinatenberechnungssystem (KoordinatenExtern => LeseEinheitenGebaut.Koordinaten (EinheitRasseNummerExtern => EinheitRasseNummerExtern),
                                                                                                        ÄnderungExtern    => (SichtweiteERichtungExtern, -SichtweiteYRichtungExtern, -SichtweiteXRichtungExtern),
                                                                                                        LogikGrafikExtern => True);
            
      if
        KartenQuadrantWert.XAchse = KartenKonstanten.LeerXAchse
      then
         null;
               
      elsif
        SichtweiteYRichtungExtern <= 1
        and
          SichtweiteXRichtungExtern <= 1
      then
         SichtbarkeitSetzen (RasseExtern       => EinheitRasseNummerExtern.Rasse,
                             KoordinatenExtern => KartenQuadrantWert);
               
      elsif
        SichtweiteYRichtungExtern in 2 .. 3
        and
          SichtweiteXRichtungExtern <= 1
      then
         YÄnderungSchleife:
         for YÄnderungSchleifenwert in 2 .. SichtweiteYRichtungExtern loop
            XÄnderungSchleife:
            for XÄnderungSchleifenwert in 0 .. SichtweiteXRichtungExtern loop
               
               if
                 False = SichtbarkeitBlockadeTesten (KoordinatenExtern => KartenQuadrantWert,
                                                     YÄnderungExtern   => YÄnderungSchleifenwert - 1,
                                                     XÄnderungExtern   => XÄnderungSchleifenwert,
                                                     SichtweiteExtern  => SichtweiteMaximalExtern)
               then
                  exit YÄnderungSchleife;
                        
               elsif
                 YÄnderungSchleifenwert = SichtweiteYRichtungExtern
                 and
                   XÄnderungSchleifenwert = SichtweiteXRichtungExtern
               then
                  SichtbarkeitSetzen (RasseExtern       => EinheitRasseNummerExtern.Rasse,
                                      KoordinatenExtern => KartenQuadrantWert);
                        
               else
                  null;
               end if;
                     
            end loop XÄnderungSchleife;
         end loop YÄnderungSchleife;
               
      elsif
        SichtweiteYRichtungExtern <= 1
        and
          SichtweiteXRichtungExtern in 2 .. 3
      then
         YÄnderungSchleife22:
         for YÄnderungSchleifenwert in 0 .. SichtweiteYRichtungExtern loop
            XÄnderungSchleife22:
            for XÄnderungSchleifenwert in 2 .. SichtweiteXRichtungExtern loop
               
               if
                 False = SichtbarkeitBlockadeTesten (KoordinatenExtern => KartenQuadrantWert,
                                                     YÄnderungExtern   => YÄnderungSchleifenwert,
                                                     XÄnderungExtern   => XÄnderungSchleifenwert - 1,
                                                     SichtweiteExtern  => SichtweiteMaximalExtern)
               then
                  exit YÄnderungSchleife22;
                  
               elsif
                 YÄnderungSchleifenwert = SichtweiteYRichtungExtern
                 and
                   XÄnderungSchleifenwert = SichtweiteXRichtungExtern
               then
                  SichtbarkeitSetzen (RasseExtern       => EinheitRasseNummerExtern.Rasse,
                                      KoordinatenExtern => KartenQuadrantWert);
                        
               else
                  null;
               end if;
                     
            end loop XÄnderungSchleife22;
         end loop YÄnderungSchleife22;
               
      else
         YÄnderungSchleife333:
         for YÄnderungSchleifenwert in 2 .. SichtweiteYRichtungExtern loop
            XÄnderungSchleife333:
            for XÄnderungSchleifenwert in 2 .. SichtweiteXRichtungExtern loop
                     
               if
                 False = SichtbarkeitBlockadeTesten (KoordinatenExtern => KartenQuadrantWert,
                                                     YÄnderungExtern   => YÄnderungSchleifenwert - 1,
                                                     XÄnderungExtern   => XÄnderungSchleifenwert - 1,
                                                     SichtweiteExtern  => SichtweiteMaximalExtern)
               then
                  exit YÄnderungSchleife333;
                        
               elsif
                 YÄnderungSchleifenwert = SichtweiteYRichtungExtern
                 and
                   XÄnderungSchleifenwert = SichtweiteXRichtungExtern
               then
                  SichtbarkeitSetzen (RasseExtern       => EinheitRasseNummerExtern.Rasse,
                                      KoordinatenExtern => KartenQuadrantWert);
                        
               else
                  null;
               end if;
                     
            end loop XÄnderungSchleife333;
         end loop YÄnderungSchleife333;
      end if;
                  
   end QuadrantVier;
   
   
   
   function SichtbarkeitBlockadeTesten
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      YÄnderungExtern : in KartenDatentypen.UmgebungsbereichZwei;
      XÄnderungExtern : in KartenDatentypen.UmgebungsbereichZwei;
      SichtweiteExtern : in KartenDatentypen.UmgebungsbereichDrei)
      return Boolean
   is begin
      
      KartenBlockadeWert := KartenkoordinatenberechnungssystemLogik.Kartenkoordinatenberechnungssystem (KoordinatenExtern => KoordinatenExtern,
                                                                                                        ÄnderungExtern    => (0, YÄnderungExtern, XÄnderungExtern),
                                                                                                        LogikGrafikExtern => True);
      
      if
        KartenBlockadeWert.XAchse = KartenKonstanten.LeerXAchse
      then
         return True;
         
      else
         AktuellerGrund := LeseWeltkarte.AktuellerGrund (KoordinatenExtern => KartenBlockadeWert);
         BasisGrund := LeseWeltkarte.AktuellerGrund (KoordinatenExtern => KartenBlockadeWert);
      end if;
         
      if
        AktuellerGrund = KartengrundDatentypen.Gebirge_Enum
        or
          AktuellerGrund = KartengrundDatentypen.Hügel_Enum
          or
            BasisGrund = KartengrundDatentypen.Gebirge_Enum
            or
              BasisGrund = KartengrundDatentypen.Hügel_Enum
              or
                (SichtweiteExtern /= 3
                 and
                   (AktuellerGrund = KartengrundDatentypen.Dschungel_Enum
                    or
                      AktuellerGrund = KartengrundDatentypen.Sumpf_Enum
                    or
                      AktuellerGrund = KartengrundDatentypen.Wald_Enum))
      then
         return False;
         
      else
         return True;
      end if;
            
   end SichtbarkeitBlockadeTesten;
   
   
   
   procedure SichtbarkeitsprüfungOhneBlockade
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      SichtweiteExtern : in KartenDatentypen.Sichtweite)
   is begin
      
      Einheitenkoordinaten := LeseEinheitenGebaut.Koordinaten (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      
      -- Das berücksichtigt noch nicht die Durchsichtigkeit von Wasser, später noch einbauen. äöü
      case
        Einheitenkoordinaten.EAchse
      is
         when 0 =>
            EAchseAnfang := 0;
            EAchseEnde := 1;
            
         when 1 =>
            EAchseAnfang := -1;
            EAchseEnde := 1;
            
         when 2 =>
            EAchseAnfang := -1;
            EAchseEnde := 0;
            
         when others =>
            EAchseAnfang := 0;
            EAchseEnde := 0;
      end case;
            
      EAchseSchleife:
      for EAchseSchleifenwert in EAchseAnfang .. EAchseEnde loop
         YAchseSchleife:
         for YAchseSchleifenwert in -SichtweiteExtern .. SichtweiteExtern loop
            XAchseSchleife:
            for XAchseSchleifenwert in -SichtweiteExtern .. SichtweiteExtern loop
            
               KartenWert := KartenkoordinatenberechnungssystemLogik.Kartenkoordinatenberechnungssystem (KoordinatenExtern => Einheitenkoordinaten,
                                                                                                         ÄnderungExtern    => (EAchseSchleifenwert, YAchseSchleifenwert, XAchseSchleifenwert),
                                                                                                         LogikGrafikExtern => True);
            
               case
                 KartenWert.XAchse
               is
                  when KartenKonstanten.LeerXAchse =>
                     null;
                  
                  when others =>
                     SichtbarkeitSetzen (RasseExtern       => EinheitRasseNummerExtern.Rasse,
                                         KoordinatenExtern => KartenWert);
               end case;
               
            end loop XAchseSchleife;
         end loop YAchseSchleife;
      end loop EAchseSchleife;
      
   end SichtbarkeitsprüfungOhneBlockade;
   
   

   procedure SichtbarkeitsprüfungFürStadt
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord)
   is begin
      
      SichtweiteObjekt := LeseStadtGebaut.UmgebungGröße (StadtRasseNummerExtern => StadtRasseNummerExtern) + 1;
      Stadtkoordinaten := LeseStadtGebaut.Koordinaten (StadtRasseNummerExtern => StadtRasseNummerExtern);
      
      -- Das berücksichtigt noch nicht die Durchsichtigkeit von Wasser, später noch einbauen. äöü
      case
        Stadtkoordinaten.EAchse
      is
         when 0 =>
            EAchseAnfang := 0;
            EAchseEnde := 1;
            
         when 1 =>
            EAchseAnfang := -1;
            EAchseEnde := 1;
            
         when 2 =>
            EAchseAnfang := -1;
            EAchseEnde := 0;
            
         when others =>
            EAchseAnfang := 0;
            EAchseEnde := 0;
      end case;
            
      EAchseSchleife:
      for EAchseSchleifenwert in EAchseAnfang .. EAchseEnde loop
         YAchseSchleife:
         for YAchseSchleifenwert in -SichtweiteObjekt .. SichtweiteObjekt loop
            XAchseSchleife:
            for XAchseSchleifenwert in -SichtweiteObjekt .. SichtweiteObjekt loop
            
               KartenWert := KartenkoordinatenberechnungssystemLogik.Kartenkoordinatenberechnungssystem (KoordinatenExtern => Stadtkoordinaten,
                                                                                                         ÄnderungExtern    => (EAchseSchleifenwert, YAchseSchleifenwert, XAchseSchleifenwert),
                                                                                                         LogikGrafikExtern => True);
            
               case
                 KartenWert.XAchse
               is
                  when KartenKonstanten.LeerXAchse =>
                     null;
                  
                  when others =>
                     SichtbarkeitSetzen (RasseExtern       => StadtRasseNummerExtern.Rasse,
                                         KoordinatenExtern => KartenWert);
               end case;
                        
            end loop XAchseSchleife;
         end loop YAchseSchleife;
      end loop EAchseSchleife;
      
   end SichtbarkeitsprüfungFürStadt;
   
   
   
   procedure SichtbarkeitSetzen
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
   is begin
      
      -- Die Kontaktsichtbarkeitsprüfung aus BewegungBerechnen kann hier nicht reingebaut werden, da dann jedes neu sichtbare Feld geprüft wird ob die anderen Rassen das sehen.
      -- Und nicht nur für das Feld auf dem die Einheit dann steht.
      
      case
        LeseWeltkarte.Sichtbar (KoordinatenExtern => KoordinatenExtern,
                                RasseExtern       => RasseExtern)
      is
         when True =>
            return;
            
         when False =>
            SchreibeWeltkarte.Sichtbar (KoordinatenExtern => KoordinatenExtern,
                                        RasseExtern       => RasseExtern,
                                        SichtbarExtern    => True);
      end case;
      
      FremdeEinheit := EinheitSuchenLogik.KoordinatenEinheitOhneSpezielleRasseSuchen (RasseExtern       => RasseExtern,
                                                                                      KoordinatenExtern => KoordinatenExtern,
                                                                                      LogikGrafikExtern => True);
      
      case
        FremdeEinheit.Rasse
      is
         when StadtKonstanten.LeerRasse =>
            null;
            
         when others =>
            KennenlernenLogik.Erstkontakt (EigeneRasseExtern => RasseExtern,
                                           FremdeRasseExtern => FremdeEinheit.Rasse);
            return;
      end case;
      
      FremdeStadt := LeseWeltkarte.StadtbelegungGrund (KoordinatenExtern => KoordinatenExtern);
      
      if
        FremdeStadt.Rasse = RassenDatentypen.Keine_Rasse_Enum
        or
          FremdeStadt.Rasse = RasseExtern
      then
         null;
            
      else
         KennenlernenLogik.Erstkontakt (EigeneRasseExtern => RasseExtern,
                                        FremdeRasseExtern => FremdeStadt.Rasse);
      end if;
      
   end SichtbarkeitSetzen;
   
end SichtbarkeitLogik;
