with ZeitKonstanten;

with NachLogiktask;

package body EingabeAllgemeinLogik is

   procedure EingabeAbwarten
   is begin
              
      while NachLogiktask.Warten loop
         
         delay ZeitKonstanten.WartezeitEingabe;
         
      end loop;
      
   end EingabeAbwarten;

end EingabeAllgemeinLogik;
