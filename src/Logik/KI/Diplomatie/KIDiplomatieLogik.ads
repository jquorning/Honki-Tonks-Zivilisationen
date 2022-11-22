with RassenDatentypen;

with LeseRassenbelegung;

package KIDiplomatieLogik is
   pragma Elaborate_Body;
   use type RassenDatentypen.Spieler_Enum;

   procedure Diplomatie
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
     with
       Pre => (
                 LeseRassenbelegung.Belegung (RasseExtern => RasseExtern) = RassenDatentypen.KI_Spieler_Enum
              );

   procedure DiplomatieKIMensch
     (RasseMenschExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      RasseKIExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
     with
       Pre => (
                 LeseRassenbelegung.Belegung (RasseExtern => RasseMenschExtern) = RassenDatentypen.Mensch_Spieler_Enum
               and
                 LeseRassenbelegung.Belegung (RasseExtern => RasseKIExtern) = RassenDatentypen.KI_Spieler_Enum
              );

   procedure DiplomatieKIKI
     (EigeneRasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      FremdeRasseKIExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
     with
       Pre => (
                 LeseRassenbelegung.Belegung (RasseExtern => EigeneRasseExtern) = RassenDatentypen.KI_Spieler_Enum
               and
                 LeseRassenbelegung.Belegung (RasseExtern => FremdeRasseKIExtern) = RassenDatentypen.KI_Spieler_Enum
              );

end KIDiplomatieLogik;
