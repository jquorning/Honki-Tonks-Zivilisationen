with EinheitenDatentypen;
with EinheitenKonstanten;
with KartenKonstanten;
with Weltkarte;

with LeseWeltkarte;

with Fehlermeldungssystem;
with FehlermeldungssystemZusatzinformationen;

package body SchreibeWeltkarte is
   
   procedure Basisgrund
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      GrundExtern : in KartengrundDatentypen.Basisgrund_Vorhanden_Enum)
   is begin
      
      case
        KoordinatenExtern.EAchse
      is
         when KartenKonstanten.LeerEAchse =>
            Fehlermeldungssystem.Logik (FehlermeldungExtern => "SchreibeWeltkarte.Basisgrund: " & FehlermeldungssystemZusatzinformationen.Koordinaten (KoordinatenExtern => KoordinatenExtern));
            
         when others =>
            Weltkarte.Karte (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse).Grund.Basisgrund := GrundExtern;
      end case;
      
   end Basisgrund;
   
   

   procedure Zusatzgrund
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      GrundExtern : in KartengrundDatentypen.Zusatzgrund_Enum)
   is begin
      
      case
        KoordinatenExtern.EAchse
      is
         when KartenKonstanten.LeerEAchse =>
            Fehlermeldungssystem.Logik (FehlermeldungExtern => "SchreibeWeltkarte.Zusatzgrund: " & FehlermeldungssystemZusatzinformationen.Koordinaten (KoordinatenExtern => KoordinatenExtern));
            
         when others =>
            Weltkarte.Karte (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse).Grund.Zusatzgrund := GrundExtern;
      end case;
      
   end Zusatzgrund;
   
   
   
   procedure Gesamtgrund
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      GrundExtern : in KartenRecords.KartengrundRecord)
   is begin
      
      case
        KoordinatenExtern.EAchse
      is
         when KartenKonstanten.LeerEAchse =>
            Fehlermeldungssystem.Logik (FehlermeldungExtern => "SchreibeWeltkarte.Gesamtgrund: " & FehlermeldungssystemZusatzinformationen.Koordinaten (KoordinatenExtern => KoordinatenExtern));
            
         when others =>
            Weltkarte.Karte (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse).Grund := GrundExtern;
      end case;
      
   end Gesamtgrund;
   
   
   
   procedure Sichtbar
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      SichtbarExtern : in Boolean)
   is begin
      
      case
        KoordinatenExtern.EAchse
      is
         when KartenKonstanten.LeerEAchse =>
            Fehlermeldungssystem.Logik (FehlermeldungExtern => "SchreibeWeltkarte.Sichtbar: " & FehlermeldungssystemZusatzinformationen.Koordinaten (KoordinatenExtern => KoordinatenExtern));
            
         when others =>
            Weltkarte.Karte (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse).Sichtbar (RasseExtern) := SichtbarExtern;
      end case;
        
   end Sichtbar;
   
   
   
   procedure Fluss
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      FlussExtern : in KartenextraDatentypen.Fluss_Enum)
   is begin
      
      case
        KoordinatenExtern.EAchse
      is
         when KartenKonstanten.LeerEAchse =>
            Fehlermeldungssystem.Logik (FehlermeldungExtern => "SchreibeWeltkarte.Fluss: " & FehlermeldungssystemZusatzinformationen.Koordinaten (KoordinatenExtern => KoordinatenExtern));
            
         when others =>
            Weltkarte.Karte (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse).Fluss := FlussExtern;
      end case;
      
   end Fluss;
   
   
   
   procedure Ressource
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      RessourceExtern : in KartenextraDatentypen.Ressourcen_Enum)
   is begin
      
      case
        KoordinatenExtern.EAchse
      is
         when KartenKonstanten.LeerEAchse =>
            Fehlermeldungssystem.Logik (FehlermeldungExtern => "SchreibeWeltkarte.Ressource: " & FehlermeldungssystemZusatzinformationen.Koordinaten (KoordinatenExtern => KoordinatenExtern));
            
         when others =>
            Weltkarte.Karte (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse).Ressource := RessourceExtern;
      end case;
      
   end Ressource;
   
   
   
   procedure Weg
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      WegExtern : in KartenverbesserungDatentypen.Karten_Weg_Enum)
   is begin
      
      case
        KoordinatenExtern.EAchse
      is
         when KartenKonstanten.LeerEAchse =>
            Fehlermeldungssystem.Logik (FehlermeldungExtern => "SchreibeWeltkarte.Weg: " & FehlermeldungssystemZusatzinformationen.Koordinaten (KoordinatenExtern => KoordinatenExtern));
            
         when others =>
            Weltkarte.Karte (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse).Weg := WegExtern;
      end case;
      
   end Weg;
   
   
   
   procedure Verbesserung
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      VerbesserungExtern : in KartenverbesserungDatentypen.Karten_Verbesserung_Enum)
   is begin
      
      case
        KoordinatenExtern.EAchse
      is
         when KartenKonstanten.LeerEAchse =>
            Fehlermeldungssystem.Logik (FehlermeldungExtern => "SchreibeWeltkarte.Verbesserung: " & FehlermeldungssystemZusatzinformationen.Koordinaten (KoordinatenExtern => KoordinatenExtern));
            
         when others =>
            Weltkarte.Karte (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse).Verbesserung := VerbesserungExtern;
      end case;
      
   end Verbesserung;
   
   
   
   procedure BelegterGrund
     (KoordinatenExtern : KartenRecords.AchsenKartenfeldNaturalRecord;
      BelegterGrundExtern : in StadtRecords.RasseStadtnummerRecord)
   is begin
      
      case
        KoordinatenExtern.EAchse
      is
         when KartenKonstanten.LeerEAchse =>
            Fehlermeldungssystem.Logik (FehlermeldungExtern => "SchreibeWeltkarte.BelegterGrund: " & FehlermeldungssystemZusatzinformationen.Koordinaten (KoordinatenExtern => KoordinatenExtern));
            
         when others =>
            Weltkarte.Karte (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse).DurchStadtBelegterGrund := BelegterGrundExtern;
      end case;
      
   end BelegterGrund;
   
   
   
   procedure EinheitSchreiben
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      EinheitentauschExtern : in Boolean)
   is
      use type KartenDatentypen.Ebene;
      use type EinheitenRecords.RasseEinheitnummerRecord;
   begin
      
      if
        KoordinatenExtern.EAchse = KartenKonstanten.LeerEAchse
      then
         null;
         
      elsif
        LeseWeltkarte.EinheitenbelegungGrund (KoordinatenExtern => KoordinatenExtern) /= EinheitenKonstanten.LeerRasseNummer
        and
          EinheitentauschExtern = False
      then
         null;
         
      else
         Weltkarte.Karte (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse).Einheit := EinheitRasseNummerExtern;
      end if;
      
   end EinheitSchreiben;
   
   
   
   procedure EinheitEntfernen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
   is
      use type RassenDatentypen.Rassen_Enum;
      use type KartenDatentypen.Ebene;
      use type EinheitenDatentypen.MaximaleEinheitenMitNullWert;
      use type EinheitenRecords.RasseEinheitnummerRecord;
   begin
      
      if
        EinheitRasseNummerExtern.Rasse = EinheitenKonstanten.LeerRasse
        or
          EinheitRasseNummerExtern.Nummer = EinheitenKonstanten.LeerNummer
          or
            KoordinatenExtern.EAchse = KartenKonstanten.LeerEAchse
      then
         null;
         
      elsif
        LeseWeltkarte.EinheitenbelegungGrund (KoordinatenExtern => KoordinatenExtern) /= EinheitRasseNummerExtern
      then
         null;
         
      else
         Weltkarte.Karte (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse).Einheit := EinheitenKonstanten.LeerRasseNummer;
      end if;
      
   end EinheitEntfernen;
   
   
   
   procedure Standardeinstellungen
   is begin
      
      Weltkarte.Karte := (others => (others => (others => WeltkarteRecords.LeerWeltkarte)));
      
   end Standardeinstellungen;
   
   
   
   procedure GanzerEintrag
     (EintrageExtern : in WeltkarteRecords.WeltkarteRecord;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldVorhandenRecord)
   is begin
      
      Weltkarte.Karte (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse) := EintrageExtern;
      
   end GanzerEintrag;
   
end SchreibeWeltkarte;