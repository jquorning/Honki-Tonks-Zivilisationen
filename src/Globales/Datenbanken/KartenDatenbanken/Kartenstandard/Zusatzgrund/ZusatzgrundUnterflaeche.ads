pragma Warnings (Off, "*array aggregate*");

with KartengrundDatentypen;
with RassenDatentypen;
with KartendatenbankRecord;

with BewertungDatentypen;

package ZusatzgrundUnterflaeche is
   pragma Pure;
   
   -- Passierbarkeit: Boden, Wasser, Luft, Weltraum, Unterwasser, Küstenwasser, Unterirdisch (Erde), Planeteninneres (Gestein), Lava

   type ZusatzgrundlisteUnterflächeArray is array (KartengrundDatentypen.Zusatzgrund_Unterfläche_Enum'Range) of KartendatenbankRecord.KartenlistenRecord;
   ZusatzgrundlisteUnterfläche : constant ZusatzgrundlisteUnterflächeArray := (
                                                                                 KartengrundDatentypen.Korallen_Enum =>
                                                                                   (
                                                                                    Bewertung =>
                                                                                      (
                                                                                       RassenDatentypen.Menschen_Enum         => BewertungDatentypen.Bewertung_Sechs_Enum,
                                                                                       RassenDatentypen.Kasrodiah_Enum        => BewertungDatentypen.Bewertung_Sechs_Enum,
                                                                                       RassenDatentypen.Lasupin_Enum          => BewertungDatentypen.Bewertung_Sechs_Enum,
                                                                                       RassenDatentypen.Lamustra_Enum         => BewertungDatentypen.Bewertung_Sechs_Enum,
                                                                                       RassenDatentypen.Manuky_Enum           => BewertungDatentypen.Bewertung_Sechs_Enum,
                                                                                       RassenDatentypen.Suroka_Enum           => BewertungDatentypen.Bewertung_Sechs_Enum,
                                                                                       RassenDatentypen.Pryolon_Enum          => BewertungDatentypen.Bewertung_Sechs_Enum,
                                                                                       RassenDatentypen.Moru_Phisihl_Enum     => BewertungDatentypen.Bewertung_Sechs_Enum,
                                                                                       RassenDatentypen.Larinos_Lotaris_Enum  => BewertungDatentypen.Bewertung_Sechs_Enum,
                                                                                       RassenDatentypen.Carupex_Enum          => BewertungDatentypen.Bewertung_Sechs_Enum,
                                                                                       RassenDatentypen.Alary_Enum            => BewertungDatentypen.Bewertung_Sechs_Enum,
                                                                                       RassenDatentypen.Natries_Zermanis_Enum => BewertungDatentypen.Bewertung_Sechs_Enum,
                                                                                       RassenDatentypen.Tridatus_Enum         => BewertungDatentypen.Bewertung_Sechs_Enum,
                                                                                       RassenDatentypen.Senelari_Enum         => BewertungDatentypen.Bewertung_Sechs_Enum,
                                                                                       RassenDatentypen.Aspari_2_Enum         => BewertungDatentypen.Bewertung_Sechs_Enum,
                                                                                       RassenDatentypen.Ekropa_Enum           => BewertungDatentypen.Bewertung_Sechs_Enum,
                                                                                       RassenDatentypen.Tesorahn_Enum         => BewertungDatentypen.Bewertung_Sechs_Enum,
                                                                                       RassenDatentypen.Talbidahr_Enum        => BewertungDatentypen.Bewertung_Sechs_Enum
                                                                                      ),

                                                                                      -- Nahrung, Produktion, Geld, Forschung
                                                                                    Wirtschaft =>
                                                                                      (
                                                                                       RassenDatentypen.Menschen_Enum         => (1, 1, 1, 1),
                                                                                       RassenDatentypen.Kasrodiah_Enum        => (1, 1, 1, 1),
                                                                                       RassenDatentypen.Lasupin_Enum          => (1, 1, 1, 1),
                                                                                       RassenDatentypen.Lamustra_Enum         => (1, 1, 1, 1),
                                                                                       RassenDatentypen.Manuky_Enum           => (1, 1, 1, 1),
                                                                                       RassenDatentypen.Suroka_Enum           => (1, 1, 1, 1),
                                                                                       RassenDatentypen.Pryolon_Enum          => (1, 1, 1, 1),
                                                                                       RassenDatentypen.Moru_Phisihl_Enum     => (1, 1, 1, 1),
                                                                                       RassenDatentypen.Larinos_Lotaris_Enum  => (1, 1, 1, 1),
                                                                                       RassenDatentypen.Carupex_Enum          => (1, 1, 1, 1),
                                                                                       RassenDatentypen.Alary_Enum            => (1, 1, 1, 1),
                                                                                       RassenDatentypen.Natries_Zermanis_Enum => (1, 1, 1, 1),
                                                                                       RassenDatentypen.Tridatus_Enum         => (1, 1, 1, 1),
                                                                                       RassenDatentypen.Senelari_Enum         => (1, 1, 1, 1),
                                                                                       RassenDatentypen.Aspari_2_Enum         => (1, 1, 1, 1),
                                                                                       RassenDatentypen.Ekropa_Enum           => (1, 1, 1, 1),
                                                                                       RassenDatentypen.Tesorahn_Enum         => (1, 1, 1, 1),
                                                                                       RassenDatentypen.Talbidahr_Enum        => (1, 1, 1, 1)
                                                                                      ),

                                                                                      -- Verteidigung, Angriff
                                                                                    Kampf =>
                                                                                      (
                                                                                       RassenDatentypen.Menschen_Enum         => (1, 1),
                                                                                       RassenDatentypen.Kasrodiah_Enum        => (1, 1),
                                                                                       RassenDatentypen.Lasupin_Enum          => (1, 1),
                                                                                       RassenDatentypen.Lamustra_Enum         => (1, 1),
                                                                                       RassenDatentypen.Manuky_Enum           => (1, 1),
                                                                                       RassenDatentypen.Suroka_Enum           => (1, 1),
                                                                                       RassenDatentypen.Pryolon_Enum          => (1, 1),
                                                                                       RassenDatentypen.Moru_Phisihl_Enum     => (1, 1),
                                                                                       RassenDatentypen.Larinos_Lotaris_Enum  => (1, 1),
                                                                                       RassenDatentypen.Carupex_Enum          => (1, 1),
                                                                                       RassenDatentypen.Alary_Enum            => (1, 1),
                                                                                       RassenDatentypen.Natries_Zermanis_Enum => (1, 1),
                                                                                       RassenDatentypen.Tridatus_Enum         => (1, 1),
                                                                                       RassenDatentypen.Senelari_Enum         => (1, 1),
                                                                                       RassenDatentypen.Aspari_2_Enum         => (1, 1),
                                                                                       RassenDatentypen.Ekropa_Enum           => (1, 1),
                                                                                       RassenDatentypen.Tesorahn_Enum         => (1, 1),
                                                                                       RassenDatentypen.Talbidahr_Enum        => (1, 1)
                                                                                      )
                                                                                   ),

                                                                                 KartengrundDatentypen.Unterwald_Enum =>
                                                                                   (
                                                                                    Bewertung =>
                                                                                      (
                                                                                       RassenDatentypen.Menschen_Enum         => BewertungDatentypen.Bewertung_Sechs_Enum,
                                                                                       RassenDatentypen.Kasrodiah_Enum        => BewertungDatentypen.Bewertung_Sechs_Enum,
                                                                                       RassenDatentypen.Lasupin_Enum          => BewertungDatentypen.Bewertung_Sechs_Enum,
                                                                                       RassenDatentypen.Lamustra_Enum         => BewertungDatentypen.Bewertung_Sechs_Enum,
                                                                                       RassenDatentypen.Manuky_Enum           => BewertungDatentypen.Bewertung_Sechs_Enum,
                                                                                       RassenDatentypen.Suroka_Enum           => BewertungDatentypen.Bewertung_Sechs_Enum,
                                                                                       RassenDatentypen.Pryolon_Enum          => BewertungDatentypen.Bewertung_Sechs_Enum,
                                                                                       RassenDatentypen.Moru_Phisihl_Enum     => BewertungDatentypen.Bewertung_Sechs_Enum,
                                                                                       RassenDatentypen.Larinos_Lotaris_Enum  => BewertungDatentypen.Bewertung_Sechs_Enum,
                                                                                       RassenDatentypen.Carupex_Enum          => BewertungDatentypen.Bewertung_Sechs_Enum,
                                                                                       RassenDatentypen.Alary_Enum            => BewertungDatentypen.Bewertung_Sechs_Enum,
                                                                                       RassenDatentypen.Natries_Zermanis_Enum => BewertungDatentypen.Bewertung_Sechs_Enum,
                                                                                       RassenDatentypen.Tridatus_Enum         => BewertungDatentypen.Bewertung_Sechs_Enum,
                                                                                       RassenDatentypen.Senelari_Enum         => BewertungDatentypen.Bewertung_Sechs_Enum,
                                                                                       RassenDatentypen.Aspari_2_Enum         => BewertungDatentypen.Bewertung_Sechs_Enum,
                                                                                       RassenDatentypen.Ekropa_Enum           => BewertungDatentypen.Bewertung_Sechs_Enum,
                                                                                       RassenDatentypen.Tesorahn_Enum         => BewertungDatentypen.Bewertung_Sechs_Enum,
                                                                                       RassenDatentypen.Talbidahr_Enum        => BewertungDatentypen.Bewertung_Sechs_Enum
                                                                                      ),

                                                                                      -- Nahrung, Produktion, Geld, Forschung
                                                                                    Wirtschaft =>
                                                                                      (
                                                                                       RassenDatentypen.Menschen_Enum         => (1, 1, 1, 1),
                                                                                       RassenDatentypen.Kasrodiah_Enum        => (1, 1, 1, 1),
                                                                                       RassenDatentypen.Lasupin_Enum          => (1, 1, 1, 1),
                                                                                       RassenDatentypen.Lamustra_Enum         => (1, 1, 1, 1),
                                                                                       RassenDatentypen.Manuky_Enum           => (1, 1, 1, 1),
                                                                                       RassenDatentypen.Suroka_Enum           => (1, 1, 1, 1),
                                                                                       RassenDatentypen.Pryolon_Enum          => (1, 1, 1, 1),
                                                                                       RassenDatentypen.Moru_Phisihl_Enum     => (1, 1, 1, 1),
                                                                                       RassenDatentypen.Larinos_Lotaris_Enum  => (1, 1, 1, 1),
                                                                                       RassenDatentypen.Carupex_Enum          => (1, 1, 1, 1),
                                                                                       RassenDatentypen.Alary_Enum            => (1, 1, 1, 1),
                                                                                       RassenDatentypen.Natries_Zermanis_Enum => (1, 1, 1, 1),
                                                                                       RassenDatentypen.Tridatus_Enum         => (1, 1, 1, 1),
                                                                                       RassenDatentypen.Senelari_Enum         => (1, 1, 1, 1),
                                                                                       RassenDatentypen.Aspari_2_Enum         => (1, 1, 1, 1),
                                                                                       RassenDatentypen.Ekropa_Enum           => (1, 1, 1, 1),
                                                                                       RassenDatentypen.Tesorahn_Enum         => (1, 1, 1, 1),
                                                                                       RassenDatentypen.Talbidahr_Enum        => (1, 1, 1, 1)
                                                                                      ),

                                                                                      -- Verteidigung, Angriff
                                                                                    Kampf =>
                                                                                      (
                                                                                       RassenDatentypen.Menschen_Enum         => (1, 1),
                                                                                       RassenDatentypen.Kasrodiah_Enum        => (1, 1),
                                                                                       RassenDatentypen.Lasupin_Enum          => (1, 1),
                                                                                       RassenDatentypen.Lamustra_Enum         => (1, 1),
                                                                                       RassenDatentypen.Manuky_Enum           => (1, 1),
                                                                                       RassenDatentypen.Suroka_Enum           => (1, 1),
                                                                                       RassenDatentypen.Pryolon_Enum          => (1, 1),
                                                                                       RassenDatentypen.Moru_Phisihl_Enum     => (1, 1),
                                                                                       RassenDatentypen.Larinos_Lotaris_Enum  => (1, 1),
                                                                                       RassenDatentypen.Carupex_Enum          => (1, 1),
                                                                                       RassenDatentypen.Alary_Enum            => (1, 1),
                                                                                       RassenDatentypen.Natries_Zermanis_Enum => (1, 1),
                                                                                       RassenDatentypen.Tridatus_Enum         => (1, 1),
                                                                                       RassenDatentypen.Senelari_Enum         => (1, 1),
                                                                                       RassenDatentypen.Aspari_2_Enum         => (1, 1),
                                                                                       RassenDatentypen.Ekropa_Enum           => (1, 1),
                                                                                       RassenDatentypen.Tesorahn_Enum         => (1, 1),
                                                                                       RassenDatentypen.Talbidahr_Enum        => (1, 1)
                                                                                      )
                                                                                   )
                                                                                );

end ZusatzgrundUnterflaeche;
