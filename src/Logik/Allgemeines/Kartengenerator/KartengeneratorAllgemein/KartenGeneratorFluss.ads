pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KartenDatentypen; use KartenDatentypen;
with KartenGrundDatentypen;
with KartenRecords;

with Karten;

package KartenGeneratorFluss is

   procedure AufteilungFlussgenerierung;

private
   
   type WahscheinlichkeitFlussArray is array (KartenDatentypen.Kartentemperatur_Enum'Range) of Float;
   WahrscheinlichkeitFluss : constant WahscheinlichkeitFlussArray := (
                                                                      KartenDatentypen.Kartentemperatur_Kalt_Enum     => 0.25,
                                                                      KartenDatentypen.Kartentemperatur_Gemäßigt_Enum => 0.30,
                                                                      KartenDatentypen.Kartentemperatur_Heiß_Enum     => 0.25,
                                                                      KartenDatentypen.Kartentemperatur_Eiszeit_Enum  => 0.15,
                                                                      KartenDatentypen.Kartentemperatur_Wüste_Enum    => 0.15
                                                                     );
   
   type StandardFlussArray is array (KartenDatentypen.EbeneVorhanden'First .. 0) of KartenGrundDatentypen.Karten_Fluss_Enum;
   StandardFluss : constant StandardFlussArray := (
                                                   -2 => KartenGrundDatentypen.Lavasee_Enum,
                                                   -1 => KartenGrundDatentypen.Unterirdischer_See_Enum,
                                                   0  => KartenGrundDatentypen.See_Enum
                                                  );
   
   type WelcherFlusstypArray is array (StandardFlussArray'Range) of Natural;
   WelcherFlusstyp : constant WelcherFlusstypArray := (
                                                       -2 => KartenGrundDatentypen.Karten_Fluss_Enum'Pos (KartenGrundDatentypen.Lavaflusskreuzung_Vier_Enum)
                                                       - KartenGrundDatentypen.Karten_Fluss_Enum'Pos (KartenGrundDatentypen.Flusskreuzung_Vier_Enum),
                                                       
                                                       -1 => KartenGrundDatentypen.Karten_Fluss_Enum'Pos (KartenGrundDatentypen.Unterirdische_Flusskreuzung_Vier_Enum)
                                                       - KartenGrundDatentypen.Karten_Fluss_Enum'Pos (KartenGrundDatentypen.Flusskreuzung_Vier_Enum),
                                                       
                                                       0 => 0
                                                      );
   Flusswert : WelcherFlusstypArray;
   
   type BeliebigerFlusswertArray is array (StandardFlussArray'Range) of Float;
   BeliebigerFlusswert : BeliebigerFlusswertArray;

   type KartenWertArray is array (StandardFlussArray'Range) of KartenRecords.AchsenKartenfeldPositivRecord;
   KartenWert : KartenWertArray;
   KartenWertTesten : KartenWertArray;
   
   procedure GenerierungFlüsse;
   
   procedure FlussGenerierung
     (EbeneExtern : in KartenDatentypen.EbeneVorhanden);
   
   procedure FlussUmgebungTesten
     (YKoordinateExtern : in KartenDatentypen.KartenfeldPositiv;
      XKoordinateExtern : in KartenDatentypen.KartenfeldPositiv;
      EbeneExtern : in KartenDatentypen.EbeneVorhanden)
     with
       Pre =>
         (YKoordinateExtern <= Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).YAchse
          and
            XKoordinateExtern <= Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).XAchse);
   
   procedure FlussBerechnung
     (YKoordinateExtern : in KartenDatentypen.KartenfeldPositiv;
      XKoordinateExtern : in KartenDatentypen.KartenfeldPositiv;
      EbeneExtern : in KartenDatentypen.EbeneVorhanden)
     with
       Pre =>
         (YKoordinateExtern <= Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).YAchse
          and
            XKoordinateExtern <= Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).XAchse);
   
   procedure BerechnungLinks
     (EbeneExtern : in KartenDatentypen.EbeneVorhanden);
   
   procedure BerechnungRechts
     (EbeneExtern : in KartenDatentypen.EbeneVorhanden);
   
   procedure BerechnungOben
     (EbeneExtern : in KartenDatentypen.EbeneVorhanden);
   
   procedure BerechnungUnten
     (EbeneExtern : in KartenDatentypen.EbeneVorhanden);
   
   procedure FlussPlatzieren
     (YKoordinateExtern : in KartenDatentypen.KartenfeldPositiv;
      XKoordinateExtern : in KartenDatentypen.KartenfeldPositiv;
      EbeneExtern : in KartenDatentypen.EbeneVorhanden);

end KartenGeneratorFluss;
