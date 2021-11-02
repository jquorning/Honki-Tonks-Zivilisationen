pragma SPARK_Mode (On);

with SonstigeDatentypen; use SonstigeDatentypen;
with SystemDatentypen; use SystemDatentypen;
with GlobaleVariablen;
with EinheitStadtDatentypen;

package DiplomatischerZustand is

   type SympathieGrenzenArray is array (SonstigeDatentypen.Status_Untereinander_Bekannt_Enum'Range) of EinheitStadtDatentypen.ProduktionFeld;
   SympathieGrenzen : constant SympathieGrenzenArray := (
                                                         SonstigeDatentypen.Neutral           => 50,
                                                         SonstigeDatentypen.Nichtangriffspakt => EinheitStadtDatentypen.ProduktionFeld'Last,
                                                         SonstigeDatentypen.Krieg             => 0
                                                        );

   procedure DiplomatischenStatusÄndern
     (RasseEinsExtern : in SystemDatentypen.Rassen_Verwendet_Enum;
      RasseZweiExtern : in SystemDatentypen.Rassen_Verwendet_Enum;
      NeuerStatusExtern : in SonstigeDatentypen.Status_Untereinander_Enum)
     with
       Pre =>
         (RasseEinsExtern /= RasseZweiExtern
          and
            GlobaleVariablen.RassenImSpiel (RasseEinsExtern) /= SonstigeDatentypen.Leer
          and
            GlobaleVariablen.RassenImSpiel (RasseZweiExtern) /= SonstigeDatentypen.Leer);

   procedure SympathieÄndern
     (EigeneRasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum;
      FremdeRasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum;
      ÄnderungExtern : in EinheitStadtDatentypen.ProduktionFeld)
     with
       Pre =>
         (EigeneRasseExtern /= FremdeRasseExtern
          and
            GlobaleVariablen.RassenImSpiel (EigeneRasseExtern) /= SonstigeDatentypen.Leer
          and
            GlobaleVariablen.RassenImSpiel (FremdeRasseExtern) /= SonstigeDatentypen.Leer);

   procedure VergangeneZeitÄndern
     (RasseEinsExtern : in SystemDatentypen.Rassen_Verwendet_Enum;
      RasseZweiExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
     with
       Pre =>
         (RasseEinsExtern /= RasseZweiExtern
          and
            GlobaleVariablen.RassenImSpiel (RasseEinsExtern) /= SonstigeDatentypen.Leer
          and
            GlobaleVariablen.RassenImSpiel (RasseZweiExtern) /= SonstigeDatentypen.Leer);



   function GegnerAngreifen
     (EigeneRasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum;
      GegnerischeRasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
      return Boolean
     with
       Pre =>
         (EigeneRasseExtern /= GegnerischeRasseExtern
          and
            GlobaleVariablen.RassenImSpiel (EigeneRasseExtern) /= SonstigeDatentypen.Leer
          and
            GlobaleVariablen.RassenImSpiel (GegnerischeRasseExtern) /= SonstigeDatentypen.Leer);

   function DiplomatischenStatusPrüfen
     (EigeneRasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum;
      FremdeRasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
      return SonstigeDatentypen.Status_Untereinander_Enum
     with
       Pre =>
         (EigeneRasseExtern /= FremdeRasseExtern
          and
            GlobaleVariablen.RassenImSpiel (EigeneRasseExtern) /= SonstigeDatentypen.Leer
          and
            GlobaleVariablen.RassenImSpiel (FremdeRasseExtern) /= SonstigeDatentypen.Leer);

   function DiplomatischerStatusLetzteÄnderung
     (EigeneRasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum;
      FremdeRasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
      return Natural
     with
       Pre =>
         (EigeneRasseExtern /= FremdeRasseExtern
          and
            GlobaleVariablen.RassenImSpiel (EigeneRasseExtern) /= SonstigeDatentypen.Leer
          and
            GlobaleVariablen.RassenImSpiel (FremdeRasseExtern) /= SonstigeDatentypen.Leer);

   function AktuelleSympathie
     (EigeneRasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum;
      FremdeRasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
      return EinheitStadtDatentypen.ProduktionFeld
     with
       Pre =>
         (EigeneRasseExtern /= FremdeRasseExtern
          and
            GlobaleVariablen.RassenImSpiel (EigeneRasseExtern) /= SonstigeDatentypen.Leer
          and
            GlobaleVariablen.RassenImSpiel (FremdeRasseExtern) /= SonstigeDatentypen.Leer);

end DiplomatischerZustand;
