pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KartenDatentypen; use KartenDatentypen;
with KartenverbesserungDatentypen; use KartenverbesserungDatentypen;
with StadtDatentypen; use StadtDatentypen;
with KartenKonstanten;
with EinheitenKonstanten;
with KartenRecordKonstanten;
with TextnummernKonstanten;

with SchreibeEinheitenGebaut;
with SchreibeStadtGebaut;
with SchreibeKarten;
with SchreibeWichtiges;
with LeseKarten;
with LeseEinheitenGebaut;
with LeseStadtGebaut;

with Kartenkoordinatenberechnungssystem;
with RasseEntfernen;
with Wachstum;
with AuswahlLogik;

package body StadtEntfernen is
   
   procedure StadtAbreißen
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord)
   is begin
         
      case
        AuswahlLogik.JaNein (FrageZeileExtern => TextnummernKonstanten.FrageStadtAbreißen)
      is
         when True =>
            StadtEntfernen (StadtRasseNummerExtern => StadtRasseNummerExtern);
            
         when False =>
            null;
      end case;
      
   end StadtAbreißen;
   
   

   procedure StadtEntfernen
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord)
   is begin
      
      BelegteStadtfelderFreigeben (StadtRasseNummerExtern => StadtRasseNummerExtern);
      HeimatstädteEntfernen (StadtRasseNummerExtern => StadtRasseNummerExtern);
      NeueHauptstadtSetzen (StadtRasseNummerExtern => StadtRasseNummerExtern);
      SchreibeKarten.Verbesserung (KoordinatenExtern  => LeseStadtGebaut.Koordinaten (StadtRasseNummerExtern => StadtRasseNummerExtern),
                                   VerbesserungExtern => KartenverbesserungDatentypen.Leer_Verbesserung_Enum);
      SchreibeStadtGebaut.Nullsetzung (StadtRasseNummerExtern => StadtRasseNummerExtern);
      Wachstum.WachstumWichtiges (RasseExtern => StadtRasseNummerExtern.Rasse);
      SchreibeWichtiges.AnzahlStädte (RasseExtern     => StadtRasseNummerExtern.Rasse,
                                       PlusMinusExtern => False);
      RasseEntfernen.RasseExistenzPrüfen (RasseExtern => StadtRasseNummerExtern.Rasse);
      
   end StadtEntfernen;
   
   
   
   procedure BelegteStadtfelderFreigeben
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord)
   is begin
      
      YUmgebungFreigebenSchleife:
      for YUmgebungFreigebenSchleifenwert in KartenDatentypen.UmgebungsbereichDrei'Range loop
         XUmgebungFreigebenSchleife:
         for XUmgebungFreigebenSchleifenwert in KartenDatentypen.UmgebungsbereichDrei'Range loop
         
            KartenWert := Kartenkoordinatenberechnungssystem.Kartenkoordinatenberechnungssystem (KoordinatenExtern => LeseStadtGebaut.Koordinaten (StadtRasseNummerExtern => StadtRasseNummerExtern),
                                                                                                 ÄnderungExtern    => (0, YUmgebungFreigebenSchleifenwert, XUmgebungFreigebenSchleifenwert),
                                                                                                 LogikGrafikExtern => True);
         
            if
              KartenWert.XAchse = KartenKonstanten.LeerXAchse
            then
               null;
               
            elsif
              LeseKarten.BestimmteStadtBelegtGrund (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                                    KoordinatenExtern      => KartenWert)
              = True
            then
               SchreibeKarten.BelegterGrund (KoordinatenExtern   => KartenWert,
                                             BelegterGrundExtern => KartenRecordKonstanten.LeerDurchStadtBelegterGrund);
            
            else
               null;
            end if;
         
         end loop XUmgebungFreigebenSchleife;
      end loop YUmgebungFreigebenSchleife;
      
   end BelegteStadtfelderFreigeben;
   
   
   
   procedure HeimatstädteEntfernen
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord)
   is begin
      
      EinheitenSchleife:
      for EinheitNummerSchleifenwert in SpielVariablen.EinheitenGebautArray'First (2) .. SpielVariablen.Grenzen (StadtRasseNummerExtern.Rasse).Einheitengrenze loop
         
         if
           LeseEinheitenGebaut.Heimatstadt (EinheitRasseNummerExtern => (StadtRasseNummerExtern.Rasse, EinheitNummerSchleifenwert)) = StadtRasseNummerExtern.Nummer
         then
            SchreibeEinheitenGebaut.Heimatstadt (EinheitRasseNummerExtern => (StadtRasseNummerExtern.Rasse, EinheitNummerSchleifenwert),
                                                 HeimatstadtExtern        => EinheitenKonstanten.LeerHeimatstadt);
            
         else
            null;
         end if;
         
      end loop EinheitenSchleife;
      
   end HeimatstädteEntfernen;
   
   
   
   procedure NeueHauptstadtSetzen
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord)
   is begin
      
      case
        LeseStadtGebaut.ID (StadtRasseNummerExtern => StadtRasseNummerExtern)
      is
         when KartenverbesserungDatentypen.Hauptstadt_Enum =>
            null;
            
         when others =>
            return;
      end case;
      
      StadtSchleife:
      for StadtSchleifenwert in SpielVariablen.StadtGebautArray'First (2) .. SpielVariablen.Grenzen (StadtRasseNummerExtern.Rasse).Städtegrenze loop
         
         if
           LeseStadtGebaut.ID (StadtRasseNummerExtern => (StadtRasseNummerExtern.Rasse, StadtSchleifenwert)) = KartenverbesserungDatentypen.Leer_Verbesserung_Enum
           or
             StadtSchleifenwert = StadtRasseNummerExtern.Nummer
         then
            null;
            
         else
            SchreibeStadtGebaut.ID (StadtRasseNummerExtern => (StadtRasseNummerExtern.Rasse, StadtSchleifenwert),
                                    IDExtern               => KartenverbesserungDatentypen.Hauptstadt_Enum);
            return;
         end if;
         
      end loop StadtSchleife;
      
   end NeueHauptstadtSetzen;

end StadtEntfernen;
