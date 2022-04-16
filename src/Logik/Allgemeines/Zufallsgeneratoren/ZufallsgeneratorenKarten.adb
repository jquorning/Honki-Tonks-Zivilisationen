pragma SPARK_Mode (Off);
pragma Warnings (Off, "*array aggregate*");

with KartenGrundDatentypen; use KartenGrundDatentypen;

with LeseKarten;

with BewegungPassierbarkeitPruefen;

package body ZufallsgeneratorenKarten is

   function StartPosition
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return KartenRecords.AchsenKartenfeldPositivRecord
   is begin
      
      EAchse := StartPositionEAchse (RasseExtern => RasseExtern);
      
      PositionBestimmenSchleife:
      loop
         
         YXAchsen := StartPunkteYXFestlegen;
         
         if
           BewegungPassierbarkeitPruefen.PassierbarkeitPrüfenID (RasseExtern           => RasseExtern,
                                                                  IDExtern              => 1,
                                                                  NeueKoordinatenExtern => (EAchse, YXAchsen.YAchse, YXAchsen.XAchse))
             = True
           and
             LeseKarten.Grund (KoordinatenExtern => (EAchse, YXAchsen.YAchse, YXAchsen.XAchse)) /= KartenGrundDatentypen.Eis_Enum
         then
            return (EAchse, YXAchsen.YAchse, YXAchsen.XAchse);
               
         else
            null;
         end if;
         
      end loop PositionBestimmenSchleife;
      
   end StartPosition;
   
   
   
   function StartPositionEAchse
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return KartenDatentypen.EbeneVorhanden
   is begin
      
      case
        RasseExtern
      is
         when RassenDatentypen.Talbidahr_Enum | RassenDatentypen.Tesorahn_Enum =>
            -- Nutzen aktuell noch eine modifizierte Menschendatenbank, sollte aber für Testzwecke schon einmal funktionieren.
            return -1;
            
         when others =>
            return 0;
      end case;
      
   end StartPositionEAchse;
   
   
   
   function StartPunkteYXFestlegen
     return KartenRecords.YXAchsenKartenfeldPositivRecord
   is begin
      
      case
        Karten.Kartenparameter.Kartengröße
      is
         when KartenDatentypen.Kartengröße_20_20_Enum =>
            WerteWählen20.Reset (PositionGewählt20);
            YAchse := WerteWählen20.Random (PositionGewählt20);
            XAchse := WerteWählen20.Random (PositionGewählt20);

         when KartenDatentypen.Kartengröße_40_40_Enum =>
            WerteWählen40.Reset (PositionGewählt40);
            YAchse := WerteWählen40.Random (PositionGewählt40);
            XAchse := WerteWählen40.Random (PositionGewählt40);
            
         when KartenDatentypen.Kartengröße_80_80_Enum =>
            WerteWählen80.Reset (PositionGewählt80);
            YAchse := WerteWählen80.Random (PositionGewählt80);
            XAchse := WerteWählen80.Random (PositionGewählt80);
            
         when KartenDatentypen.Kartengröße_120_80_Enum =>
            WerteWählen80.Reset (PositionGewählt80);
            WerteWählen120.Reset (PositionGewählt120);
            YAchse := WerteWählen120.Random (PositionGewählt120);
            XAchse := WerteWählen80.Random (PositionGewählt80);
            
         when KartenDatentypen.Kartengröße_120_160_Enum =>
            WerteWählen120.Reset (PositionGewählt120);
            WerteWählen160.Reset (PositionGewählt160);
            YAchse := WerteWählen120.Random (PositionGewählt120);
            XAchse := WerteWählen160.Random (PositionGewählt160);
            
         when KartenDatentypen.Kartengröße_160_160_Enum =>
            WerteWählen160.Reset (PositionGewählt160);
            YAchse := WerteWählen160.Random (PositionGewählt160);
            XAchse := WerteWählen160.Random (PositionGewählt160);
            
         when KartenDatentypen.Kartengröße_240_240_Enum =>
            WerteWählen240.Reset (PositionGewählt240);
            YAchse := WerteWählen240.Random (PositionGewählt240);
            XAchse := WerteWählen240.Random (PositionGewählt240);
            
         when KartenDatentypen.Kartengröße_320_320_Enum =>
            WerteWählen320.Reset (PositionGewählt320);
            YAchse := WerteWählen320.Random (PositionGewählt320);
            XAchse := WerteWählen320.Random (PositionGewählt320);
            
         when KartenDatentypen.Kartengröße_1000_1000_Enum =>
            WerteWählen1000.Reset (PositionGewählt1000);
            YAchse := WerteWählen1000.Random (PositionGewählt1000);
            XAchse := WerteWählen1000.Random (PositionGewählt1000);

         when others =>
            WerteWählen1000.Reset (PositionGewählt1000);
            BenutzerdefinierteAuswahlSchleife:
            loop
               
               YAchse := WerteWählen1000.Random (PositionGewählt1000);
               XAchse := WerteWählen1000.Random (PositionGewählt1000);

               if
                 YAchse <= Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).YAchsenGröße
                 and
                   XAchse <= Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).XAchsenGröße
               then
                  exit BenutzerdefinierteAuswahlSchleife;

               else
                  null;
               end if;
               
            end loop BenutzerdefinierteAuswahlSchleife;
      end case;
      
      return (YAchse, XAchse);
      
   end StartPunkteYXFestlegen;



   function ZufälligerWert
     return Float
   is begin

      Ada.Numerics.Float_Random.Reset (ZufälligerFloatWert);
      return Ada.Numerics.Float_Random.Random (ZufälligerFloatWert);
      
   end ZufälligerWert;



   function ChaoskarteGrund
     return KartenGrundDatentypen.Karten_Grund_Alle_Felder_Enum
   is begin
      
      WerteWählenChaoskarte.Reset (GrundGewählt);
      
      GrundSchleife:
      loop
         
         GrundWert := WerteWählenChaoskarte.Random (GrundGewählt);
         
         case
           GrundWert
         is
            when KartenGrundDatentypen.Hügel_Mit_Enum =>
               null;
               
            when others =>
               return GrundWert;
         end case;
         
      end loop GrundSchleife;
      
   end ChaoskarteGrund;
   
   
   
   function ChaoskarteFluss
     return KartenGrundDatentypen.Karten_Fluss_Enum
   is begin
      
      FlussWählenChaoskarte.Reset (FlussGewählt);
      return FlussWählenChaoskarte.Random (FlussGewählt);
      
   end ChaoskarteFluss;
   
   
   
   function ChaoskarteRessource
     (WasserLandExtern : in Boolean)
      return KartenGrundDatentypen.Karten_Ressourcen_Enum
   is begin
      
      RessourceWählenChaoskarte.Reset (RessourceGewählt);
      RessourceWert := RessourceWählenChaoskarte.Random (RessourceGewählt);
         
      case
        WasserLandExtern
      is
         when True =>
            if
              RessourceWert in KartenGrundDatentypen.Karten_Ressourcen_Wasser'Range
            then
               return RessourceWert;
                  
            else
               null;
            end if;

         when False =>
            if
              RessourceWert in KartenGrundDatentypen.Karten_Ressourcen_Land'Range
            then
               return RessourceWert;
                  
            else
               null;
            end if;
      end case;
            
      return KartenGrundDatentypen.Leer_Ressource_Enum;
      
   end ChaoskarteRessource;

end ZufallsgeneratorenKarten;
