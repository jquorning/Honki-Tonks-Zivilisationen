pragma SPARK_Mode (On);

with Sf.System.Vector2;

with GlobaleTexte;

package TextAnzeigeSFML is

   procedure AnzeigeMitAuswahl
     (FrageDateiExtern : in GlobaleTexte.Welche_Datei_Enum;
      TextDateiExtern : in GlobaleTexte.Welche_Datei_Enum;
      FrageZeileExtern : in Natural;
      ErsteZeileExtern : in Natural;
      LetzteZeileExtern : in Natural;
      AktuelleAuswahlExtern : in Positive;
      MaximaleAnzahlZeichenExtern : in Natural);
   
   procedure AnzeigeOhneAuswahl
     (ÜberschriftDateiExtern : in GlobaleTexte.Welche_Datei_Enum;
      TextDateiExtern : in GlobaleTexte.Welche_Datei_Enum;
      ÜberschriftZeileExtern : in Natural;
      ErsteZeileExtern : in Positive;
      LetzteZeileExtern : in Positive;
      AbstandAnfangExtern : in GlobaleTexte.Welcher_Abstand_Enum;
      AbstandMitteExtern : in GlobaleTexte.Welcher_Abstand_Enum;
      AbstandEndeExtern : in GlobaleTexte.Welcher_Abstand_Enum);
   
private
   
   RahmenGezeichnet : Boolean;
   
   ÜberschriftAbstand : Natural;
   AktuelleZeile : Natural;
   
   Zeilenabstand : constant Float := 8.00;
   Rahmenabstand : constant Float := 5.00;
   Rahmendicke : constant Float := 3.00;
   Rahmenlänge : Float;
   Rahmenbreite : Float;
   Position : Float;
   
   AktuellePosition : Sf.System.Vector2.sfVector2f;
   StartAnzeigePosition : constant Sf.System.Vector2.sfVector2f := (x => 20.00,
                                                                    y => 20.00);
   
   procedure AnzeigeSelbst
     (TextDateiExtern : in GlobaleTexte.Welche_Datei_Enum;
      AktuelleAuswahlExtern : in Positive;
      MaximaleAnzahlZeichenExtern : in Natural;
      AktuelleZeileExtern : in Natural);

end TextAnzeigeSFML;
