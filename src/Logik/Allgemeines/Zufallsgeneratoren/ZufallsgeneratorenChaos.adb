pragma SPARK_Mode (Off);
pragma Warnings (Off, "*array aggregate*");

package body ZufallsgeneratorenChaos is

   function ChaoskarteGrund
     return KartengrundDatentypen.Kartengrund_Vorhanden_Enum
   is begin
      
      WerteWählenChaoskarte.Reset (GrundGewählt);
      
      GrundSchleife:
      loop
         
         GrundWert := WerteWählenChaoskarte.Random (GrundGewählt);
         
         case
           GrundWert
         is
            when KartengrundDatentypen.Hügel_Mit_Enum =>
               null;
               
            when others =>
               return GrundWert;
         end case;
         
      end loop GrundSchleife;
      
   end ChaoskarteGrund;
   
   
   
   function ChaoskarteFluss
     return KartengrundDatentypen.Karten_Fluss_Enum
   is begin
      
      FlussWählenChaoskarte.Reset (FlussGewählt);
      return FlussWählenChaoskarte.Random (FlussGewählt);
      
   end ChaoskarteFluss;
   
   
   
   function ChaoskarteRessource
     (WasserLandExtern : in Boolean)
      return KartengrundDatentypen.Karten_Ressourcen_Enum
   is begin
      
      RessourceWählenChaoskarte.Reset (RessourceGewählt);
      RessourceWert := RessourceWählenChaoskarte.Random (RessourceGewählt);
         
      case
        WasserLandExtern
      is
         when True =>
            if
              RessourceWert in KartengrundDatentypen.Karten_Ressourcen_Wasser'Range
            then
               return RessourceWert;
                  
            else
               null;
            end if;

         when False =>
            if
              RessourceWert in KartengrundDatentypen.Karten_Ressourcen_Land'Range
            then
               return RessourceWert;
                  
            else
               null;
            end if;
      end case;
            
      return KartengrundDatentypen.Leer_Ressource_Enum;
      
   end ChaoskarteRessource;

   
   
   function TotaleChaoskarteGrund
     return KartengrundDatentypen.Kartengrund_Vorhanden_Enum
   is begin
      
      WerteWählenChaoskarte.Reset (GrundGewählt);
      
      GrundSchleife:
      loop
         
         GrundWert := WerteWählenChaoskarte.Random (GrundGewählt);
         
         case
           GrundWert
         is
            when KartengrundDatentypen.Hügel_Mit_Enum =>
               null;
               
            when others =>
               return GrundWert;
         end case;
         
      end loop GrundSchleife;
      
   end TotaleChaoskarteGrund;
   
   
   
   function TotaleChaoskarteFluss
     return KartengrundDatentypen.Karten_Fluss_Enum
   is begin
      
      FlussWählenChaoskarte.Reset (FlussGewählt);
      return FlussWählenChaoskarte.Random (FlussGewählt);
      
   end TotaleChaoskarteFluss;
   
   
   
   function TotaleChaoskarteRessource
      return KartengrundDatentypen.Karten_Ressourcen_Enum
   is begin
      
      RessourceWählenChaoskarte.Reset (RessourceGewählt);
      return RessourceWählenChaoskarte.Random (RessourceGewählt);
      
   end TotaleChaoskarteRessource;

end ZufallsgeneratorenChaos;