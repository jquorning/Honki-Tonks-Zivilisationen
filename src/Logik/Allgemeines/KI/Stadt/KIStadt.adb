pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with EinheitStadtDatentypen; use EinheitStadtDatentypen;
with KartenDatentypen; use KartenDatentypen;
with SystemDatentypen; use SystemDatentypen;
with KartenKonstanten;
with EinheitenKonstanten;

with KIDatentypen; use KIDatentypen;

with SchreibeStadtGebaut;
with LeseStadtGebaut;
with LeseEinheitenDatenbank;
with LeseEinheitenGebaut;

with EinheitSuchen;
with Kartenkoordinatenberechnungssystem;
with DiplomatischerZustand;
with EinheitenModifizieren;

with KIEinheitenBauen;
with KIGebaeudeBauen;

package body KIStadt is

   procedure KIStadt
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
   is begin
      
      case
        GefahrStadt (StadtRasseNummerExtern => StadtRasseNummerExtern)
      is
         when True =>
            return;
            
         when False =>
            null;
      end case;
      
      case
        LeseStadtGebaut.KIBeschäftigung (StadtRasseNummerExtern => StadtRasseNummerExtern)
      is
         when KIDatentypen.Keine_Aufgabe_Enum =>
            null;
            
         when others =>
            return;
      end case;
      
      NeuesBauprojekt  (StadtRasseNummerExtern => StadtRasseNummerExtern,
                        EinheitBauenExtern     => KIEinheitenBauen.EinheitenBauen (StadtRasseNummerExtern => StadtRasseNummerExtern),
                        GebäudeBauenExtern     => KIGebaeudeBauen.GebäudeBauen (StadtRasseNummerExtern => StadtRasseNummerExtern),
                        NotfallExtern          => False);
      
   end KIStadt;
   
   
   
   procedure NeuesBauprojekt
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      EinheitBauenExtern : in KIRecords.EinheitIDBewertungRecord;
      GebäudeBauenExtern : in KIRecords.GebäudeIDBewertungRecord;
      NotfallExtern : in Boolean)
   is begin
      
      if
        EinheitBauenExtern.ID = EinheitenKonstanten.LeerID
        and
          GebäudeBauenExtern.ID = EinheitStadtDatentypen.GebäudeIDMitNullwert'First
      then
         null;
         
      elsif
        EinheitBauenExtern.ID = EinheitenKonstanten.LeerID
      then
         SchreibeStadtGebaut.KIBeschäftigung (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                               BeschäftigungExtern   => KIDatentypen.Gebäude_Bauen_Enum);
         SchreibeStadtGebaut.Bauprojekt (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                         BauprojektExtern       => (True, GebäudeBauenExtern.ID));
         
      elsif
        GebäudeBauenExtern.ID = EinheitStadtDatentypen.GebäudeIDMitNullwert'First
      then
         case
           NotfallExtern
         is
            when True =>
               SchreibeStadtGebaut.KIBeschäftigung (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                                     BeschäftigungExtern   => KIDatentypen.Gefahr_Einheit_Bauen_Enum);
               
            when False =>
               SchreibeStadtGebaut.KIBeschäftigung (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                                     BeschäftigungExtern   => KIDatentypen.Einheit_Bauen_Enum);
         end case;
         SchreibeStadtGebaut.Bauprojekt (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                         BauprojektExtern       => (False, EinheitBauenExtern.ID));
      
      elsif
        EinheitBauenExtern.Bewertung >= GebäudeBauenExtern.Bewertung
      then
         case
           NotfallExtern
         is
            when True =>
               SchreibeStadtGebaut.KIBeschäftigung (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                                     BeschäftigungExtern   => KIDatentypen.Gefahr_Einheit_Bauen_Enum);
               
            when False =>
               SchreibeStadtGebaut.KIBeschäftigung (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                                     BeschäftigungExtern   => KIDatentypen.Einheit_Bauen_Enum);
         end case;
         SchreibeStadtGebaut.Bauprojekt (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                         BauprojektExtern       => (False, EinheitBauenExtern.ID));

      else
         SchreibeStadtGebaut.KIBeschäftigung (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                               BeschäftigungExtern   => KIDatentypen.Gebäude_Bauen_Enum);
         SchreibeStadtGebaut.Bauprojekt (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                         BauprojektExtern       => (True, GebäudeBauenExtern.ID));
      end if;
      
   end NeuesBauprojekt;
   
   
   
   function GefahrStadt
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
      return Boolean
   is begin
      
      case
        FeindNahe (StadtRasseNummerExtern => StadtRasseNummerExtern)
      is
         when True =>
            NotfallEinheit := EinheitStadtDatentypen.EinheitenIDMitNullWert'First;
            WelcheEinheitArt (StadtRasseNummerExtern => StadtRasseNummerExtern);
            
         when False =>
            return False;
      end case;
      
      case
        NotfallEinheit
      is
         when EinheitStadtDatentypen.EinheitenIDMitNullWert'First =>
            return False;
            
         when others =>
            NeuesBauprojekt (StadtRasseNummerExtern => StadtRasseNummerExtern,
                             EinheitBauenExtern     => (NotfallEinheit, 1),
                             GebäudeBauenExtern     => (EinheitStadtDatentypen.GebäudeIDMitNullwert'First, 0),
                             NotfallExtern          => True);
            return True;
      end case;
      
   end GefahrStadt;
   
   
   
   function FeindNahe
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
      return Boolean
   is begin
      
      YAchseSchleife:
      for YAchseSchleifenwert in -LeseStadtGebaut.UmgebungGröße (StadtRasseNummerExtern => StadtRasseNummerExtern) .. LeseStadtGebaut.UmgebungGröße (StadtRasseNummerExtern => StadtRasseNummerExtern) loop
         XAchseSchleife:
         for XAchseSchleifenwert in -LeseStadtGebaut.UmgebungGröße (StadtRasseNummerExtern => StadtRasseNummerExtern) .. LeseStadtGebaut.UmgebungGröße (StadtRasseNummerExtern => StadtRasseNummerExtern) loop
            
            KartenWert := Kartenkoordinatenberechnungssystem.Kartenkoordinatenberechnungssystem (KoordinatenExtern => LeseStadtGebaut.Koordinaten (StadtRasseNummerExtern => StadtRasseNummerExtern),
                                                                                                 ÄnderungExtern    => (0, YAchseSchleifenwert, XAchseSchleifenwert),
                                                                                                 LogikGrafikExtern => True);
            
            case
              KartenWert.XAchse
            is
               when KartenKonstanten.LeerXAchse =>
                  null;
                  
               when others =>
                  FremdeEinheit := EinheitSuchen.KoordinatenEinheitOhneSpezielleRasseSuchen (RasseExtern       => StadtRasseNummerExtern.Rasse,
                                                                                             KoordinatenExtern => KartenWert);
                  if
                    FremdeEinheit.Platznummer = EinheitenKonstanten.LeerNummer
                  then
                     null;
                     
                  elsif
                    DiplomatischerZustand.DiplomatischenStatusPrüfen (EigeneRasseExtern => StadtRasseNummerExtern.Rasse,
                                                                       FremdeRasseExtern => FremdeEinheit.Rasse)
                    /= SystemDatentypen.Krieg_Enum
                  then
                     null;
                     
                  else
                     case
                       LeseEinheitenDatenbank.EinheitArt (RasseExtern => FremdeEinheit.Rasse,
                                                          IDExtern    => LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => FremdeEinheit))
                     is
                        when EinheitStadtDatentypen.Leer_Enum | EinheitStadtDatentypen.Arbeiter_Enum =>
                           null;
            
                        when others =>
                           return True;
                     end case;
                  end if;
            end case;
            
         end loop XAchseSchleife;
      end loop YAchseSchleife;
      
      return False;
      
   end FeindNahe;
   
   
   
   procedure WelcheEinheitArt
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
   is begin
      
      EinheitenSchleife:
      for EinheitenSchleifenwert in EinheitStadtDatentypen.EinheitenID'Range loop
         
         if
           LeseEinheitenDatenbank.EinheitArt (RasseExtern => StadtRasseNummerExtern.Rasse,
                                              IDExtern    => EinheitenSchleifenwert)
           = EinheitStadtDatentypen.Arbeiter_Enum
           or
             LeseEinheitenDatenbank.EinheitArt (RasseExtern => StadtRasseNummerExtern.Rasse,
                                                IDExtern    => EinheitenSchleifenwert)
           = EinheitStadtDatentypen.Leer_Enum
         then
            null;
            
         elsif
           EinheitenModifizieren.EinheitAnforderungenErfüllt (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                                               IDExtern               => EinheitenSchleifenwert)
           = True
         then
            NotfallEinheitBauen (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                 EinheitIDExtern        => EinheitenSchleifenwert);
               
         else
            null;
         end if;
         
      end loop EinheitenSchleife;
      
   end WelcheEinheitArt;
   
   
   
   procedure NotfallEinheitBauen
   -- Stadt mit übergeben und später die Baukosten noch mit in die Bewertung einfließen lassen.
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      EinheitIDExtern : in EinheitStadtDatentypen.EinheitenID)
   is begin
      
      if
        NotfallEinheit = EinheitStadtDatentypen.EinheitenIDMitNullWert'First
      then
         NotfallEinheit := EinheitIDExtern;
         
      elsif
        LeseEinheitenDatenbank.Angriff (RasseExtern => StadtRasseNummerExtern.Rasse,
                                        IDExtern    => NotfallEinheit)
        +
        LeseEinheitenDatenbank.Verteidigung (RasseExtern => StadtRasseNummerExtern.Rasse,
                                             IDExtern    => NotfallEinheit)
        < LeseEinheitenDatenbank.Angriff (RasseExtern => StadtRasseNummerExtern.Rasse,
                                          IDExtern    => EinheitIDExtern)
        +
        LeseEinheitenDatenbank.Verteidigung (RasseExtern => StadtRasseNummerExtern.Rasse,
                                             IDExtern    => EinheitIDExtern)
      then
         NotfallEinheit := EinheitIDExtern;
         
      else
         null;
      end if;
      
   end NotfallEinheitBauen;
     
end KIStadt;