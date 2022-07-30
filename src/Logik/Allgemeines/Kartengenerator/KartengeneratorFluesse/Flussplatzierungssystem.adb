pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KartenKonstanten;

with LeseKarten;
with SchreibeKarten;

with Kartenkoordinatenberechnungssystem;

package body Flussplatzierungssystem is

   procedure Flussplatzierung
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
   is begin
      
      FlussLinks (KoordinatenExtern.EAchse) := False;
      FlussRechts (KoordinatenExtern.EAchse) := False;
      FlussOben (KoordinatenExtern.EAchse) := False;
      FlussUnten (KoordinatenExtern.EAchse) := False;
      
      YAchseSchleife:
      for YÄnderungSchleifenwert in KartenDatentypen.UmgebungsbereichEins'Range loop
         XAchseSchleife:
         for XÄnderungSchleifenwert in KartenDatentypen.UmgebungsbereichEins'Range loop

            KartenWert (KoordinatenExtern.EAchse) := Kartenkoordinatenberechnungssystem.Kartenkoordinatenberechnungssystem (KoordinatenExtern => KoordinatenExtern,
                                                                                                                            ÄnderungExtern    => (0, YÄnderungSchleifenwert, XÄnderungSchleifenwert),
                                                                                                                            LogikGrafikExtern => True);

            if
              KartenWert (KoordinatenExtern.EAchse).XAchse = KartenKonstanten.LeerXAchse
            then
               null;
                  
            elsif
              YÄnderungSchleifenwert = 0
              and
                XÄnderungSchleifenwert = -1
            then
               FlussLinks (KoordinatenExtern.EAchse) := BerechnungLinks (KoordinatenExtern => KartenWert (KoordinatenExtern.EAchse));
               
            elsif
              YÄnderungSchleifenwert = 0
              and
                XÄnderungSchleifenwert = 1
            then
               FlussRechts (KoordinatenExtern.EAchse) := BerechnungRechts (KoordinatenExtern => KartenWert (KoordinatenExtern.EAchse));
               
            elsif
              YÄnderungSchleifenwert = -1
              and
                XÄnderungSchleifenwert = 0
            then
               FlussOben (KoordinatenExtern.EAchse) := BerechnungOben (KoordinatenExtern => KartenWert (KoordinatenExtern.EAchse));
               
            elsif
              YÄnderungSchleifenwert = 1
              and
                XÄnderungSchleifenwert = 0
            then
               FlussUnten (KoordinatenExtern.EAchse) := BerechnungUnten (KoordinatenExtern => KartenWert (KoordinatenExtern.EAchse));
               
            else
               null;
            end if;
            
         end loop XAchseSchleife;
      end loop YAchseSchleife;

      SchreibeKarten.Fluss (KoordinatenExtern => KoordinatenExtern,
                            FlussExtern       => KartengrundDatentypen.Kartenfluss_Enum'Val (Flusswert (FlussLinks (KoordinatenExtern.EAchse), FlussRechts (KoordinatenExtern.EAchse),
                              FlussOben (KoordinatenExtern.EAchse), FlussUnten (KoordinatenExtern.EAchse)) + Flusstyp (KoordinatenExtern.EAchse)));
      
   end Flussplatzierung;
   
   
   
   function BerechnungLinks
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
      return Boolean
   is begin
      
      WelcherFluss (KoordinatenExtern.EAchse) := LeseKarten.Fluss (KoordinatenExtern => KoordinatenExtern);
      
      case
        WelcherFluss (KoordinatenExtern.EAchse)
      is
         when KartengrundDatentypen.Leer_Fluss_Enum =>
            return False;
            
         when others =>
            WelcherFluss (KoordinatenExtern.EAchse)
              := KartengrundDatentypen.Kartenfluss_Oberfläche_Enum'Val (KartengrundDatentypen.Kartenfluss_Oberfläche_Enum'Pos (WelcherFluss (KoordinatenExtern.EAchse)) - Flusstyp (KoordinatenExtern.EAchse));
            SchreibeKarten.Fluss (KoordinatenExtern => KartenWert (KoordinatenExtern.EAchse),
                                  FlussExtern       => KartengrundDatentypen.Kartenfluss_Enum'Val (FlüsseLinks (WelcherFluss (KoordinatenExtern.EAchse)) + Flusstyp (KoordinatenExtern.EAchse)));
            return True;
      end case;
            
   end BerechnungLinks;
   
   
   
   function BerechnungRechts
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
      return Boolean
   is begin
      
      WelcherFluss (KoordinatenExtern.EAchse) := LeseKarten.Fluss (KoordinatenExtern => KoordinatenExtern);
      
      case
        WelcherFluss (KoordinatenExtern.EAchse)
      is
         when KartengrundDatentypen.Leer_Fluss_Enum =>
            return False;
            
         when others =>
            WelcherFluss (KoordinatenExtern.EAchse)
              := KartengrundDatentypen.Kartenfluss_Oberfläche_Enum'Val (KartengrundDatentypen.Kartenfluss_Oberfläche_Enum'Pos (WelcherFluss (KoordinatenExtern.EAchse)) - Flusstyp (KoordinatenExtern.EAchse));
            SchreibeKarten.Fluss (KoordinatenExtern => KartenWert (KoordinatenExtern.EAchse),
                                  FlussExtern       => KartengrundDatentypen.Kartenfluss_Enum'Val (FlüsseRechts (WelcherFluss (KoordinatenExtern.EAchse)) + Flusstyp (KoordinatenExtern.EAchse)));
            return True;
      end case;
      
   end BerechnungRechts;
   
   
   
   function BerechnungOben
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
      return Boolean
   is begin
      
      WelcherFluss (KoordinatenExtern.EAchse) := LeseKarten.Fluss (KoordinatenExtern => KoordinatenExtern);
      
      case
        WelcherFluss (KoordinatenExtern.EAchse)
      is
         when KartengrundDatentypen.Leer_Fluss_Enum =>
            return False;
            
         when others =>
            WelcherFluss (KoordinatenExtern.EAchse)
              := KartengrundDatentypen.Kartenfluss_Oberfläche_Enum'Val (KartengrundDatentypen.Kartenfluss_Oberfläche_Enum'Pos (WelcherFluss (KoordinatenExtern.EAchse)) - Flusstyp (KoordinatenExtern.EAchse));
            SchreibeKarten.Fluss (KoordinatenExtern => KartenWert (KoordinatenExtern.EAchse),
                                  FlussExtern       => KartengrundDatentypen.Kartenfluss_Enum'Val (FlüsseOben (WelcherFluss (KoordinatenExtern.EAchse)) + Flusstyp (KoordinatenExtern.EAchse)));
            return True;
      end case;
            
   end BerechnungOben;
   
   
   
   function BerechnungUnten
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
      return Boolean
   is begin
      
      WelcherFluss (KoordinatenExtern.EAchse) := LeseKarten.Fluss (KoordinatenExtern => KoordinatenExtern);
      
      case
        WelcherFluss (KoordinatenExtern.EAchse)
      is
         when KartengrundDatentypen.Leer_Fluss_Enum =>
            return False;
            
         when others =>
            WelcherFluss (KoordinatenExtern.EAchse)
              := KartengrundDatentypen.Kartenfluss_Oberfläche_Enum'Val (KartengrundDatentypen.Kartenfluss_Oberfläche_Enum'Pos (WelcherFluss (KoordinatenExtern.EAchse)) - Flusstyp (KoordinatenExtern.EAchse));
            SchreibeKarten.Fluss (KoordinatenExtern => KartenWert (KoordinatenExtern.EAchse),
                                  FlussExtern       => KartengrundDatentypen.Kartenfluss_Enum'Val (FlüsseUnten (WelcherFluss (KoordinatenExtern.EAchse)) + Flusstyp (KoordinatenExtern.EAchse)));
            return True;
      end case;
      
   end BerechnungUnten;

end Flussplatzierungssystem;
