with RassenDatentypen;

private with EinheitenDatentypen;
private with StadtDatentypen;

with LeseRassenbelegung;

package KILogik is
   pragma Elaborate_Body;
   use type RassenDatentypen.Spieler_Enum;

   procedure KI
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
     with
       Pre => (
                 LeseRassenbelegung.Belegung (RasseExtern => RasseExtern) = RassenDatentypen.KI_Spieler_Enum
              );

private

   Städtezeitwert : StadtDatentypen.MaximaleStädteMitNullWert;

   Einheitenzeitwert : EinheitenDatentypen.MaximaleEinheitenMitNullWert;

   procedure EinheitenDurchgehen
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
     with
       Pre => (
                 LeseRassenbelegung.Belegung (RasseExtern => RasseExtern) = RassenDatentypen.KI_Spieler_Enum
              );

   procedure StädteDurchgehen
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
     with
       Pre => (
                 LeseRassenbelegung.Belegung (RasseExtern => RasseExtern) = RassenDatentypen.KI_Spieler_Enum
              );

end KILogik;
