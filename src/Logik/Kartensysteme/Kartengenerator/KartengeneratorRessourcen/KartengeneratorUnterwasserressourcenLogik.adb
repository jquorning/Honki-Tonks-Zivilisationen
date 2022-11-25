with SchreibeWeltkarte;
with LeseWeltkarte;

with ZufallsgeneratorenKartenLogik;
with KartengeneratorVariablenLogik;

package body KartengeneratorUnterwasserressourcenLogik is

   procedure KartengeneratorUnterwasserressourcen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldVorhandenRecord)
   is
      use type SystemDatentypen.NullBisHundert;
   begin
      
      WelcheRessource := KartengrundDatentypen.Leer_Ressource_Enum;
      Zahlenspeicher := 0;
      
      ZufallszahlenSchleife:
      for ZufallszahlSchleifenwert in KartengrundDatentypen.Kartenressourcen_Unterfläche_Wasser_Enum'Range loop
         
         GezogeneZahl := ZufallsgeneratorenKartenLogik.KartengeneratorZufallswerte;
         
         if
           GezogeneZahl > KartengeneratorVariablenLogik.KartenressourcenWahrscheinlichkeiten (ZufallszahlSchleifenwert)
           or
             GezogeneZahl = 0
         then
            null;
            
         elsif
           (GezogeneZahl = Zahlenspeicher
            and
              ZufallsgeneratorenKartenLogik.KartengeneratorBoolean = True)
           or
             GezogeneZahl > Zahlenspeicher
         then
            Zahlenspeicher := GezogeneZahl;
            WelcheRessource := ZufallszahlSchleifenwert;
            
         else
            null;
         end if;
         
      end loop ZufallszahlenSchleife;
      
      case
        WelcheRessource
      is
         when KartengrundDatentypen.Leer_Ressource_Enum =>
            return;
              
         when others =>
            WelcheRessource := RessourceZusatzberechnungen (KoordinatenExtern => KoordinatenExtern,
                                                            RessourceExtern   => WelcheRessource);
      end case;
      
      case
        WelcheRessource
      is
         when KartengrundDatentypen.Kartenressourcen_Unterfläche_Wasser_Enum'Range =>
            SchreibeWeltkarte.Ressource (KoordinatenExtern => (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse),
                                         RessourceExtern   => WelcheRessource);
            
         when others =>
            null;
      end case;
      
   end KartengeneratorUnterwasserressourcen;
   
   
   
   function RessourceZusatzberechnungen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldVorhandenRecord;
      RessourceExtern : in KartengrundDatentypen.Kartenressourcen_Unterfläche_Wasser_Enum)
      return KartengrundDatentypen.Kartenressourcen_Enum
   is begin
      
      case
        RessourceExtern
      is
         when KartengrundDatentypen.Fisch_Enum =>
            return ZusatzberechnungFisch (KoordinatenExtern => KoordinatenExtern,
                                          RessourceExtern   => RessourceExtern);
            
         when KartengrundDatentypen.Wal_Enum =>
            return ZusatzberechnungWal (KoordinatenExtern => KoordinatenExtern,
                                        RessourceExtern   => RessourceExtern);
            
         when KartengrundDatentypen.Hochwertiges_Holz_Enum =>
            return ZusatzberechnungHochwertigesHolz (KoordinatenExtern => KoordinatenExtern,
                                                     RessourceExtern   => RessourceExtern);
      end case;
      
   end RessourceZusatzberechnungen;
   
   
   
   function ZusatzberechnungFisch
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldVorhandenRecord;
      RessourceExtern : in KartengrundDatentypen.Kartenressourcen_Enum)
      return KartengrundDatentypen.Kartenressourcen_Enum
   is begin
      
      if
        KoordinatenExtern.YAchse = KoordinatenExtern.XAchse
      then
         null;
         
      else
         null;
      end if;
      
      return RessourceExtern;
      
   end ZusatzberechnungFisch;
   
   
   
   function ZusatzberechnungWal
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldVorhandenRecord;
      RessourceExtern : in KartengrundDatentypen.Kartenressourcen_Enum)
      return KartengrundDatentypen.Kartenressourcen_Enum
   is begin
      
      if
        KoordinatenExtern.YAchse = KoordinatenExtern.XAchse
      then
         null;
         
      else
         null;
      end if;
      
      return RessourceExtern;
      
   end ZusatzberechnungWal;
   
   
   
   function ZusatzberechnungHochwertigesHolz
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldVorhandenRecord;
      RessourceExtern : in KartengrundDatentypen.Kartenressourcen_Enum)
      return KartengrundDatentypen.Kartenressourcen_Enum
   is begin
      
      case
        LeseWeltkarte.Zusatzgrund (KoordinatenExtern => (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse))
      is
         when KartengrundDatentypen.Unterwald_Enum =>
            return RessourceExtern;
            
         when others =>
            return KartengrundDatentypen.Leer_Ressource_Enum;
      end case;
      
   end ZusatzberechnungHochwertigesHolz;

end KartengeneratorUnterwasserressourcenLogik;
