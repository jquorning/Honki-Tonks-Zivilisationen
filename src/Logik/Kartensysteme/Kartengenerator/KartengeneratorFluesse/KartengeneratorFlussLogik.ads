pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KartenDatentypen; use KartenDatentypen;

private with KartenRecords;
private with Weltkarte;
private with SystemDatentypen;

package KartengeneratorFlussLogik is

   procedure GenerierungFlüsse;

private
   
   -- Später vom Nutzer einstellbar machen. äöü
   -- Oder rauswerfen? äöü
   FlussumgebungBonus : Float := 1.25;
   
   type KartenzeitwertArray is array (KartenDatentypen.EbenePlanet'Range) of KartenDatentypen.KartenfeldNatural;
   Kartenzeitwert : KartenzeitwertArray;
   
   -- Später vom Nutzer einstellbar machen. äöü
   type WahrscheinlichkeitFlussArray is array (KartenDatentypen.EbenePlanet'Range) of SystemDatentypen.NullBisHundert;
   WahrscheinlichkeitFluss : constant WahrscheinlichkeitFlussArray := (
                                                                       -2 => 30,
                                                                       -1 => 30,
                                                                       0  => 30
                                                                      );
         
   type BeliebigerFlusswertArray is array (WahrscheinlichkeitFlussArray'Range) of SystemDatentypen.NullBisHundert;
   BeliebigerFlusswert : BeliebigerFlusswertArray;

   type KartenWertArray is array (WahrscheinlichkeitFlussArray'Range) of KartenRecords.AchsenKartenfeldNaturalRecord;
   KartenWert : KartenWertArray;
   
   procedure FlussGenerierung
     (EbeneExtern : in KartenDatentypen.EbenePlanet);
   
      
      
   function FlussumgebungTesten
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
      return Boolean
     with
       Pre => (
                 KoordinatenExtern.YAchse <= Weltkarte.Karteneinstellungen.Kartengröße.YAchse
               and
                 KoordinatenExtern.XAchse <= Weltkarte.Karteneinstellungen.Kartengröße.XAchse
              );

end KartengeneratorFlussLogik;
