pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with SystemDatentypen; use SystemDatentypen;
with SystemKonstanten;

with SchreibenVerzeichnisse;
with EinlesenEinstellungen;
with Einlesen;
with InteraktionLogiktask;
with Hauptmenue;
with InteraktionGrafiktask;

package body StartLogik is

   procedure StartLogik
   is begin
      
      SchreibenVerzeichnisse.SchreibenVerzeichnisse;
      EinlesenEinstellungen.EinlesenEinstellungen;
      
      Einlesen.EinlesenOhneAnzeige;
      
      InteraktionGrafiktask.ErzeugeFensterÄndern;
      
      FensterVorhandenSchleife:
      while InteraktionLogiktask.FensterErzeugtAbrufen = False loop
         
         delay SystemKonstanten.WartezeitLogik;
         
      end loop FensterVorhandenSchleife;
      
      Einlesen.EinlesenMitAnzeige;
      
      InteraktionLogiktask.EinlesenAbgeschlossen := True;
      InteraktionGrafiktask.AktuelleDarstellungÄndern (DarstellungExtern => SystemDatentypen.Grafik_Intro_Enum);
      
      IntroSchleife:
      while InteraktionGrafiktask.AktuelleDarstellungAbrufen = SystemDatentypen.Grafik_Intro_Enum loop
         
         delay SystemKonstanten.WartezeitLogik;
         
      end loop IntroSchleife;
      
      Hauptmenue.Hauptmenü;
      
   end StartLogik;
   
end StartLogik;
