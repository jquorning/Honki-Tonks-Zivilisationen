pragma SPARK_Mode (On);

with GlobaleDatentypen;

with DatenbankRecords;

package RasseAspari2 is

   RasseAspari2Liste : constant DatenbankRecords.RassenListeRecord :=
     (
      Aggressivität       => 0,
      Expansion           => 0,
      Wissenschaft        => 0,
      Produktion          => 0,
      Wirtschaft          => 0,
      Bewirtschaftung     => 0,
      GültigeStaatsformen => (GlobaleDatentypen.Anarchie,
                               GlobaleDatentypen.Demokratie,
                               GlobaleDatentypen.Anarchie,
                               GlobaleDatentypen.Anarchie,
                               GlobaleDatentypen.Anarchie)
     );

end RasseAspari2;
