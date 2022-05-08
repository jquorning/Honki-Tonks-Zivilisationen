pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KartenDatentypen; use KartenDatentypen;
with KartenVerbesserungDatentypen;
with KartenRecords;
with AufgabenDatentypen;

with Karten;

package VerbesserungAnlegen is

   procedure VerbesserungAnlegen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      VerbesserungExtern : in AufgabenDatentypen.Einheitenbefehle_Gebilde_Enum)
     with
       Pre =>
         (KoordinatenExtern.YAchse <= Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).YAchse
          and
            KoordinatenExtern.XAchse <= Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).XAchse);

private

   WelcheVerbesserung : KartenVerbesserungDatentypen.Karten_Verbesserung_Gebilde_Enum;

end VerbesserungAnlegen;