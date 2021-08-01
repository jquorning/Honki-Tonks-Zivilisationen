pragma SPARK_Mode (On);

with GlobaleVariablen, GlobaleKonstanten, GlobaleDatentypen;

with Karten, Cheat;

package body AllesAufAnfangSetzen is

   procedure AllesAufAnfangSetzen
   is begin
      
      GlobaleVariablen.RassenImSpiel := (others => GlobaleDatentypen.Leer);
      GlobaleVariablen.EinheitenGebaut := (others => (others => GlobaleKonstanten.LeerEinheit));
      GlobaleVariablen.StadtGebaut := (others => (others => GlobaleKonstanten.LeerStadt));
      GlobaleVariablen.Wichtiges := (others => GlobaleKonstanten.LeerWichtigesZeug);
      GlobaleVariablen.Diplomatie := (others => (others => GlobaleDatentypen.Leer));
      GlobaleVariablen.RundenAnzahl := 1;
      GlobaleVariablen.RasseAmZugNachLaden := GlobaleDatentypen.Leer;
      GlobaleVariablen.CursorImSpiel := (others => GlobaleKonstanten.LeerCursor);
      GlobaleVariablen.Gewonnen := False;
      Cheat.GewonnenDurchCheat := False;

      Karten.Weltkarte := (others => (others => (others => GlobaleKonstanten.LeerWeltkarte)));
      Karten.Kartengrößen := ((20, 20), (40, 40), (80, 80), (120, 80), (120, 160), (160, 160), (240, 240), (320, 320), (1_000, 1_000), (1, 1));
            
   end AllesAufAnfangSetzen;

end AllesAufAnfangSetzen;
