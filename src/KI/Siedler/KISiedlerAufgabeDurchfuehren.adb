pragma SPARK_Mode (On);

with KIDatentypen;

with StadtBauen, KINullwerteSetzen, Verbesserungen, ZugriffKarten, Karten;

package body KISiedlerAufgabeDurchfuehren is

   procedure SiedlerAufgabeDurchfuehren
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
   is begin
      
      case
        GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).KIBeschäftigt
      is
         when KIDatentypen.Stadt_Bauen =>
            StadtBauen.StadtBauen (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
            KINullwerteSetzen.ZielBewegungNullSetzen (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                      WelchenWertNullSetzten   => 0);
            GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).KIBeschäftigt := KIDatentypen.Keine_Aufgabe;
            
            
         when KIDatentypen.Verbesserung_Anlegen =>
            WelcheVerbesserungAnlegen (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
            
         when KIDatentypen.Flucht =>
            null;
            
         when KIDatentypen.Einheit_Heilen =>
            Verbesserungen.Verbesserung (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                         BefehlExtern             => GlobaleDatentypen.Heilen);
            
         when KIDatentypen.Einheit_Festsetzen =>
            Verbesserungen.Verbesserung (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                         BefehlExtern             => GlobaleDatentypen.Verschanzen);
            
         when KIDatentypen.Einheit_Verbessern =>
            null;
            
         when others =>
            null;
      end case;
      
   end SiedlerAufgabeDurchfuehren;
   
   
   
   procedure WelcheVerbesserungAnlegen
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
   is begin
      
      case
        Karten.Weltkarte (GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition.EAchse,
                          GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition.YAchse,
                          GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition.XAchse).VerbesserungGebiet
      is
         when 0 =>         
            Grund := ZugriffKarten.KartenGrundVereinfachung (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      
            if
              Grund in 6 .. 7
              or
                Grund in 10 .. 11
                or
                  Grund = 33
                  or
                    ZugriffKarten.KartenHügelVereinfachung (EinheitRasseNummerExtern => EinheitRasseNummerExtern) = True
            then
               Verbesserungen.Verbesserung (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                            BefehlExtern             => GlobaleDatentypen.Mine_Bauen);
         
            elsif
              Grund = 1
            then
               Verbesserungen.Verbesserung (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                            BefehlExtern             => GlobaleDatentypen.Festung_Bauen);
         
            else
               Verbesserungen.Verbesserung (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                            BefehlExtern             => GlobaleDatentypen.Farm_Bauen);
            end if;
      
         when others =>
            null;
      end case;
      
      case
        Karten.Weltkarte (GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition.EAchse,
                          GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition.YAchse,
                          GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition.XAchse).VerbesserungStraße
      is
         when 0 =>
            Verbesserungen.Verbesserung (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                         BefehlExtern             => GlobaleDatentypen.Straße_Bauen);
            return;
            
         when others =>
            GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AktuelleBeschäftigung := GlobaleDatentypen.Keine;
            GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).KIBeschäftigt := KIDatentypen.Keine_Aufgabe;
      end case;
      
   end WelcheVerbesserungAnlegen;

end KISiedlerAufgabeDurchfuehren;
