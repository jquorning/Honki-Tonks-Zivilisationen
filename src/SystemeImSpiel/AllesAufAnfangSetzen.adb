package body AllesAufAnfangSetzen is

   procedure AllesAufAnfangSetzen is
   begin
      
      GlobaleVariablen.EinheitenGebaut := (others => (others => (0, 0,    0, 0, 0,    0, 0.0, 0, 0,    0, 0)));
      GlobaleVariablen.StadtGebaut := (others => (others => ((0, 0, 0,    False,    0, 0, 0, 0, 0, 0, 0, 0, 0, 0,    "000000000000000000000000", To_Unbounded_Wide_Wide_String (Source => ""),    (others => (others => False))))));
      GlobaleVariablen.Wichtiges := (others => (0, 0, 0, 0, 1, "0000000000000000000000000"));
      GlobaleVariablen.Diplomatie := (others => (others => 0));
      GlobaleVariablen.RundenAnzahl := 1;

      Karten.Karten := (others => (others => (0, False, False, 0, 0, 0, 0)));
      Karten.Stadtkarte := (others => (others => (0)));
      
   end AllesAufAnfangSetzen;

end AllesAufAnfangSetzen;