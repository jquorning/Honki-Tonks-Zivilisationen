pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with ForschungKonstanten;
with AufgabenDatentypen;
with TextKonstanten;
with RassenDatentypen;
with ForschungenDatentypen;
with ProduktionDatentypen;
with EinheitenRecords;
with KampfDatentypen;
with StadtDatentypen;
with EinheitenDatentypen;

with KIDatentypen;

package EinheitenKonstanten is
   
   LeerRasse : constant RassenDatentypen.Rassen_Enum := RassenDatentypen.Keine_Rasse_Enum;
   LeerNummer : constant EinheitenDatentypen.MaximaleEinheitenMitNullWert := EinheitenDatentypen.MaximaleEinheitenMitNullWert'First;
   LeerRasseNummer : constant EinheitenRecords.RasseEinheitnummerRecord := (LeerRasse, LeerNummer);

   LeerID : constant EinheitenDatentypen.EinheitenIDMitNullWert := EinheitenDatentypen.EinheitenIDMitNullWert'First;
   LeerHeimatstadt : constant StadtDatentypen.MaximaleStädteMitNullWert := StadtDatentypen.MaximaleStädteMitNullWert'First;
   LeerLebenspunkte : constant EinheitenDatentypen.Lebenspunkte := EinheitenDatentypen.Lebenspunkte'First;
   LeerBewegungspunkte : constant EinheitenDatentypen.VorhandeneBewegungspunkte := EinheitenDatentypen.VorhandeneBewegungspunkte'First;
   LeerErfahrungspunkte : constant KampfDatentypen.Kampfwerte := KampfDatentypen.Kampfwerte'First;
   LeerRang : constant KampfDatentypen.Kampfwerte := KampfDatentypen.Kampfwerte'First;
   LeerBeschäftigung : constant AufgabenDatentypen.Einheiten_Aufgaben_Enum := AufgabenDatentypen.Leer_Aufgabe_Enum;
   LeerBeschäftigungszeit : constant ProduktionDatentypen.Arbeitszeit := ProduktionDatentypen.Arbeitszeit'First;
   LeerKIBeschäftigt : constant KIDatentypen.Einheit_Aufgabe_Enum := KIDatentypen.Leer_Aufgabe_Enum;
   LeerTransportiert : constant EinheitenDatentypen.MaximaleEinheitenMitNullWert := EinheitenDatentypen.MaximaleEinheitenMitNullWert'First;
   LeerWirdTransportiert : constant EinheitenDatentypen.MaximaleEinheitenMitNullWert := EinheitenDatentypen.MaximaleEinheitenMitNullWert'First;
   LeerMeldung : constant EinheitenDatentypen.Einheit_Meldung_Enum := EinheitenDatentypen.Leer_Einheit_Meldung_Enum;
   
   
   
   LeerEinheitenGrafik : constant Wide_Wide_Character := TextKonstanten.LeerZeichen;
   LeerEinheitArt : constant EinheitenDatentypen.Einheitart_Enum := EinheitenDatentypen.Arbeiter_Enum;
   LeerPreisGeld : constant ProduktionDatentypen.Produktion := 0;
   LeerPreisRessourcen : constant ProduktionDatentypen.Produktion := 0;
   LeerPermanenteKosten : constant ProduktionDatentypen.Stadtproduktion := 0;
   LeerAnforderungen : constant ForschungenDatentypen.ForschungIDNichtMöglich := ForschungKonstanten.ForschungUnmöglich;
   LeerPassierbarkeit : constant Boolean := False;
   LeerMaximaleLebenspunkte : constant EinheitenDatentypen.LebenspunkteVorhanden := EinheitenDatentypen.LebenspunkteVorhanden'First;
   LeerMaximaleBewegungspunkte : constant EinheitenDatentypen.VorhandeneBewegungspunkte := 1.00;
   LeerWirdVerbessertZu : constant EinheitenDatentypen.EinheitenIDMitNullWert := EinheitenDatentypen.EinheitenIDMitNullWert'First;
   LeerBeförderungsgrenze : constant KampfDatentypen.Kampfwerte := KampfDatentypen.Kampfwerte'First;
   LeerMaximalerRang : constant KampfDatentypen.Kampfwerte := KampfDatentypen.Kampfwerte'First;
   LeerReichweite : constant KampfDatentypen.Kampfwerte := KampfDatentypen.Kampfwerte'First;
   LeerAngriff : constant KampfDatentypen.Kampfwerte := KampfDatentypen.Kampfwerte'First;
   LeerVerteidigung : constant KampfDatentypen.Kampfwerte := KampfDatentypen.Kampfwerte'First;
   LeerKannTransportieren : constant EinheitenDatentypen.Transport_Enum := EinheitenDatentypen.Kein_Transport_Enum;
   LeerKannTransportiertWerden : constant EinheitenDatentypen.Transport_Enum := EinheitenDatentypen.Kein_Transport_Enum;
   LeerTransportkapazität : constant EinheitenDatentypen.Transportplätze := EinheitenDatentypen.Transportplätze'First;
   
   
   
   LeerArbeit : constant AufgabenDatentypen.Einheiten_Aufgaben_Enum := AufgabenDatentypen.Leer_Aufgabe_Enum;
   LeerArbeitszeit : constant ProduktionDatentypen.Arbeitszeit := ProduktionDatentypen.Arbeitszeit'First;
   
end EinheitenKonstanten;
