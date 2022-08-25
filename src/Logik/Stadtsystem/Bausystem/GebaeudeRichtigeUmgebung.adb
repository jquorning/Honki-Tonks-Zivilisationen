pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KartenDatentypen; use KartenDatentypen;
with KartengrundDatentypen; use KartengrundDatentypen;
with KartenKonstanten;

with LeseKarten;
with LeseStadtGebaut;
with LeseGebaeudeDatenbank;

with Kartenkoordinatenberechnungssystem;

package body GebaeudeRichtigeUmgebung is

   function RichtigeUmgebungVorhanden
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord;
      GebäudeIDExtern : in StadtDatentypen.GebäudeID)
      return Boolean
   is begin
     
      if
        LeseGebaeudeDatenbank.GrundBenötigt (RasseExtern => StadtRasseNummerExtern.Rasse,
                                              IDExtern    => GebäudeIDExtern)
        = KartengrundDatentypen.Leer_Grund_Enum
        and
          LeseGebaeudeDatenbank.FlussBenötigt (RasseExtern => StadtRasseNummerExtern.Rasse,
                                                IDExtern    => GebäudeIDExtern)
        = False
        and
          LeseGebaeudeDatenbank.RessourceBenötigt (RasseExtern => StadtRasseNummerExtern.Rasse,
                                                    IDExtern    => GebäudeIDExtern)
        = KartengrundDatentypen.Leer_Ressource_Enum
      then
         return True;
               
      else
         return UmgebungPrüfen (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                 GebäudeIDExtern       => GebäudeIDExtern);
      end if;
            
   end RichtigeUmgebungVorhanden;
   
   
   
   function UmgebungPrüfen
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord;
      GebäudeIDExtern : in StadtDatentypen.GebäudeID)
      return Boolean
   is begin
      
      YAchseGebäudeSchleife:
      for YAchseGebäudeSchleifenwert in -LeseStadtGebaut.UmgebungGröße (StadtRasseNummerExtern => StadtRasseNummerExtern) .. LeseStadtGebaut.UmgebungGröße (StadtRasseNummerExtern => StadtRasseNummerExtern) loop
         XAchseGebäudeSchleife:
         for XAchseGebäudeSchleifenwert in -LeseStadtGebaut.UmgebungGröße (StadtRasseNummerExtern => StadtRasseNummerExtern) .. LeseStadtGebaut.UmgebungGröße (StadtRasseNummerExtern => StadtRasseNummerExtern) loop
               
            KartenWert := Kartenkoordinatenberechnungssystem.Kartenkoordinatenberechnungssystem (KoordinatenExtern => LeseStadtGebaut.Koordinaten (StadtRasseNummerExtern => StadtRasseNummerExtern),
                                                                                                 ÄnderungExtern    => (0, YAchseGebäudeSchleifenwert, XAchseGebäudeSchleifenwert),
                                                                                                 LogikGrafikExtern => True);
               
            if
              KartenWert.XAchse = KartenKonstanten.LeerXAchse
            then
               null;
                        
            elsif
              False = LeseKarten.BestimmteStadtBelegtGrund (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                                            KoordinatenExtern      => KartenWert)
            then
               null;
                  
            elsif
              -- An neue Mehrfachumgebung möglich anpassen. äöü
              -- Noch um Umgebungsverbesserung erweitern? äöü
              LeseKarten.AktuellerGrund (KoordinatenExtern => KartenWert) = LeseGebaeudeDatenbank.GrundBenötigt (RasseExtern => StadtRasseNummerExtern.Rasse,
                                                                                                                  IDExtern    => GebäudeIDExtern)
              or
                False = LeseGebaeudeDatenbank.FlussBenötigt (RasseExtern => StadtRasseNummerExtern.Rasse,
                                                              IDExtern    => GebäudeIDExtern)
              -- or
              -- LeseKarten.Fluss (KoordinatenExtern => KartenWert) = LeseGebaeudeDatenbank.FlussBenötigt (RasseExtern => StadtRasseNummerExtern.Rasse,
              --                                                                                            IDExtern    => GebäudeIDExtern)
              or
                LeseKarten.Ressource (KoordinatenExtern => KartenWert) = LeseGebaeudeDatenbank.RessourceBenötigt (RasseExtern => StadtRasseNummerExtern.Rasse,
                                                                                                                   IDExtern    => GebäudeIDExtern)
            then
               return True;
               
            else
               null;
            end if;
               
         end loop XAchseGebäudeSchleife;
      end loop YAchseGebäudeSchleife;
      
      return False;
      
   end UmgebungPrüfen;

end GebaeudeRichtigeUmgebung;
