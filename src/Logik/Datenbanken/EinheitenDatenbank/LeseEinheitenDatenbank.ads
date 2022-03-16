pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with SystemDatentypen; use SystemDatentypen;
with GlobaleVariablen;
with EinheitStadtDatentypen;

with DatenbankRecords;

package LeseEinheitenDatenbank is

   function EinheitArt
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum;
      IDExtern : in EinheitStadtDatentypen.EinheitenID)
      return EinheitStadtDatentypen.Einheit_Art_Enum
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) /= SystemDatentypen.Leer_Spieler_Enum);
   
   function PreisGeld
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum;
      IDExtern : in EinheitStadtDatentypen.EinheitenID)
      return EinheitStadtDatentypen.KostenLager
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) /= SystemDatentypen.Leer_Spieler_Enum);
   
   function PreisRessourcen
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum;
      IDExtern : in EinheitStadtDatentypen.EinheitenID)
      return EinheitStadtDatentypen.KostenLager
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) /= SystemDatentypen.Leer_Spieler_Enum);
   
   function PermanenteKosten
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum;
      IDExtern : in EinheitStadtDatentypen.EinheitenID;
      WelcheKostenExtern : in EinheitStadtDatentypen.Permanente_Kosten_Verwendet_Enum)
      return EinheitStadtDatentypen.GesamtePermanenteKosten
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) /= SystemDatentypen.Leer_Spieler_Enum);
   
   function Anforderungen
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum;
      IDExtern : in EinheitStadtDatentypen.EinheitenID)
      return EinheitStadtDatentypen.ForschungIDNichtMöglich
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) /= SystemDatentypen.Leer_Spieler_Enum);

   function Passierbarkeit
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum;
      IDExtern : in EinheitStadtDatentypen.EinheitenID;
      WelcheUmgebungExtern : in EinheitStadtDatentypen.Passierbarkeit_Vorhanden_Enum)
      return Boolean
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) /= SystemDatentypen.Leer_Spieler_Enum);
      
   function MaximaleLebenspunkte
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum;
      IDExtern : in EinheitStadtDatentypen.EinheitenID)
      return EinheitStadtDatentypen.LebenspunkteVorhanden
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) /= SystemDatentypen.Leer_Spieler_Enum);
   
   function MaximaleBewegungspunkte
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum;
      IDExtern : in EinheitStadtDatentypen.EinheitenID)
      return EinheitStadtDatentypen.VorhandeneBewegungspunkte
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) /= SystemDatentypen.Leer_Spieler_Enum);
   
   function WirdVerbessertZu
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum;
      IDExtern : in EinheitStadtDatentypen.EinheitenID)
      return EinheitStadtDatentypen.EinheitenIDMitNullWert
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) /= SystemDatentypen.Leer_Spieler_Enum);

   function Beförderungsgrenze
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum;
      IDExtern : in EinheitStadtDatentypen.EinheitenID)
      return EinheitStadtDatentypen.Kampfwerte
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) /= SystemDatentypen.Leer_Spieler_Enum);
   
   function MaximalerRang
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum;
      IDExtern : in EinheitStadtDatentypen.EinheitenID)
      return EinheitStadtDatentypen.Kampfwerte
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) /= SystemDatentypen.Leer_Spieler_Enum);
   
   function Reichweite
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum;
      IDExtern : in EinheitStadtDatentypen.EinheitenID)
      return EinheitStadtDatentypen.Kampfwerte
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) /= SystemDatentypen.Leer_Spieler_Enum);
   
   function Angriff
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum;
      IDExtern : in EinheitStadtDatentypen.EinheitenID)
      return EinheitStadtDatentypen.Kampfwerte
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) /= SystemDatentypen.Leer_Spieler_Enum);
   
   function Verteidigung
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum;
      IDExtern : in EinheitStadtDatentypen.EinheitenID)
      return EinheitStadtDatentypen.Kampfwerte
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) /= SystemDatentypen.Leer_Spieler_Enum);

   function KannTransportieren
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum;
      IDExtern : in EinheitStadtDatentypen.EinheitenID)
      return EinheitStadtDatentypen.Transportwerte
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) /= SystemDatentypen.Leer_Spieler_Enum);
   
   function KannTransportiertWerden
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum;
      IDExtern : in EinheitStadtDatentypen.EinheitenID)
      return EinheitStadtDatentypen.Transportwerte
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) /= SystemDatentypen.Leer_Spieler_Enum);
   
   function Transportkapazität
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum;
      IDExtern : in EinheitStadtDatentypen.EinheitenID)
      return EinheitStadtDatentypen.Transportwerte
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) /= SystemDatentypen.Leer_Spieler_Enum);
   
   function GanzerEintrag
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum;
      IDExtern : in EinheitStadtDatentypen.EinheitenID)
      return DatenbankRecords.EinheitenListeRecord
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) /= SystemDatentypen.Leer_Spieler_Enum);

end LeseEinheitenDatenbank;
