pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Ada.Wide_Wide_Text_IO; use Ada.Wide_Wide_Text_IO;
with Ada.Characters.Wide_Wide_Latin_1; use Ada.Characters.Wide_Wide_Latin_1;

with EinheitStadtDatentypen; use EinheitStadtDatentypen;
with KartenVerbesserungDatentypen; use KartenVerbesserungDatentypen;

with EingeleseneGrafikenKonsole;

package body FarbgebungKonsole is

   procedure Farben
     (EinheitIDExtern : in EinheitStadtDatentypen.EinheitenIDMitNullWert;
      VerbesserungExtern : in KartenVerbesserungDatentypen.Karten_Verbesserung_Enum;
      WegExtern : in KartenVerbesserungDatentypen.Karten_Weg_Enum;
      GrundExtern : in KartenGrundDatentypen.Kartengrund_Enum;
      FlussExtern : in KartenGrundDatentypen.Karten_Fluss_Enum;
      RessourceExtern : in KartenGrundDatentypen.Karten_Ressourcen_Enum;
      CursorExtern : in Boolean;
      EigeneRasseExtern : in RassenDatentypen.Rassen_Enum;
      RasseExtern : in RassenDatentypen.Rassen_Enum)
   is begin
            
      FarbenFeld (GrundExtern => GrundExtern);
      
      case
        FlussExtern
      is
         when KartenGrundDatentypen.Leer_Fluss_Enum =>
            null;
            
         when others =>
            FarbenFluss (GrundExtern => GrundExtern,
                         FlussExtern => FlussExtern);
      end case;
      
      case
        RessourceExtern
      is
         when KartenGrundDatentypen.Leer_Ressource_Enum =>
            null;
            
         when others =>
            FarbenRessourcen (GrundExtern     => GrundExtern,
                              RessourceExtern => RessourceExtern);
      end case;
      
      FarbenCursorEinheitVerbesserung (EinheitIDExtern    => EinheitIDExtern,
                                       VerbesserungExtern => VerbesserungExtern,
                                       WegExtern          => WegExtern,
                                       GrundExtern        => GrundExtern,
                                       FlussExtern        => FlussExtern,
                                       RessourceExtern    => RessourceExtern,
                                       CursorExtern       => CursorExtern,
                                       EigeneRasseExtern  => EigeneRasseExtern,
                                       RasseExtern        => RasseExtern);
      
   end Farben;
   
   
   
   procedure FarbenFeld
     (GrundExtern : in KartenGrundDatentypen.Kartengrund_Vorhanden_Enum)
   is begin
      
      Put (Item => CSI & Feldfarbe (GrundExtern));
      
   end FarbenFeld;
   
   
   
   procedure FarbenFluss
     (GrundExtern : in KartenGrundDatentypen.Kartengrund_Vorhanden_Enum;
      FlussExtern : in KartenGrundDatentypen.Karten_Alle_Flüsse_Vorhanden_Enum)
   is begin
      
      case
        GrundExtern
      is
         when KartenGrundDatentypen.Eis_Enum | KartenGrundDatentypen.Tundra_Enum | KartenGrundDatentypen.Wüste_Enum | KartenGrundDatentypen.Sand_Enum | KartenGrundDatentypen.Küstengewässer_Enum
            | KartenGrundDatentypen.Wolken_Enum | KartenGrundDatentypen.Untereis_Enum | KartenGrundDatentypen.Unterküstengewässer_Enum =>
            if
              FlussExtern in KartenGrundDatentypen.Karten_Fluss_Vorhanden_Enum'Range
              or
                FlussExtern in KartenGrundDatentypen.Karten_Unterirdischer_Fluss_Vorhanden_Enum'Range
            then
               Put (Item => CSI & "38;2;0;0;205m");
               
            else
               -- Lavafluss
               Put (Item => CSI & "38;2;230;50;50m");
            end if;
                  
         when others =>
            if
              FlussExtern in KartenGrundDatentypen.Karten_Fluss_Vorhanden_Enum'Range
              or
                FlussExtern in KartenGrundDatentypen.Karten_Unterirdischer_Fluss_Vorhanden_Enum'Range
            then
               Put (Item => CSI & "38;2;135;206;250m");
               
            else
               -- Lavafluss
               Put (Item => CSI & "38;2;230;50;50m");
            end if;
      end case;
      
   end FarbenFluss;
   
   
   
   procedure FarbenRessourcen
     (GrundExtern : in KartenGrundDatentypen.Kartengrund_Vorhanden_Enum;
      RessourceExtern : in KartenGrundDatentypen.Karten_Ressourcen_Vorhanden_Enum)
   is begin
      
      case
        RessourceExtern
      is
         when KartenGrundDatentypen.Öl_Enum =>
            ------------------------
            -- Eventuell mal verschiedene Farben für die einzelnen Ressourcen einbauen?
            null;
            
         when others =>
            null;
      end case;
      
      case
        GrundExtern
      is
         when KartenGrundDatentypen.Eis_Enum | KartenGrundDatentypen.Tundra_Enum | KartenGrundDatentypen.Wüste_Enum | KartenGrundDatentypen.Sand_Enum | KartenGrundDatentypen.Küstengewässer_Enum
            | KartenGrundDatentypen.Wolken_Enum | KartenGrundDatentypen.Untereis_Enum | KartenGrundDatentypen.Unterküstengewässer_Enum =>
            Put (Item => CSI & "38;2;0;0;0m");
                  
         when others =>
            Put (Item => CSI & "38;2;255;255;255m");
      end case;
      
   end FarbenRessourcen;
   
   
   
   procedure FarbenCursorEinheitVerbesserung
     (EinheitIDExtern : in EinheitStadtDatentypen.EinheitenIDMitNullWert;
      VerbesserungExtern : in KartenVerbesserungDatentypen.Karten_Verbesserung_Enum;
      WegExtern : in KartenVerbesserungDatentypen.Karten_Weg_Enum;
      GrundExtern : in KartenGrundDatentypen.Kartengrund_Enum;
      FlussExtern : in KartenGrundDatentypen.Karten_Fluss_Enum;
      RessourceExtern : in KartenGrundDatentypen.Karten_Ressourcen_Enum;
      CursorExtern : in Boolean;
      EigeneRasseExtern : in RassenDatentypen.Rassen_Enum;
      RasseExtern : in RassenDatentypen.Rassen_Enum)
   is begin
      
      if
        CursorExtern
      then
         Put (Item => CSI & "5m" & EingeleseneGrafikenKonsole.CursorGrafik (EigeneRasseExtern) & CSI & "0m");
         
      elsif
        EinheitIDExtern > EinheitStadtDatentypen.EinheitenIDMitNullWert'First
      then
         Put (Item => EingeleseneGrafikenKonsole.EinheitenGrafik (EigeneRasseExtern, EinheitIDExtern) & CSI & "0m");
        
      elsif
        VerbesserungExtern in KartenVerbesserungDatentypen.Karten_Verbesserung_Eigene_Städte_Enum'Range
        and
          RasseExtern = EigeneRasseExtern
      then
         Put (Item => EingeleseneGrafikenKonsole.VerbesserungenGrafik (VerbesserungExtern) & CSI & "0m");
            
      elsif
        VerbesserungExtern in KartenVerbesserungDatentypen.Karten_Verbesserung_Eigene_Städte_Enum'Range
      then
         case
           VerbesserungExtern
         is
            when KartenVerbesserungDatentypen.Eigene_Hauptstadt_Enum =>
               Put (Item => EingeleseneGrafikenKonsole.VerbesserungenGrafik (KartenVerbesserungDatentypen.Fremde_Hauptstadt_Enum) & CSI & "0m");
               
            when KartenVerbesserungDatentypen.Eigene_Stadt_Enum =>
               Put (Item => EingeleseneGrafikenKonsole.VerbesserungenGrafik (KartenVerbesserungDatentypen.Fremde_Stadt_Enum) & CSI & "0m");
               
            when others =>
               null;
         end case;
            
      elsif
        VerbesserungExtern /= KartenVerbesserungDatentypen.Leer_Verbesserung_Enum
      then
         Put (Item => EingeleseneGrafikenKonsole.VerbesserungenGrafik (VerbesserungExtern) & CSI & "0m");
            
      elsif
        WegExtern /= KartenVerbesserungDatentypen.Leer_Weg_Enum
      then
         Put (Item => EingeleseneGrafikenKonsole.WegeGrafik (WegExtern) & CSI & "0m");

      elsif
        RessourceExtern /= KartenGrundDatentypen.Leer_Ressource_Enum
      then
         Put (Item => EingeleseneGrafikenKonsole.KartenressourcenGrafik (RessourceExtern) & CSI & "0m");
         
      elsif
        FlussExtern /= KartenGrundDatentypen.Leer_Fluss_Enum
      then
         Put (Item => EingeleseneGrafikenKonsole.KartenflussGrafik (FlussExtern) & CSI & "0m");
            
      else
         Put (Item => EingeleseneGrafikenKonsole.KartenfelderGrafik (GrundExtern) & CSI & "0m");
      end if;
      
   end FarbenCursorEinheitVerbesserung;

end FarbgebungKonsole;
