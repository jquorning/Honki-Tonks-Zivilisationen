pragma SPARK_Mode (On);

with KartenKonstanten;

with SchreibeKarten;
with LeseKarten;

with KartePositionPruefen;

package body KartenGeneratorKueste is

   procedure GenerierungKüstenSeeGewässer
   is begin
      
      YAchseSchleife:
      for YAchseSchleifenwert in Karten.WeltkarteArray'First (2) + KartenKonstanten.Eisrand (Karten.Kartengröße)
        .. Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße - KartenKonstanten.Eisrand (Karten.Kartengröße) loop
         XAchseSchleife:
         for XAchseSchleifenwert in Karten.WeltkarteArray'First (3) .. Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße loop
                              
            case
              LeseKarten.Grund (PositionExtern => (0, YAchseSchleifenwert, XAchseSchleifenwert))
            is
               when KartenDatentypen.Wasser =>
                  GewässerFestlegen (KoordinatenExtern => (0, YAchseSchleifenwert, XAchseSchleifenwert));
                  
               when others =>
                  null;
            end case;
            
         end loop XAchseSchleife;
      end loop YAchseSchleife;
      
   end GenerierungKüstenSeeGewässer;
   
   
   
   procedure GewässerFestlegen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord)
   is begin
      
      YAchseSchleife:
      for YÄnderungSchleifenwert in KartenDatentypen.LoopRangeMinusEinsZuEins'Range loop
         XAchseSchleife:
         for XÄnderungSchleifenwert in KartenDatentypen.LoopRangeMinusEinsZuEins'Range loop
                     
            KartenWert := KartePositionPruefen.KartenPositionBestimmen (KoordinatenExtern => KoordinatenExtern,
                                                                        ÄnderungExtern    => (0, YÄnderungSchleifenwert, XÄnderungSchleifenwert),
                                                                        LogikGrafikExtern => True);
                        
            if
              KartenWert.XAchse = KartenKonstanten.LeerXAchse
            then
               null;
               
            elsif
              LeseKarten.Grund (PositionExtern => KartenWert) /= KartenDatentypen.Flachland
            then
               null;
               
            else
               SchreibeKarten.Grund (KoordinatenExtern => KoordinatenExtern,
                                     GrundExtern       => KartenDatentypen.Küstengewässer);
               return;
            end if;
                        
         end loop XAchseSchleife;
      end loop YAchseSchleife;
      
   end GewässerFestlegen;

end KartenGeneratorKueste;
