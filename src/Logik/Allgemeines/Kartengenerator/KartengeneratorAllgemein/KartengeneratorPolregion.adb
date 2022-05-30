pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KartengrundDatentypen; use KartengrundDatentypen;
with KartenDatentypen; use KartenDatentypen;

with SchreibeKarten;

with Karten;
-- with KartengeneratorVariablen;

package body KartengeneratorPolregion is

   procedure PolregionGenerieren
   is
      
      task Norden;
      task Süden;
      task Westen;
      task Osten;
      
      task body Norden
      is begin
         
         PolregionNorden;
         
      end Norden;
      
      
      
      task body Süden
      is begin
         
         PolregionSüden;
         
      end Süden;
      
      
      
      task body Westen
      is begin
         
         PolregionWesten;
         
      end Westen;
      
      
      
      task body Osten
      is begin
         
         PolregionOsten;
         
      end Osten;
   
   begin
      
      null;
      
   end PolregionGenerieren;
   
   
   
   procedure PolregionNorden
   is begin
      
      case
        Karten.Kartenparameter.Kartenpole.Nordpol
      is
         when KartenDatentypen.Kartenpol_Nicht_Vorhanden_Enum =>
            return;
            
         when KartenDatentypen.Kartenpol_Vorhanden_Enum =>
            null;
      end case;
      
      YAchseSchleife:
      for YAchseSchleifenwert in Karten.WeltkarteArray'First (2) .. Karten.Polgrößen (KartenDatentypen.Norden_Enum) loop
         XAchseSchleife:
         for XAchseSchleifenwert in Karten.WeltkarteArray'First (3) .. Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).XAchse loop
            
            SchreibeKarten.ZweimalGrund (KoordinatenExtern => (0, YAchseSchleifenwert, XAchseSchleifenwert),
                                         GrundExtern       => KartengrundDatentypen.Eis_Enum);
            
            SchreibeKarten.ZweimalGrund (KoordinatenExtern => (-1, YAchseSchleifenwert, XAchseSchleifenwert),
                                         GrundExtern       => KartengrundDatentypen.Untereis_Enum);
            
         end loop XAchseSchleife;
      end loop YAchseSchleife;
      
   end PolregionNorden;
   
   
   
   procedure PolregionSüden
   is begin
      
      case
        Karten.Kartenparameter.Kartenpole.Südpol
      is
         when KartenDatentypen.Kartenpol_Nicht_Vorhanden_Enum =>
            return;
            
         when KartenDatentypen.Kartenpol_Vorhanden_Enum =>
            null;
      end case;

      -- Hier ist + 1 nötig, da er nicht wie auf der anderen Polseite bis zu dem Punkt loopt sondern eins weiter.
      YAchseSchleife:
      for YAchseSchleifenwert in Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).YAchse - Karten.Polgrößen (KartenDatentypen.Süden_Enum) + 1 .. Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).YAchse loop
         XAchseSchleife:
         for XAchseSchleifenwert in Karten.WeltkarteArray'First (3) .. Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).XAchse loop
            
            SchreibeKarten.ZweimalGrund (KoordinatenExtern => (0, YAchseSchleifenwert, XAchseSchleifenwert),
                                         GrundExtern       => KartengrundDatentypen.Eis_Enum);
            
            SchreibeKarten.ZweimalGrund (KoordinatenExtern => (-1, YAchseSchleifenwert, XAchseSchleifenwert),
                                         GrundExtern       => KartengrundDatentypen.Untereis_Enum);
            
         end loop XAchseSchleife;
      end loop YAchseSchleife;
      
   end PolregionSüden;
   
   
   
   procedure PolregionWesten
   is begin
      
      case
        Karten.Kartenparameter.Kartenpole.Westpol
      is
         when KartenDatentypen.Kartenpol_Nicht_Vorhanden_Enum =>
            return;
            
         when KartenDatentypen.Kartenpol_Vorhanden_Enum =>
            null;
      end case;
      
      YAchseSchleife:
      for YAchseSchleifenwert in Karten.WeltkarteArray'First (2) .. Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).YAchse loop
         XAchseSchleife:
         for XAchseSchleifenwert in Karten.WeltkarteArray'First (3) .. Karten.Polgrößen (KartenDatentypen.Westen_Enum) loop
            
            SchreibeKarten.ZweimalGrund (KoordinatenExtern => (0, YAchseSchleifenwert, XAchseSchleifenwert),
                                         GrundExtern       => KartengrundDatentypen.Eis_Enum);
            
            SchreibeKarten.ZweimalGrund (KoordinatenExtern => (-1, YAchseSchleifenwert, XAchseSchleifenwert),
                                         GrundExtern       => KartengrundDatentypen.Untereis_Enum);
            
         end loop XAchseSchleife;
      end loop YAchseSchleife;
      
   end PolregionWesten;
   
   
   
   procedure PolregionOsten
   is begin
      
      case
        Karten.Kartenparameter.Kartenpole.Ostpol
      is
         when KartenDatentypen.Kartenpol_Nicht_Vorhanden_Enum =>
            return;
            
         when KartenDatentypen.Kartenpol_Vorhanden_Enum =>
            null;
      end case;
      
      -- Hier ist + 1 nötig, da er nicht wie auf der anderen Polseite bis zu dem Punkt loopt sondern eins weiter.
      YAchseSchleife:
      for YAchseSchleifenwert in Karten.WeltkarteArray'First (2) .. Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).YAchse loop
         XAchseSchleife:
         for XAchseSchleifenwert in Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).XAchse - Karten.Polgrößen (KartenDatentypen.Osten_Enum) + 1
           .. Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).XAchse loop
            
            SchreibeKarten.ZweimalGrund (KoordinatenExtern => (0, YAchseSchleifenwert, XAchseSchleifenwert),
                                         GrundExtern       => KartengrundDatentypen.Eis_Enum);
            
            SchreibeKarten.ZweimalGrund (KoordinatenExtern => (-1, YAchseSchleifenwert, XAchseSchleifenwert),
                                         GrundExtern       => KartengrundDatentypen.Untereis_Enum);
            
         end loop XAchseSchleife;
      end loop YAchseSchleife;
      
   end PolregionOsten;

end KartengeneratorPolregion;
