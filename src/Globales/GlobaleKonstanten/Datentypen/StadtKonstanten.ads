with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

with SystemDatentypen;
with ForschungKonstanten;
with StadtDatentypen;
with KartenDatentypen;
with KartengrundDatentypen;
with KartenverbesserungDatentypen;
with TextKonstanten;
with SpeziesDatentypen;
with ForschungenDatentypen;
with ProduktionDatentypen;
with StadtRecords;
with KampfDatentypen;
with KartenextraDatentypen;

with KIDatentypen;

package StadtKonstanten is
   pragma Elaborate_Body;
   
   LeerSpezies : constant SpeziesDatentypen.Spezies_Enum := SpeziesDatentypen.Keine_Spezies_Enum;
   LeerNummer : constant StadtDatentypen.MaximaleStädteMitNullWert := StadtDatentypen.MaximaleStädteMitNullWert'First;
   LeerSpeziesNummer : constant StadtRecords.SpeziesStadtnummerRecord := (LeerSpezies, LeerNummer);
   
   AnfangNummer : constant StadtDatentypen.MaximaleStädte := StadtDatentypen.MaximaleStädte'First;
   
   LeerID : constant KartenverbesserungDatentypen.Karten_Verbesserung_Stadt_ID_Enum := KartenverbesserungDatentypen.Leer_Verbesserung_Enum;
   LeerEinwohner : constant ProduktionDatentypen.Einwohner := 0;
   LeerArbeiter : constant ProduktionDatentypen.Einwohner := 0;
   LeerEinwohnerArbeiter : constant StadtRecords.EinwohnerArbeiterArray := (LeerEinwohner, LeerArbeiter);
   LeerNahrungsmittel : constant ProduktionDatentypen.StadtLagermenge := 0;
   LeerNahrungsproduktion : constant ProduktionDatentypen.Stadtproduktion := 0;
   LeerRessourcen : constant ProduktionDatentypen.StadtLagermenge := 0;
   LeerProduktionrate : constant ProduktionDatentypen.Stadtproduktion := 0;
   LeerGeldgewinnung : constant ProduktionDatentypen.Stadtproduktion := 0;
   LeerPermanenteKosten : constant ProduktionDatentypen.Stadtproduktion := 0;
   LeerForschungsrate : constant ProduktionDatentypen.Stadtproduktion := 0;
   LeerBauprojekt : constant StadtRecords.BauprojektRecord := (0, 0);
   LeerBauzeit : constant ProduktionDatentypen.Produktion := 0;
   LeerKorruption : constant ProduktionDatentypen.Stadtproduktion := 0;
   LeerZufriedenheit : constant ProduktionDatentypen.Feldproduktion := 0;
   LeerGebäude : constant Boolean := False;
   LeerName : constant Unbounded_Wide_Wide_String := TextKonstanten.LeerUnboundedString;
   LeerUmgebungBewitschaftet : constant Boolean := False;
   LeerUmgebungGröße : constant KartenDatentypen.UmgebungsbereichDrei := 0;
   LeerMeldung : constant StadtDatentypen.Stadt_Meldung_Enum := StadtDatentypen.Leer_Stadt_Meldung_Enum;
   LeerKIBeschäftigung : constant KIDatentypen.Stadt_Aufgabe_Enum := KIDatentypen.Keine_Aufgabe_Enum;
   
   

   MaximaleBauzeit : constant ProduktionDatentypen.Produktion := ProduktionDatentypen.Produktion'Last;
   
   LeerGebäudeID : constant StadtDatentypen.GebäudeIDMitNullwert := 0;
   LeerPreisGeld : constant ProduktionDatentypen.Produktion := 0;
   LeerPreisRessourcen : constant ProduktionDatentypen.Produktion := 0;
   LeerAnforderungen : constant ForschungenDatentypen.ForschungIDNichtMöglich := ForschungKonstanten.ForschungUnmöglich;
   LeerBonusWirtschaft : constant ProduktionDatentypen.Feldproduktion := 0;
   LeerBonusKampf : constant KampfDatentypen.KampfwerteEinheiten := KampfDatentypen.KampfwerteEinheiten'First;
   LeerBasisgrundBenötigt : constant KartengrundDatentypen.Basisgrund_Enum := KartengrundDatentypen.Leer_Basisgrund_Enum;
   LeerZusatzgrundBenötigt : constant KartengrundDatentypen.Zusatzgrund_Enum := KartengrundDatentypen.Leer_Zusatzgrund_Enum;
   LeerFlussBenötigt : constant Boolean := False;
   LeerRessourceBenötigt : constant KartenextraDatentypen.Ressourcen_Enum := KartenextraDatentypen.Leer_Ressource_Enum;
   LeerVerbesserungBenötigt : constant KartenverbesserungDatentypen.Karten_Verbesserung_Enum := KartenverbesserungDatentypen.Leer_Verbesserung_Enum;
   LeerSpezielleEigenschaft : constant StadtDatentypen.Gebäude_Spezielle_Eigenschaften_Enum := StadtDatentypen.Leer_Gebäude_Spezielle_Egienschaft_Enum;
   
   
   
   -- Das auch so ändern dass es davon einen Standardwert und einen einstellbaren Wert gibt. äöü
   type StadtUmgebungWachstumArray is array (SystemDatentypen.Anfang_Ende_Enum'Range, SpeziesDatentypen.Spezies_Verwendet_Enum'Range) of ProduktionDatentypen.Einwohner;
   StadtUmgebungWachstum : constant StadtUmgebungWachstumArray := (
                                                                   SystemDatentypen.Anfangswert_Enum =>
                                                                     (
                                                                      SpeziesDatentypen.Menschen_Enum         => 10,
                                                                      SpeziesDatentypen.Kasrodiah_Enum        => 10,
                                                                      SpeziesDatentypen.Lasupin_Enum          => 10,
                                                                      SpeziesDatentypen.Lamustra_Enum         => 10,
                                                                      SpeziesDatentypen.Manuky_Enum           => 10,
                                                                      SpeziesDatentypen.Suroka_Enum           => 10,
                                                                      SpeziesDatentypen.Pryolon_Enum          => 10,
                                                                      SpeziesDatentypen.Talbidahr_Enum        => 10,
                                                                      SpeziesDatentypen.Moru_Phisihl_Enum     => 10,
                                                                      SpeziesDatentypen.Larinos_Lotaris_Enum  => 10,
                                                                      SpeziesDatentypen.Carupex_Enum          => 10,
                                                                      SpeziesDatentypen.Alary_Enum            => 10,
                                                                      SpeziesDatentypen.Tesorahn_Enum         => 10,
                                                                      SpeziesDatentypen.Natries_Zermanis_Enum => 10,
                                                                      SpeziesDatentypen.Tridatus_Enum         => 10,
                                                                      SpeziesDatentypen.Senelari_Enum         => 10,
                                                                      SpeziesDatentypen.Aspari_2_Enum         => 10,
                                                                      SpeziesDatentypen.Ekropa_Enum           => 10
                                                                     ),

                                                                   SystemDatentypen.Endwert_Enum =>
                                                                     (
                                                                      SpeziesDatentypen.Menschen_Enum         => 20,
                                                                      SpeziesDatentypen.Kasrodiah_Enum        => 20,
                                                                      SpeziesDatentypen.Lasupin_Enum          => 20,
                                                                      SpeziesDatentypen.Lamustra_Enum         => 20,
                                                                      SpeziesDatentypen.Manuky_Enum           => 20,
                                                                      SpeziesDatentypen.Suroka_Enum           => 20,
                                                                      SpeziesDatentypen.Pryolon_Enum          => 20,
                                                                      SpeziesDatentypen.Talbidahr_Enum        => 20,
                                                                      SpeziesDatentypen.Moru_Phisihl_Enum     => 20,
                                                                      SpeziesDatentypen.Larinos_Lotaris_Enum  => 20,
                                                                      SpeziesDatentypen.Carupex_Enum          => 20,
                                                                      SpeziesDatentypen.Alary_Enum            => 20,
                                                                      SpeziesDatentypen.Tesorahn_Enum         => 20,
                                                                      SpeziesDatentypen.Natries_Zermanis_Enum => 20,
                                                                      SpeziesDatentypen.Tridatus_Enum         => 20,
                                                                      SpeziesDatentypen.Senelari_Enum         => 20,
                                                                      SpeziesDatentypen.Aspari_2_Enum         => 20,
                                                                      SpeziesDatentypen.Ekropa_Enum           => 20
                                                                     )
                                                                  );

end StadtKonstanten;
