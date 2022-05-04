pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with EinheitStadtDatentypen;
with RassenDatentypen;
with TastenbelegungDatentypen;

with DatenbankRecords;

package ForschungKonstanten is
   
   LeerPreisForschung : constant EinheitStadtDatentypen.KostenLager := 0;
   LeerForschung : constant EinheitStadtDatentypen.ForschungIDMitNullWert := EinheitStadtDatentypen.ForschungIDMitNullWert'First;
   LeerForschungAnforderung : constant EinheitStadtDatentypen.ForschungIDMitNullWert := EinheitStadtDatentypen.ForschungIDMitNullWert'First;
   ForschungUnmöglich : constant EinheitStadtDatentypen.ForschungIDNichtMöglich := EinheitStadtDatentypen.ForschungIDNichtMöglich'First;
   
   LeerForschungListe : constant DatenbankRecords.ForschungslisteRecord := (
                                                                           PreisForschung       => LeerPreisForschung,
                                                                           AnforderungForschung => (others => ForschungUnmöglich)
                                                                          );
   
   type TechnologieVerbesserungArray is array (RassenDatentypen.Rassen_Verwendet_Enum'Range, TastenbelegungDatentypen.Tastenbelegung_Befehle_Enum'Range) of EinheitStadtDatentypen.ForschungIDNichtMöglich;
   TechnologieVerbesserung : constant TechnologieVerbesserungArray := (
                                                                       RassenDatentypen.Menschen_Enum =>
                                                                         (
                                                                          TastenbelegungDatentypen.Straße_Bauen_Enum       => 0,
                                                                          TastenbelegungDatentypen.Wald_Aufforsten_Enum    => 0,
                                                                          TastenbelegungDatentypen.Mine_Bauen_Enum         => 6,
                                                                          TastenbelegungDatentypen.Farm_Bauen_Enum         => 2,
                                                                          TastenbelegungDatentypen.Festung_Bauen_Enum      => 11,
                                                                          TastenbelegungDatentypen.Roden_Trockenlegen_Enum => 1,
                                                                          others                                           => LeerForschungAnforderung
                                                                         ),

                                                                       RassenDatentypen.Kasrodiah_Enum =>
                                                                         (
                                                                          TastenbelegungDatentypen.Straße_Bauen_Enum       => 0,
                                                                          TastenbelegungDatentypen.Wald_Aufforsten_Enum    => 0,
                                                                          TastenbelegungDatentypen.Mine_Bauen_Enum         => 6,
                                                                          TastenbelegungDatentypen.Farm_Bauen_Enum         => 2,
                                                                          TastenbelegungDatentypen.Festung_Bauen_Enum      => 11,
                                                                          TastenbelegungDatentypen.Roden_Trockenlegen_Enum => 1,
                                                                          others                                           => LeerForschungAnforderung
                                                                         ),

                                                                       RassenDatentypen.Lasupin_Enum =>
                                                                         (
                                                                          TastenbelegungDatentypen.Straße_Bauen_Enum       => 0,
                                                                          TastenbelegungDatentypen.Wald_Aufforsten_Enum    => 0,
                                                                          TastenbelegungDatentypen.Mine_Bauen_Enum         => 6,
                                                                          TastenbelegungDatentypen.Farm_Bauen_Enum         => 2,
                                                                          TastenbelegungDatentypen.Festung_Bauen_Enum      => 11,
                                                                          TastenbelegungDatentypen.Roden_Trockenlegen_Enum => 1,
                                                                          others                                           => LeerForschungAnforderung
                                                                         ),

                                                                       RassenDatentypen.Lamustra_Enum =>
                                                                         (
                                                                          TastenbelegungDatentypen.Straße_Bauen_Enum       => 0,
                                                                          TastenbelegungDatentypen.Wald_Aufforsten_Enum    => 0,
                                                                          TastenbelegungDatentypen.Mine_Bauen_Enum         => 6,
                                                                          TastenbelegungDatentypen.Farm_Bauen_Enum         => 2,
                                                                          TastenbelegungDatentypen.Festung_Bauen_Enum      => 11,
                                                                          TastenbelegungDatentypen.Roden_Trockenlegen_Enum => 1,
                                                                          others                                           => LeerForschungAnforderung
                                                                         ),

                                                                       RassenDatentypen.Manuky_Enum =>
                                                                         (
                                                                          TastenbelegungDatentypen.Straße_Bauen_Enum       => 0,
                                                                          TastenbelegungDatentypen.Wald_Aufforsten_Enum    => 0,
                                                                          TastenbelegungDatentypen.Mine_Bauen_Enum         => 6,
                                                                          TastenbelegungDatentypen.Farm_Bauen_Enum         => 2,
                                                                          TastenbelegungDatentypen.Festung_Bauen_Enum      => 11,
                                                                          TastenbelegungDatentypen.Roden_Trockenlegen_Enum => 1,
                                                                          others                                           => LeerForschungAnforderung
                                                                         ),

                                                                       RassenDatentypen.Suroka_Enum =>
                                                                         (
                                                                          TastenbelegungDatentypen.Straße_Bauen_Enum       => 0,
                                                                          TastenbelegungDatentypen.Wald_Aufforsten_Enum    => 0,
                                                                          TastenbelegungDatentypen.Mine_Bauen_Enum         => 6,
                                                                          TastenbelegungDatentypen.Farm_Bauen_Enum         => 2,
                                                                          TastenbelegungDatentypen.Festung_Bauen_Enum      => 11,
                                                                          TastenbelegungDatentypen.Roden_Trockenlegen_Enum => 1,
                                                                          others                                           => LeerForschungAnforderung
                                                                         ),

                                                                       RassenDatentypen.Pryolon_Enum =>
                                                                         (
                                                                          TastenbelegungDatentypen.Straße_Bauen_Enum       => 0,
                                                                          TastenbelegungDatentypen.Wald_Aufforsten_Enum    => 0,
                                                                          TastenbelegungDatentypen.Mine_Bauen_Enum         => 6,
                                                                          TastenbelegungDatentypen.Farm_Bauen_Enum         => 2,
                                                                          TastenbelegungDatentypen.Festung_Bauen_Enum      => 11,
                                                                          TastenbelegungDatentypen.Roden_Trockenlegen_Enum => 1,
                                                                          others                                           => LeerForschungAnforderung
                                                                         ),

                                                                       RassenDatentypen.Talbidahr_Enum =>
                                                                         (
                                                                          TastenbelegungDatentypen.Straße_Bauen_Enum       => 0,
                                                                          TastenbelegungDatentypen.Wald_Aufforsten_Enum    => 0,
                                                                          TastenbelegungDatentypen.Mine_Bauen_Enum         => 6,
                                                                          TastenbelegungDatentypen.Farm_Bauen_Enum         => 2,
                                                                          TastenbelegungDatentypen.Festung_Bauen_Enum      => 11,
                                                                          TastenbelegungDatentypen.Roden_Trockenlegen_Enum => 1,
                                                                          others                                           => LeerForschungAnforderung
                                                                         ),

                                                                       RassenDatentypen.Moru_Phisihl_Enum =>
                                                                         (
                                                                          TastenbelegungDatentypen.Straße_Bauen_Enum       => 0,
                                                                          TastenbelegungDatentypen.Wald_Aufforsten_Enum    => 0,
                                                                          TastenbelegungDatentypen.Mine_Bauen_Enum         => 6,
                                                                          TastenbelegungDatentypen.Farm_Bauen_Enum         => 2,
                                                                          TastenbelegungDatentypen.Festung_Bauen_Enum      => 11,
                                                                          TastenbelegungDatentypen.Roden_Trockenlegen_Enum => 1,
                                                                          others                                           => LeerForschungAnforderung
                                                                         ),

                                                                       RassenDatentypen.Larinos_Lotaris_Enum =>
                                                                         (
                                                                          TastenbelegungDatentypen.Straße_Bauen_Enum       => 0,
                                                                          TastenbelegungDatentypen.Wald_Aufforsten_Enum    => 0,
                                                                          TastenbelegungDatentypen.Mine_Bauen_Enum         => 6,
                                                                          TastenbelegungDatentypen.Farm_Bauen_Enum         => 2,
                                                                          TastenbelegungDatentypen.Festung_Bauen_Enum      => 11,
                                                                          TastenbelegungDatentypen.Roden_Trockenlegen_Enum => 1,
                                                                          others                                           => LeerForschungAnforderung
                                                                         ),

                                                                       RassenDatentypen.Carupex_Enum =>
                                                                         (
                                                                          TastenbelegungDatentypen.Straße_Bauen_Enum       => 0,
                                                                          TastenbelegungDatentypen.Wald_Aufforsten_Enum    => 0,
                                                                          TastenbelegungDatentypen.Mine_Bauen_Enum         => 6,
                                                                          TastenbelegungDatentypen.Farm_Bauen_Enum         => 2,
                                                                          TastenbelegungDatentypen.Festung_Bauen_Enum      => 11,
                                                                          TastenbelegungDatentypen.Roden_Trockenlegen_Enum => 1,
                                                                          others                                           => LeerForschungAnforderung
                                                                         ),

                                                                       RassenDatentypen.Alary_Enum =>
                                                                         (
                                                                          TastenbelegungDatentypen.Straße_Bauen_Enum       => 0,
                                                                          TastenbelegungDatentypen.Wald_Aufforsten_Enum    => 0,
                                                                          TastenbelegungDatentypen.Mine_Bauen_Enum         => 6,
                                                                          TastenbelegungDatentypen.Farm_Bauen_Enum         => 2,
                                                                          TastenbelegungDatentypen.Festung_Bauen_Enum      => 11,
                                                                          TastenbelegungDatentypen.Roden_Trockenlegen_Enum => 1,
                                                                          others                                           => LeerForschungAnforderung
                                                                         ),

                                                                       RassenDatentypen.Tesorahn_Enum =>
                                                                         (
                                                                          TastenbelegungDatentypen.Straße_Bauen_Enum       => 0,
                                                                          TastenbelegungDatentypen.Wald_Aufforsten_Enum    => 0,
                                                                          TastenbelegungDatentypen.Mine_Bauen_Enum         => 6,
                                                                          TastenbelegungDatentypen.Farm_Bauen_Enum         => 2,
                                                                          TastenbelegungDatentypen.Festung_Bauen_Enum      => 11,
                                                                          TastenbelegungDatentypen.Roden_Trockenlegen_Enum => 1,
                                                                          others                                           => LeerForschungAnforderung
                                                                         ),

                                                                       RassenDatentypen.Natries_Zermanis_Enum =>
                                                                         (
                                                                          TastenbelegungDatentypen.Straße_Bauen_Enum       => 0,
                                                                          TastenbelegungDatentypen.Wald_Aufforsten_Enum    => 0,
                                                                          TastenbelegungDatentypen.Mine_Bauen_Enum         => 6,
                                                                          TastenbelegungDatentypen.Farm_Bauen_Enum         => 2,
                                                                          TastenbelegungDatentypen.Festung_Bauen_Enum      => 11,
                                                                          TastenbelegungDatentypen.Roden_Trockenlegen_Enum => 1,
                                                                          others                                           => LeerForschungAnforderung
                                                                         ),

                                                                       RassenDatentypen.Tridatus_Enum =>
                                                                         (
                                                                          TastenbelegungDatentypen.Straße_Bauen_Enum       => 0,
                                                                          TastenbelegungDatentypen.Wald_Aufforsten_Enum    => 0,
                                                                          TastenbelegungDatentypen.Mine_Bauen_Enum         => 6,
                                                                          TastenbelegungDatentypen.Farm_Bauen_Enum         => 2,
                                                                          TastenbelegungDatentypen.Festung_Bauen_Enum      => 11,
                                                                          TastenbelegungDatentypen.Roden_Trockenlegen_Enum => 1,
                                                                          others                                           => LeerForschungAnforderung
                                                                         ),

                                                                       RassenDatentypen.Senelari_Enum =>
                                                                         (
                                                                          TastenbelegungDatentypen.Straße_Bauen_Enum       => 0,
                                                                          TastenbelegungDatentypen.Wald_Aufforsten_Enum    => 0,
                                                                          TastenbelegungDatentypen.Mine_Bauen_Enum         => 6,
                                                                          TastenbelegungDatentypen.Farm_Bauen_Enum         => 2,
                                                                          TastenbelegungDatentypen.Festung_Bauen_Enum      => 11,
                                                                          TastenbelegungDatentypen.Roden_Trockenlegen_Enum => 1,
                                                                          others                                           => LeerForschungAnforderung
                                                                         ),

                                                                       RassenDatentypen.Aspari_2_Enum =>
                                                                         (
                                                                          TastenbelegungDatentypen.Straße_Bauen_Enum       => 0,
                                                                          TastenbelegungDatentypen.Wald_Aufforsten_Enum    => 0,
                                                                          TastenbelegungDatentypen.Mine_Bauen_Enum         => 6,
                                                                          TastenbelegungDatentypen.Farm_Bauen_Enum         => 2,
                                                                          TastenbelegungDatentypen.Festung_Bauen_Enum      => 11,
                                                                          TastenbelegungDatentypen.Roden_Trockenlegen_Enum => 1,
                                                                          others                                           => LeerForschungAnforderung
                                                                         ),

                                                                       RassenDatentypen.Ekropa_Enum =>
                                                                         (
                                                                          TastenbelegungDatentypen.Straße_Bauen_Enum       => 0,
                                                                          TastenbelegungDatentypen.Wald_Aufforsten_Enum    => 0,
                                                                          TastenbelegungDatentypen.Mine_Bauen_Enum         => 6,
                                                                          TastenbelegungDatentypen.Farm_Bauen_Enum         => 2,
                                                                          TastenbelegungDatentypen.Festung_Bauen_Enum      => 11,
                                                                          TastenbelegungDatentypen.Roden_Trockenlegen_Enum => 1,
                                                                          others                                           => LeerForschungAnforderung
                                                                         )
                                                                      );

end ForschungKonstanten;
