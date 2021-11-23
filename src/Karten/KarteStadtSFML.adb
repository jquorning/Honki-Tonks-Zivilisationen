pragma SPARK_Mode (On);

with Sf.Graphics.Color;

with KartenDatentypen; use KartenDatentypen;

with LeseKarten;
with LeseStadtGebaut;
with KarteSFML;
with GrafikAllgemein;
with BerechnungenKarteSFML;

package body KarteStadtSFML is

   procedure AnzeigeStadt
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
   is begin
      
      -- GrafikAllgemein.FensterLeeren;
      
      GrafischeDarstellung (StadtRasseNummerExtern => StadtRasseNummerExtern);
      
      -- GrafikAllgemein.FensterAnzeigen;
      
   end AnzeigeStadt;
   
   
   
   procedure GrafischeDarstellung
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
   is begin
      
      GrafikAllgemein.RechteckZeichnen (AbmessungExtern => BerechnungenKarteSFML.StadtKarte,
                                        PositionExtern  => (0.00, 0.00),
                                        FarbeExtern     => KarteSFML.FarbeErmitteln (GrundExtern => LeseKarten.Grund (PositionExtern => LeseStadtGebaut.Position (StadtRasseNummerExtern => StadtRasseNummerExtern))));
      
      GrafikAllgemein.RechteckZeichnen (AbmessungExtern => (BerechnungenKarteSFML.StadtAnzeige.x - BerechnungenKarteSFML.StadtKarte.x, BerechnungenKarteSFML.StadtAnzeige.y),
                                        PositionExtern  => (BerechnungenKarteSFML.StadtKarte.x, 0.00),
                                        FarbeExtern     => Sf.Graphics.Color.sfBlack);
      
   end GrafischeDarstellung;

end KarteStadtSFML;
