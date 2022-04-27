pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Ada.Directories; use Ada.Directories;

with EinheitenDatenbank;
with ForschungsDatenbank;
with GebaeudeDatenbank;
with KartenDatenbank;
with VerbesserungenDatenbank;
with RassenDatenbank;

package body EinlesenDatenbanken is
   
   procedure EinlesenAlleDatenbanken
   is begin
      
      EinlesenEinheitenDatenbank;
      EinlesenForschungsDatenbank;
      EinlesenGebäudeDatenbank;
      EinlesenKartenDatenbank;
      EinlesenVerbesserungenDatenbank;
      EinlesenRassenDatenbank;
      
   end EinlesenAlleDatenbanken;
   
   

   procedure EinlesenEinheitenDatenbank
   is begin
      
      case
        Exists (Name => "Datenbanken/EinheitenDatenbank")
      is
         when True =>
            Open (File => DatenbankEinlesen,
                  Mode => In_File,
                  Name => "Datenbanken/EinheitenDatenbank");

         when False =>
            EinheitenDatenbank.StandardEinheitenDatenbankLaden;
            return;
      end case;
      
      EinheitenDatenbank.EinheitenListeArray'Read (Stream (File => DatenbankEinlesen),
                                                   EinheitenDatenbank.EinheitenListe);
      
      Close (File => DatenbankEinlesen);
      
   end EinlesenEinheitenDatenbank;
   
   
   
   procedure EinlesenForschungsDatenbank
   is begin
      
      case
        Exists (Name => "Datenbanken/ForschungsDatenbank")
      is
         when True =>
            Open (File => DatenbankEinlesen,
                  Mode => In_File,
                  Name => "Datenbanken/ForschungsDatenbank");

         when False =>
            ForschungsDatenbank.StandardForschungsDatenbankLaden;
            return;
      end case;
      
      ForschungsDatenbank.ForschungListeArray'Read (Stream (File => DatenbankEinlesen),
                                                    ForschungsDatenbank.ForschungListe);
      
      Close (File => DatenbankEinlesen);
      
   end EinlesenForschungsDatenbank;
   
   
   
   procedure EinlesenGebäudeDatenbank
   is begin
      
      case
        Exists (Name => "Datenbanken/GebaeudeDatenbank")
      is
         when True =>
            Open (File => DatenbankEinlesen,
                  Mode => In_File,
                  Name => "Datenbanken/GebaeudeDatenbank");

         when False =>
            GebaeudeDatenbank.StandardGebaeudeDatenbankLaden;
            return;
      end case;
      
      GebaeudeDatenbank.GebäudeListeArray'Read (Stream (File => DatenbankEinlesen),
                                                 GebaeudeDatenbank.GebäudeListe);
      
      Close (File => DatenbankEinlesen);
      
   end EinlesenGebäudeDatenbank;
   
   
   
   procedure EinlesenKartenDatenbank
   is begin
      
      case
        Exists (Name => "Datenbanken/KartenGrundDatenbank")
      is
         when True =>
            Open (File => DatenbankEinlesen,
                  Mode => In_File,
                  Name => "Datenbanken/KartenGrundDatenbank");

         when False =>
            KartenDatenbank.StandardKartenGrundDatenbankLaden;
            return;
      end case;
      
      KartenDatenbank.KartenGrundListeArray'Read (Stream (File => DatenbankEinlesen),
                                                  KartenDatenbank.KartenGrundListe);
      
      Close (File => DatenbankEinlesen);
      
      
      
      case
        Exists (Name => "Datenbanken/KartenFlussDatenbank")
      is
         when True =>
            Open (File => DatenbankEinlesen,
                  Mode => In_File,
                  Name => "Datenbanken/KartenFlussDatenbank");

         when False =>
            KartenDatenbank.StandardKartenFlussDatenbankLaden;
            return;
      end case;
      
      KartenDatenbank.KartenFlussListeArray'Read (Stream (File => DatenbankEinlesen),
                                                  KartenDatenbank.KartenFlussListe);
      
      Close (File => DatenbankEinlesen);
      
      
      
      case
        Exists (Name => "Datenbanken/KartenRessourcenDatenbank")
      is
         when True =>
            Open (File => DatenbankEinlesen,
                  Mode => In_File,
                  Name => "Datenbanken/KartenRessourcenDatenbank");

         when False =>
            KartenDatenbank.StandardKartenRessourcenDatenbankLaden;
            return;
      end case;
      
      KartenDatenbank.KartenRessourcenListeArray'Read (Stream (File => DatenbankEinlesen),
                                                       KartenDatenbank.KartenRessourcenListe);
      
      Close (File => DatenbankEinlesen);
      
   end EinlesenKartenDatenbank;
   
   
   
   procedure EinlesenVerbesserungenDatenbank
   is begin
      
      case
        Exists (Name => "Datenbanken/VerbesserungenDatenbank")
      is
         when True =>
            Open (File => DatenbankEinlesen,
                  Mode => In_File,
                  Name => "Datenbanken/VerbesserungenDatenbank");

         when False =>
            VerbesserungenDatenbank.StandardVerbesserungenDatenbankLaden;
            return;
      end case;
      
      VerbesserungenDatenbank.VerbesserungenListeArray'Read (Stream (File => DatenbankEinlesen),
                                                             VerbesserungenDatenbank.VerbesserungenListe);
      
      Close (File => DatenbankEinlesen);
      
      
      
      case
        Exists (Name => "Datenbanken/WegeDatenbank")
      is
         when True =>
            Open (File => DatenbankEinlesen,
                  Mode => In_File,
                  Name => "Datenbanken/WegeDatenbank");

         when False =>
            VerbesserungenDatenbank.StandardWegeDatenbankLaden;
            return;
      end case;
      
      VerbesserungenDatenbank.WegeListeArray'Read (Stream (File => DatenbankEinlesen),
                                                   VerbesserungenDatenbank.WegeListe);
      
      Close (File => DatenbankEinlesen);
      
   end EinlesenVerbesserungenDatenbank;
   
   
   
   procedure EinlesenRassenDatenbank
   is begin
      
      case
        Exists (Name => "Datenbanken/RassenDatenbank")
      is
         when True =>
            Open (File => DatenbankEinlesen,
                  Mode => In_File,
                  Name => "Datenbanken/RassenDatenbank");

         when False =>
            RassenDatenbank.StandardRassenDatenbankLaden;
            return;
      end case;
      
      RassenDatenbank.RassenListeArray'Read (Stream (File => DatenbankEinlesen),
                                             RassenDatenbank.RassenListe);
      
      Close (File => DatenbankEinlesen);
      
   end EinlesenRassenDatenbank;

end EinlesenDatenbanken;