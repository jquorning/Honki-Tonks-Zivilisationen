pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with ProduktionDatentypen; use ProduktionDatentypen;
with EinheitenRecordKonstanten;
with EinheitenKonstanten;

with SchreibeEinheitenGebaut;
with LeseKarten;

with AufgabeEinheitRoden;
with Fehler;
with AufgabenArbeitszeitFarm;
with Grenzpruefungen;

package body AufgabeEinheitFarm is

   function FarmErmitteln
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      AnlegenTestenExtern : in Boolean;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
      return Boolean
   is begin
      
      VorhandenerGrund := LeseKarten.VorhandenerGrund (KoordinatenExtern => KoordinatenExtern);
      
      -- Nur auf Basisgrund prüfen? Müsste hierbei ausreichen. äöü
      if
        AufgabenArbeitszeitFarm.Arbeitszeit (EinheitRasseNummerExtern.Rasse, VorhandenerGrund.BasisGrund) = EinheitenKonstanten.UnmöglicheArbeit
        or
          AufgabenArbeitszeitFarm.Arbeitszeit (EinheitRasseNummerExtern.Rasse, VorhandenerGrund.AktuellerGrund) = EinheitenKonstanten.UnmöglicheArbeit
      then
         return False;
         
      else
         null;
      end if;

      if
        VorhandenerGrund.BasisGrund = KartengrundDatentypen.Eis_Enum
      then
         return False;

      else
         null;
      end if;
      
      case
        VorhandenerGrund.AktuellerGrund
      is
         when KartengrundDatentypen.Kartengrund_Oberfläche_Land_Enum'Range =>
            Arbeitswerte := OberflächeLand (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                             GrundExtern              => VorhandenerGrund,
                                             AnlegenTestenExtern      => AnlegenTestenExtern,
                                             KoordinatenExtern        => KoordinatenExtern);
            
         when KartengrundDatentypen.Kartengrund_Unterfläche_Wasser_Enum'Range =>
            Arbeitswerte := UnterflächeWasser (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                GrundExtern              => VorhandenerGrund,
                                                AnlegenTestenExtern      => AnlegenTestenExtern,
                                                KoordinatenExtern        => KoordinatenExtern);
            
         when KartengrundDatentypen.Kartengrund_Unterfläche_Land_Enum'Range =>
            Arbeitswerte := UnterflächeLand (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                              GrundExtern              => VorhandenerGrund);
            
         when others =>
            return False;
      end case;
      
      case
        Arbeitswerte.Aufgabe
      is
         when AufgabenDatentypen.Leer_Aufgabe_Enum =>
            return False;
            
         when AufgabenDatentypen.Farm_Bauen_Enum =>
            null;
            
         when others =>
            Fehler.LogikFehler (FehlermeldungExtern => "WaldErmitteln.WaldErmitteln - Ungültige Aufgabe wurde ausgewählt.");
      end case;
      
      case
        AnlegenTestenExtern
      is
         when True =>
            if
              Arbeitswerte.Vorarbeit
            then
               SchreibeEinheitenGebaut.BeschäftigungNachfolger (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                                 BeschäftigungExtern     => Arbeitswerte.Aufgabe);
               SchreibeEinheitenGebaut.BeschäftigungszeitNachfolger (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                                      ZeitExtern               => Arbeitswerte.Arbeitszeit,
                                                                      RechnenSetzenExtern      => 0);
               
            else
               SchreibeEinheitenGebaut.Beschäftigung (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                       BeschäftigungExtern     => Arbeitswerte.Aufgabe);
               SchreibeEinheitenGebaut.Beschäftigungszeit (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                            ZeitExtern               => Arbeitswerte.Arbeitszeit,
                                                            RechnenSetzenExtern      => 0);
            end if;
            
         when False =>
            null;
      end case;
      
      return True;
      
   end FarmErmitteln;
   
   
   
   function OberflächeLand
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      GrundExtern : in KartenRecords.KartengrundRecord;
      AnlegenTestenExtern : in Boolean;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
      return EinheitenRecords.ArbeitVorleistungRecord
   is begin
      
      Arbeitszeit := Grenzpruefungen.Arbeitszeit (AktuellerWertExtern => EinheitenKonstanten.MinimaleArbeitszeit,
                                                  ÄnderungExtern      => AufgabenArbeitszeitFarm.Arbeitszeit (EinheitRasseNummerExtern.Rasse, GrundExtern.BasisGrund));
      
      if
        GrundExtern.BasisGrund = GrundExtern.AktuellerGrund
      then
         VorarbeitNötig := False;
         
      elsif
        True = AufgabeEinheitRoden.RodenErmitteln (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                   AnlegenTestenExtern      => AnlegenTestenExtern,
                                                   KoordinatenExtern        => KoordinatenExtern)
      then
         Arbeitszeit := Grenzpruefungen.Arbeitszeit (AktuellerWertExtern => Arbeitszeit,
                                                     ÄnderungExtern      => AufgabenArbeitszeitFarm.Arbeitszeit (EinheitRasseNummerExtern.Rasse, GrundExtern.AktuellerGrund));
         VorarbeitNötig := True;
         
      else
         return EinheitenRecordKonstanten.KeineArbeitVorleistung;
      end if;
      
      return (
              Aufgabe     => AufgabenDatentypen.Farm_Bauen_Enum,
              Arbeitszeit => Arbeitszeit,
              Vorarbeit   => VorarbeitNötig
             );
   
   end OberflächeLand;
     
   
     
   function UnterflächeLand
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      GrundExtern : in KartenRecords.KartengrundRecord)
      return EinheitenRecords.ArbeitVorleistungRecord
   is begin
      
      Arbeitszeit := Grenzpruefungen.Arbeitszeit (AktuellerWertExtern => EinheitenKonstanten.MinimaleArbeitszeit,
                                                  ÄnderungExtern      => AufgabenArbeitszeitFarm.Arbeitszeit (EinheitRasseNummerExtern.Rasse, GrundExtern.BasisGrund));
      
      if
        GrundExtern.BasisGrund = GrundExtern.AktuellerGrund
      then
         VorarbeitNötig := False;
         
      else
         Arbeitszeit := Grenzpruefungen.Arbeitszeit (AktuellerWertExtern => Arbeitszeit,
                                                     ÄnderungExtern      => AufgabenArbeitszeitFarm.Arbeitszeit (EinheitRasseNummerExtern.Rasse, GrundExtern.AktuellerGrund));
         VorarbeitNötig := False;
      end if;
      
      return (
              Aufgabe     => AufgabenDatentypen.Farm_Bauen_Enum,
              Arbeitszeit => Arbeitszeit,
              Vorarbeit   => VorarbeitNötig
             );
      
   end UnterflächeLand;
     
     
     
   function UnterflächeWasser
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      GrundExtern : in KartenRecords.KartengrundRecord;
      AnlegenTestenExtern : in Boolean;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
      return EinheitenRecords.ArbeitVorleistungRecord
   is begin
      
      Arbeitszeit := Grenzpruefungen.Arbeitszeit (AktuellerWertExtern => EinheitenKonstanten.MinimaleArbeitszeit,
                                                  ÄnderungExtern      => AufgabenArbeitszeitFarm.Arbeitszeit (EinheitRasseNummerExtern.Rasse, GrundExtern.BasisGrund));
      
      if
        GrundExtern.BasisGrund = GrundExtern.AktuellerGrund
      then
         VorarbeitNötig := False;
         
      elsif
        True = AufgabeEinheitRoden.RodenErmitteln (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                   AnlegenTestenExtern      => AnlegenTestenExtern,
                                                   KoordinatenExtern        => KoordinatenExtern)
      then
         Arbeitszeit := Grenzpruefungen.Arbeitszeit (AktuellerWertExtern => Arbeitszeit,
                                                     ÄnderungExtern      => AufgabenArbeitszeitFarm.Arbeitszeit (EinheitRasseNummerExtern.Rasse, GrundExtern.AktuellerGrund));
         VorarbeitNötig := True;
         
      else
         return EinheitenRecordKonstanten.KeineArbeitVorleistung;
      end if;
      
      return (
              Aufgabe     => AufgabenDatentypen.Farm_Bauen_Enum,
              Arbeitszeit => Arbeitszeit,
              Vorarbeit   => VorarbeitNötig
             );
   
   end UnterflächeWasser;

end AufgabeEinheitFarm;
