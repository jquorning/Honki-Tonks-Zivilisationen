with Views;
with KartengrundDatentypen;
with ViewKonstanten;
with ZeitKonstanten;
with GrafikDatentypen;
with GrafikVariablen;
with TextaccessVariablen;
with KartenDatentypen;

with LeseWeltkarte;

with FensterGrafik;
with EingeleseneTexturenGrafik;
with KartenspritesZeichnenGrafik;
with ViewsEinstellenGrafik;
with Vergleiche;
with InteraktionAllgemein;
with ViewbereicheBerechnenGrafik;
with HintergrundGrafik;
with TextberechnungenBreiteGrafik;
with TextberechnungenHoeheGrafik;
with TextaccessverwaltungssystemGrafik;
with GebaeudebeschreibungenGrafik;
with SichtweitenGrafik;

package body StadtkarteGrafik is

   procedure Stadtkarte
     (StadtauswahlExtern : in StadtGrafikRecords.StadtkarteGrafikRecord)
   is
      use type KartenDatentypen.Kartenfeld;
   begin
      
      ViewsEinstellenGrafik.ViewEinstellen (ViewExtern           => Views.StadtviewAccesse (ViewKonstanten.StadtKarte),
                                            GrößeExtern          => FensterGrafik.AktuelleAuflösung,
                                            AnzeigebereichExtern => GrafikRecordKonstanten.Stadtbereich (ViewKonstanten.StadtKarte));
      
      Gesamtgrund := LeseWeltkarte.Gesamtgrund (KoordinatenExtern => StadtauswahlExtern.Koordinaten);
      GrafischeDarstellung (GrundExtern => Gesamtgrund);
      GebäudeZusatzinformationen := StadtKonstanten.LeerGebäudeID;
      
      Grafikgröße := SichtweitenGrafik.Stadtumgebungsfläche;
      
      YAchseSchleife:
      for YAchseSchleifenwert in 1 .. StadtKonstanten.Stadtkartengröße loop
         XAchseSchleife:
         for XAchseSchleifenwert in 1 .. StadtKonstanten.Stadtkartengröße loop
            
            if
              (YAchseSchleifenwert - 1) * StadtKonstanten.Stadtkartengröße + XAchseSchleifenwert > KartenDatentypen.KartenfeldPositiv (StadtDatentypen.GebäudeID'Last)
            then
               exit YAchseSchleife;
               
            else
               GebäudeID := StadtDatentypen.GebäudeID ((YAchseSchleifenwert - 1) * StadtKonstanten.Stadtkartengröße + XAchseSchleifenwert);
            end if;
                     
            case
              StadtauswahlExtern.GebäudeVorhanden (GebäudeID)
            is
               when False =>
                  null;
                  
               when True =>
                  KartenspritesZeichnenGrafik.SpriteZeichnenVariabel (PositionExtern     => (Float (XAchseSchleifenwert - 1) * Grafikgröße.x, Float (YAchseSchleifenwert - 1) * Grafikgröße.y),
                                                                      GrößeExtern        => Grafikgröße,
                                                                      TexturAccessExtern => EingeleseneTexturenGrafik.GebäudeAccess (StadtauswahlExtern.Spezies, GebäudeID));
                  
                  if
                    True = Vergleiche.Auswahlposition (MauspositionExtern => InteraktionAllgemein.Mausposition,
                                                       TextboxExtern      => (Float (XAchseSchleifenwert - 1) * Grafikgröße.x, Float (YAchseSchleifenwert - 1) * Grafikgröße.y, Grafikgröße.x, Grafikgröße.y))
                  then
                     GebäudeZusatzinformationen := GebäudeID;
                     
                  else
                     null;
                  end if;
            end case;
         
         end loop XAchseSchleife;
      end loop YAchseSchleife;
      
      Zusatzinformationen (GebäudeIDExtern => GebäudeZusatzinformationen,
                           SpeziesExtern   => StadtauswahlExtern.Spezies);
      
   end Stadtkarte;
   
   
   
   procedure GrafischeDarstellung
     (GrundExtern : in KartenRecords.KartengrundRecord)
   is begin
      
      KartenspritesZeichnenGrafik.StadtkarteZeichnen (TexturAccessExtern => EingeleseneTexturenGrafik.BasisgrundAccess (GrundExtern.Basisgrund));
      
      case
        GrundExtern.Zusatzgrund
      is
         when KartengrundDatentypen.Leer_Zusatzgrund_Enum =>
            null;
            
         when others =>
            KartenspritesZeichnenGrafik.StadtkarteZeichnen (TexturAccessExtern => EingeleseneTexturenGrafik.ZusatzgrundAccess (GrundExtern.Zusatzgrund));
      end case;
            
   end GrafischeDarstellung;
   
   
   
   procedure Zusatzinformationen
     (GebäudeIDExtern : in StadtDatentypen.GebäudeIDMitNullwert;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
   is
      use type StadtDatentypen.GebäudeIDMitNullwert;
   begin
      
      if
        GebäudeIDExtern = StadtKonstanten.LeerGebäudeID
        or
          GebäudeIDExtern /= AlteID
      then
         Anzeigezeit := Clock;
         AlteID := GebäudeIDExtern;
         
      elsif
        Anzeigezeit + ZeitKonstanten.AnzeigeInformationen < Clock
        and
          GebäudeIDExtern = AlteID
      then
         Informationsfeld (GebäudeIDExtern => GebäudeIDExtern,
                           SpeziesExtern   => SpeziesExtern);
         
      else
         null;
      end if;
            
   end Zusatzinformationen;
   
   
   
   procedure Informationsfeld
     (GebäudeIDExtern : in StadtDatentypen.GebäudeID;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
   is begin
      
      GrafikVariablen.InformationsfeldBereiche (ViewKonstanten.InformationsfeldStadtkarte)
        := ViewbereicheBerechnenGrafik.ViewbereichBreiteHöheBerechnen (BereichExtern => GrafikVariablen.InformationsfeldBereiche (ViewKonstanten.InformationsfeldStadtkarte));
                                                                        
      Viewfläche := ViewsEinstellenGrafik.ViewflächeVariabelAnpassen (ViewflächeExtern => Viewfläche,
                                                                        VerhältnisExtern => (GrafikVariablen.InformationsfeldBereiche (ViewKonstanten.InformationsfeldStadtkarte).width,
                                                                                              GrafikVariablen.InformationsfeldBereiche (ViewKonstanten.InformationsfeldStadtkarte).height));
      
      ViewsEinstellenGrafik.ViewEinstellen (ViewExtern           => Views.InformationsfeldAccesse (ViewKonstanten.InformationsfeldStadtkarte),
                                            GrößeExtern          => Viewfläche,
                                            AnzeigebereichExtern => GrafikVariablen.InformationsfeldBereiche (ViewKonstanten.InformationsfeldStadtkarte));
      
      HintergrundGrafik.Hintergrund (HintergrundExtern => GrafikDatentypen.Bauen_Hintergrund_Enum,
                                     AbmessungenExtern => Viewfläche);
           
      Textposition.x := TextberechnungenBreiteGrafik.KleinerSpaltenabstandVariabel;
      Textposition.y := TextberechnungenHoeheGrafik.KleinerZeilenabstandVariabel;
      
      TextaccessverwaltungssystemGrafik.TextPositionZeichnen (TextaccessExtern => TextaccessVariablen.TextAccess,
                                                              TextExtern       => GebaeudebeschreibungenGrafik.Kurzbeschreibung (IDExtern      => GebäudeIDExtern,
                                                                                                                                 SpeziesExtern => SpeziesExtern),
                                                              PositionExtern   => Textposition);
      
      Viewfläche := (Textposition.x, Textposition.y + TextberechnungenHoeheGrafik.KleinerZeilenabstandVariabel);
      
   end Informationsfeld;

end StadtkarteGrafik;
