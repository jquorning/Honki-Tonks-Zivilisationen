pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with MenueDatentypen;
with RueckgabeDatentypen;

private with SystemKonstanten;

package MenuerueckgabenLogik is
   
   function RückgabeMenüs
     (EndeExtern : in Positive;
      AktuelleAuswahlExtern : in Positive;
      WelchesMenüExtern : in MenueDatentypen.Menü_Ohne_Steuerung_Enum)
      return RueckgabeDatentypen.Rückgabe_Werte_Enum
     with
       Pre => (
                 AktuelleAuswahlExtern <= EndeExtern
              );
            
   function SteuerungMenü
     (AnfangExtern : in Positive;
      EndeExtern : in Positive;
      AktuelleAuswahlExtern : in Positive)
      return RueckgabeDatentypen.Rückgabe_Werte_Enum
     with
       Pre => (
                 AnfangExtern <= EndeExtern
               and
                 AktuelleAuswahlExtern <= EndeExtern
              );
   
private
   
   MitFertig : Boolean;
   
   Anfang : constant Positive := 1;
   AbzugFertig : constant Positive := 2;
   AbzugZHB : constant Positive := 4;
   Grundwert : constant Positive := RueckgabeDatentypen.Rückgabe_Werte_Enum'Pos (RueckgabeDatentypen.Auswahl_Null_Enum);
   
   Ende : Positive;
   
   type MenüendeArray is array (MenueDatentypen.Menü_Ohne_Steuerung_Enum'Range) of Positive;
   Menüende : MenüendeArray := (
                                  MenueDatentypen.Optionen_Menü_Enum           => SystemKonstanten.EndeAbzugGrafik (MenueDatentypen.Optionen_Menü_Enum) - AbzugZHB,
                                  MenueDatentypen.Grafik_Menü_Enum             => SystemKonstanten.EndeAbzugGrafik (MenueDatentypen.Grafik_Menü_Enum) - AbzugZHB,
                                  MenueDatentypen.Editoren_Menü_Enum           => SystemKonstanten.EndeAbzugGrafik (MenueDatentypen.Editoren_Menü_Enum) - AbzugZHB,
                                  MenueDatentypen.Sonstiges_Menü_Enum          => SystemKonstanten.EndeAbzugGrafik (MenueDatentypen.Sonstiges_Menü_Enum) - AbzugZHB,
                                  MenueDatentypen.Debug_Menü_Enum              => SystemKonstanten.EndeAbzugGrafik (MenueDatentypen.Debug_Menü_Enum) - AbzugFertig,
                                  MenueDatentypen.Kartenart_Menü_Enum          => SystemKonstanten.EndeAbzugGrafik (MenueDatentypen.Kartenart_Menü_Enum) - AbzugFertig,
                                  MenueDatentypen.Kartenressourcen_Menü_Enum   => SystemKonstanten.EndeAbzugGrafik (MenueDatentypen.Kartenressourcen_Menü_Enum) - AbzugFertig,
                                  MenueDatentypen.Schwierigkeitsgrad_Menü_Enum => SystemKonstanten.EndeAbzugGrafik (MenueDatentypen.Schwierigkeitsgrad_Menü_Enum) - AbzugFertig,
                                  MenueDatentypen.Kartentemperatur_Menü_Enum   => SystemKonstanten.EndeAbzugGrafik (MenueDatentypen.Kartentemperatur_Menü_Enum) - AbzugFertig,
                                  MenueDatentypen.Rassen_Menü_Enum             => SystemKonstanten.EndeAbzugGrafik (MenueDatentypen.Rassen_Menü_Enum) - AbzugFertig,
                                  MenueDatentypen.Kartenpole_Menü_Enum         => SystemKonstanten.EndeAbzugGrafik (MenueDatentypen.Kartenpole_Menü_Enum) - AbzugFertig,
                                  MenueDatentypen.Kartenform_Menü_Enum         => SystemKonstanten.EndeAbzugGrafik (MenueDatentypen.Kartenform_Menü_Enum) - AbzugFertig,
                                  MenueDatentypen.Kartengröße_Menü_Enum        => SystemKonstanten.EndeAbzugGrafik (MenueDatentypen.Kartengröße_Menü_Enum) - AbzugFertig,
                                  
                                  -- Aufgrund der Beschaffenheit dieser Menüs sind die Abzüge hier nicht dem Standard entsprechend, auch wenn die Abzüge eventuell identisch mit einem der Standards sind!
                                  MenueDatentypen.Diplomatie_Menü_Enum         => SystemKonstanten.EndeAbzugGrafik (MenueDatentypen.Diplomatie_Menü_Enum) - 3,
                                  
                                  -- Das hier sind Spezialmenüs die nicht so einfach in das aktuelle System integriert werden können.
                                  -- Oder wie beispielsweise das Soundmenü noch unvollständig sind.
                                  MenueDatentypen.Sound_Menü_Enum              => 1,
                                  MenueDatentypen.Einstellungen_Menü_Enum      => 1,
                                  MenueDatentypen.Haupt_Menü_Enum              => 1,
                                  MenueDatentypen.Spiel_Menü_Enum              => 1
                                 );

   function Hauptmenü
     (EndeExtern : in Positive;
      AktuelleAuswahlExtern : in Positive)
      return RueckgabeDatentypen.Rückgabe_Werte_Enum
     with
       Pre => (
                 AktuelleAuswahlExtern <= EndeExtern
              );

   function Spielmenü
     (EndeExtern : in Positive;
      AktuelleAuswahlExtern : in Positive)
      return RueckgabeDatentypen.Rückgabe_Werte_Enum
     with
       Pre => (
                 AktuelleAuswahlExtern <= EndeExtern
              );
   
   function SpieleinstellungenMenü
     (EndeExtern : in Positive;
      AktuelleAuswahlExtern : in Positive)
      return RueckgabeDatentypen.Rückgabe_Werte_Enum
     with
       Pre => (
                 AktuelleAuswahlExtern <= EndeExtern
              );
            
   function SoundMenü
     (EndeExtern : in Positive;
      AktuelleAuswahlExtern : in Positive)
      return RueckgabeDatentypen.Rückgabe_Werte_Enum
     with
       Pre => (
                 AktuelleAuswahlExtern <= EndeExtern
              );
      
   function Fertig
     (EndeExtern : in Positive;
      AktuelleAuswahlExtern : in Positive)
      return RueckgabeDatentypen.Rückgabe_Werte_Enum
     with
       Pre => (
                 AktuelleAuswahlExtern <= EndeExtern
              );
   
   function ZurückHauptmenüEnde
     (EndeExtern : in Positive;
      AktuelleAuswahlExtern : in Positive;
      FertigExtern : in Boolean)
      return RueckgabeDatentypen.Rückgabe_Werte_Enum
     with
       Pre => (
                 AktuelleAuswahlExtern <= EndeExtern
              );

end MenuerueckgabenLogik;