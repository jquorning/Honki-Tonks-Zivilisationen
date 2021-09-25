pragma SPARK_Mode (On);

with GlobaleDatentypen, GlobaleVariablen, SystemKonstanten;
use GlobaleDatentypen;

package ImSpiel is

   function ImSpiel
     return Integer
     with
       Post =>
         (ImSpiel'Result in -1 .. 0);

private

   RassenSchleifeVerlassenKonstante : constant Integer := -300;

   AktuellerBefehlSpieler : Integer;
   RückgabeWert : Integer;
   RückgabeOptionen : Integer;
   RückgabeRassen : Integer;

   procedure KISpieler
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) = GlobaleDatentypen.Spieler_KI);



   function RasseImSpiel
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
      return Integer;

   function RasseDurchgehen
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
      return Integer;

   function MenschlicherSpieler
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
      return Integer
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) = GlobaleDatentypen.Spieler_Mensch),
         Post =>
           (MenschlicherSpieler'Result in SystemKonstanten.RundeBeendenKonstante .. 5);

   function MenschAmZug
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
      return Integer;

   function NochSpielerVorhanden
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
      return Boolean;

end ImSpiel;
