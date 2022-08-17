pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with GrafikDatentypen;
with GrafikKonstanten;

with AuswahlMenuesEinfachSFML;
with AuswahlMenueKartenformSFML;
with AuswahlMenueSteuerungSFML;
with Fehler;
with ViewsEinstellenSFML;
with HintergrundSFML;
with ViewsSFML;

package body AuswahlMenuesSFML is

   procedure AuswahlMenüsAufteilung
     (WelchesMenüExtern : in MenueDatentypen.Welches_Menü_Enum)
   is begin
      
      -- Irgendwann mal herausfinden warum ich das zweimal aufrufen muss um das richtige Ergebnis zu bekommen. äöü
     Viewfläche := ViewsEinstellenSFML.ViewflächeAuflösungAnpassen (ViewflächeExtern => Viewfläche);
     Viewfläche := ViewsEinstellenSFML.ViewflächeAuflösungAnpassen (ViewflächeExtern => Viewfläche);
      
      ViewsEinstellenSFML.ViewEinstellen (ViewExtern           => ViewsSFML.MenüviewAccess,
                                          GrößeExtern          => Viewfläche,
                                          AnzeigebereichExtern => GrafikKonstanten.StandardAnzeigebereich);
      
      HintergrundSFML.MenüHintergrund (HintergrundExtern => GrafikDatentypen.Standard_Hintergrund_Enum,
                                        AbmessungenExtern => Viewfläche);
      
      case
        WelchesMenüExtern
      is
         when MenueDatentypen.Leer_Menü_Enum =>
            Fehler.GrafikFehler (FehlermeldungExtern => "AuswahlMenuesSFML.AuswahlMenüsAufteilung - Kein Menü ausgewählt.");
            
         when MenueDatentypen.Menü_Einfach_Enum =>
            Viewfläche := AuswahlMenuesEinfachSFML.AuswahlMenüsEinfach (WelchesMenüExtern => WelchesMenüExtern,
                                                                          ViewflächeExtern  => Viewfläche);
            
         when MenueDatentypen.Kartenform_Menü_Enum =>
            Viewfläche := AuswahlMenueKartenformSFML.AuswahlMenüKartenform (ViewflächeExtern => Viewfläche);
            
            -- when MenueDatentypen.Rassen_Menü_Enum =>
            -- Gibt es da noch eine Lösung die in die anderen Menüs mit rein passt. Vor allem wegen dem Zusatztext scheint das problematisch. äöü
            
         when MenueDatentypen.Steuerung_Menü_Enum =>
            Viewfläche := AuswahlMenueSteuerungSFML.AuswahlMenüSteuerung (ViewflächeExtern => Viewfläche);
      end case;
      
   end AuswahlMenüsAufteilung;

end AuswahlMenuesSFML;
