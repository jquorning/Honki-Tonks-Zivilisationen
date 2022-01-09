pragma SPARK_Mode (On);

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
      
      InteraktionGrafiktask.AktuelleDarstellungÄndern (DarstellungExtern => SystemDatentypen.Grafik_Intro);
      
      IntroSchleife:
      while InteraktionGrafiktask.AktuelleDarstellungAbrufen = SystemDatentypen.Grafik_Intro loop
         
         delay SystemKonstanten.WartezeitLogik;
         
      end loop IntroSchleife;
      
      Hauptmenue.Hauptmenü;
      
   end StartLogik;

end StartLogik;
