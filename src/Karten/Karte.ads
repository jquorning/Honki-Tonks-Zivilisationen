with Ada.Wide_Wide_Text_IO, Ada.Float_Text_IO, Ada.Strings.Wide_Wide_Unbounded, Ada.Characters.Wide_Wide_Latin_9;
use Ada.Wide_Wide_Text_IO, Ada.Strings.Wide_Wide_Unbounded, Ada.Characters.Wide_Wide_Latin_9;

with GlobaleDatentypen, KarteStadt, KartenDatenbank, Karten, GlobaleVariablen, EinheitenDatenbank, VerbesserungenDatenbank, ForschungsDatenbank, Sichtbarkeit, SchleifenPruefungen;
use GlobaleDatentypen;

package Karte is

   procedure AnzeigeKarte (RasseExtern : in Positive)
     with Pre => RasseExtern in GlobaleDatentypen.RassenImSpielArray'Range;

private

   StehtDrauf : Boolean;

   -- MöglicheAngriffsfelder : constant Wide_Wide_Character := '■'; -- Später für Fernkampfeinheiten wieder einbauen?
   Verteidigungsbonus : GlobaleDatentypen.GrundwerteNRGWVA;
   Nahrungsgewinnung : GlobaleDatentypen.GrundwerteNRGWVA;
   Ressourcengewinnung : GlobaleDatentypen.GrundwerteNRGWVA;
   Geldgewinnung : GlobaleDatentypen.GrundwerteNRGWVA;
   Wissensgewinnung : GlobaleDatentypen.GrundwerteNRGWVA;
   SichtweiteFestlegen : Integer;
   BewegungsfeldFestlegen : Integer;

   Kartenwert : GlobaleDatentypen.AchsenAusKartenfeld;

   RasseUndPlatznummer : GlobaleDatentypen.RasseUndPlatznummerRecord;

   type SichtweiteArray is array (1 .. 3) of GlobaleDatentypen.AchsenAusKartenfeldPositiv;

   Sichtweite : constant SichtweiteArray := (1 => (0, 6, 10),
                                             2 => (0, 6, 22),
                                             3 => (0, 6, 35));

   Bewegungsfeld : constant SichtweiteArray := (1 => (0, 5, 9),
                                                2 => (0, 5, 21),
                                                3 => (0, 5, 34));

   procedure Information (RasseExtern : in Positive)
     with Pre => RasseExtern in GlobaleDatentypen.RassenImSpielArray'Range;

end Karte;
