with GlobaleDatentypen, GlobaleRecords;
use GlobaleDatentypen;

package KarteStadt is
   
   procedure AnzeigeStadt (StadtNummer : in Positive; RasseExtern : in GlobaleDatentypen.Rassen);
   procedure Beschreibung (RasseExtern : in GlobaleDatentypen.Rassen);

private
   
   Stadtumgebungsgröße : GlobaleDatentypen.Kartenfeld := 1;
   Überhang : GlobaleDatentypen.Kartenfeld := 0;
   YAchsenabstraktion : GlobaleDatentypen.Kartenfeld;
   CursorKonstant : constant GlobaleDatentypen.Kartenfeld := 3;
   Cursor : GlobaleDatentypen.Kartenfeld;
   CursorYAchsePlus : GlobaleDatentypen.Kartenfeld;
   CursorXAchsePlus : GlobaleDatentypen.Kartenfeld;
   Nahrungsgewinnung : GlobaleDatentypen.GrundwerteNRGWVA;
   Ressourcengewinnung : GlobaleDatentypen.GrundwerteNRGWVA;
   Geldgewinnung : GlobaleDatentypen.GrundwerteNRGWVA;
   Wissensgewinnung : GlobaleDatentypen.GrundwerteNRGWVA;
   YAchse : GlobaleDatentypen.Kartenfeld;
   XAchse : GlobaleDatentypen.Kartenfeld;

   Wert : Integer;

   KartenWert : GlobaleRecords.AchsenAusKartenfeldRecord;
   
   RasseUndPlatznummer : GlobaleRecords.RasseUndPlatznummerRecord;
   
   procedure FarbenStadt;
   procedure InformationenStadt (YAufschlag, XAufschlag : in GlobaleDatentypen.Kartenfeld; RasseExtern : in GlobaleDatentypen.Rassen);

end KarteStadt;
