pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KartenverbesserungDatentypen; use KartenverbesserungDatentypen;
with AufgabenDatentypen; use AufgabenDatentypen;
with ProduktionDatentypen; use ProduktionDatentypen;
with EinheitenRecordKonstanten;
with ForschungKonstanten;
with EinheitenKonstanten;

with SchreibeEinheitenGebaut;
with LeseWeltkarte;

with Fehler;
with Grenzpruefungen;
with ForschugnstestsLogik;
with ArbeitszeitWegLogik;

package body WegErmittelnLogik is
   
   function WegErmitteln
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      AnlegenTestenExtern : in Boolean;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
      return Boolean
   is begin
      
      VorhandenerGrund := LeseWeltkarte.VorhandenerGrund (KoordinatenExtern => KoordinatenExtern);
      
      -- Nur auf Basisgrund prüfen? Müsste hierbei ausreichen. äöü
      if
        ArbeitszeitWegLogik.Arbeitszeit (EinheitRasseNummerExtern.Rasse, VorhandenerGrund.BasisGrund) = EinheitenKonstanten.UnmöglicheArbeit
        or
          ArbeitszeitWegLogik.Arbeitszeit (EinheitRasseNummerExtern.Rasse, VorhandenerGrund.AktuellerGrund) = EinheitenKonstanten.UnmöglicheArbeit
      then
         return False;
         
      else
         WegVorhanden := LeseWeltkarte.Weg (KoordinatenExtern => KoordinatenExtern);
      end if;

      case
        VorhandenerGrund.AktuellerGrund
      is
         when KartengrundDatentypen.Eis_Enum | KartengrundDatentypen.Kartengrund_Oberfläche_Land_Enum'Range =>
            Arbeitswerte := OberflächeLand (RasseExtern => EinheitRasseNummerExtern.Rasse,
                                             WegExtern   => WegVorhanden,
                                             GrundExtern => VorhandenerGrund);
            
         when KartengrundDatentypen.Kartengrund_Oberfläche_Wasser_Enum'Range =>
            Arbeitswerte := OberflächeWasser (RasseExtern => EinheitRasseNummerExtern.Rasse,
                                               WegExtern   => WegVorhanden,
                                               GrundExtern => VorhandenerGrund);
            
         when KartengrundDatentypen.Untereis_Enum | KartengrundDatentypen.Kartengrund_Unterfläche_Land_Enum'Range =>
            Arbeitswerte := UnterflächeLand (RasseExtern => EinheitRasseNummerExtern.Rasse,
                                              WegExtern   => WegVorhanden,
                                              GrundExtern => VorhandenerGrund);
            
         when KartengrundDatentypen.Kartengrund_Unterfläche_Wasser_Enum'Range =>
            Arbeitswerte := UnterflächeWasser (RasseExtern => EinheitRasseNummerExtern.Rasse,
                                                WegExtern   => WegVorhanden,
                                                GrundExtern => VorhandenerGrund);
               
         when others =>
            return False;
      end case;
      
      case
        Arbeitswerte.Aufgabe
      is
         when AufgabenDatentypen.Leer_Aufgabe_Enum =>
            return False;
            
         when AufgabenDatentypen.Einheitenbefehle_Wege_Enum'Range =>
            null;
            
         when others =>
            Fehler.LogikFehler (FehlermeldungExtern => "WegErmitteln.WegErmitteln - Falsche Aufgabe ausgewählt.");
      end case;
      
      case
        AnlegenTestenExtern
      is
         when True =>
            SchreibeEinheitenGebaut.Beschäftigung (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                    BeschäftigungExtern     => Arbeitswerte.Aufgabe);
            SchreibeEinheitenGebaut.Beschäftigungszeit (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                         ZeitExtern               => Arbeitswerte.Arbeitszeit,
                                                         RechnenSetzenExtern      => 0);
            
         when False =>
            null;
      end case;
      
      return True;
      
   end WegErmitteln;
   
   
   
   function OberflächeLand
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      WegExtern : in KartenverbesserungDatentypen.Karten_Weg_Enum;
      GrundExtern : in KartenRecords.KartengrundRecord)
      return EinheitenRecords.ArbeitRecord
   is begin
            
      case
        WegExtern
      is
         when KartenverbesserungDatentypen.Karten_Straße_Enum'Range | KartenverbesserungDatentypen.Leer_Weg_Enum =>
            if
              True = ForschugnstestsLogik.TechnologieVorhanden (RasseExtern       => RasseExtern,
                                                                TechnologieExtern => ForschungKonstanten.TechnologischeVoraussetzung (RasseExtern, WelcheWegart (WegExtern)))
            then
               WelcheArbeit := WelcheWegart (WegExtern);
               
            else
               return EinheitenRecordKonstanten.KeineArbeit;
            end if;
            
         when others =>
            return EinheitenRecordKonstanten.KeineArbeit;
      end case;
      
      Arbeitszeit := Grenzpruefungen.Arbeitszeit (AktuellerWertExtern => EinheitenKonstanten.MinimaleArbeitszeit,
                                                  ÄnderungExtern      => ArbeitszeitWegLogik.Arbeitszeit (RasseExtern, GrundExtern.BasisGrund));

      if
        GrundExtern.BasisGrund = GrundExtern.AktuellerGrund
      then
         null;

      else
         Arbeitszeit := Grenzpruefungen.Arbeitszeit (AktuellerWertExtern => Arbeitszeit,
                                                     ÄnderungExtern      => ArbeitszeitWegLogik.Arbeitszeit (RasseExtern, GrundExtern.AktuellerGrund));
      end if;
      
      return (WelcheArbeit, Arbeitszeit);
   
   end OberflächeLand;

   
     
   function OberflächeWasser
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      WegExtern : in KartenverbesserungDatentypen.Karten_Weg_Enum;
      GrundExtern : in KartenRecords.KartengrundRecord)
      return EinheitenRecords.ArbeitRecord
   is begin
      
      if
        GrundExtern.AktuellerGrund = KartengrundDatentypen.Wasser_Enum
        and
          RasseExtern /= RassenDatentypen.Ekropa_Enum
      then
         return EinheitenRecordKonstanten.KeineArbeit;
         
      else
         null;
      end if;
      
      case
        WegExtern
      is
         when KartenverbesserungDatentypen.Karten_Straße_Enum'Range | KartenverbesserungDatentypen.Leer_Weg_Enum =>
            if
              True = ForschugnstestsLogik.TechnologieVorhanden (RasseExtern       => RasseExtern,
                                                                TechnologieExtern => ForschungKonstanten.TechnologischeVoraussetzung (RasseExtern, WelcheWegart (WegExtern)))
            then
               WelcheArbeit := WelcheWegart (WegExtern);
               
            else
               return EinheitenRecordKonstanten.KeineArbeit;
            end if;
            
         when others =>
            return EinheitenRecordKonstanten.KeineArbeit;
      end case;
      
      Arbeitszeit := Grenzpruefungen.Arbeitszeit (AktuellerWertExtern => EinheitenKonstanten.MinimaleArbeitszeit,
                                                  ÄnderungExtern      => ArbeitszeitWegLogik.Arbeitszeit (RasseExtern, GrundExtern.BasisGrund));

      if
        GrundExtern.BasisGrund = GrundExtern.AktuellerGrund
      then
         null;

      else
         Arbeitszeit := Grenzpruefungen.Arbeitszeit (AktuellerWertExtern => Arbeitszeit,
                                                     ÄnderungExtern      => ArbeitszeitWegLogik.Arbeitszeit (RasseExtern, GrundExtern.AktuellerGrund));
      end if;
      
      return (WelcheArbeit, Arbeitszeit);
   
   end OberflächeWasser;
     
     
     
   function UnterflächeLand
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      WegExtern : in KartenverbesserungDatentypen.Karten_Weg_Enum;
      GrundExtern : in KartenRecords.KartengrundRecord)
      return EinheitenRecords.ArbeitRecord
   is begin
      
      case
        WegExtern
      is
         when KartenverbesserungDatentypen.Karten_Straße_Enum'Range | KartenverbesserungDatentypen.Leer_Weg_Enum =>
            if
              True = ForschugnstestsLogik.TechnologieVorhanden (RasseExtern       => RasseExtern,
                                                                TechnologieExtern => ForschungKonstanten.TechnologischeVoraussetzung (RasseExtern, WelcheWegart (WegExtern)))
            then
               WelcheArbeit := WelcheWegart (WegExtern);
               
            else
               return EinheitenRecordKonstanten.KeineArbeit;
            end if;
            
         when others =>
            return EinheitenRecordKonstanten.KeineArbeit;
      end case;
      
      Arbeitszeit := Grenzpruefungen.Arbeitszeit (AktuellerWertExtern => EinheitenKonstanten.MinimaleArbeitszeit,
                                                  ÄnderungExtern      => ArbeitszeitWegLogik.Arbeitszeit (RasseExtern, GrundExtern.BasisGrund));

      if
        GrundExtern.BasisGrund = GrundExtern.AktuellerGrund
      then
         null;

      else
         Arbeitszeit := Grenzpruefungen.Arbeitszeit (AktuellerWertExtern => Arbeitszeit,
                                                     ÄnderungExtern      => ArbeitszeitWegLogik.Arbeitszeit (RasseExtern, GrundExtern.AktuellerGrund));
      end if;
      
      return (WelcheArbeit, Arbeitszeit);
      
   end UnterflächeLand;
     
     
     
   -- Das ist doch ein wenig sinnfrei, oder? äöü
   function UnterflächeWasser
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      WegExtern : in KartenverbesserungDatentypen.Karten_Weg_Enum;
      GrundExtern : in KartenRecords.KartengrundRecord)
      return EinheitenRecords.ArbeitRecord
   is begin
      
      case
        WegExtern
      is
         when KartenverbesserungDatentypen.Karten_Straße_Enum'Range | KartenverbesserungDatentypen.Leer_Weg_Enum =>
            if
              True = ForschugnstestsLogik.TechnologieVorhanden (RasseExtern       => RasseExtern,
                                                                TechnologieExtern => ForschungKonstanten.TechnologischeVoraussetzung (RasseExtern, WelcheWegart (WegExtern)))
            then
               WelcheArbeit := WelcheWegart (WegExtern);
               
            else
               return EinheitenRecordKonstanten.KeineArbeit;
            end if;
            
         when others =>
            return EinheitenRecordKonstanten.KeineArbeit;
      end case;
      
      Arbeitszeit := Grenzpruefungen.Arbeitszeit (AktuellerWertExtern => EinheitenKonstanten.MinimaleArbeitszeit,
                                                  ÄnderungExtern      => ArbeitszeitWegLogik.Arbeitszeit (RasseExtern, GrundExtern.BasisGrund));

      if
        GrundExtern.BasisGrund = GrundExtern.AktuellerGrund
      then
         null;

      else
         Arbeitszeit := Grenzpruefungen.Arbeitszeit (AktuellerWertExtern => Arbeitszeit,
                                                     ÄnderungExtern      => ArbeitszeitWegLogik.Arbeitszeit (RasseExtern, GrundExtern.AktuellerGrund));
      end if;
      
      return (WelcheArbeit, Arbeitszeit);
   
   end UnterflächeWasser;

end WegErmittelnLogik;
