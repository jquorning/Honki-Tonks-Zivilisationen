private with Sf.System.Vector2;

with RassenDatentypen;
with StadtRecords;
with StadtKonstanten;

private with StadtDatentypen;
private with KartenDatentypen;
private with KartenRecords;

with LeseGrenzen;
with LeseRassenbelegung;

package StadtkarteGrafik is
   pragma Elaborate_Body;
   use type RassenDatentypen.Spieler_Enum;

   procedure Stadtkarte
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord)
     with
       Pre => (
                 StadtRasseNummerExtern.Nummer in StadtKonstanten.AnfangNummer .. LeseGrenzen.Städtegrenzen (RasseExtern => StadtRasseNummerExtern.Rasse)
               and
                 LeseRassenbelegung.Belegung (RasseExtern => StadtRasseNummerExtern.Rasse) = RassenDatentypen.Mensch_Spieler_Enum
              );

private

   ZusatzgrundDarstellen : Boolean := True;

   GebäudeID : StadtDatentypen.GebäudeID;

   YMultiplikator : Float;
   XMultiplikator : Float;

   Gesamtgrund : KartenRecords.KartengrundRecord;

   Grafikposition : Sf.System.Vector2.sfVector2f;

   procedure GrafischeDarstellung
     (GrundExtern : in KartenRecords.KartengrundRecord;
      PositionExtern : in Sf.System.Vector2.sfVector2f)
     with
       Pre => (
                 PositionExtern.x >= 0.00
               and
                 PositionExtern.y >= 0.00
              );

   procedure DarstellungGebäude
     (YAchseExtern : in KartenDatentypen.Stadtfeld;
      XAchseExtern : in KartenDatentypen.Stadtfeld;
      PositionExtern : in Sf.System.Vector2.sfVector2f;
      StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord)
     with
       Pre => (
                 StadtRasseNummerExtern.Nummer in StadtKonstanten.AnfangNummer .. LeseGrenzen.Städtegrenzen (RasseExtern => StadtRasseNummerExtern.Rasse)
               and
                 LeseRassenbelegung.Belegung (RasseExtern => StadtRasseNummerExtern.Rasse) = RassenDatentypen.Mensch_Spieler_Enum
               and
                 PositionExtern.x >= 0.00
               and
                 PositionExtern.y >= 0.00
              );

end StadtkarteGrafik;
