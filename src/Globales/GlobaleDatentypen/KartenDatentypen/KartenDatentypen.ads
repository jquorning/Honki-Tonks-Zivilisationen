pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

package KartenDatentypen is
   pragma Pure;

   type Kartenfeld is range -1_000 .. 1_000;
   subtype KartenfeldNatural is Kartenfeld range 0 .. Kartenfeld'Last;
   subtype KartenfeldPositiv is KartenfeldNatural range 1 .. KartenfeldNatural'Last;
   
   subtype Stadtfeld is KartenfeldPositiv range KartenfeldPositiv'First .. 20;
   
   -- Das heir kann vermutlich auch mal umgebaut/ersetzt/entfernt werden. äöü
   subtype SichtweiteNatural is KartenfeldNatural range KartenfeldNatural'First .. 10;
   -- Dafür auch mal einen subtype für die Einheitensichtweite einbauen? äöü
   subtype Sichtweite is SichtweiteNatural range 1 .. SichtweiteNatural'Last;
   
   -- Noch Umgebungsbereich von 0 .. X einbauen? äöü
   subtype UmgebungsbereichDrei is Kartenfeld range -3 .. 3;
   subtype UmgebungsbereichZwei is UmgebungsbereichDrei range -2 .. 2;
   subtype UmgebungsbereichEins is UmgebungsbereichZwei range -1 .. 1;
   
   
   
   -- Rückgabewert, Planeteninneres, Unterirdisch/Unterwasser, Oberfläche, Himmel, Weltraum/Orbit
   type Ebene is new UmgebungsbereichDrei range -3 .. 2;
   subtype EbeneVorhanden is Ebene range -2 .. 2;
   subtype EbenePlanet is EbeneVorhanden range -2 .. 0;
   subtype EbeneLuft is EbeneVorhanden range 1 .. 2;
   subtype EbenenbereichEins is EbeneVorhanden range EbeneVorhanden (UmgebungsbereichEins'First) .. EbeneVorhanden (UmgebungsbereichEins'Last);

end KartenDatentypen;
