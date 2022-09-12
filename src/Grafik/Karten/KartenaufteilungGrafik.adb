pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with EinheitenKonstanten;

with StadtkarteGrafik;
with CursorplatzierungGrafik;
with CursorplatzierungAltGrafik;
with WeltkarteGrafik;
with SeitenleisteGrafik;
with StadtseitenleisteGrafik;
with StadtumgebungGrafik;
with StadtbefehleGrafik;
with WeltkartenbefehleGrafik;

package body KartenaufteilungGrafik is
   
   procedure Weltkarte
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
   is begin
      
      CursorplatzierungGrafik.Weltkarte (RasseExtern => EinheitRasseNummerExtern.Rasse);
      CursorplatzierungAltGrafik.CursorplatzierungAlt (RasseExtern => EinheitRasseNummerExtern.Rasse);
      
      -- Von außen die Arraypositionen für die Bereiche/Views hineingeben? äöü
      WeltkarteGrafik.Weltkarte (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      SeitenleisteGrafik.SeitenleisteGrafik (RasseExtern => EinheitRasseNummerExtern.Rasse);
      
      -- Für den Anfang nur eines der beiden Anzeigen, man kann das ja später ändern. äöü
      case
        EinheitRasseNummerExtern.Nummer
      is
         when EinheitenKonstanten.LeerNummer =>
            WeltkartenbefehleGrafik.Kartenbefehle;
            
         when others =>
            WeltkartenbefehleGrafik.Einheitenbefehle (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      end case;
      
   end Weltkarte;
   
   

   procedure Stadtkarte
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord)
   is begin
      
      -- Von außen die Arraypositionen für die Bereiche/Views hineingeben? äöü
      StadtkarteGrafik.Stadtkarte (StadtRasseNummerExtern => StadtRasseNummerExtern);
      StadtumgebungGrafik.Stadtumgebung (StadtRasseNummerExtern => StadtRasseNummerExtern);
      StadtbefehleGrafik.Stadtbefehle;
      StadtseitenleisteGrafik.Stadtinformationen (StadtRasseNummerExtern => StadtRasseNummerExtern);
      
   end Stadtkarte;

end KartenaufteilungGrafik;
