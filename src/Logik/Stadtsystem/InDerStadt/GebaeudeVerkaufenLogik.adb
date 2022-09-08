pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with StadtDatentypen; use StadtDatentypen;
with InteraktionAuswahl;
with TastenbelegungDatentypen;
with GrafikDatentypen;
with TextnummernKonstanten;

with LeseStadtGebaut;

with NachGrafiktask;
with Mausauswahl;
with TasteneingabeLogik;
with GebaeudeAllgemein;
with StadtProduktion;
with JaNeinLogik;

package body GebaeudeVerkaufenLogik is
   
   procedure Verkaufsliste
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord)
   is begin
      
      case
        VerkaufbareGebäudeErmitteln (StadtRasseNummerExtern => StadtRasseNummerExtern)
      is
         when False =>
            return;
            
         when True =>
            GebäudeVerkaufen (StadtRasseNummerExtern => StadtRasseNummerExtern);
      end case;
      
      NachGrafiktask.AktuelleDarstellung := GrafikDatentypen.Grafik_Stadtkarte_Enum;
      
   end Verkaufsliste;
   
   
   
   function VerkaufbareGebäudeErmitteln
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord)
      return Boolean
   is begin
      
      VerkaufenMöglich := False;
      
      GebäudeSchleife:
      for GebäudeSchleifenwert in StadtDatentypen.GebäudeID'Range loop
         
         InteraktionAuswahl.MöglicheGebäude (GebäudeSchleifenwert) := LeseStadtGebaut.GebäudeVorhanden (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                                                                                            WelchesGebäudeExtern  => GebäudeSchleifenwert);
         
         if
           InteraktionAuswahl.MöglicheGebäude (GebäudeSchleifenwert) = True
           and
             VerkaufenMöglich = False
         then
            VerkaufenMöglich := True;
            
         else
            null;
         end if;
         
      end loop GebäudeSchleife;
      
      return VerkaufenMöglich;
      
   end VerkaufbareGebäudeErmitteln;
   
   
   
   procedure GebäudeVerkaufen
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord)
   is begin
      
      NachGrafiktask.AktuelleDarstellung := GrafikDatentypen.Grafik_Verkaufen_Enum;
      
      AuswahlSchleife:
      loop
         
         AktuelleAuswahl := Mausauswahl.Verkaufsmenü;
         NachGrafiktask.AktuelleBauauswahl.Gebäude := AktuelleAuswahl;
         
         case
           TasteneingabeLogik.Tastenwert
         is               
            when TastenbelegungDatentypen.Auswählen_Enum =>
               if
                 AktuelleAuswahl = 0
               then
                  null;
                  
               else
                  case
                    JaNeinLogik.JaNein (FrageZeileExtern => TextnummernKonstanten.FrageGebäudeAbreißen)
                  is
                     when False =>
                        null;
                        
                     when True =>
                        GebaeudeAllgemein.GebäudeEntfernen (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                                             WelchesGebäudeExtern   => AktuelleAuswahl);
                        StadtProduktion.StadtProduktion (StadtRasseNummerExtern => StadtRasseNummerExtern);
                  
                        if
                          VerkaufbareGebäudeErmitteln (StadtRasseNummerExtern => StadtRasseNummerExtern) = True
                        then
                           null;
                        
                        else
                           exit AuswahlSchleife;
                        end if;
                  end case;
               end if;
               
            when TastenbelegungDatentypen.Menü_Zurück_Enum =>
               exit AuswahlSchleife;
               
            when others =>
               null;
         end case;
         
      end loop AuswahlSchleife;
      
   end GebäudeVerkaufen;

end GebaeudeVerkaufenLogik;
