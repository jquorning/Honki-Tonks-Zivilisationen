pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KartengrundDatentypen;
with EinheitenDatentypen;
with RassenDatentypen;

with DatenbankRecords;

package KartengrundKern is
   
   -- Passierbarkeit: Boden, Wasser, Luft, Weltraum, Unterwasser, Küstenwasser, Unterirdisch (Erde), Planeteninneres (Gestein), Lava

   type KartengrundlisteKernArray is array (KartengrundDatentypen.Kartengrund_Kernfläche_Enum'Range) of DatenbankRecords.KartengrundlisteRecord;
   KartengrundlisteKern : constant KartengrundlisteKernArray := (
                                                                 KartengrundDatentypen.Lava_Enum =>
                                                                   (
                                                                    Passierbarkeit => (EinheitenDatentypen.Planeteninneres_Enum => True,
                                                                                       others                                   => False),
                                                                    
                                                                    Bewertung => 
                                                                      (
                                                                       RassenDatentypen.Menschen_Enum         => 1,
                                                                       RassenDatentypen.Kasrodiah_Enum        => 1,
                                                                       RassenDatentypen.Lasupin_Enum          => 1,
                                                                       RassenDatentypen.Lamustra_Enum         => 1,
                                                                       RassenDatentypen.Manuky_Enum           => 1,
                                                                       RassenDatentypen.Suroka_Enum           => 1,
                                                                       RassenDatentypen.Pryolon_Enum          => 1,
                                                                       RassenDatentypen.Moru_Phisihl_Enum     => 1,
                                                                       RassenDatentypen.Larinos_Lotaris_Enum  => 1,
                                                                       RassenDatentypen.Carupex_Enum          => 1,
                                                                       RassenDatentypen.Alary_Enum            => 1,
                                                                       RassenDatentypen.Natries_Zermanis_Enum => 1,
                                                                       RassenDatentypen.Tridatus_Enum         => 1,
                                                                       RassenDatentypen.Senelari_Enum         => 1,
                                                                       RassenDatentypen.Aspari_2_Enum         => 1,
                                                                       RassenDatentypen.Ekropa_Enum           => 1,
                                                                       RassenDatentypen.Tesorahn_Enum         => 1,
                                                                       RassenDatentypen.Talbidahr_Enum        => 1
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
      
                                                                 KartengrundDatentypen.Planetenkern_Enum =>
                                                                   (
                                                                    Passierbarkeit => (EinheitenDatentypen.Planeteninneres_Enum => True,
                                                                                       others                                   => False),
                                                                    
                                                                    Bewertung => 
                                                                      (
                                                                       RassenDatentypen.Menschen_Enum         => 1,
                                                                       RassenDatentypen.Kasrodiah_Enum        => 1,
                                                                       RassenDatentypen.Lasupin_Enum          => 1,
                                                                       RassenDatentypen.Lamustra_Enum         => 1,
                                                                       RassenDatentypen.Manuky_Enum           => 1,
                                                                       RassenDatentypen.Suroka_Enum           => 1,
                                                                       RassenDatentypen.Pryolon_Enum          => 1,
                                                                       RassenDatentypen.Moru_Phisihl_Enum     => 1,
                                                                       RassenDatentypen.Larinos_Lotaris_Enum  => 1,
                                                                       RassenDatentypen.Carupex_Enum          => 1,
                                                                       RassenDatentypen.Alary_Enum            => 1,
                                                                       RassenDatentypen.Natries_Zermanis_Enum => 1,
                                                                       RassenDatentypen.Tridatus_Enum         => 1,
                                                                       RassenDatentypen.Senelari_Enum         => 1,
                                                                       RassenDatentypen.Aspari_2_Enum         => 1,
                                                                       RassenDatentypen.Ekropa_Enum           => 1,
                                                                       RassenDatentypen.Tesorahn_Enum         => 1,
                                                                       RassenDatentypen.Talbidahr_Enum        => 1
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
                                                                 
                                                                 KartengrundDatentypen.Ringwoodit_Enum =>
                                                                   (
                                                                    Passierbarkeit => (EinheitenDatentypen.Planeteninneres_Enum => True,
                                                                                       others                                   => False),
                                                                    
                                                                    Bewertung => 
                                                                      (
                                                                       RassenDatentypen.Menschen_Enum         => 1,
                                                                       RassenDatentypen.Kasrodiah_Enum        => 1,
                                                                       RassenDatentypen.Lasupin_Enum          => 1,
                                                                       RassenDatentypen.Lamustra_Enum         => 1,
                                                                       RassenDatentypen.Manuky_Enum           => 1,
                                                                       RassenDatentypen.Suroka_Enum           => 1,
                                                                       RassenDatentypen.Pryolon_Enum          => 1,
                                                                       RassenDatentypen.Moru_Phisihl_Enum     => 1,
                                                                       RassenDatentypen.Larinos_Lotaris_Enum  => 1,
                                                                       RassenDatentypen.Carupex_Enum          => 1,
                                                                       RassenDatentypen.Alary_Enum            => 1,
                                                                       RassenDatentypen.Natries_Zermanis_Enum => 1,
                                                                       RassenDatentypen.Tridatus_Enum         => 1,
                                                                       RassenDatentypen.Senelari_Enum         => 1,
                                                                       RassenDatentypen.Aspari_2_Enum         => 1,
                                                                       RassenDatentypen.Ekropa_Enum           => 1,
                                                                       RassenDatentypen.Tesorahn_Enum         => 1,
                                                                       RassenDatentypen.Talbidahr_Enum        => 1
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
      
                                                                 KartengrundDatentypen.Majorit_Enum =>
                                                                   (
                                                                    Passierbarkeit => (EinheitenDatentypen.Planeteninneres_Enum => True,
                                                                                       others                                   => False),
                                                                    
                                                                    Bewertung => 
                                                                      (
                                                                       RassenDatentypen.Menschen_Enum         => 1,
                                                                       RassenDatentypen.Kasrodiah_Enum        => 1,
                                                                       RassenDatentypen.Lasupin_Enum          => 1,
                                                                       RassenDatentypen.Lamustra_Enum         => 1,
                                                                       RassenDatentypen.Manuky_Enum           => 1,
                                                                       RassenDatentypen.Suroka_Enum           => 1,
                                                                       RassenDatentypen.Pryolon_Enum          => 1,
                                                                       RassenDatentypen.Moru_Phisihl_Enum     => 1,
                                                                       RassenDatentypen.Larinos_Lotaris_Enum  => 1,
                                                                       RassenDatentypen.Carupex_Enum          => 1,
                                                                       RassenDatentypen.Alary_Enum            => 1,
                                                                       RassenDatentypen.Natries_Zermanis_Enum => 1,
                                                                       RassenDatentypen.Tridatus_Enum         => 1,
                                                                       RassenDatentypen.Senelari_Enum         => 1,
                                                                       RassenDatentypen.Aspari_2_Enum         => 1,
                                                                       RassenDatentypen.Ekropa_Enum           => 1,
                                                                       RassenDatentypen.Tesorahn_Enum         => 1,
                                                                       RassenDatentypen.Talbidahr_Enum        => 1
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
                                                                 
                                                                 KartengrundDatentypen.Perowskit_Enum =>
                                                                   (
                                                                    Passierbarkeit => (EinheitenDatentypen.Planeteninneres_Enum => True,
                                                                                       others                                   => False),
                                                                    
                                                                    Bewertung => 
                                                                      (
                                                                       RassenDatentypen.Menschen_Enum         => 1,
                                                                       RassenDatentypen.Kasrodiah_Enum        => 1,
                                                                       RassenDatentypen.Lasupin_Enum          => 1,
                                                                       RassenDatentypen.Lamustra_Enum         => 1,
                                                                       RassenDatentypen.Manuky_Enum           => 1,
                                                                       RassenDatentypen.Suroka_Enum           => 1,
                                                                       RassenDatentypen.Pryolon_Enum          => 1,
                                                                       RassenDatentypen.Moru_Phisihl_Enum     => 1,
                                                                       RassenDatentypen.Larinos_Lotaris_Enum  => 1,
                                                                       RassenDatentypen.Carupex_Enum          => 1,
                                                                       RassenDatentypen.Alary_Enum            => 1,
                                                                       RassenDatentypen.Natries_Zermanis_Enum => 1,
                                                                       RassenDatentypen.Tridatus_Enum         => 1,
                                                                       RassenDatentypen.Senelari_Enum         => 1,
                                                                       RassenDatentypen.Aspari_2_Enum         => 1,
                                                                       RassenDatentypen.Ekropa_Enum           => 1,
                                                                       RassenDatentypen.Tesorahn_Enum         => 1,
                                                                       RassenDatentypen.Talbidahr_Enum        => 1
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
      
                                                                 KartengrundDatentypen.Magnesiowüstit_Enum =>
                                                                   (
                                                                    Passierbarkeit => (EinheitenDatentypen.Planeteninneres_Enum => True,
                                                                                       others                                   => False),
                                                                    
                                                                    Bewertung => 
                                                                      (
                                                                       RassenDatentypen.Menschen_Enum         => 1,
                                                                       RassenDatentypen.Kasrodiah_Enum        => 1,
                                                                       RassenDatentypen.Lasupin_Enum          => 1,
                                                                       RassenDatentypen.Lamustra_Enum         => 1,
                                                                       RassenDatentypen.Manuky_Enum           => 1,
                                                                       RassenDatentypen.Suroka_Enum           => 1,
                                                                       RassenDatentypen.Pryolon_Enum          => 1,
                                                                       RassenDatentypen.Moru_Phisihl_Enum     => 1,
                                                                       RassenDatentypen.Larinos_Lotaris_Enum  => 1,
                                                                       RassenDatentypen.Carupex_Enum          => 1,
                                                                       RassenDatentypen.Alary_Enum            => 1,
                                                                       RassenDatentypen.Natries_Zermanis_Enum => 1,
                                                                       RassenDatentypen.Tridatus_Enum         => 1,
                                                                       RassenDatentypen.Senelari_Enum         => 1,
                                                                       RassenDatentypen.Aspari_2_Enum         => 1,
                                                                       RassenDatentypen.Ekropa_Enum           => 1,
                                                                       RassenDatentypen.Tesorahn_Enum         => 1,
                                                                       RassenDatentypen.Talbidahr_Enum        => 1
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

end KartengrundKern;
