with WichtigesKonstanten;
with KartenKonstanten;

with KIKonstanten;

with LeseGebaeudeDatenbank;
with LeseStadtGebaut;
with LeseWichtiges;

with GebaeudeAllgemeinLogik;
with KIKriegErmittelnLogik;

package body KIGebaeudeBauenLogik is

   function GebäudeBauen
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord)
      return KIRecords.GebäudeIDBewertungRecord
   is
      use type KIDatentypen.BauenBewertung;
      use type StadtDatentypen.GebäudeIDMitNullwert;
   begin
      
      GebäudeBewertet := KIKonstanten.LeerGebäudebewertung;
      
      GebäudeSchleife:
      for GebäudeSchleifenwert in StadtRecords.GebäudeVorhandenArray'Range loop
         
         case
           GebaeudeAllgemeinLogik.GebäudeAnforderungenErfüllt (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                                                 IDExtern               => GebäudeSchleifenwert)
         is
            when True =>
               Gebäudewertung := GebäudeBewerten (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                                    IDExtern               => GebäudeSchleifenwert);
               
               if
                 Gebäudewertung < KIKonstanten.LeerBewertung
               then
                  null;
                     
               elsif
                 GebäudeBewertet.ID = StadtKonstanten.LeerGebäudeID
                 or
                   GebäudeBewertet.Bewertung < Gebäudewertung
               then
                  GebäudeBewertet := (GebäudeSchleifenwert, Gebäudewertung);

               else
                  null;
               end if;

            when False =>
               null;
         end case;
         
      end loop GebäudeSchleife;
      
      return GebäudeBewertet;
      
   end GebäudeBauen;
   
   
   
   function GebäudeBewerten
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord;
      IDExtern : in StadtDatentypen.GebäudeID)
      return KIDatentypen.BauenBewertung
   is
      use type KIDatentypen.BauenBewertung;
   begin
      
      Gesamtwertung := KIKonstanten.LeerBewertung;
      
      Gesamtwertung := Gesamtwertung + NahrungsproduktionBewerten (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                                                   IDExtern               => IDExtern);
      Gesamtwertung := Gesamtwertung + GeldproduktionBewerten (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                                               IDExtern               => IDExtern);
      Gesamtwertung := Gesamtwertung + WissensgewinnBewerten (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                                              IDExtern               => IDExtern);
      Gesamtwertung := Gesamtwertung + RessourcenproduktionBewerten (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                                                     IDExtern               => IDExtern);
      Gesamtwertung := Gesamtwertung + VerteidigungBewerten (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                                             IDExtern               => IDExtern);
      Gesamtwertung := Gesamtwertung + AngriffBewerten (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                                        IDExtern               => IDExtern);
      Gesamtwertung := Gesamtwertung + KostenBewerten (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                                       IDExtern               => IDExtern);
      
      return Gesamtwertung;
            
   end GebäudeBewerten;
   
   
   
   -- Mal die Abfragen in ein lokale Variable schieben. äöü
   function NahrungsproduktionBewerten
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord;
      IDExtern : in StadtDatentypen.GebäudeID)
      return KIDatentypen.BauenBewertung
   is
      use type ProduktionDatentypen.Produktion;
      use type KIDatentypen.BauenBewertung;
   begin
      
      Produktion := LeseStadtGebaut.Nahrungsproduktion (StadtRasseNummerExtern => StadtRasseNummerExtern);
      
      if
        Produktion < StadtKonstanten.LeerNahrungsproduktion
        and
          StadtKonstanten.LeerNahrungsproduktion < Produktion + LeseGebaeudeDatenbank.WirtschaftBonus (RasseExtern            => StadtRasseNummerExtern.Rasse,
                                                                                                       IDExtern               => IDExtern,
                                                                                                       WirtschaftBonusExtern => KartenKonstanten.WirtschaftNahrung)
      then
         return 20;
         
      elsif
        Produktion < StadtKonstanten.LeerNahrungsproduktion
        and
          LeseGebaeudeDatenbank.WirtschaftBonus (RasseExtern            => StadtRasseNummerExtern.Rasse,
                                                 IDExtern               => IDExtern,
                                                 WirtschaftBonusExtern => KartenKonstanten.WirtschaftNahrung)
        > StadtKonstanten.LeerNahrungsproduktion
      then
         return 10;
         
      elsif
        Produktion < StadtKonstanten.LeerNahrungsproduktion
        and
          StadtKonstanten.LeerNahrungsproduktion = LeseGebaeudeDatenbank.WirtschaftBonus (RasseExtern            => StadtRasseNummerExtern.Rasse,
                                                                                          IDExtern               => IDExtern,
                                                                                          WirtschaftBonusExtern => KartenKonstanten.WirtschaftNahrung)
      then
         return 5;
      
      elsif
        StadtKonstanten.LeerNahrungsproduktion >= Produktion - LeseGebaeudeDatenbank.PermanenteKosten (RasseExtern        => StadtRasseNummerExtern.Rasse,
                                                                                                       IDExtern           => IDExtern,
                                                                                                       WelcheKostenExtern => ProduktionDatentypen.Nahrung_Enum)
      then
         return -20;
         
      else
         return KIDatentypen.BauenBewertung (LeseGebaeudeDatenbank.WirtschaftBonus (RasseExtern            => StadtRasseNummerExtern.Rasse,
                                                                                    IDExtern               => IDExtern,
                                                                                    WirtschaftBonusExtern => KartenKonstanten.WirtschaftNahrung)
                                             - LeseGebaeudeDatenbank.PermanenteKosten (RasseExtern        => StadtRasseNummerExtern.Rasse,
                                                                                       IDExtern           => IDExtern,
                                                                                       WelcheKostenExtern => ProduktionDatentypen.Nahrung_Enum));
      end if;
      
   end NahrungsproduktionBewerten;
   
   
   
   function GeldproduktionBewerten
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord;
      IDExtern : in StadtDatentypen.GebäudeID)
      return KIDatentypen.BauenBewertung
   is
      use type ProduktionDatentypen.Produktion;
      use type KIDatentypen.BauenBewertung;
   begin
      
      Produktion := LeseWichtiges.GeldZugewinnProRunde (RasseExtern => StadtRasseNummerExtern.Rasse);
      
      if
        Produktion < WichtigesKonstanten.LeerGeldZugewinnProRunde
        and
          WichtigesKonstanten.LeerGeldZugewinnProRunde < Produktion + LeseGebaeudeDatenbank.WirtschaftBonus (RasseExtern           => StadtRasseNummerExtern.Rasse,
                                                                                                             IDExtern              => IDExtern,
                                                                                                             WirtschaftBonusExtern => KartenKonstanten.WirtschaftGeld)
      then
         return 20;
         
      elsif
        Produktion < WichtigesKonstanten.LeerGeldZugewinnProRunde
        and
          LeseGebaeudeDatenbank.WirtschaftBonus (RasseExtern           => StadtRasseNummerExtern.Rasse,
                                                 IDExtern              => IDExtern,
                                                 WirtschaftBonusExtern => KartenKonstanten.WirtschaftGeld)
        > StadtKonstanten.LeerGeldgewinnung
      then
         return 10;
         
      elsif
        Produktion < WichtigesKonstanten.LeerGeldZugewinnProRunde
        and
          StadtKonstanten.LeerGeldgewinnung = LeseGebaeudeDatenbank.WirtschaftBonus (RasseExtern           => StadtRasseNummerExtern.Rasse,
                                                                                     IDExtern              => IDExtern,
                                                                                     WirtschaftBonusExtern => KartenKonstanten.WirtschaftGeld)
      then
         return 5;
         
      elsif
        WichtigesKonstanten.LeerGeldZugewinnProRunde >= Produktion - LeseGebaeudeDatenbank.PermanenteKosten (RasseExtern        => StadtRasseNummerExtern.Rasse,
                                                                                                             IDExtern           => IDExtern,
                                                                                                             WelcheKostenExtern => ProduktionDatentypen.Geld_Enum)
      then
         return -20;
         
      else
         return KIDatentypen.BauenBewertung (LeseGebaeudeDatenbank.WirtschaftBonus (RasseExtern           => StadtRasseNummerExtern.Rasse,
                                                                                    IDExtern              => IDExtern,
                                                                                    WirtschaftBonusExtern => KartenKonstanten.WirtschaftGeld)
                                             - LeseGebaeudeDatenbank.PermanenteKosten (RasseExtern        => StadtRasseNummerExtern.Rasse,
                                                                                       IDExtern           => IDExtern,
                                                                                       WelcheKostenExtern => ProduktionDatentypen.Geld_Enum));
      end if;
      
   end GeldproduktionBewerten;
   
   
     
   function WissensgewinnBewerten
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord;
      IDExtern : in StadtDatentypen.GebäudeID)
      return KIDatentypen.BauenBewertung
   is
      use type ProduktionDatentypen.Produktion;
   begin
      
      Produktion := LeseStadtGebaut.Forschungsrate (StadtRasseNummerExtern => StadtRasseNummerExtern);
      
      if
        Produktion = StadtKonstanten.LeerForschungsrate
        and
          LeseGebaeudeDatenbank.WirtschaftBonus (RasseExtern           => StadtRasseNummerExtern.Rasse,
                                                 IDExtern              => IDExtern,
                                                 WirtschaftBonusExtern => KartenKonstanten.WirtschaftForschung)
        > WichtigesKonstanten.LeerGesamteForschungsrate
      then
         return 5;
         
      else
         return KIDatentypen.BauenBewertung (LeseGebaeudeDatenbank.WirtschaftBonus (RasseExtern           => StadtRasseNummerExtern.Rasse,
                                                                                    IDExtern              => IDExtern,
                                                                                    WirtschaftBonusExtern => KartenKonstanten.WirtschaftForschung));
      end if;
      
   end WissensgewinnBewerten;
   
     
          
   function RessourcenproduktionBewerten
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord;
      IDExtern : in StadtDatentypen.GebäudeID)
      return KIDatentypen.BauenBewertung
   is
      use type ProduktionDatentypen.Produktion;
      use type KIDatentypen.BauenBewertung;
   begin
      
      Produktion := LeseStadtGebaut.Produktionrate (StadtRasseNummerExtern => StadtRasseNummerExtern);
      
      if
        Produktion < StadtKonstanten.LeerProduktionrate
        and
          StadtKonstanten.LeerProduktionrate < Produktion + LeseGebaeudeDatenbank.WirtschaftBonus (RasseExtern           => StadtRasseNummerExtern.Rasse,
                                                                                                   IDExtern              => IDExtern,
                                                                                                   WirtschaftBonusExtern => KartenKonstanten.WirtschaftProduktion)
      then
         return 20;
         
      elsif
        Produktion < StadtKonstanten.LeerProduktionrate
        and
          StadtKonstanten.LeerProduktionrate <= Produktion + LeseGebaeudeDatenbank.WirtschaftBonus (RasseExtern           => StadtRasseNummerExtern.Rasse,
                                                                                                    IDExtern              => IDExtern,
                                                                                                    WirtschaftBonusExtern => KartenKonstanten.WirtschaftProduktion)
      then
         return 10;
         
      elsif
        Produktion < StadtKonstanten.LeerProduktionrate
        and
          StadtKonstanten.LeerProduktionrate = Produktion + LeseGebaeudeDatenbank.WirtschaftBonus (RasseExtern           => StadtRasseNummerExtern.Rasse,
                                                                                                   IDExtern              => IDExtern,
                                                                                                   WirtschaftBonusExtern => KartenKonstanten.WirtschaftProduktion)
      then
         return 5;
         
      elsif
        StadtKonstanten.LeerProduktionrate >= Produktion - LeseGebaeudeDatenbank.PermanenteKosten (RasseExtern        => StadtRasseNummerExtern.Rasse,
                                                                                                   IDExtern           => IDExtern,
                                                                                                   WelcheKostenExtern => ProduktionDatentypen.Produktion_Enum)
      then
         return -20;
         
      else
         return KIDatentypen.BauenBewertung (LeseGebaeudeDatenbank.WirtschaftBonus (RasseExtern           => StadtRasseNummerExtern.Rasse,
                                                                                    IDExtern              => IDExtern,
                                                                                    WirtschaftBonusExtern => KartenKonstanten.WirtschaftProduktion)
                                             - LeseGebaeudeDatenbank.PermanenteKosten (RasseExtern        => StadtRasseNummerExtern.Rasse,
                                                                                       IDExtern           => IDExtern,
                                                                                       WelcheKostenExtern => ProduktionDatentypen.Produktion_Enum));
      end if;
      
   end RessourcenproduktionBewerten;
     
   
     
   function VerteidigungBewerten
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord;
      IDExtern : in StadtDatentypen.GebäudeID)
      return KIDatentypen.BauenBewertung
   is
      use type KIDatentypen.BauenBewertung;
   begin
      
      case
        KIKriegErmittelnLogik.IstImKrieg (RasseExtern => StadtRasseNummerExtern.Rasse)
      is
         when True =>
            return 2 * KIDatentypen.BauenBewertung (LeseGebaeudeDatenbank.KampfBonus (RasseExtern      => StadtRasseNummerExtern.Rasse,
                                                                                      IDExtern         => IDExtern,
                                                                                      KampfBonusExtern => KartenKonstanten.KampfVerteidigung));
            
         when False =>
            return KIDatentypen.BauenBewertung (LeseGebaeudeDatenbank.KampfBonus (RasseExtern      => StadtRasseNummerExtern.Rasse,
                                                                                  IDExtern         => IDExtern,
                                                                                  KampfBonusExtern => KartenKonstanten.KampfVerteidigung));
      end case;
      
   end VerteidigungBewerten;
     
   
     
   function AngriffBewerten
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord;
      IDExtern : in StadtDatentypen.GebäudeID)
      return KIDatentypen.BauenBewertung
   is
      use type KIDatentypen.BauenBewertung;
   begin
      
      case
        KIKriegErmittelnLogik.IstImKrieg (RasseExtern => StadtRasseNummerExtern.Rasse)
      is
         when True =>
            return 2 * KIDatentypen.BauenBewertung (LeseGebaeudeDatenbank.KampfBonus (RasseExtern      => StadtRasseNummerExtern.Rasse,
                                                                                      IDExtern         => IDExtern,
                                                                                      KampfBonusExtern => KartenKonstanten.KampfAngriff));
            
         when False =>
            return KIDatentypen.BauenBewertung (LeseGebaeudeDatenbank.KampfBonus (RasseExtern      => StadtRasseNummerExtern.Rasse,
                                                                                  IDExtern         => IDExtern,
                                                                                  KampfBonusExtern => KartenKonstanten.KampfAngriff));
      end case;
      
   end AngriffBewerten;
     
   
     
   function KostenBewerten
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord;
      IDExtern : in StadtDatentypen.GebäudeID)
      return KIDatentypen.BauenBewertung
   is
      use type KIDatentypen.BauenBewertung;
      use type ProduktionDatentypen.Produktion;
   begin
      
      return -(KIDatentypen.BauenBewertung (LeseGebaeudeDatenbank.Produktionskosten (RasseExtern => StadtRasseNummerExtern.Rasse,
                                                                                     IDExtern    => IDExtern)
               / LeseStadtGebaut.Produktionrate (StadtRasseNummerExtern => StadtRasseNummerExtern)
               / 10));
      
   end KostenBewerten;

end KIGebaeudeBauenLogik;
