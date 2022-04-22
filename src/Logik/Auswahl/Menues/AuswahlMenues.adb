pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with AuswahlMenuesEinfach;

package body AuswahlMenues is

   function AuswahlMenüsAufteilung
     (WelchesMenüExtern : in MenueDatentypen.Welches_Menü_Vorhanden_Enum)
      return RueckgabeDatentypen.Rückgabe_Werte_Enum
   is begin
      
      ------------------------ Wird diese Aufteilungdatei noch benötigt? Theoretisch kann ich ja alles Positionen egal wie das Menü oder die Auswahl aussieht so gestalten.
      return AuswahlMenuesEinfach.AuswahlMenüsEinfach (WelchesMenüExtern => WelchesMenüExtern);
      
   end AuswahlMenüsAufteilung;

end AuswahlMenues;
