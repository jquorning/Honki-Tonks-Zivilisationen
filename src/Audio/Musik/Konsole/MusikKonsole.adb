pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with SystemDatentypen;
with SystemKonstanten;

with InteraktionMusiktask;
with Fehler;
with MusikIntroKonsole;

package body MusikKonsole is

   procedure MusikKonsole
   is begin
      
      MusikSchleife:
      loop
         
         case
           InteraktionMusiktask.AktuelleMusik
         is
            when SystemDatentypen.Musik_Konsole =>
               delay SystemKonstanten.WartezeitMusik;
               
            when SystemDatentypen.Musik_Intro =>
               MusikIntroKonsole.Intro;
               
            when SystemDatentypen.Musik_SFML =>
               Fehler.MusikFehler (FehlermeldungExtern => "MusikKonsole.MusikKonsole - SFML wird bei Konsole aufgerufen.");
               
            when SystemDatentypen.Musik_Ende =>
               exit MusikSchleife;
         end case;
         
      end loop MusikSchleife;
      
   end MusikKonsole;

end MusikKonsole;
