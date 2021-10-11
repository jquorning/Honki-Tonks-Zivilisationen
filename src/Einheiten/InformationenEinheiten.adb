pragma SPARK_Mode (On);

with Ada.Wide_Wide_Text_IO; use Ada.Wide_Wide_Text_IO;
with Ada.Float_Text_IO;
with Ada.Integer_Text_IO;

with EinheitStadtDatentypen; use EinheitStadtDatentypen;
with GlobaleTexte;
with EinheitenKonstanten;

with LeseEinheitenGebaut;
with LeseEinheitenDatenbank;

with Anzeige;
with EinheitenBeschreibungen;
with StadtInformationen;
with KampfwerteEinheitErmitteln;
with Cheat;

package body InformationenEinheiten is

   procedure Einheiten
     (RasseExtern : in SonstigeDatentypen.Rassen_Verwendet_Enum;
      EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
   is begin
      
      EinheitRasseNummer := Allgemeines (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      Lebenspunkte (EinheitRasseNummerExtern => EinheitRasseNummer);
      
      if
        RasseExtern = EinheitRasseNummerExtern.Rasse
        or
          Cheat.FeindlicheInformationenSehen
      then
         Bewegungspunkte (EinheitRasseNummerExtern => EinheitRasseNummer);
         Erfahrungspunkte (EinheitRasseNummerExtern => EinheitRasseNummer);
         Beschäftigung (EinheitRasseNummerExtern => EinheitRasseNummer);
         Beschäftigungszeit (EinheitRasseNummerExtern => EinheitRasseNummer);
         Angriff (EinheitRasseNummerExtern => EinheitRasseNummer);
         Verteidigung (EinheitRasseNummerExtern => EinheitRasseNummer);
         Rang (EinheitRasseNummerExtern => EinheitRasseNummer);
         Heimatstadt (EinheitRasseNummerExtern => EinheitRasseNummer);
         AktuelleVerteidigung (EinheitRasseNummerExtern => EinheitRasseNummer);
         AktuellerAngriff (EinheitRasseNummerExtern => EinheitRasseNummer);
         Ladung (EinheitRasseNummerExtern => EinheitRasseNummer);
         
      else
         null;
      end if;
                        
      New_Line;
      Gecheatet (EinheitRasseNummerExtern => EinheitRasseNummer);
      
   end Einheiten;
   
   
   
   function Allgemeines
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
      return EinheitStadtRecords.RassePlatznummerRecord
   is begin
            
      case
        LeseEinheitenGebaut.WirdTransportiert (EinheitRasseNummerExtern => EinheitRasseNummerExtern)
      is
         when EinheitenKonstanten.LeerWirdTransportiert =>
            EinheitNummer := EinheitRasseNummerExtern.Platznummer;
                        
         when others =>
            EinheitNummer := LeseEinheitenGebaut.WirdTransportiert (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      end case;
      EinheitenBeschreibungen.BeschreibungKurz (IDExtern => LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => (EinheitRasseNummerExtern.Rasse, EinheitNummer)));
      New_Line;
      
      return (EinheitRasseNummerExtern.Rasse, EinheitNummer);
      
   end Allgemeines;
   
   
   
   procedure Lebenspunkte
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
   is begin
      
      Anzeige.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleTexte.Leer,
                                     TextDateiExtern        => GlobaleTexte.Zeug,
                                     ÜberschriftZeileExtern => 0,
                                     ErsteZeileExtern       => 14,
                                     LetzteZeileExtern      => 14,
                                     AbstandAnfangExtern    => GlobaleTexte.Großer_Abstand,
                                     AbstandMitteExtern     => GlobaleTexte.Leer,
                                     AbstandEndeExtern      => GlobaleTexte.Kleiner_Abstand);
      
      Ada.Integer_Text_IO.Put (Item  => Natural (LeseEinheitenGebaut.Lebenspunkte (EinheitRasseNummerExtern => EinheitRasseNummerExtern)),
                               Width => 1);
      Put (Item => " / ");
      Ada.Integer_Text_IO.Put (Item  => Positive (LeseEinheitenDatenbank.MaximaleLebenspunkte (RasseExtern => EinheitRasseNummerExtern.Rasse,
                                                                                               IDExtern    => LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => EinheitRasseNummerExtern))),
                               Width => 1);
      
   end Lebenspunkte;
   
   
   
   procedure Bewegungspunkte
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
   is begin
      
      Anzeige.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleTexte.Leer,
                                     TextDateiExtern        => GlobaleTexte.Zeug,
                                     ÜberschriftZeileExtern => 0,
                                     ErsteZeileExtern       => 15,
                                     LetzteZeileExtern      => 15,
                                     AbstandAnfangExtern    => GlobaleTexte.Großer_Abstand,
                                     AbstandMitteExtern     => GlobaleTexte.Leer,
                                     AbstandEndeExtern      => GlobaleTexte.Kleiner_Abstand);
      Ada.Float_Text_IO.Put (Item => Float (LeseEinheitenGebaut.Bewegungspunkte (EinheitRasseNummerExtern => EinheitRasseNummerExtern)),
                             Fore => 1,
                             Aft  => 2,
                             Exp  => 0);
      Put (Item => " / ");
      Ada.Float_Text_IO.Put (Item => Float (LeseEinheitenDatenbank.MaximaleBewegungspunkte (RasseExtern => EinheitRasseNummerExtern.Rasse,
                                                                                            IDExtern    => LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => EinheitRasseNummerExtern))),
                             Fore => 1,
                             Aft  => 2,
                             Exp  => 0);
      
   end Bewegungspunkte;
   
   
   
   procedure Erfahrungspunkte
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
   is begin
      
      Anzeige.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleTexte.Leer,
                                     TextDateiExtern        => GlobaleTexte.Zeug,
                                     ÜberschriftZeileExtern => 0,
                                     ErsteZeileExtern       => 16,
                                     LetzteZeileExtern      => 16,
                                     AbstandAnfangExtern    => GlobaleTexte.Großer_Abstand,
                                     AbstandMitteExtern     => GlobaleTexte.Leer,
                                     AbstandEndeExtern      => GlobaleTexte.Kleiner_Abstand);
      Ada.Integer_Text_IO.Put (Item  => Natural (LeseEinheitenGebaut.Erfahrungspunkte (EinheitRasseNummerExtern => EinheitRasseNummerExtern)),
                               Width => 1);
      Put (Item => " / ");
      Ada.Integer_Text_IO.Put (Item  => Natural (LeseEinheitenDatenbank.Beförderungsgrenze (RasseExtern => EinheitRasseNummerExtern.Rasse,
                                                                                             IDExtern    => LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => EinheitRasseNummerExtern))),
                               Width => 1);
      New_Line;
      
   end Erfahrungspunkte;
   
   
   
   procedure Beschäftigung
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
   is begin
      
      Anzeige.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleTexte.Leer,
                                     TextDateiExtern        => GlobaleTexte.Zeug,
                                     ÜberschriftZeileExtern => 0,
                                     ErsteZeileExtern       => 17,
                                     LetzteZeileExtern      => 17,
                                     AbstandAnfangExtern    => GlobaleTexte.Großer_Abstand,
                                     AbstandMitteExtern     => GlobaleTexte.Leer,
                                     AbstandEndeExtern      => GlobaleTexte.Kleiner_Abstand);
      EinheitenBeschreibungen.Beschäftigung (LeseEinheitenGebaut.Beschäftigung (EinheitRasseNummerExtern => EinheitRasseNummerExtern));
      
   end Beschäftigung;
   
   
   
   procedure Beschäftigungszeit
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
   is begin
      
      Anzeige.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleTexte.Leer,
                                     TextDateiExtern        => GlobaleTexte.Zeug,
                                     ÜberschriftZeileExtern => 0,
                                     ErsteZeileExtern       => 18,
                                     LetzteZeileExtern      => 18,
                                     AbstandAnfangExtern    => GlobaleTexte.Großer_Abstand,
                                     AbstandMitteExtern     => GlobaleTexte.Leer,
                                     AbstandEndeExtern      => GlobaleTexte.Kleiner_Abstand);
      Ada.Integer_Text_IO.Put (Item  => Natural (LeseEinheitenGebaut.Beschäftigungszeit (EinheitRasseNummerExtern => EinheitRasseNummerExtern)),
                               Width => 1);
      New_Line;
      
   end Beschäftigungszeit;
   
   
   
   procedure Angriff
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
   is begin
      
      Anzeige.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleTexte.Leer,
                                     TextDateiExtern        => GlobaleTexte.Zeug,
                                     ÜberschriftZeileExtern => 0,
                                     ErsteZeileExtern       => 24,
                                     LetzteZeileExtern      => 24,
                                     AbstandAnfangExtern    => GlobaleTexte.Großer_Abstand,
                                     AbstandMitteExtern     => GlobaleTexte.Leer,
                                     AbstandEndeExtern      => GlobaleTexte.Kleiner_Abstand);
      Ada.Integer_Text_IO.Put (Item  => Integer (LeseEinheitenDatenbank.Angriff (RasseExtern => EinheitRasseNummerExtern.Rasse,
                                                                                 IDExtern    => LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => EinheitRasseNummerExtern))),
                               Width => 1);
      
   end Angriff;
   
   
   
   procedure Verteidigung
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
   is begin
      
      Anzeige.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleTexte.Leer,
                                     TextDateiExtern        => GlobaleTexte.Zeug,
                                     ÜberschriftZeileExtern => 0,
                                     ErsteZeileExtern       => 25,
                                     LetzteZeileExtern      => 25,
                                     AbstandAnfangExtern    => GlobaleTexte.Großer_Abstand,
                                     AbstandMitteExtern     => GlobaleTexte.Leer,
                                     AbstandEndeExtern      => GlobaleTexte.Kleiner_Abstand);
      Ada.Integer_Text_IO.Put (Item  => Integer (LeseEinheitenDatenbank.Verteidigung (RasseExtern => EinheitRasseNummerExtern.Rasse,
                                                                                      IDExtern    => LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => EinheitRasseNummerExtern))),
                               Width => 1);
      
   end Verteidigung;
   
   
   
   procedure Rang
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
   is begin
      
      Anzeige.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleTexte.Leer,
                                     TextDateiExtern        => GlobaleTexte.Zeug,
                                     ÜberschriftZeileExtern => 0,
                                     ErsteZeileExtern       => 26,
                                     LetzteZeileExtern      => 26,
                                     AbstandAnfangExtern    => GlobaleTexte.Großer_Abstand,
                                     AbstandMitteExtern     => GlobaleTexte.Leer,
                                     AbstandEndeExtern      => GlobaleTexte.Kleiner_Abstand);
      Ada.Integer_Text_IO.Put (Item  => Natural (LeseEinheitenGebaut.Rang (EinheitRasseNummerExtern => EinheitRasseNummerExtern)),
                               Width => 1);
      Put (Item => " / ");
      Ada.Integer_Text_IO.Put (Item  => Natural (LeseEinheitenDatenbank.MaximalerRang (RasseExtern => EinheitRasseNummerExtern.Rasse,
                                                                                       IDExtern    => LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => EinheitRasseNummerExtern))),
                               Width => 1);
      
   end Rang;
   
   
   
   procedure Heimatstadt
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
   is begin
      
      Anzeige.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleTexte.Leer,
                                     TextDateiExtern        => GlobaleTexte.Zeug,
                                     ÜberschriftZeileExtern => 0,
                                     ErsteZeileExtern       => 52,
                                     LetzteZeileExtern      => 52,
                                     AbstandAnfangExtern    => GlobaleTexte.Großer_Abstand,
                                     AbstandMitteExtern     => GlobaleTexte.Leer,
                                     AbstandEndeExtern      => GlobaleTexte.Kleiner_Abstand);
         
      case
        LeseEinheitenGebaut.Heimatstadt (EinheitRasseNummerExtern => EinheitRasseNummerExtern)
      is
         when EinheitenKonstanten.LeerNummer =>
            Anzeige.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleTexte.Leer,
                                           TextDateiExtern        => GlobaleTexte.Zeug,
                                           ÜberschriftZeileExtern => 0,
                                           ErsteZeileExtern       => 53,
                                           LetzteZeileExtern      => 53,
                                           AbstandAnfangExtern    => GlobaleTexte.Leer,
                                           AbstandMitteExtern     => GlobaleTexte.Leer,
                                           AbstandEndeExtern      => GlobaleTexte.Leer);
               
         when others =>
            StadtInformationen.StadtName (StadtRasseNummerExtern => (EinheitRasseNummerExtern.Rasse, LeseEinheitenGebaut.Heimatstadt (EinheitRasseNummerExtern => EinheitRasseNummerExtern)));
      end case;
      New_Line;
      
   end Heimatstadt;
   
   
   
   procedure AktuelleVerteidigung
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
   is begin
      
      Anzeige.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleTexte.Leer,
                                     TextDateiExtern        => GlobaleTexte.Zeug,
                                     ÜberschriftZeileExtern => 0,
                                     ErsteZeileExtern       => 60,
                                     LetzteZeileExtern      => 60,
                                     AbstandAnfangExtern    => GlobaleTexte.Großer_Abstand,
                                     AbstandMitteExtern     => GlobaleTexte.Leer,
                                     AbstandEndeExtern      => GlobaleTexte.Kleiner_Abstand);
      Ada.Integer_Text_IO.Put (Item  => Integer (KampfwerteEinheitErmitteln.AktuelleVerteidigungEinheit (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                                                                         AngreiferExtern          => False)),
                               Width => 1);
      
   end AktuelleVerteidigung;
   
   
   
   procedure AktuellerAngriff
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
   is begin
      
      Anzeige.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleTexte.Leer,
                                     TextDateiExtern        => GlobaleTexte.Zeug,
                                     ÜberschriftZeileExtern => 0,
                                     ErsteZeileExtern       => 61,
                                     LetzteZeileExtern      => 61,
                                     AbstandAnfangExtern    => GlobaleTexte.Großer_Abstand,
                                     AbstandMitteExtern     => GlobaleTexte.Leer,
                                     AbstandEndeExtern      => GlobaleTexte.Kleiner_Abstand);
      Ada.Integer_Text_IO.Put (Item  => Integer (KampfwerteEinheitErmitteln.AktuellerAngriffEinheit (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                                                                     AngreiferExtern          => False)),
                               Width => 1);
      
   end AktuellerAngriff;
   
   
   
   procedure Ladung
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
   is begin
      
      IDEinheit := LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      
      case
        LeseEinheitenDatenbank.KannTransportieren (RasseExtern => EinheitRasseNummerExtern.Rasse,
                                                   IDExtern    => IDEinheit)
      is
         when EinheitenKonstanten.LeerKannTransportieren =>
            null;
               
         when others =>
            ErsteAnzeige := True;
            
            LadungSchleife:
            for LadungSchleifenwert in EinheitStadtRecords.TransporterArray'First .. LeseEinheitenDatenbank.Transportkapazität (RasseExtern => EinheitRasseNummerExtern.Rasse,
                                                                                                                                 IDExtern    => IDEinheit) loop
                  
               if
                 LeseEinheitenGebaut.Transportiert (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                    PlatzExtern              => LadungSchleifenwert)
                 /= EinheitenKonstanten.LeerTransportiert
                 and
                   ErsteAnzeige
               then
                  New_Line;
                  ErsteAnzeige := False;
                  Anzeige.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleTexte.Zeug,
                                                 TextDateiExtern        => GlobaleTexte.Beschreibungen_Einheiten_Kurz,
                                                 ÜberschriftZeileExtern => 51,
                                                 ErsteZeileExtern       =>
                                                   Positive (LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => (EinheitRasseNummerExtern.Rasse,
                                                                                                                  LeseEinheitenGebaut.Transportiert (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                                                                                                                     PlatzExtern              => LadungSchleifenwert)))),
                                                 LetzteZeileExtern      =>
                                                   Positive (LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => (EinheitRasseNummerExtern.Rasse,
                                                                                                                  LeseEinheitenGebaut.Transportiert (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                                                                                                                     PlatzExtern              => LadungSchleifenwert)))),
                                                 AbstandAnfangExtern    => GlobaleTexte.Großer_Abstand,
                                                 AbstandMitteExtern     => GlobaleTexte.Leer,
                                                 AbstandEndeExtern      => GlobaleTexte.Großer_Abstand);
                     
               elsif
                 LeseEinheitenGebaut.Transportiert (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                    PlatzExtern              => LadungSchleifenwert)
                 /= EinheitenKonstanten.LeerTransportiert
               then
                  Anzeige.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleTexte.Leer,
                                                 TextDateiExtern        => GlobaleTexte.Beschreibungen_Einheiten_Kurz,
                                                 ÜberschriftZeileExtern => 0,
                                                 ErsteZeileExtern       =>
                                                   Positive (LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => (EinheitRasseNummerExtern.Rasse,
                                                                                                                  LeseEinheitenGebaut.Transportiert (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                                                                                                                     PlatzExtern              => LadungSchleifenwert)))),
                                                 LetzteZeileExtern      =>
                                                   Positive (LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => (EinheitRasseNummerExtern.Rasse,
                                                                                                                  LeseEinheitenGebaut.Transportiert (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                                                                                                                     PlatzExtern              => LadungSchleifenwert)))),
                                                 AbstandAnfangExtern    => GlobaleTexte.Leer,
                                                 AbstandMitteExtern     => GlobaleTexte.Leer,
                                                 AbstandEndeExtern      => GlobaleTexte.Großer_Abstand);
                     
               else
                  null;
               end if;
            
            end loop LadungSchleife;
      end case;
         
      New_Line;
      
   end Ladung;
   
   
   
   procedure Gecheatet
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
   is begin
      
      case
        Cheat.FeindlicheInformationenSehen
      is
         when False =>
            null;
            
         when True =>
            Cheat.KarteInfosEinheiten (EinheitRasseNummerExtern => EinheitRasseNummerExtern);                     
      end case;
      
   end Gecheatet;

end InformationenEinheiten;