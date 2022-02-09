pragma SPARK_Mode (On);

with KartenDatentypen; use KartenDatentypen;
with KartenKonstanten;
with StadtKonstanten;

with SchreibeKarten;
with SchreibeStadtGebaut;
with LeseKarten;

with KartePositionPruefen;
with GesamtwerteFeld;
with StadtUmgebungsbereichFestlegen;
with GebaeudeRichtigeUmgebung;

package body StadtWerteFestlegen is
   
   procedure StadtUmgebungGrößeFestlegenTechnologie
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      StadtSchleife:
      for StadtSchleifenwert in GlobaleVariablen.StadtGebautArray'First (2) .. GlobaleVariablen.Grenzen (RasseExtern).Städtegrenze loop
         
         case
           LeseStadtGebaut.ID (StadtRasseNummerExtern => (RasseExtern, StadtSchleifenwert))
         is
            when StadtKonstanten.LeerID =>
               null;
               
            when others =>
               StadtUmgebungGrößeFestlegen (StadtRasseNummerExtern => (RasseExtern, StadtSchleifenwert));
         end case;
         
      end loop StadtSchleife;
      
   end StadtUmgebungGrößeFestlegenTechnologie;
   
   

   procedure StadtUmgebungGrößeFestlegen
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
   is begin
            
      GrößeAlt := LeseStadtGebaut.UmgebungGröße (StadtRasseNummerExtern => StadtRasseNummerExtern);
      StadtUmgebungsbereichFestlegen.StadtUmgebungsbereichFestlegen (StadtRasseNummerExtern => StadtRasseNummerExtern);
      GrößeNeu := LeseStadtGebaut.UmgebungGröße (StadtRasseNummerExtern => StadtRasseNummerExtern);

      -- StadtUmgebungGröße darf hier nicht genutzt werden, damit bei einer Verkleinerung auch alle Felder zurückgenommen werden können.
      YAchseSchleife:
      for YÄnderungSchleifenwert in KartenDatentypen.LoopRangeMinusDreiZuDrei'Range loop
         XAchseSchleife:
         for XÄnderungSchleifenwert in KartenDatentypen.LoopRangeMinusDreiZuDrei'Range loop
            
            KartenWert := KartePositionPruefen.KartenPositionBestimmen (KoordinatenExtern => LeseStadtGebaut.Position (StadtRasseNummerExtern => StadtRasseNummerExtern),
                                                                        ÄnderungExtern    => (0, YÄnderungSchleifenwert, XÄnderungSchleifenwert),
                                                                        LogikGrafikExtern => True);
            
            if
              KartenWert.XAchse = KartenKonstanten.LeerXAchse
            then
               null;
               
            elsif
              (abs (YÄnderungSchleifenwert) > GrößeNeu
               or
               abs (XÄnderungSchleifenwert) > GrößeNeu)
              and
                LeseKarten.BestimmteStadtBelegtGrund (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                                      KoordinatenExtern      => KartenWert)
              = True
            then
               SchreibeKarten.BelegterGrund (PositionExtern      => KartenWert,
                                             BelegterGrundExtern => KartenKonstanten.LeerDurchStadtBelegterGrund);
               
               case
                 LeseStadtGebaut.UmgebungBewirtschaftung (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                                          YPositionExtern        => YÄnderungSchleifenwert,
                                                          XPositionExtern        => XÄnderungSchleifenwert)
               is
                  when True =>
                     SchreibeStadtGebaut.EinwohnerArbeiter (StadtRasseNummerExtern  => StadtRasseNummerExtern,
                                                            EinwohnerArbeiterExtern => False,
                                                            ÄnderungExtern          => -1);
                     SchreibeStadtGebaut.UmgebungBewirtschaftung (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                                                  YPositionExtern        => YÄnderungSchleifenwert,
                                                                  XPositionExtern        => XÄnderungSchleifenwert,
                                                                  BelegenEntfernenExtern => False);
                     
                  when False =>
                     null;
               end case;

            elsif
            abs (YÄnderungSchleifenwert) > GrößeNeu
              or
            abs (XÄnderungSchleifenwert) > GrößeNeu
            then
               null;
                     
            elsif
              LeseKarten.BelegterGrundLeer (KoordinatenExtern => KartenWert) = True
            then
               SchreibeKarten.BelegterGrund (PositionExtern      => KartenWert,
                                             BelegterGrundExtern => (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer));
               
            else
               null;
            end if;
            
         end loop XAchseSchleife;
      end loop YAchseSchleife;
      
      NeueUmgebungsgrößePrüfen (StadtRasseNummerExtern => StadtRasseNummerExtern);
      
   end StadtUmgebungGrößeFestlegen;
   
   
   
   procedure NeueUmgebungsgrößePrüfen
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
   is begin
      
      if
        GrößeNeu > GrößeAlt
      then
         ArbeiterSchleife:
         for ArbeiterSchleifenwert in 1 .. LeseStadtGebaut.EinwohnerArbeiter (StadtRasseNummerExtern  => StadtRasseNummerExtern,
                                                                              EinwohnerArbeiterExtern => True) - LeseStadtGebaut.EinwohnerArbeiter (StadtRasseNummerExtern  => StadtRasseNummerExtern,
                                                                                                                                                    EinwohnerArbeiterExtern => False) loop
            
            BewirtschaftbareFelderBelegen (ZuwachsOderSchwundExtern => True,
                                           StadtRasseNummerExtern   => StadtRasseNummerExtern);
            
         end loop ArbeiterSchleife;
         
      elsif
        GrößeNeu < GrößeAlt
      then
         GebäudeEntfernen (StadtRasseNummerExtern => StadtRasseNummerExtern);
         
      else
         null;
      end if;
      
   end NeueUmgebungsgrößePrüfen;
   


   procedure BewirtschaftbareFelderBelegen
     (ZuwachsOderSchwundExtern : in Boolean;
      StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
   is begin
      
      case
        ZuwachsOderSchwundExtern
      is
         when False =>
            SchreibeStadtGebaut.EinwohnerArbeiter (StadtRasseNummerExtern  => StadtRasseNummerExtern,
                                                   EinwohnerArbeiterExtern => True,
                                                   ÄnderungExtern         => -1);
            
            if
              LeseStadtGebaut.EinwohnerArbeiter (StadtRasseNummerExtern  => StadtRasseNummerExtern,
                                                 EinwohnerArbeiterExtern => True)
              >= LeseStadtGebaut.EinwohnerArbeiter (StadtRasseNummerExtern  => StadtRasseNummerExtern,
                                                    EinwohnerArbeiterExtern => False)
            then
               return;
               
            else
               null;
            end if;
            
         when True =>
            null;
      end case;
      
      UmgebungFestlegen (ZuwachsOderSchwundExtern => ZuwachsOderSchwundExtern,
                         StadtRasseNummerExtern   => StadtRasseNummerExtern);
      WelchesFeld := (0, 0, 0);
      
      case
        ZuwachsOderSchwundExtern
      is
         when True =>
            ArbeiterBelegen (StadtRasseNummerExtern => StadtRasseNummerExtern);
                  
         when False =>
            ArbeiterEntfernen (StadtRasseNummerExtern => StadtRasseNummerExtern);
      end case;
      
   end BewirtschaftbareFelderBelegen;
   
   
   
   procedure UmgebungFestlegen
     (ZuwachsOderSchwundExtern : in Boolean;
      StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
   is begin
      
      NutzbarerBereich := LeseStadtGebaut.UmgebungGröße (StadtRasseNummerExtern => StadtRasseNummerExtern);
      Umgebung := (others => (others => (False, EinheitStadtDatentypen.GesamtproduktionStadt'First)));

      YAchseSchleife:
      for YPositionSchleifenwert in -NutzbarerBereich .. NutzbarerBereich loop
         XAchseSchleife:
         for XPositionSchleifenwert in -NutzbarerBereich .. NutzbarerBereich loop
            
            KartenWert := KartePositionPruefen.KartenPositionBestimmen (KoordinatenExtern => LeseStadtGebaut.Position (StadtRasseNummerExtern => StadtRasseNummerExtern),
                                                                        ÄnderungExtern    => (0, YPositionSchleifenwert, XPositionSchleifenwert),
                                                                        LogikGrafikExtern => True);
            
            if
              KartenWert.XAchse = KartenKonstanten.LeerXAchse
            then
               null;
               
            elsif
              YPositionSchleifenwert = 0
              and
                XPositionSchleifenwert = 0
            then
               null;
               
            elsif
              LeseKarten.BestimmteStadtBelegtGrund (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                                    KoordinatenExtern      => KartenWert)
              = False
            then
               null;
              
            elsif
              LeseStadtGebaut.UmgebungBewirtschaftung (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                                       YPositionExtern        => YPositionSchleifenwert,
                                                       XPositionExtern        => XPositionSchleifenwert)
              = ZuwachsOderSchwundExtern
            then
               Umgebung (YPositionSchleifenwert, XPositionSchleifenwert).Belegt := ZuwachsOderSchwundExtern;
               
            else
               Umgebung (YPositionSchleifenwert, XPositionSchleifenwert)
                 := (not ZuwachsOderSchwundExtern, FeldBewerten (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                                                 PositionExtern         => KartenWert,
                                                                 BelegenOderEntfernen   => ZuwachsOderSchwundExtern));
            end if;
            
         end loop XAchseSchleife;
      end loop YAchseSchleife;
      
   end UmgebungFestlegen;
   
   
   
   function FeldBewerten
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      PositionExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      BelegenOderEntfernen : in Boolean)
      return EinheitStadtDatentypen.GesamtproduktionStadt
   is begin
      
      return NahrungBewertung (StadtRasseNummerExtern => StadtRasseNummerExtern,
                               PositionExtern         => PositionExtern,
                               BelegenOderEntfernen   => BelegenOderEntfernen)
        + ProduktionBewertung (StadtRasseNummerExtern => StadtRasseNummerExtern,
                               PositionExtern         => PositionExtern,
                               BelegenOderEntfernen   => BelegenOderEntfernen)
        + GeldBewertung (StadtRasseNummerExtern => StadtRasseNummerExtern,
                         PositionExtern         => PositionExtern,
                         BelegenOderEntfernen   => BelegenOderEntfernen)
        + WissenBewertung (StadtRasseNummerExtern => StadtRasseNummerExtern,
                           PositionExtern         => PositionExtern,
                           BelegenOderEntfernen   => BelegenOderEntfernen);
      
   end FeldBewerten;
   
   
   
   function NahrungBewertung
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      PositionExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      BelegenOderEntfernen : in Boolean)
      return EinheitStadtDatentypen.GesamtproduktionStadt
   is begin
      
      NahrungGesamt := GesamtwerteFeld.FeldNahrung (KoordinatenExtern => PositionExtern,
                                                    RasseExtern       => StadtRasseNummerExtern.Rasse);
      
      if
        LeseStadtGebaut.Nahrungsproduktion (StadtRasseNummerExtern => StadtRasseNummerExtern) <= 1
        and
          NahrungGesamt >= 1
      then
         case
           BelegenOderEntfernen
         is
            when True =>
               return 100 + (NahrungGesamt * 20);
               
            when False =>
               return -100 - (NahrungGesamt * 20);
         end case;
         
      else
         case
           BelegenOderEntfernen
         is
            when True =>
               return NahrungGesamt;
               
            when False =>
               return -NahrungGesamt;
         end case;
      end if;
      
   end NahrungBewertung;
   
   
   
   function ProduktionBewertung
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      PositionExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      BelegenOderEntfernen : in Boolean)
      return EinheitStadtDatentypen.GesamtproduktionStadt
   is begin
      
      RessourcenGesamt := GesamtwerteFeld.FeldProduktion (KoordinatenExtern => PositionExtern,
                                                          RasseExtern       => StadtRasseNummerExtern.Rasse);
      
      if
        LeseStadtGebaut.Produktionrate (StadtRasseNummerExtern => StadtRasseNummerExtern) <= 0
        and
          RessourcenGesamt >= 1
      then
         case
           BelegenOderEntfernen
         is
            when True =>
               return 25 + RessourcenGesamt;
               
            when False =>
               return -25 - RessourcenGesamt;
         end case;
         
      else
         case
           BelegenOderEntfernen
         is
            when True =>
               return RessourcenGesamt;
               
            when False =>
               return -RessourcenGesamt;
         end case;
      end if;
      
   end ProduktionBewertung;



   function GeldBewertung
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      PositionExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      BelegenOderEntfernen : in Boolean)
      return EinheitStadtDatentypen.GesamtproduktionStadt
   is begin
      
      GeldGesamt := GesamtwerteFeld.FeldGeld (KoordinatenExtern => PositionExtern,
                                              RasseExtern       => StadtRasseNummerExtern.Rasse);

      if
        LeseStadtGebaut.Geldgewinnung (StadtRasseNummerExtern => StadtRasseNummerExtern) <= 0
        and
          GeldGesamt >= 1
      then
         case
           BelegenOderEntfernen
         is
            when True =>
               return 25 + GeldGesamt;
               
            when False =>
               return -25 - GeldGesamt;
         end case;
         
      else
         case
           BelegenOderEntfernen
         is
            when True =>
               return GeldGesamt;
               
            when False =>
               return -GeldGesamt;
         end case;
      end if;

   end GeldBewertung;
   
   
   
   function WissenBewertung
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      PositionExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      BelegenOderEntfernen : in Boolean)
      return EinheitStadtDatentypen.GesamtproduktionStadt
   is begin

      WissenGesamt := GesamtwerteFeld.FeldWissen (KoordinatenExtern => PositionExtern,
                                                  RasseExtern       => StadtRasseNummerExtern.Rasse);
      
      if
        LeseStadtGebaut.Forschungsrate (StadtRasseNummerExtern => StadtRasseNummerExtern) <= 0
        and
          WissenGesamt >= 1
      then
         case
           BelegenOderEntfernen
         is
            when True =>
               return 25 + WissenGesamt;
               
            when False =>
               return -25 - WissenGesamt;
         end case;
      
      else
         case
           BelegenOderEntfernen
         is
            when True =>
               return WissenGesamt;
               
            when False =>
               return -WissenGesamt;
         end case;
      end if;
      
   end WissenBewertung;
   
   
   
   procedure ArbeiterBelegen
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
   is begin
      
      YAchseSchleife:
      for YPositionSchleifenwert in -NutzbarerBereich .. NutzbarerBereich loop
         XAchseSchleife:
         for XPositionSchleifenwert in -NutzbarerBereich .. NutzbarerBereich loop
            
            if
              Umgebung (YPositionSchleifenwert, XPositionSchleifenwert).Belegt = True
            then
               null;
               
            elsif
              Umgebung (YPositionSchleifenwert, XPositionSchleifenwert).Gesamtbewertung > WelchesFeld.HöchsterWert
            then
               WelchesFeld := (Umgebung (YPositionSchleifenwert, XPositionSchleifenwert).Gesamtbewertung, YPositionSchleifenwert, XPositionSchleifenwert);
               
            else
               null;
            end if;
            
         end loop XAchseSchleife;
      end loop YAchseSchleife;
      
      ArbeiterBelegenEntfernen (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                BelegenEntfernenExtern => True,
                                ÄnderungExtern         => 1);
      
   end ArbeiterBelegen;
   
   
   
   procedure ArbeiterEntfernen
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
   is begin
      
      YAchseSchleife:
      for YPositionSchleifenwert in -NutzbarerBereich .. NutzbarerBereich loop
         XAchseSchleife:
         for XPositionSchleifenwert in -NutzbarerBereich .. NutzbarerBereich loop
            
            if
              Umgebung (YPositionSchleifenwert, XPositionSchleifenwert).Belegt = False
            then
               null;
               
            elsif
              Umgebung (YPositionSchleifenwert, XPositionSchleifenwert).Gesamtbewertung < WelchesFeld.HöchsterWert
            then
               WelchesFeld := (Umgebung (YPositionSchleifenwert, XPositionSchleifenwert).Gesamtbewertung, YPositionSchleifenwert, XPositionSchleifenwert);
               
            else
               null;
            end if;
            
         end loop XAchseSchleife;
      end loop YAchseSchleife;
                  
      ArbeiterBelegenEntfernen (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                BelegenEntfernenExtern => False,
                                ÄnderungExtern         => -1);
      
   end ArbeiterEntfernen;
   
   
   
   procedure ArbeiterBelegenEntfernen
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      BelegenEntfernenExtern : in Boolean;
      ÄnderungExtern : in EinheitStadtDatentypen.ProduktionFeld)
   is begin
      
      case
        WelchesFeld.HöchsterWert
      is
         when 0 =>
            null;
            
         when others =>
            SchreibeStadtGebaut.UmgebungBewirtschaftung (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                                         YPositionExtern        => WelchesFeld.YKoordinate,
                                                         XPositionExtern        => WelchesFeld.XKoordinate,
                                                         BelegenEntfernenExtern => BelegenEntfernenExtern);
            SchreibeStadtGebaut.EinwohnerArbeiter (StadtRasseNummerExtern  => StadtRasseNummerExtern,
                                                   EinwohnerArbeiterExtern => False,
                                                   ÄnderungExtern          => ÄnderungExtern);
      end case;
      
   end ArbeiterBelegenEntfernen;
   
   
   
   procedure GebäudeEntfernen
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
   is begin
      
      GebäudeSchleife:
      for GebäudeSchleifenwert in EinheitStadtDatentypen.GebäudeID'Range loop
         
         if
           LeseStadtGebaut.GebäudeVorhanden (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                              WelchesGebäudeExtern  => GebäudeSchleifenwert)
           = False
         then
            null;
            
         elsif
           GebaeudeRichtigeUmgebung.RichtigeUmgebungVorhanden (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                                               GebäudeIDExtern       => GebäudeSchleifenwert)
           = True
         then
            null;
            
         else
            SchreibeStadtGebaut.GebäudeVorhanden (StadtRasseNummerExtern     => StadtRasseNummerExtern,
                                                   WelchesGebäudeExtern      => GebäudeSchleifenwert,
                                                   HinzufügenEntfernenExtern => False);
         end if;
         
      end loop GebäudeSchleife;
      
   end GebäudeEntfernen;
   
end StadtWerteFestlegen;
