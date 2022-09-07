pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with StadtKonstanten;
with GrafikDatentypen;
with TastenbelegungDatentypen;

with InDerStadtBauen;
with TasteneingabeLogik;
with EinwohnerZuweisenEntfernen;
with GebaeudeVerkaufen;
with NachGrafiktask;
with Mausauswahl;
with StadtEntfernen;
with StadtAllgemeinLogik;

package body InDerStadt is

   procedure InDerStadt
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord)
   is begin
      
      NachGrafiktask.AktuelleStadt := StadtRasseNummerExtern.Nummer;
      NachGrafiktask.AktuelleDarstellung := GrafikDatentypen.Grafik_Stadtkarte_Enum;
      
      StadtSchleife:
      loop
         
         case
           TasteneingabeLogik.Tastenwert
         is
            when TastenbelegungDatentypen.Auswählen_Enum =>
               if
                 WasIstAusgewählt (StadtRasseNummerExtern => StadtRasseNummerExtern) = False
               then
                  null;
                  
               else
                  exit StadtSchleife;
               end if;
               
            when TastenbelegungDatentypen.Bauen_Enum =>
               InDerStadtBauen.Bauen (StadtRasseNummerExtern => StadtRasseNummerExtern);
               
            when TastenbelegungDatentypen.Auflösen_Enum =>
               GebaeudeVerkaufen.GebäudeVerkaufen (StadtRasseNummerExtern => StadtRasseNummerExtern);

            when TastenbelegungDatentypen.Stadt_Umbenennen_Enum =>
               StadtAllgemeinLogik.NeuerStadtname (StadtRasseNummerExtern => StadtRasseNummerExtern);

            when TastenbelegungDatentypen.Menü_Zurück_Enum =>
               exit StadtSchleife;
               
            when others =>
               null;
         end case;
         
      end loop StadtSchleife;
      
      NachGrafiktask.AktuelleDarstellung := GrafikDatentypen.Grafik_Pause_Enum;
      NachGrafiktask.AktuelleStadt := StadtKonstanten.LeerNummer;
      
   end InDerStadt;
   
   
   
   function WasIstAusgewählt
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord)
      return Boolean
   is begin
      
      case
        EinwohnerZuweisenEntfernen.EinwohnerZuweisenEntfernen (StadtRasseNummerExtern => StadtRasseNummerExtern)
      is
         when True =>
            return False;
            
         when others =>
            Befehlsauswahl := Mausauswahl.Stadtbefehle;
      end case;
            
      case
        Befehlsauswahl
      is
         when 0 =>
            null;
            
         when others =>
            return Mausbefehle (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                AuswahlExtern          => Befehlsauswahl);
      end case;
      
      return False;
            
   end WasIstAusgewählt;
   
   
   
   function Mausbefehle
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord;
      AuswahlExtern : in Positive)
      return Boolean
   is begin
      
      case
        AuswahlExtern
      is
         when 1 =>
            InDerStadtBauen.Bauen (StadtRasseNummerExtern => StadtRasseNummerExtern);
            
         when 2 =>
            null;
            
         when 3 =>
            StadtAllgemeinLogik.NeuerStadtname (StadtRasseNummerExtern => StadtRasseNummerExtern);
            
         when 4 =>
            StadtEntfernen.StadtAbreißen (StadtRasseNummerExtern => StadtRasseNummerExtern);
            return True;
            
         when others =>
            return True;
      end case;
      
      return False;
      
   end Mausbefehle;

end InDerStadt;
