pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with EinheitStadtDatentypen; use EinheitStadtDatentypen;
with WichtigesKonstanten;
with StadtKonstanten;
with SpielVariablen;

with KIDatentypen; use KIDatentypen;
with KIKonstanten;

with LeseEinheitenDatenbank;
with LeseStadtGebaut;
with LeseWichtiges;

with EinheitenModifizieren;

with KIKriegErmitteln;
with KIStadtLaufendeBauprojekte;

package body KIEinheitenBauen is

   function EinheitenBauen
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
      return KIRecords.EinheitIDBewertungRecord
   is begin
      
      EinheitBewertet := KIKonstanten.LeerEinheitIDBewertung;
      AnzahlStädte := LeseWichtiges.AnzahlStädte (RasseExtern => StadtRasseNummerExtern.Rasse);
      
      if
        LeseWichtiges.AnzahlEinheiten (RasseExtern => StadtRasseNummerExtern.Rasse) > 3 * AnzahlStädte
        or
          LeseWichtiges.AnzahlEinheiten (RasseExtern => StadtRasseNummerExtern.Rasse) = SpielVariablen.Grenzen (StadtRasseNummerExtern.Rasse).Einheitengrenze
      then
         return EinheitBewertet;
         
      else
         return EinheitenDurchgehen (StadtRasseNummerExtern => StadtRasseNummerExtern);
      end if;
      
   end EinheitenBauen;
   
   
   
   function EinheitenDurchgehen
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
      return KIRecords.EinheitIDBewertungRecord
   is begin
      
      EinheitenSchleife:
      for EinheitenSchleifenwert in EinheitStadtDatentypen.EinheitenID'Range loop
         
         case
           EinheitenModifizieren.EinheitAnforderungenErfüllt (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                                               IDExtern               => EinheitenSchleifenwert)
         is
            when True =>
               EinheitBewerten (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                IDExtern               => EinheitenSchleifenwert);
               
            when False =>
               null;
         end case;
                     
      end loop EinheitenSchleife;
      
      return EinheitBewertet;
      
   end EinheitenDurchgehen;
   
   
   
   procedure EinheitBewerten
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      IDExtern : in EinheitStadtDatentypen.EinheitenID)
   is begin
      
      Gesamtwertung := 0;
      Gesamtwertung := Gesamtwertung + KostenBewerten (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                                       EinheitenIDExtern      => IDExtern);
      Gesamtwertung := Gesamtwertung + GeldKostenBewerten (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                                           EinheitenIDExtern      => IDExtern);
      Gesamtwertung := Gesamtwertung + NahrungKostenBewerten (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                                              EinheitenIDExtern      => IDExtern);
      Gesamtwertung := Gesamtwertung + RessourcenKostenBewerten (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                                                 EinheitenIDExtern      => IDExtern);
      Gesamtwertung := Gesamtwertung + SpezielleEinheitBewerten (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                                                 IDExtern               => IDExtern);
      
      
      if
        Gesamtwertung <= 0
      then
         null;
         
      elsif
        EinheitBewertet.Bewertung < Gesamtwertung
      then
         EinheitBewertet := (IDExtern, Gesamtwertung);

      else
         null;
      end if;
      
   end EinheitBewerten;
   
   
   
   function SpezielleEinheitBewerten
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      IDExtern : in EinheitStadtDatentypen.EinheitenID)
      return KIDatentypen.BauenBewertung
   is begin
      
      case
        LeseEinheitenDatenbank.EinheitArt (RasseExtern => StadtRasseNummerExtern.Rasse,
                                           IDExtern    => IDExtern)
      is
         when EinheitStadtDatentypen.Arbeiter_Enum =>
            return ArbeiterBewerten (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                     EinheitenIDExtern      => IDExtern);
            
         when EinheitStadtDatentypen.Nahkämpfer_Enum =>
            return Gesamtwertung + NahkämpferBewerten (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                                        EinheitenIDExtern      => IDExtern);
            
         when EinheitStadtDatentypen.Fernkämpfer_Enum =>
            return Gesamtwertung + FernkämpferBewerten (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                                         EinheitenIDExtern      => IDExtern);
            
         when EinheitStadtDatentypen.Beides_Enum =>
            null;
            
         when EinheitStadtDatentypen.Sonstiges_Enum =>
            null;
            
         when EinheitStadtDatentypen.Cheat_Enum =>
            return KIDatentypen.BauenBewertung'First;
            
         when EinheitStadtDatentypen.Leer_Enum =>
            null;
      end case;
      
      return 0;
      
   end SpezielleEinheitBewerten;
   
   
   
   function ArbeiterBewerten
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      EinheitenIDExtern : in EinheitStadtDatentypen.EinheitenID)
      return KIDatentypen.BauenBewertung
   is begin
      
      MengeVorhanden := LeseWichtiges.AnzahlArbeiter (RasseExtern => StadtRasseNummerExtern.Rasse);
      MengeImBau := KIStadtLaufendeBauprojekte.GleicheEinheitArtBauprojekte (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                                                             EinheitArtExtern       => EinheitStadtDatentypen.Nahkämpfer_Enum);
      
      if
        MengeVorhanden = MinimaleSiedlerMenge
        or
          MengeVorhanden + MengeImBau = MinimaleSiedlerMenge
      then
         return 0;
         
      elsif
        MengeVorhanden > MinimaleSiedlerMenge
        or
          MengeVorhanden + MengeImBau > MinimaleSiedlerMenge
      then
         return -5;
         
      else
         -- Auf die maximale Größe der ID und des KIDatentypen.BauenBewertung Datentyps achten.
         return 20 + KIDatentypen.BauenBewertung (EinheitenIDExtern);
      end if;
      
   end ArbeiterBewerten;
   
   
   
   function NahkämpferBewerten
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      EinheitenIDExtern : in EinheitStadtDatentypen.EinheitenID)
      return KIDatentypen.BauenBewertung
   is begin
      
      MengeVorhanden := LeseWichtiges.AnzahlKämpfer (RasseExtern => StadtRasseNummerExtern.Rasse);
      MengeImBau := KIStadtLaufendeBauprojekte.GleicheEinheitArtBauprojekte (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                                                             EinheitArtExtern       => EinheitStadtDatentypen.Nahkämpfer_Enum);
        
      case
        KIKriegErmitteln.IstImKrieg (RasseExtern => StadtRasseNummerExtern.Rasse)
      is
         when False =>
            if
              MengeVorhanden + MengeImBau < AnzahlStädte
            then
               -- Auf die maximale Größe der ID und des KIDatentypen.BauenBewertung Datentyps achten.
               return 20 + KIDatentypen.BauenBewertung (EinheitenIDExtern);
               
            elsif
              MengeVorhanden = 2 * AnzahlStädte
              or
                MengeVorhanden + MengeImBau = 2 * AnzahlStädte
            then
               return 0;
         
            elsif
              MengeVorhanden > 2 * AnzahlStädte
              or
                MengeVorhanden + MengeImBau > 2 * AnzahlStädte
            then
               return -5;
         
            else
               -- Auf die maximale Größe der ID und des KIDatentypen.BauenBewertung Datentyps achten.
               return 10 + KIDatentypen.BauenBewertung (EinheitenIDExtern);
            end if;
            
         when True =>
            if
              MengeVorhanden + MengeImBau < AnzahlStädte
            then
               -- Auf die maximale Größe der ID und des KIDatentypen.BauenBewertung Datentyps achten.
               return 20 + KIDatentypen.BauenBewertung (EinheitenIDExtern);
               
            elsif
              MengeVorhanden = 5 * AnzahlStädte
              or
                MengeVorhanden + MengeImBau = 5 * AnzahlStädte
            then
               return 0;
         
            elsif
              MengeVorhanden > 5 * AnzahlStädte
              or
                MengeVorhanden + MengeImBau > 5 * AnzahlStädte
            then
               return -5;
         
            else
               -- Auf die maximale Größe der ID und des KIDatentypen.BauenBewertung Datentyps achten.
               return 10 * (5 + KIDatentypen.BauenBewertung (EinheitenIDExtern));
            end if;
      end case;
      
   end NahkämpferBewerten;
   
   
   
   function FernkämpferBewerten
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      EinheitenIDExtern : in EinheitStadtDatentypen.EinheitenID)
      return KIDatentypen.BauenBewertung
   is begin
      
      MengeVorhanden := LeseWichtiges.AnzahlKämpfer (RasseExtern => StadtRasseNummerExtern.Rasse);
      MengeImBau := KIStadtLaufendeBauprojekte.GleicheEinheitArtBauprojekte (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                                                             EinheitArtExtern       => EinheitStadtDatentypen.Fernkämpfer_Enum);
        
      case
        KIKriegErmitteln.IstImKrieg (RasseExtern => StadtRasseNummerExtern.Rasse)
      is
         when False =>
            if
              MengeVorhanden = 2 * AnzahlStädte
              or
                MengeVorhanden + MengeImBau = 2 * AnzahlStädte
            then
               return 0;
         
            elsif
              MengeVorhanden > 2 * AnzahlStädte
              or
                MengeVorhanden + MengeImBau > 2 * AnzahlStädte
            then
               return -5;
         
            else
               -- Auf die maximale Größe der ID und des KIDatentypen.BauenBewertung Datentyps achten.
               return 5 + KIDatentypen.BauenBewertung (EinheitenIDExtern);
            end if;
            
         when True =>
            if
              MengeVorhanden = 5 * AnzahlStädte
              or
                MengeVorhanden + MengeImBau = 5 * AnzahlStädte
            then
               return 0;
         
            elsif
              MengeVorhanden > 5 * AnzahlStädte
              or
                MengeVorhanden + MengeImBau > 5 * AnzahlStädte
            then
               return -5;
         
            else
               -- Auf die maximale Größe der ID und des KIDatentypen.BauenBewertung Datentyps achten.
               return 5 * (5 + KIDatentypen.BauenBewertung (EinheitenIDExtern));
            end if;
      end case;
      
   end FernkämpferBewerten;
   
   
   
   function KostenBewerten
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      EinheitenIDExtern : in EinheitStadtDatentypen.EinheitenID)
      return KIDatentypen.BauenBewertung
   is begin
      
      return -(KIDatentypen.BauenBewertung (LeseEinheitenDatenbank.PreisRessourcen (RasseExtern => StadtRasseNummerExtern.Rasse,
                                                                                   IDExtern    => EinheitenIDExtern)
                                           / LeseStadtGebaut.Produktionrate (StadtRasseNummerExtern => StadtRasseNummerExtern)
                                           / 10));
      
   end KostenBewerten;
     
     
     
   function GeldKostenBewerten
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      EinheitenIDExtern : in EinheitStadtDatentypen.EinheitenID)
      return KIDatentypen.BauenBewertung
   is begin
      
      if
        LeseEinheitenDatenbank.PermanenteKosten (RasseExtern        => StadtRasseNummerExtern.Rasse,
                                                 IDExtern           => EinheitenIDExtern,
                                                 WelcheKostenExtern => EinheitStadtDatentypen.Geld_Enum)
        = WichtigesKonstanten.LeerWichtigesZeug.GeldZugewinnProRunde
      then
         return 5;
         
      elsif
        LeseWichtiges.GeldZugewinnProRunde (RasseExtern => StadtRasseNummerExtern.Rasse)
        - LeseEinheitenDatenbank.PermanenteKosten (RasseExtern        => StadtRasseNummerExtern.Rasse,
                                                   IDExtern           => EinheitenIDExtern,
                                                   WelcheKostenExtern => EinheitStadtDatentypen.Geld_Enum)
        < WichtigesKonstanten.LeerWichtigesZeug.GeldZugewinnProRunde
      then
         return -10;
      
      else
         return 0;
      end if;
      
   end GeldKostenBewerten;
   
   
   
   function NahrungKostenBewerten
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      EinheitenIDExtern : in EinheitStadtDatentypen.EinheitenID)
      return KIDatentypen.BauenBewertung
   is begin
      
      if
        LeseEinheitenDatenbank.PermanenteKosten (RasseExtern        => StadtRasseNummerExtern.Rasse,
                                                 IDExtern           => EinheitenIDExtern,
                                                 WelcheKostenExtern => EinheitStadtDatentypen.Nahrung_Enum)
        = StadtKonstanten.LeerStadt.Nahrungsproduktion
      then
         return 5;
         
      elsif
        LeseStadtGebaut.Nahrungsproduktion (StadtRasseNummerExtern => StadtRasseNummerExtern)
        - LeseEinheitenDatenbank.PermanenteKosten (RasseExtern        => StadtRasseNummerExtern.Rasse,
                                                   IDExtern           => EinheitenIDExtern,
                                                   WelcheKostenExtern => EinheitStadtDatentypen.Nahrung_Enum)
        < StadtKonstanten.LeerStadt.Nahrungsproduktion
      then
         return -20;
      
      else
         return 0;
      end if;
      
   end NahrungKostenBewerten;
     
     
     
   function RessourcenKostenBewerten
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      EinheitenIDExtern : in EinheitStadtDatentypen.EinheitenID)
      return KIDatentypen.BauenBewertung
   is begin
      
      if
        LeseEinheitenDatenbank.PermanenteKosten (RasseExtern        => StadtRasseNummerExtern.Rasse,
                                                 IDExtern           => EinheitenIDExtern,
                                                 WelcheKostenExtern => EinheitStadtDatentypen.Ressourcen_Enum)
        = StadtKonstanten.LeerStadt.Produktionrate
      then
         return 5;
         
      elsif
        LeseStadtGebaut.Produktionrate (StadtRasseNummerExtern => StadtRasseNummerExtern)
        - LeseEinheitenDatenbank.PermanenteKosten (RasseExtern        => StadtRasseNummerExtern.Rasse,
                                                   IDExtern           => EinheitenIDExtern,
                                                   WelcheKostenExtern => EinheitStadtDatentypen.Ressourcen_Enum)
        < StadtKonstanten.LeerStadt.Produktionrate
      then
         return -20;
      
      else
         return 0;
      end if;
      
   end RessourcenKostenBewerten;

end KIEinheitenBauen;