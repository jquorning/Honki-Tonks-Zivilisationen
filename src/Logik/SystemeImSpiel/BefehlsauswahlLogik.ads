with RassenDatentypen;
with RueckgabeDatentypen;

private with TastenbelegungDatentypen;
private with StadtRecords;

with LeseRassenbelegung;

package BefehlsauswahlLogik is
   pragma Elaborate_Body;
   use type RassenDatentypen.Spieler_Enum;

   function Befehlsauswahl
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return RueckgabeDatentypen.Rückgabe_Werte_Enum
     with
       Pre => (
                 LeseRassenbelegung.Belegung (RasseExtern => RasseExtern) = RassenDatentypen.Mensch_Spieler_Enum
              );
   
private
      
   Befehl : TastenbelegungDatentypen.Allgemeine_Belegung_Enum;
   
   StadtSuchenNachNamen : StadtRecords.RasseStadtnummerRecord;
   
   
   
   function Tasteneingabe
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      BefehlExtern : in TastenbelegungDatentypen.Allgemeine_Belegung_Enum)
      return RueckgabeDatentypen.Rückgabe_Werte_Enum
     with
       Pre => (
                 LeseRassenbelegung.Belegung (RasseExtern => RasseExtern) = RassenDatentypen.Mensch_Spieler_Enum
              );

end BefehlsauswahlLogik;
