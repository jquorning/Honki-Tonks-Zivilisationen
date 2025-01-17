with LadezeitenDatentypen;

with KartengeneratorKuesteLogik;
with KartengeneratorLandschaftLogik;
with KartengeneratorFlussLogik;
with KartengeneratorRessourcenLogik;
with KartengeneratorUnterflaecheLogik;
with KartengeneratorAllgemeinesLogik;
with LadezeitenLogik;
with KartengeneratorVariablenLogik;

package body KartengeneratorLogik is

   procedure Kartengenerator
   is begin
      
      KartengeneratorAllgemeinesLogik.GenerierungAllgemeines;
      PrüfeEinstellungen;
      LadezeitenLogik.FortschrittSpielweltMaximum (WelcheBerechnungenExtern => LadezeitenDatentypen.Generiere_Allgemeines_Enum);
      
      KartengeneratorKuesteLogik.GenerierungKüstenSeeGewässer;
      LadezeitenLogik.FortschrittSpielweltMaximum (WelcheBerechnungenExtern => LadezeitenDatentypen.Generiere_Küstenwasser_Enum);
      
      KartengeneratorLandschaftLogik.GenerierungLandschaft;
      LadezeitenLogik.FortschrittSpielweltMaximum (WelcheBerechnungenExtern => LadezeitenDatentypen.Generiere_Landschaft_Enum);
      
      KartengeneratorUnterflaecheLogik.GenerierungLandschaft;
      LadezeitenLogik.FortschrittSpielweltMaximum (WelcheBerechnungenExtern => LadezeitenDatentypen.Generiere_Unterfläche_Enum);
      
      KartengeneratorFlussLogik.GenerierungFlüsse;
      LadezeitenLogik.FortschrittSpielweltMaximum (WelcheBerechnungenExtern => LadezeitenDatentypen.Generiere_Flüsse_Enum);
      
      KartengeneratorRessourcenLogik.GenerierungRessourcen;
      LadezeitenLogik.FortschrittSpielweltMaximum (WelcheBerechnungenExtern => LadezeitenDatentypen.Generiere_Ressourcen_Enum);
      
   end Kartengenerator;
   
   
   
   procedure PrüfeEinstellungen
   is begin
      
      RessourcenSchleife:
      for RessourcenSchleifenwert in KartengeneratorVariablenLogik.KartenressourcenWahrscheinlichkeitenArray'Range loop
         
         KartengeneratorVariablenLogik.KartenressourcenWahrscheinlichkeiten (RessourcenSchleifenwert)
           := KartengeneratorVariablenLogik.StandardKartenressourcenWahrscheinlichkeiten (KartengeneratorVariablenLogik.Kartenparameter.Kartenressourcen, RessourcenSchleifenwert);
         
      end loop RessourcenSchleife;
      
   end PrüfeEinstellungen;

end KartengeneratorLogik;
