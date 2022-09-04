pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with EinheitenKonstanten;
with LadezeitenDatentypen;

with KartenfelderBewerten;
with KartengeneratorKueste;
with KartengeneratorLandschaft;
with KartengeneratorFluss;
with KartengeneratorRessourcen;
with KartengeneratorUnterwasserUnterirdisch;
with KartengeneratorAllgemeines;
with Ladezeiten;

package body Kartengenerator is

   procedure Kartengenerator
   is begin
      
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
            
      KartengeneratorAllgemeines.GenerierungAllgemeines;
      Ladezeiten.FortschrittSpielweltMaximum (WelcheBerechnungenExtern => LadezeitenDatentypen.Generiere_Allgemeines_Enum);
      
   end AllgemeinesGenerieren;
   
   
   
   procedure KüstenwasserGenerieren
   is begin
            
      KartengeneratorKueste.GenerierungKüstenSeeGewässer;
      Ladezeiten.FortschrittSpielweltMaximum (WelcheBerechnungenExtern => LadezeitenDatentypen.Generiere_Küstenwasser_Enum);
      
   end KüstenwasserGenerieren;
   
   
   
   procedure LandschaftGenerieren
   is begin
            
      KartengeneratorLandschaft.GenerierungLandschaft;
      Ladezeiten.FortschrittSpielweltMaximum (WelcheBerechnungenExtern => LadezeitenDatentypen.Generiere_Landschaft_Enum);
      
   end LandschaftGenerieren;
   
   
   
   procedure UnterwasserUnterirdischGenerieren
   is begin
            
      KartengeneratorUnterwasserUnterirdisch.GenerierungLandschaft;
      Ladezeiten.FortschrittSpielweltMaximum (WelcheBerechnungenExtern => LadezeitenDatentypen.Generiere_Unterfläche_Enum);
      
   end UnterwasserUnterirdischGenerieren;
   
   
   
   procedure FlüsseGenerieren
   is begin
            
      KartengeneratorFluss.AufteilungFlussgenerierung;
      Ladezeiten.FortschrittSpielweltMaximum (WelcheBerechnungenExtern => LadezeitenDatentypen.Generiere_Flüsse_Enum);
      
   end FlüsseGenerieren;
   
   
   
   procedure RessourcenGenerieren
   is begin
            
      KartengeneratorRessourcen.AufteilungRessourcengenerierung;
      Ladezeiten.FortschrittSpielweltMaximum (WelcheBerechnungenExtern => LadezeitenDatentypen.Generiere_Ressourcen_Enum);
      
   end RessourcenGenerieren;
   
   
   
   procedure BewerteKartenfelder
   is begin
      
      KartenfelderBewerten.KartenfelderBewerten (RasseExtern => EinheitenKonstanten.LeerRasse);
      Ladezeiten.FortschrittSpielweltMaximum (WelcheBerechnungenExtern => LadezeitenDatentypen.Bewerte_Kartenfelder_Enum);
      
   end BewerteKartenfelder;

end Kartengenerator;
