pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Ada.Calendar; use Ada.Calendar;

with SystemDatentypen;
with EinheitenKonstanten;
with GrafikDatentypen;
with LadezeitenDatentypen;

with KartenfelderBewerten;
with KartengeneratorKueste;
with KartengeneratorLandschaft;
with KartengeneratorFluss;
with KartengeneratorRessourcen;
with KartengeneratorUnterwasserUnterirdisch;
with KartengeneratorAllgemeines;
with InteraktionGrafiktask;
with Ladezeiten;

package body Kartengenerator is

   procedure Kartengenerator
   is begin
      
      Ladezeiten.Nullsetzen;
      InteraktionGrafiktask.AktuelleDarstellung := GrafikDatentypen.Grafik_Generierungszeit_Enum;
      
      AllgemeinesGenerieren;
      KüstenwasserGenerieren;
      LandschaftGenerieren;
      UnterwasserUnterirdischGenerieren;
      FlüsseGenerieren;
      RessourcenGenerieren;
      BewerteKartenfelder;
      
   end Kartengenerator;
   
   
   
   procedure AllgemeinesGenerieren
   is begin
      
      Ladezeiten.SpielweltErstellen (LadezeitenDatentypen.Generiere_Allgemeines_Enum, SystemDatentypen.Anfangswert_Enum) := Clock;
      
      KartengeneratorAllgemeines.GenerierungAllgemeines;
            
      Ladezeiten.SpielweltErstellen (LadezeitenDatentypen.Generiere_Allgemeines_Enum, SystemDatentypen.Endwert_Enum) := Clock;
      
   end AllgemeinesGenerieren;
   
   
   
   procedure KüstenwasserGenerieren
   is begin
      
      Ladezeiten.SpielweltErstellen (LadezeitenDatentypen.Generiere_Küstenwasser_Enum, SystemDatentypen.Anfangswert_Enum) := Clock;
      
      KartengeneratorKueste.GenerierungKüstenSeeGewässer;
      
      Ladezeiten.SpielweltErstellen (LadezeitenDatentypen.Generiere_Küstenwasser_Enum, SystemDatentypen.Endwert_Enum) := Clock;
      
   end KüstenwasserGenerieren;
   
   
   
   procedure LandschaftGenerieren
   is begin
      
      Ladezeiten.SpielweltErstellen (LadezeitenDatentypen.Generiere_Landschaft_Enum, SystemDatentypen.Anfangswert_Enum) := Clock;
      
      KartengeneratorLandschaft.GenerierungLandschaft;
      
      Ladezeiten.SpielweltErstellen (LadezeitenDatentypen.Generiere_Landschaft_Enum, SystemDatentypen.Endwert_Enum) := Clock;
      
   end LandschaftGenerieren;
   
   
   
   procedure UnterwasserUnterirdischGenerieren
   is begin
      
      Ladezeiten.SpielweltErstellen (LadezeitenDatentypen.Generiere_Unterfläche_Enum, SystemDatentypen.Anfangswert_Enum) := Clock;
      
      KartengeneratorUnterwasserUnterirdisch.GenerierungLandschaft;
      
      Ladezeiten.SpielweltErstellen (LadezeitenDatentypen.Generiere_Unterfläche_Enum, SystemDatentypen.Endwert_Enum) := Clock;
      
   end UnterwasserUnterirdischGenerieren;
   
   
   
   procedure FlüsseGenerieren
   is begin
      
      Ladezeiten.SpielweltErstellen (LadezeitenDatentypen.Generiere_Flüsse_Enum, SystemDatentypen.Anfangswert_Enum) := Clock;
      
      KartengeneratorFluss.AufteilungFlussgenerierung;
      
      Ladezeiten.SpielweltErstellen (LadezeitenDatentypen.Generiere_Flüsse_Enum, SystemDatentypen.Endwert_Enum) := Clock;
      
   end FlüsseGenerieren;
   
   
   
   procedure RessourcenGenerieren
   is begin
      
      Ladezeiten.SpielweltErstellen (LadezeitenDatentypen.Generiere_Ressourcen_Enum, SystemDatentypen.Anfangswert_Enum) := Clock;
      
      KartengeneratorRessourcen.GenerierungRessourcen;
      
      Ladezeiten.SpielweltErstellen (LadezeitenDatentypen.Generiere_Ressourcen_Enum, SystemDatentypen.Endwert_Enum) := Clock;
      
   end RessourcenGenerieren;
   
   
   
   procedure BewerteKartenfelder
   is begin

      Ladezeiten.SpielweltErstellen (LadezeitenDatentypen.Bewerte_Kartenfelder_Enum, SystemDatentypen.Anfangswert_Enum) := Clock;
      
      KartenfelderBewerten.KartenfelderBewerten (RasseExtern => EinheitenKonstanten.LeerRasse);
      
      Ladezeiten.SpielweltErstellen (LadezeitenDatentypen.Bewerte_Kartenfelder_Enum, SystemDatentypen.Endwert_Enum) := Clock;
      
   end BewerteKartenfelder;

end Kartengenerator;
