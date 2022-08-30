pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

private with Sf.System.Vector2;

with RassenDatentypen; use RassenDatentypen;
with GrafikDatentypen;
with SpielVariablen;

private with LadezeitenDatentypen;
private with GrafikRecordKonstanten;

private with UmwandlungenAdaNachEigenes;

package LadezeitenSFML is
   
   procedure LadezeitenSFML
     (WelcheLadeanzeigeExtern : in GrafikDatentypen.Ladezeiten_Enum;
      RasseExtern : in RassenDatentypen.Rassen_Enum)
     with
       Pre => (
               if RasseExtern /= RassenDatentypen.Keine_Rasse_Enum then SpielVariablen.RassenImSpiel (RasseExtern) /= RassenDatentypen.Leer_Spieler_Enum
              );

private
   
   WelcheZeit : Positive;
   Überschrift : Positive;
   
   Textbreite : Float;
   
   Text : Unbounded_Wide_Wide_String;
         
   Viewfläche : Sf.System.Vector2.sfVector2f := GrafikRecordKonstanten.StartgrößeView;
   Textposition : Sf.System.Vector2.sfVector2f;
   
   
   
   function SpielweltErstellen
     (ViewflächeExtern : in Sf.System.Vector2.sfVector2f)
      return Sf.System.Vector2.sfVector2f
     with
       Pre => (
                 ViewflächeExtern.x >= 0.00
               and
                 ViewflächeExtern.y >= 0.00
              ),
         
       Post => (
                  SpielweltErstellen'Result.x >= 0.00
                and
                  SpielweltErstellen'Result.y >= 0.00
               );
   
   function Rundenende
     (ViewflächeExtern : in Sf.System.Vector2.sfVector2f)
      return Sf.System.Vector2.sfVector2f
     with
         Pre => (
                   ViewflächeExtern.x >= 0.00
                 and
                   ViewflächeExtern.y >= 0.00
                ),
           
         Post => (
                    Rundenende'Result.x >= 0.00
                  and
                    Rundenende'Result.y >= 0.00
                 );
   
   function SpeichernLaden
     (ViewflächeExtern : in Sf.System.Vector2.sfVector2f)
      return Sf.System.Vector2.sfVector2f
     with
         Pre => (
                   ViewflächeExtern.x >= 0.00
                 and
                   ViewflächeExtern.y >= 0.00
                ),
           
         Post => (
                    SpeichernLaden'Result.x >= 0.00
                  and
                    SpeichernLaden'Result.y >= 0.00
                 );
   
   function KIRechnet
     (ViewflächeExtern : in Sf.System.Vector2.sfVector2f)
      return Sf.System.Vector2.sfVector2f
     with
         Pre => (
                   ViewflächeExtern.x >= 0.00
                 and
                   ViewflächeExtern.y >= 0.00
                ),
           
         Post => (
                    KIRechnet'Result.x >= 0.00
                  and
                    KIRechnet'Result.y >= 0.00
                 );
   
   function ZahlAlsStringLadefortschritt is new UmwandlungenAdaNachEigenes.ZahlAlsStringLeerzeichenEntfernen (GanzeZahl => LadezeitenDatentypen.Ladefortschritt);

end LadezeitenSFML;
