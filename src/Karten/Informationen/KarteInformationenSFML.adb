pragma SPARK_Mode (On);

with Sf.Graphics.Color;

-- with GlobaleTexte;
with StadtKonstanten;
with EinheitenKonstanten;

with GrafikEinstellungen;
with StadtSuchen;
with EinheitSuchen;

package body KarteInformationenSFML is

   procedure KarteInformationenSFML
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      Sf.Graphics.Text.setFont (text => TextAccess,
                                font => GrafikEinstellungen.Schriftart);
      Sf.Graphics.Text.setColor (text  => TextAccess,
                                 color => Sf.Graphics.Color.sfBlack);
      Sf.Graphics.Text.setCharacterSize (text => TextAccess,
                                         size => GrafikEinstellungen.FensterEinstellungen.Schriftgröße);
      
      case
        RasseExtern
      is
         when SystemDatentypen.Menschen =>
            null;
            
         when others =>
            null;
      end case;
      
      FensterInformationen := (Float (GrafikEinstellungen.AktuelleFensterEinstellungen.AktuelleFensterBreite), Float (GrafikEinstellungen.AktuelleFensterEinstellungen.AktuelleFensterHöhe) * 0.20);
      
      StadtInformationen (RasseExtern => RasseExtern);
      EinheitInformationen (RasseExtern => RasseExtern);
      CheatInformationen;
      
   end KarteInformationenSFML;
   
   
   
   procedure StadtInformationen
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      StadtRasseNummer := StadtSuchen.KoordinatenStadtOhneRasseSuchen (KoordinatenExtern => GlobaleVariablen.CursorImSpiel (RasseExtern).Position);
      
      case
        StadtRasseNummer.Platznummer
      is
         when StadtKonstanten.LeerNummer =>
            return;
            
         when others =>
            null;
      end case;
      
   end StadtInformationen;
   
   
   
   procedure EinheitInformationen
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      EinheitRasseNummer := EinheitSuchen.KoordinatenEinheitOhneRasseSuchen (KoordinatenExtern => GlobaleVariablen.CursorImSpiel (RasseExtern).Position);
      
      case
        EinheitRasseNummer.Platznummer
      is
         when EinheitenKonstanten.LeerNummer =>
            return;
            
         when others =>
            null;
      end case;
      
   end EinheitInformationen;
   
   
   
   procedure CheatInformationen
   is begin
      
      null;
      
   end CheatInformationen;

end KarteInformationenSFML;
