with LadezeitenDatentypen;
with SystemDatentypen;

package LadezeitenLogik is
   pragma Elaborate_Body;
      
   type FortschrittSpielweltArray is array (LadezeitenDatentypen.Spielwelt_Erstellen_Enum'Range) of SystemDatentypen.NullBisHundert;
   FortschrittSpielwelt : FortschrittSpielweltArray;
   
   type FortschrittKIArray is array (LadezeitenDatentypen.KI_Rechnet_Enum'Range) of SystemDatentypen.NullBisHundert;
   FortschrittKI : FortschrittKIArray;
   
   FortschrittRundenende : SystemDatentypen.NullBisHundert;
   FortschrittSpeichernLaden : SystemDatentypen.NullBisHundert;

   procedure SpielweltNullsetzen;
   procedure KINullsetzenFortschritt;
   procedure RundenendeNullsetzen;
   procedure SpeichernLadenNullsetzen;
   procedure RundenendeSchreiben;
   procedure RundenendeMaximum;
   procedure SpeichernLadenMaximum;
   procedure FortschrittSpielweltSchreiben
     (WelcheBerechnungenExtern : in LadezeitenDatentypen.Spielwelt_Erstellen_Enum);
   
   procedure FortschrittSpielweltMaximum
     (WelcheBerechnungenExtern : in LadezeitenDatentypen.Spielwelt_Erstellen_Enum);
   
   procedure FortschrittKISchreiben
     (WelcheBerechnungenExtern : in LadezeitenDatentypen.KI_Rechnet_Enum);
   
   procedure FortschrittKIMaximum
     (WelcheBerechnungenExtern : in LadezeitenDatentypen.KI_Rechnet_Enum);
   
   procedure SpeichernLadenSchreiben
     (SpeichernLadenExtern : in Boolean);
   
private
   
   type FortschrittSchritteArray is array (1 .. 5) of SystemDatentypen.NullBisHundert;
   FortschrittSchritte : constant FortschrittSchritteArray := (
                                                               1 => 1,
                                                               2 => 1,
                                                               3 => 10,
                                                               4 => 14,
                                                               5 => 7
                                                              );

end LadezeitenLogik;
