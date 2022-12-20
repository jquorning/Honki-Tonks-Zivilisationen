with RassenDatentypen;
with SpielRecords;

package SchreibeRassenbelegung is
   pragma Elaborate_Body;

   procedure Belegung
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      BelegungExtern : in RassenDatentypen.Spieler_Enum);
   
   procedure Besiegt
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum);
   
   procedure Standardeinstellungen;
   
   procedure GanzerEintrag
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      EintragExtern : in SpielRecords.RassenRecords);
   
   procedure GanzesArray
     (ArrayExtern : in SpielRecords.RassenbelegungArray);

end SchreibeRassenbelegung;
