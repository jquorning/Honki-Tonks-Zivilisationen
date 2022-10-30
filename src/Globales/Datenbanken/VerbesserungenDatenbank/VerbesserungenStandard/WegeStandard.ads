pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KartenverbesserungDatentypen;
with EinheitenDatentypen;
with KartendatenbankRecord;

with BewertungDatentypen;

package WegeStandard is
   pragma Pure;

   type WegelisteArray is array (KartenverbesserungDatentypen.Karten_Straße_Enum'Range) of KartendatenbankRecord.KartenpassierbarkeitslistenRecord;
   Wegeliste : constant WegelisteArray := (
                                           others =>
                                             (
                                              Passierbarkeit     => (EinheitenDatentypen.Boden_Enum    => True,
                                                                     EinheitenDatentypen.Luft_Enum     => True,
                                                                     EinheitenDatentypen.Weltraum_Enum => True,
                                                                     others                            => False),
                                              Bewertung          => (others => BewertungDatentypen.Bewertung_Eins_Enum),
                                              Wirtschaft         => (others => (others => 1)),
                                              Kampf              => (others => (others => 1))
                                             )
                                          );
                                           
   
   
   type SchienenlisteArray is array (KartenverbesserungDatentypen.Karten_Schiene_Enum'Range) of KartendatenbankRecord.KartenpassierbarkeitslistenRecord;
   Schienenliste : constant SchienenlisteArray := (
                                                   others =>
                                                     (
                                                      Passierbarkeit     => (
                                                                             EinheitenDatentypen.Boden_Enum    => True,
                                                                             EinheitenDatentypen.Luft_Enum     => True,
                                                                             EinheitenDatentypen.Weltraum_Enum => True,
                                                                             others                            => False
                                                                            ),
                                                      Bewertung          => (others => BewertungDatentypen.Bewertung_Eins_Enum),
                                                      Wirtschaft         => (others => (others => 1)),
                                                      Kampf              => (others => (others => 1))
                                                     )
                                                  );
   
   
   
   type TunnellisteArray is array (KartenverbesserungDatentypen.Karten_Tunnel_Enum'Range) of KartendatenbankRecord.KartenpassierbarkeitslistenRecord;
   Tunnelliste : constant TunnellisteArray := (
                                               others =>
                                                 (
                                                  Passierbarkeit     => (
                                                                         EinheitenDatentypen.Unterirdisch_Enum => True,
                                                                         others                                => False
                                                                        ),
                                                  Bewertung          => (others => BewertungDatentypen.Bewertung_Eins_Enum),
                                                  Wirtschaft         => (others => (others => 1)),
                                                  Kampf              => (others => (others => 1))
                                                 )
                                              );

end WegeStandard;
