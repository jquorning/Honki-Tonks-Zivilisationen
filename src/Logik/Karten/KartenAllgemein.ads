pragma SPARK_Mode (On);

with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

with KartenRecords;
with KartenDatentypen;
with EinheitStadtDatentypen;
with SystemDatentypen;

package KartenAllgemein is

   function Beschreibung
     (KartenGrundExtern : in KartenDatentypen.Karten_Grund_Enum)
      return Wide_Wide_String;

   function GrundNahrung
     (PositionExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
      return EinheitStadtDatentypen.ProduktionElement;

   function GrundProduktion
     (PositionExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
      return EinheitStadtDatentypen.ProduktionElement;

   function GrundGeld
     (PositionExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
      return EinheitStadtDatentypen.ProduktionElement;

   function GrundWissen
     (PositionExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
      return EinheitStadtDatentypen.ProduktionElement;

   function GrundVerteidigung
     (PositionExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
      return EinheitStadtDatentypen.Kampfwerte;

   function GrundAngriff
     (PositionExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
      return EinheitStadtDatentypen.Kampfwerte;

   function GrundBewertung
     (PositionExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
      return KartenDatentypen.BewertungFeld;

   function FlussNahrung
     (PositionExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
      return EinheitStadtDatentypen.ProduktionElement;

   function FlussProduktion
     (PositionExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
      return EinheitStadtDatentypen.ProduktionElement;

   function FlussGeld
     (PositionExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
      return EinheitStadtDatentypen.ProduktionElement;

   function FlussWissen
     (PositionExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
      return EinheitStadtDatentypen.ProduktionElement;

   function FlussVerteidigung
     (PositionExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
      return EinheitStadtDatentypen.Kampfwerte;

   function FlussAngriff
     (PositionExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
      return EinheitStadtDatentypen.Kampfwerte;

   function FlussBewertung
     (PositionExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
      return KartenDatentypen.BewertungFeld;

   function WegNahrung
     (PositionExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
      return EinheitStadtDatentypen.ProduktionFeld;

   function WegProduktion
     (PositionExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
      return EinheitStadtDatentypen.ProduktionFeld;

   function WegGeld
     (PositionExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
      return EinheitStadtDatentypen.ProduktionFeld;

   function WegWissen
     (PositionExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
      return EinheitStadtDatentypen.ProduktionFeld;

   function WegVerteidigung
     (PositionExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
      return EinheitStadtDatentypen.Kampfwerte;

   function WegAngriff
     (PositionExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
      return EinheitStadtDatentypen.Kampfwerte;

   function WegBewertung
     (PositionExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
      return KartenDatentypen.BewertungFeld;

   function VerbesserungNahrung
     (PositionExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
      return EinheitStadtDatentypen.ProduktionFeld;

   function VerbesserungProduktion
     (PositionExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
      return EinheitStadtDatentypen.ProduktionFeld;

   function VerbesserungGeld
     (PositionExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
      return EinheitStadtDatentypen.ProduktionFeld;

   function VerbesserungWissen
     (PositionExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
      return EinheitStadtDatentypen.ProduktionFeld;

   function VerbesserungVerteidigung
     (PositionExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
      return EinheitStadtDatentypen.Kampfwerte;

   function VerbesserungAngriff
     (PositionExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
      return EinheitStadtDatentypen.Kampfwerte;

   function VerbesserungBewertung
     (PositionExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
      return KartenDatentypen.BewertungFeld;

   function RessourceNahrung
     (PositionExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
      return EinheitStadtDatentypen.ProduktionElement;

   function RessourceProduktion
     (PositionExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
      return EinheitStadtDatentypen.ProduktionElement;

   function RessourceGeld
     (PositionExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
      return EinheitStadtDatentypen.ProduktionElement;

   function RessourceWissen
     (PositionExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
      return EinheitStadtDatentypen.ProduktionElement;

   function RessourceVerteidigung
     (PositionExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
      return EinheitStadtDatentypen.Kampfwerte;

   function RessourceAngriff
     (PositionExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
      return EinheitStadtDatentypen.Kampfwerte;

   function RessourceBewertung
     (PositionExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
      return KartenDatentypen.BewertungFeld;

   function PassierbarGrund
     (PositionExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      PassierbarkeitExtern : in EinheitStadtDatentypen.Passierbarkeit_Enum)
      return Boolean;

   function PassierbarVerbesserung
     (PositionExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      PassierbarkeitExtern : in EinheitStadtDatentypen.Passierbarkeit_Enum)
      return Boolean;

   function PassierbarWeg
     (PositionExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      PassierbarkeitExtern : in EinheitStadtDatentypen.Passierbarkeit_Enum)
      return Boolean;

private

   GrundAktuell : Positive;

   BeschreibungText : Unbounded_Wide_Wide_String;

end KartenAllgemein;
