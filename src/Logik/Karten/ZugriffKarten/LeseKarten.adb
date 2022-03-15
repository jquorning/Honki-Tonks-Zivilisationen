pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KartenDatentypen; use KartenDatentypen;
with EinheitStadtDatentypen; use EinheitStadtDatentypen;
with StadtKonstanten;
with KartenVerbesserungKonstanten;
with KartenGrundKonstanten;

with Fehler;

package body LeseKarten is
   
   function Grund
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord)
      return KartenGrundDatentypen.Karten_Grund_Enum
   is begin
      
      return Karten.Weltkarte (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse).Grund;
      
   end Grund;
   
   
   
   function Hügel
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord)
      return Boolean
   is begin
      
      return Karten.Weltkarte (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse).Hügel;
      
   end Hügel;
   
   
   
   function Sichtbar
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
      return Boolean
   is begin
      
      return Karten.Weltkarte (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse).Sichtbar (RasseExtern);
        
   end Sichtbar;
   
   
   
   function Fluss
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord)
      return KartenGrundDatentypen.Karten_Grund_Enum
   is begin
      
      case
        Karten.Weltkarte (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse).Fluss
      is
         when KartenGrundKonstanten.LeerGrund | KartenGrundDatentypen.Karten_Fluss_Enum'Range =>
            null;
         
         when others =>
            Karten.Weltkarte (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse).Fluss := KartenGrundKonstanten.LeerGrund;
      end case;
      
      return Karten.Weltkarte (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse).Fluss;
      
   end Fluss;
   
   
   
   function VerbesserungWeg
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord)
      return KartenVerbesserungDatentypen.Karten_Verbesserung_Enum
   is begin
      
      case
        Karten.Weltkarte (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse).VerbesserungWeg
      is
         when KartenVerbesserungKonstanten.LeerVerbesserungWeg | KartenVerbesserungDatentypen.Karten_Weg_Enum'Range =>
            null;
         
         when others =>
            Karten.Weltkarte (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse).VerbesserungWeg := KartenVerbesserungKonstanten.LeerVerbesserungWeg;
      end case;
      
      return Karten.Weltkarte (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse).VerbesserungWeg;
      
   end VerbesserungWeg;
   
   
   
   function VerbesserungGebiet
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord)
      return KartenVerbesserungDatentypen.Karten_Verbesserung_Enum
   is begin
      
      case
        Karten.Weltkarte (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse).VerbesserungGebiet
      is
         when KartenVerbesserungKonstanten.LeerVerbesserungGebiet | KartenVerbesserungDatentypen.Karten_Verbesserung_Gebilde_Enum'Range =>
            null;
         
         when others =>
            Karten.Weltkarte (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse).VerbesserungGebiet := KartenVerbesserungKonstanten.LeerVerbesserungGebiet;
      end case;
      
      return Karten.Weltkarte (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse).VerbesserungGebiet;
      
   end VerbesserungGebiet;
   
   
   
   function Ressource
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord)
      return KartenGrundDatentypen.Karten_Grund_Enum
   is begin
      
      case
        Karten.Weltkarte (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse).Ressource
      is
         when KartenGrundKonstanten.LeerGrund | KartenGrundDatentypen.Karten_Grund_Ressourcen_Enum'Range =>
            null;
         
         when others =>
            Karten.Weltkarte (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse).Ressource := KartenGrundKonstanten.LeerGrund;
      end case;
      
      return Karten.Weltkarte (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse).Ressource;
      
   end Ressource;
   
   
   
   function Bewertung
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
      return KartenDatentypen.GesamtbewertungFeld
   is begin
      
      return Karten.Weltkarte (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse).Felderwertung (RasseExtern);
      
   end Bewertung;
   
   
   
   function BelegterGrund
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord)
      return Boolean
   is begin
      
      if
        Karten.Weltkarte (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse).DurchStadtBelegterGrund.RasseBelegt = RasseExtern
        and
          Karten.Weltkarte (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse).DurchStadtBelegterGrund.StadtBelegt > StadtKonstanten.LeerNummer
      then
         return True;
         
      else
         return False;
      end if;
      
   end BelegterGrund;
   
      
   
   function BelegterGrundLeer
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord)
      return Boolean
   is begin
      
      if
        Karten.Weltkarte (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse).DurchStadtBelegterGrund.RasseBelegt = StadtKonstanten.LeerRasse
        and
          Karten.Weltkarte (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse).DurchStadtBelegterGrund.StadtBelegt = StadtKonstanten.LeerNummer
      then
         return True;
         
      elsif
        Karten.Weltkarte (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse).DurchStadtBelegterGrund.RasseBelegt = StadtKonstanten.LeerRasse
        or
          Karten.Weltkarte (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse).DurchStadtBelegterGrund.StadtBelegt = StadtKonstanten.LeerNummer
      then
         Fehler.LogikFehler (FehlermeldungExtern => "LeseKarten.BelegterGrundLeer - Rasse oder Nummer nicht korrekt gesetzt");
         -- return muss hier sein, weil der Kompiler nicht weiß dass der Prozeduraufruf das Programm stoppt.
         return True;
         
      else
         return False;
      end if;
      
   end BelegterGrundLeer;
   
   
   
   function BestimmteStadtBelegtGrund
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord)
      return Boolean
   is begin
     
      if
        Karten.Weltkarte (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse).DurchStadtBelegterGrund.RasseBelegt = StadtRasseNummerExtern.Rasse
        and
          Karten.Weltkarte (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse).DurchStadtBelegterGrund.StadtBelegt = StadtRasseNummerExtern.Platznummer
      then
         return True;
         
      else
         return False;
      end if;
      
   end BestimmteStadtBelegtGrund;
   
   
   
   function RasseBelegtGrund
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord)
      return SystemDatentypen.Rassen_Enum
   is begin
      
      return Karten.Weltkarte (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse).DurchStadtBelegterGrund.RasseBelegt;
      
   end RasseBelegtGrund;

end LeseKarten;
