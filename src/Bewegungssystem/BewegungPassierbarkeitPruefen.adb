pragma SPARK_Mode (On);

with Ada.Wide_Wide_Text_IO;
use Ada.Wide_Wide_Text_IO;

with GlobaleKonstanten;

with EinheitenDatenbank, KartenDatenbank, VerbesserungenDatenbank;

with EinheitSuchen, StadtSuchen, UmgebungErreichbarTesten;

package body BewegungPassierbarkeitPruefen is
   
   function FeldFürDieseEinheitPassierbarNeu
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      NeuePositionExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord)
      return GlobaleDatentypen.Bewegung_Enum
   is begin
      
      case
        EinfachePassierbarkeitPrüfenNummer (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                             NeuePositionExtern       => NeuePositionExtern)
      is
         when True =>
            return GlobaleDatentypen.Normale_Bewegung_Möglich;
            
         when False =>
            null;
      end case;
      
      BewegungMöglich := GlobaleDatentypen.Leer;
      
      -- Passierbarkeit: Boden, Wasser, Luft, Weltraum, Unterwasser, Unterirdisch (Erde), Planeteninneres (Gestein), Lava
      PassierbarSchleife:
      for PassierbarkeitSchleifenwert in GlobaleDatentypen.Passierbarkeit_Vorhanden_Enum'Range loop
         if
           EinheitenDatenbank.EinheitenListe
             (EinheitRasseNummerExtern.Rasse, GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).ID).Passierbarkeit (PassierbarkeitSchleifenwert) = True
           and
             PassierbarkeitSchleifenwert = GlobaleDatentypen.Boden
         then
            BewegungMöglich := Boden (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                       NeuePositionExtern       => NeuePositionExtern);

         elsif
           EinheitenDatenbank.EinheitenListe
             (EinheitRasseNummerExtern.Rasse, GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).ID).Passierbarkeit (PassierbarkeitSchleifenwert) = True
           and
             PassierbarkeitSchleifenwert = GlobaleDatentypen.Wasser
         then
            BewegungMöglich := Wasser (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                        NeuePositionExtern       => NeuePositionExtern);
         
         elsif
           EinheitenDatenbank.EinheitenListe
             (EinheitRasseNummerExtern.Rasse, GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).ID).Passierbarkeit (PassierbarkeitSchleifenwert) = True
           and
             PassierbarkeitSchleifenwert = GlobaleDatentypen.Luft
         then
            null;
         
         elsif
           EinheitenDatenbank.EinheitenListe
             (EinheitRasseNummerExtern.Rasse, GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).ID).Passierbarkeit (PassierbarkeitSchleifenwert) = True
           and
             PassierbarkeitSchleifenwert = GlobaleDatentypen.Weltraum
         then
            null;
         
         elsif
           EinheitenDatenbank.EinheitenListe
             (EinheitRasseNummerExtern.Rasse, GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).ID).Passierbarkeit (PassierbarkeitSchleifenwert) = True
           and
             PassierbarkeitSchleifenwert = GlobaleDatentypen.Unterwasser
         then
            null;
         
         elsif
           EinheitenDatenbank.EinheitenListe
             (EinheitRasseNummerExtern.Rasse, GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).ID).Passierbarkeit (PassierbarkeitSchleifenwert) = True
           and
             PassierbarkeitSchleifenwert = GlobaleDatentypen.Unteridrisch
         then
            null;
         
         elsif
           EinheitenDatenbank.EinheitenListe
             (EinheitRasseNummerExtern.Rasse, GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).ID).Passierbarkeit (PassierbarkeitSchleifenwert) = True
           and
             PassierbarkeitSchleifenwert = GlobaleDatentypen.Planeteninneres
         then
            null;
         
         elsif
           EinheitenDatenbank.EinheitenListe
             (EinheitRasseNummerExtern.Rasse, GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).ID).Passierbarkeit (PassierbarkeitSchleifenwert) = True
           and
             PassierbarkeitSchleifenwert = GlobaleDatentypen.Lava
         then
            null;
         
         else
            -- Nicht für eine Passierbarkeit nutzen, da sonst bei einer Änderung immer alles im else angepasst werden muss!
            null;
         end if;

         case
           BewegungMöglich
         is
            when GlobaleDatentypen.Leer | GlobaleDatentypen.Keine_Bewegung_Möglich =>
               null;
               
            when others =>
               return BewegungMöglich;
         end case;

      end loop PassierbarSchleife;
      
      return GlobaleDatentypen.Keine_Bewegung_Möglich;

   end FeldFürDieseEinheitPassierbarNeu;
   
   
   
   function EinfachePassierbarkeitPrüfenNummer
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      NeuePositionExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord)
      return Boolean
   is begin
            
      PassierbarkeitSchleife:
      for PassierbarkeitSchleifenwert in GlobaleDatentypen.Passierbarkeit_Vorhanden_Enum'Range loop
         
         if
           EinheitenDatenbank.EinheitenListe
             (EinheitRasseNummerExtern.Rasse, GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).ID).Passierbarkeit (PassierbarkeitSchleifenwert) = True
         then
            Passierbar := True;
            
         else
            Passierbar := False;
         end if;         
         
         case
           Passierbar
         is
            when False =>
               null;
               
            when True =>               
               -- Erste Prüfung ist für Zeug wie Sperre gedacht, nicht entfernen.
               if
                 Karten.Weltkarte (NeuePositionExtern.EAchse, NeuePositionExtern.YAchse, NeuePositionExtern.XAchse).VerbesserungGebiet /= GlobaleDatentypen.Leer
                 and
                   VerbesserungenDatenbank.VerbesserungListe
                     (Karten.Weltkarte (NeuePositionExtern.EAchse, NeuePositionExtern.YAchse, NeuePositionExtern.XAchse).VerbesserungGebiet).Passierbarkeit (PassierbarkeitSchleifenwert) = False
               then
                  null;
                  
               elsif
                 (Karten.Weltkarte (NeuePositionExtern.EAchse, NeuePositionExtern.YAchse, NeuePositionExtern.XAchse).VerbesserungStraße /= GlobaleDatentypen.Leer
                  and
                    VerbesserungenDatenbank.VerbesserungListe
                      (Karten.Weltkarte (NeuePositionExtern.EAchse, NeuePositionExtern.YAchse, NeuePositionExtern.XAchse).VerbesserungStraße).Passierbarkeit (PassierbarkeitSchleifenwert) = True)
                 or
                   (Karten.Weltkarte (NeuePositionExtern.EAchse, NeuePositionExtern.YAchse, NeuePositionExtern.XAchse).VerbesserungGebiet /= GlobaleDatentypen.Leer
                    and
                      VerbesserungenDatenbank.VerbesserungListe
                        (Karten.Weltkarte (NeuePositionExtern.EAchse, NeuePositionExtern.YAchse, NeuePositionExtern.XAchse).VerbesserungGebiet).Passierbarkeit (PassierbarkeitSchleifenwert) = True)
               then
                  return True;
         
               elsif
                 KartenDatenbank.KartenListe (Karten.Weltkarte (NeuePositionExtern.EAchse, NeuePositionExtern.YAchse, NeuePositionExtern.XAchse).Grund).Passierbarkeit (PassierbarkeitSchleifenwert) = True
               then
                  return True;
            
               else
                  null;
               end if;
         end case;
         
      end loop PassierbarkeitSchleife;
      
      return False;
      
   end EinfachePassierbarkeitPrüfenNummer;
   
   
   
   function EinfachePassierbarkeitPrüfenID
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum;
      IDExtern : in GlobaleDatentypen.EinheitenID;
      NeuePositionExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord)
      return Boolean
   is begin
            
      PassierbarkeitSchleife:
      for PassierbarkeitSchleifenwert in GlobaleDatentypen.Passierbarkeit_Vorhanden_Enum'Range loop
         
         if
           EinheitenDatenbank.EinheitenListe (RasseExtern, IDExtern).Passierbarkeit (PassierbarkeitSchleifenwert) = True
         then
            Passierbar := True;
            
         else
            Passierbar := False;
         end if;         
         
         case
           Passierbar
         is
            when False =>
               null;
               
            when True =>               
               -- Erste Prüfung ist für Zeug wie Sperre gedacht, nicht entfernen.
               if
                 Karten.Weltkarte (NeuePositionExtern.EAchse, NeuePositionExtern.YAchse, NeuePositionExtern.XAchse).VerbesserungGebiet /= GlobaleDatentypen.Leer
                 and
                   VerbesserungenDatenbank.VerbesserungListe
                     (Karten.Weltkarte (NeuePositionExtern.EAchse, NeuePositionExtern.YAchse, NeuePositionExtern.XAchse).VerbesserungGebiet).Passierbarkeit (PassierbarkeitSchleifenwert) = False
               then
                  null;
                  
               elsif
                 (Karten.Weltkarte (NeuePositionExtern.EAchse, NeuePositionExtern.YAchse, NeuePositionExtern.XAchse).VerbesserungStraße /= GlobaleDatentypen.Leer
                  and
                    VerbesserungenDatenbank.VerbesserungListe
                      (Karten.Weltkarte (NeuePositionExtern.EAchse, NeuePositionExtern.YAchse, NeuePositionExtern.XAchse).VerbesserungStraße).Passierbarkeit (PassierbarkeitSchleifenwert) = True)
                 or
                   (Karten.Weltkarte (NeuePositionExtern.EAchse, NeuePositionExtern.YAchse, NeuePositionExtern.XAchse).VerbesserungGebiet /= GlobaleDatentypen.Leer
                    and
                      VerbesserungenDatenbank.VerbesserungListe
                        (Karten.Weltkarte (NeuePositionExtern.EAchse, NeuePositionExtern.YAchse, NeuePositionExtern.XAchse).VerbesserungGebiet).Passierbarkeit (PassierbarkeitSchleifenwert) = True)
               then
                  return True;
         
               elsif
                 KartenDatenbank.KartenListe (Karten.Weltkarte (NeuePositionExtern.EAchse, NeuePositionExtern.YAchse, NeuePositionExtern.XAchse).Grund).Passierbarkeit (PassierbarkeitSchleifenwert) = True
               then
                  return True;
            
               else
                  null;
               end if;
         end case;
         
      end loop PassierbarkeitSchleife;
      
      return False;
      
   end EinfachePassierbarkeitPrüfenID;


   function Boden
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      NeuePositionExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord)
      return GlobaleDatentypen.Bewegung_Enum
   is begin
      
      TransporterNummer := EinheitSuchen.KoordinatenTransporterMitRasseSuchen (RasseExtern       => EinheitRasseNummerExtern.Rasse,
                                                                               KoordinatenExtern => NeuePositionExtern);

      case
        TransporterNummer
      is
         when GlobaleKonstanten.RückgabeEinheitStadtNummerFalsch =>
            return GlobaleDatentypen.Keine_Bewegung_Möglich;
               
         when others =>
            null;
      end case;

      if
        EinheitenDatenbank.EinheitenListe (EinheitRasseNummerExtern.Rasse, GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).ID).KannTransportiertWerden > 0
        and
          EinheitenDatenbank.EinheitenListe (EinheitRasseNummerExtern.Rasse, GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).ID).KannTransportiertWerden 
            <= EinheitenDatenbank.EinheitenListe (EinheitRasseNummerExtern.Rasse, GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, TransporterNummer).ID).KannTransportieren
      then
         Transportplatz := 0;
         FreierPlatzSchleife:
         for FreierPlatzSchleifenwert in GlobaleRecords.TransporterArray'Range loop
                        
            case
              GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, TransporterNummer).Transportiert (FreierPlatzSchleifenwert)
            is
               when 0 =>
                  Transportplatz := FreierPlatzSchleifenwert;
                  exit FreierPlatzSchleife;
                              
               when others =>
                  null;
            end case;
                        
         end loop FreierPlatzSchleife;

         case
           Transportplatz
         is
            when 0 =>
               return GlobaleDatentypen.Keine_Bewegung_Möglich;
                           
            when others =>
               return Beladen_Bewegung_Möglich;
         end case;

      else
         return GlobaleDatentypen.Keine_Bewegung_Möglich;
      end if;
      
   end Boden;



   function Wasser
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      NeuePositionExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord)
      return
     GlobaleDatentypen.Bewegung_Enum
   is begin
      
      StadtNummer := StadtSuchen.KoordinatenStadtMitRasseSuchen (RasseExtern       => EinheitRasseNummerExtern.Rasse,
                                                                 KoordinatenExtern => NeuePositionExtern);
         
      case
        StadtNummer
      is
         when GlobaleKonstanten.RückgabeEinheitStadtNummerFalsch =>
            return GlobaleDatentypen.Keine_Bewegung_Möglich;
               
         when others =>
            null;
      end case;
      
      case
        EinheitSuchen.KoordinatenEinheitMitRasseSuchen (RasseExtern       => EinheitRasseNummerExtern.Rasse,
                                                        KoordinatenExtern => NeuePositionExtern)
      is
         when GlobaleKonstanten.RückgabeEinheitStadtNummerFalsch =>
            null;
            
         when others =>
            return GlobaleDatentypen.Keine_Bewegung_Möglich;
      end case;

      if
        EinheitenDatenbank.EinheitenListe (EinheitRasseNummerExtern.Rasse, GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).ID).KannTransportieren /= 0
      then
         BenötigteFelder := 1;
         EntladungMöglich := True;
         
         BelegterPlatzSchleife:
         for BelegterPlatzSchleifenwert in GlobaleRecords.TransporterArray'Range loop
                        
            case
              GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Transportiert (BelegterPlatzSchleifenwert)
            is
               when 0 =>
                  null;
                              
               when others =>
                  KartenWert := UmgebungErreichbarTesten.UmgebungErreichbarTesten (AktuelleKoordinatenExtern => NeuePositionExtern,
                                                                                   RasseExtern               => EinheitRasseNummerExtern.Rasse,
                                                                                   IDExtern                  => GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse,
                                                                                     GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse,
                                                                                       EinheitRasseNummerExtern.Platznummer).Transportiert (BelegterPlatzSchleifenwert)).ID,
                                                                                   NotwendigeFelderExtern    => BenötigteFelder);
                  
                  if
                    KartenWert.XAchse = 0
                  then
                     EntladungMöglich := False;
                     exit BelegterPlatzSchleife;
                     
                  else
                     BenötigteFelder := BenötigteFelder + 1;
                  end if;
            end case;
                
         end loop BelegterPlatzSchleife;
         
         case
           EntladungMöglich
         is
            when True =>
               return GlobaleDatentypen.Transporter_Stadt_Möglich;
                          
            when False =>
               return GlobaleDatentypen.Keine_Bewegung_Möglich;
         end case;

      else
         return GlobaleDatentypen.Normale_Bewegung_Möglich;
      end if;

   end Wasser;

end BewegungPassierbarkeitPruefen;
