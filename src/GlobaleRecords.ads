with Ada.Strings.Wide_Wide_Unbounded;
use Ada.Strings.Wide_Wide_Unbounded;

with GlobaleDatentypen;

package GlobaleRecords is
   
   type AchsenAusStadtfeldRecord is record
      
      YAchse : GlobaleDatentypen.Stadtfeld;
      XAchse : GlobaleDatentypen.Stadtfeld;
      
   end record;
   
   
   
   type AchsenAusKartenfeldPositivRecord is record
      
      EAchse : GlobaleDatentypen.EbeneVorhanden;
      YAchse : GlobaleDatentypen.KartenfeldPositiv;
      XAchse : GlobaleDatentypen.KartenfeldPositiv;
      
   end record;
   
   

   type AchsenAusKartenfeldRecord is record
      
      EAchse : GlobaleDatentypen.Ebene;
      YAchse : GlobaleDatentypen.Kartenfeld;
      XAchse : GlobaleDatentypen.Kartenfeld;
      
   end record;
   
   

   type RasseUndPlatznummerRecord is record
      
      Rasse : GlobaleDatentypen.RassenMitNullwert;
      Platznummer : Integer;
      
   end record;


   
   type CursorRecord is record
      
      CursorGrafik : Wide_Wide_Character;
      AchsenPosition : AchsenAusKartenfeldPositivRecord;
      AchsenPositionAlt : AchsenAusKartenfeldPositivRecord;
      AchsenPositionStadt : AchsenAusStadtfeldRecord;
      
   end record;



   type EinheitenGebautRecord is record
      
      AktuelleBeschäftigung : Integer;
      AktuelleBeschäftigung2 : Integer;
      
      ID : GlobaleDatentypen.EinheitenIDMitNullWert;
      AchsenPosition : AchsenAusKartenfeldPositivRecord;
      --AchsenPositionAlt : YAchseXAchseAusKartenfeldPositiv;
      
      AktuelleLebenspunkte : Integer;
      AktuelleBewegungspunkte : Float;
      AktuelleErfahrungspunkte : Integer;
      AktuellerRang : Integer;
      
      AktuelleBeschäftigungszeit : Integer;
      AktuelleBeschäftigungszeit2 : Integer;
      
   end record;



   type StadtGebautRecord is record
      
      ID : Integer;
      AchsenPosition : AchsenAusKartenfeldPositivRecord;

      AmWasser : Boolean;

      Einwohner : Integer;
      AktuelleNahrungsmittel : GlobaleDatentypen.KostenLager;
      AktuelleNahrungsproduktion : GlobaleDatentypen.GesamtproduktionStadt;
      AktuelleRessourcen : GlobaleDatentypen.KostenLager;
      AktuelleProduktionrate : GlobaleDatentypen.GesamtproduktionStadt;
      AktuelleGeldgewinnung : GlobaleDatentypen.GesamtproduktionStadt;
      AktuelleForschungsrate : GlobaleDatentypen.GesamtproduktionStadt;
      AktuellesBauprojekt : Integer;
      VerbleibendeBauzeit : GlobaleDatentypen.KostenLager;
      Korruption : GlobaleDatentypen.GesamtproduktionStadt;
      
      GebäudeVorhanden : Wide_Wide_String (Integer (GlobaleDatentypen.GebäudeID'First) .. Integer (GlobaleDatentypen.GebäudeID'Last)); -- Eine Liste anlegen welche Nummer welches Gebäude ist.
      Name : Unbounded_Wide_Wide_String;

      UmgebungBewirtschaftung : GlobaleDatentypen.UmgebungBewirtschaftungArray;
      ArbeitendeEinwohner : Integer;
      StadtUmgebungGröße : GlobaleDatentypen.Stadtfeld;
      
   end record;



   type WichtigesRecord is record
      
      AktuelleGeldmenge : Integer;
      GeldZugewinnProRunde : GlobaleDatentypen.KostenLager;
      AktuelleForschungsrate : GlobaleDatentypen.KostenLager;
      AktuelleForschungsmenge : GlobaleDatentypen.KostenLager;
      VerbleibendeForschungszeit : GlobaleDatentypen.KostenLager;
      AktuellesForschungsprojekt : Integer;

      Erforscht : GlobaleDatentypen.ErforschtArray;
      
   end record;
   
   
   
   type KartenRecord is record

      Grund : GlobaleDatentypen.KartenGrund;
      Hügel : Boolean;
      Sichtbar : GlobaleDatentypen.SichtbarkeitArray;
      Fluss : GlobaleDatentypen.KartenGrund;
      VerbesserungStraße : GlobaleDatentypen.KartenVerbesserung;
      VerbesserungGebiet : GlobaleDatentypen.KartenVerbesserung;
      Ressource : GlobaleDatentypen.KartenGrund;
      DurchStadtBelegterGrund : GlobaleDatentypen.BelegterGrund;
      Felderwertung : GlobaleDatentypen.GesamtproduktionStadt;

      -- Sichtbar2
      -- VerbesserungStraße2
      -- VerbesserungGebiet2
      -- Noch mehr?

   end record;

end GlobaleRecords;
