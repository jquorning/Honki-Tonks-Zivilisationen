pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with SystemDatentypen;
with GrafikDatentypen;
with MenueDatentypen;

package InteraktionGrafiktask is
   
   TastenEingabe : Boolean := False;
   TextEingabe : Boolean := False;
   FensterGeschlossen : Boolean := False;
   AccesseSetzen : Boolean := False;
   
   JaNeinFrage : Natural := 0;
   
   AktuellesMenü : MenueDatentypen.Welches_Menü_Enum := MenueDatentypen.Leer_Menü_Enum;
      
   type Fenster_Ändern_Enum is (
                                 Keine_Änderung_Enum,
                                 
                                 Bildrate_Ändern_Enum, Fenster_Verändert_Enum, Auflösung_Verändert_Enum, Modus_Verändert_Enum
                                );
   
   subtype Fenster_Wurde_Verändert_Enum is Fenster_Ändern_Enum range Fenster_Verändert_Enum .. Modus_Verändert_Enum;
   subtype Fenster_Unverändert_Enum is Fenster_Ändern_Enum range Keine_Änderung_Enum .. Bildrate_Ändern_Enum;
   
   FensterVerändert : Fenster_Ändern_Enum;
    
   procedure ErzeugeFensterÄndern;
   
   procedure EingabeÄndern
     (EingabeExtern : in SystemDatentypen.Welche_Eingabe_Enum);
   
   procedure AktuelleDarstellungÄndern
     (DarstellungExtern : in GrafikDatentypen.Grafik_Aktuelle_Darstellung_Enum);
   
   
   
   function ErzeugeFensterAbrufen
     return Boolean;
   
   function EingabeAbrufen
     return SystemDatentypen.Welche_Eingabe_Enum;
   
   function AktuelleDarstellungAbrufen
     return GrafikDatentypen.Grafik_Aktuelle_Darstellung_Enum;
   
private

   ErzeugeFenster : Boolean := False;
   
   Eingabe : SystemDatentypen.Welche_Eingabe_Enum := SystemDatentypen.Keine_Eingabe_Enum;
   
   AktuelleDarstellung : GrafikDatentypen.Grafik_Aktuelle_Darstellung_Enum := GrafikDatentypen.Grafik_SFML_Enum;

end InteraktionGrafiktask;
