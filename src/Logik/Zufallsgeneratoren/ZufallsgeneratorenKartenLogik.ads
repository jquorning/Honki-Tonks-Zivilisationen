private with Ada.Numerics.Discrete_Random;

with KartenDatentypen;
with SystemDatentypen;

package ZufallsgeneratorenKartenLogik is
   pragma Elaborate_Body;

   function KartengeneratorZufallswerte
     return SystemDatentypen.NullBisHundert;

   function KartengeneratorBoolean
     return Boolean;

   function KartengeneratorLandgrößen
     (YAchseXAchseExtern : in Boolean)
      return KartenDatentypen.KartenfeldPositiv;

private

   MinimalerWert : KartenDatentypen.KartenfeldPositiv;
   MaximalerWert : KartenDatentypen.KartenfeldPositiv;
   Zwischenspeicher : KartenDatentypen.KartenfeldPositiv;

   package ZufälligeZahl is new Ada.Numerics.Discrete_Random (Result_Subtype => SystemDatentypen.NullBisHundert);
   package ZufälligerBoolean is new Ada.Numerics.Discrete_Random (Result_Subtype => Boolean);
   package ZufälligeLandgrößen is new Ada.Numerics.Discrete_Random (Result_Subtype => KartenDatentypen.KartenfeldPositiv);

   ZufälligeZahlGewählt : ZufälligeZahl.Generator;
   ZufälligerBooleanGewählt : ZufälligerBoolean.Generator;
   ZufälligeLandgrößeGewählt : ZufälligeLandgrößen.Generator;

end ZufallsgeneratorenKartenLogik;
