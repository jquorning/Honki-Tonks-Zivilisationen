pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Ada.Wide_Wide_Text_IO; use Ada.Wide_Wide_Text_IO;
with Ada.Characters.Wide_Wide_Latin_1; use Ada.Characters.Wide_Wide_Latin_1;

with KartenDatentypen; use KartenDatentypen;
with EinheitStadtDatentypen; use EinheitStadtDatentypen;
with KartenRecords; use KartenRecords;
with GlobaleTexte;
with KartenKonstanten;
with StadtKonstanten;
with KartenGrundDatentypen;
with KartenVerbesserungDatentypen;
with SystemKonstanten;
with EinheitenKonstanten;

with LeseKarten;
with LeseStadtGebaut;

with KarteKoordinatenPruefen;
with Karten;
with StadtInformationenKonsole;
with TextAnzeigeKonsole;
with GebaeudeAllgemein;
with KartenAllgemein;
with GrafischeAnzeigeKonsole;
with FarbgebungKonsole;
with EingeleseneGrafikenKonsole;

package body KarteStadtKonsole is

   procedure AnzeigeStadt
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
   is begin
      
      Put (Item => CSI & "2J" & CSI & "3J" & CSI & "H");

      Stadtumgebungsgröße := LeseStadtGebaut.UmgebungGröße (StadtRasseNummerExtern => StadtRasseNummerExtern);
      InformationenStadtAufrufen := False;

      GrafischeDarstellung (StadtRasseNummerExtern => StadtRasseNummerExtern);
      StadtInformationenKonsole.Stadt (RasseExtern            => StadtRasseNummerExtern.Rasse,
                                       StadtRasseNummerExtern => StadtRasseNummerExtern);

      case
        InformationenStadtAufrufen
      is
         when True =>
            WeitereInformationen (StadtRasseNummerExtern => StadtRasseNummerExtern);

         when False =>
            null;
      end case;
      
      GebäudeText (StadtRasseNummerExtern => StadtRasseNummerExtern);
      
      New_Line;
      
   end AnzeigeStadt;
   
   
   
   procedure GebäudeText
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
   is begin
      
      Aufschlag := AufschlagGebäude (RasseExtern => StadtRasseNummerExtern.Rasse);
      
      case
        Aufschlag
      is
         when KartenDatentypen.SichtweiteMitNullwert'First =>
            null;
            
         when others =>
            Aufschlag := Aufschlag - 1;
            if
              LeseStadtGebaut.GebäudeVorhanden (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                                 WelchesGebäudeExtern  => EinheitStadtDatentypen.GebäudeID (GlobaleVariablen.CursorImSpiel (StadtRasseNummerExtern.Rasse).KoordinatenStadt.XAchse + Aufschlag * 12))
              = True
            then
               Put_Line (Item => GebaeudeAllgemein.BeschreibungKurz (IDExtern => EinheitStadtDatentypen.GebäudeID (GlobaleVariablen.CursorImSpiel (StadtRasseNummerExtern.Rasse).KoordinatenStadt.XAchse + Aufschlag * 12)));
            
            else
               null;
            end if;
      end case;

      New_Line;
      
   end GebäudeText;
   
   
   
   function AufschlagGebäude
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
      return KartenDatentypen.SichtweiteMitNullwert
   is begin
      
      if
        ((GlobaleVariablen.CursorImSpiel (RasseExtern).KoordinatenStadt.YAchse = 1
          or
            GlobaleVariablen.CursorImSpiel (RasseExtern).KoordinatenStadt.YAchse = 2)
         and
           GlobaleVariablen.CursorImSpiel (RasseExtern).KoordinatenStadt.XAchse <= 12)
        or
          (GlobaleVariablen.CursorImSpiel (RasseExtern).KoordinatenStadt.YAchse = 3
           and
             GlobaleVariablen.CursorImSpiel (RasseExtern).KoordinatenStadt.XAchse <= 2)
      then
         return GlobaleVariablen.CursorImSpiel (RasseExtern).KoordinatenStadt.YAchse;
         
      else
         return KartenDatentypen.SichtweiteMitNullwert'First;
      end if;
      
   end AufschlagGebäude;
     
   
   
   procedure GrafischeDarstellung
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
   is begin
      
      YAchsenabstraktion := -Stadtumgebungsgröße;
      
      YAchseSchleife:
      for YAchseSchleifenwert in Karten.StadtkarteArray'Range (1) loop
         XAchseSchleife:
         for XAchseSchleifenwert in Karten.StadtkarteArray'Range (2) loop
                
            case
              Darstellung (YAchseExtern           => YAchseSchleifenwert,
                           XAchseExtern           => XAchseSchleifenwert,
                           StadtRasseNummerExtern => StadtRasseNummerExtern)
            is
               when True =>
                  exit XAchseSchleife;
                  
               when False =>
                  null;
            end case;

            case
              XAchseSchleifenwert
            is
               when Karten.Stadtkarte'Last (2) =>
                  New_Line;
                  
               when others =>
                  null;
            end case;
            
         end loop XAchseSchleife;
      end loop YAchseSchleife;
      
   end GrafischeDarstellung;
   
   
   
   function Darstellung
     (YAchseExtern : in KartenDatentypen.Stadtfeld;
      XAchseExtern : in KartenDatentypen.Stadtfeld;
      StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
      return Boolean
   is begin
      
      if
        YAchseExtern < Karten.Stadtkarte'First (1) + 7
        and
          XAchseExtern > Karten.Stadtkarte'Last (2) - 7
      then               
         AnsichtUmgebung (YAchseExtern           => YAchseExtern,
                          XAchseExtern           => XAchseExtern,
                          StadtRasseNummerExtern => StadtRasseNummerExtern);
         return True;
               
      elsif
        GlobaleVariablen.CursorImSpiel (StadtRasseNummerExtern.Rasse).KoordinatenStadt = (YAchseExtern, XAchseExtern)
      then
         CursorDarstellung (YAchseExtern => YAchseExtern,
                            XAchseExtern => XAchseExtern,
                            RasseExtern  => StadtRasseNummerExtern.Rasse);

      elsif
        YAchseExtern < Karten.Stadtkarte'First (1) + 7
        and
          XAchseExtern = Karten.Stadtkarte'Last (2) - 7
      then
         Put (Item => SystemKonstanten.LeerZeichen);

      elsif
        YAchseExtern = Karten.Stadtkarte'First (1) + 7
        and
          XAchseExtern >= Karten.Stadtkarte'Last (2) - 7
      then
         Put (Item => SystemKonstanten.LeerZeichen);

      elsif
        YAchseExtern = 1
        and
          XAchseExtern < 13
      then
         GebäudeDarstellung (StadtRasseNummerExtern => StadtRasseNummerExtern,
                              IDExtern               => EinheitStadtDatentypen.GebäudeID (XAchseExtern));
               
      elsif
        YAchseExtern = 2
        and
          XAchseExtern < 13
      then
         GebäudeDarstellung (StadtRasseNummerExtern => StadtRasseNummerExtern,
                              IDExtern               => EinheitStadtDatentypen.GebäudeID (XAchseExtern) + 12);
               
      elsif
        YAchseExtern = 3
        and
          XAchseExtern < 3
      then
         GebäudeDarstellung (StadtRasseNummerExtern => StadtRasseNummerExtern,
                              IDExtern               => EinheitStadtDatentypen.GebäudeID (XAchseExtern) + 24);

      else
         FarbgebungKonsole.Farben (EinheitIDExtern    => EinheitenKonstanten.LeerID,
                                   VerbesserungExtern => KartenVerbesserungDatentypen.Leer_Verbesserung_Enum,
                                   WegExtern          => KartenVerbesserungDatentypen.Leer_Weg_Enum,
                                   GrundExtern        => LeseKarten.Grund (KoordinatenExtern => GlobaleVariablen.CursorImSpiel (StadtRasseNummerExtern.Rasse).KoordinatenAktuell),
                                   FlussExtern        => KartenGrundDatentypen.Leer_Fluss_Enum,
                                   RessourceExtern    => KartenGrundDatentypen.Leer_Ressource_Enum,
                                   CursorExtern       => False,
                                   EigeneRasseExtern  => StadtRasseNummerExtern.Rasse,
                                   RasseExtern        => StadtKonstanten.LeerRasse);
      end if;
      
      return False;
      
   end Darstellung;
   
   
   
   procedure GebäudeDarstellung
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      IDExtern : in EinheitStadtDatentypen.GebäudeID)
   is begin
      
      if
        LeseStadtGebaut.GebäudeVorhanden (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                           WelchesGebäudeExtern  => IDExtern)
        = True
      then
         Put (Item => EingeleseneGrafikenKonsole.GebäudeGrafik (StadtRasseNummerExtern.Rasse, IDExtern));

      else
         FarbgebungKonsole.Farben (EinheitIDExtern    => EinheitenKonstanten.LeerID,
                                   VerbesserungExtern => KartenVerbesserungDatentypen.Leer_Verbesserung_Enum,
                                   WegExtern          => KartenVerbesserungDatentypen.Leer_Weg_Enum,
                                   GrundExtern        => LeseKarten.Grund (KoordinatenExtern => GlobaleVariablen.CursorImSpiel (StadtRasseNummerExtern.Rasse).KoordinatenAktuell),
                                   FlussExtern        => KartenGrundDatentypen.Leer_Fluss_Enum,
                                   RessourceExtern    => KartenGrundDatentypen.Leer_Ressource_Enum,
                                   CursorExtern       => False,
                                   EigeneRasseExtern  => StadtRasseNummerExtern.Rasse,
                                   RasseExtern        => StadtKonstanten.LeerRasse);
      end if;
      
   end GebäudeDarstellung;
   
   
   
   procedure CursorDarstellung
     (YAchseExtern : in KartenDatentypen.Stadtfeld;
      XAchseExtern : in KartenDatentypen.Stadtfeld;
      RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      if
        (YAchseExtern < Karten.Stadtkarte'First (1) + 7
         and
           XAchseExtern = Karten.Stadtkarte'Last (2) - 7)
        or
          (YAchseExtern = Karten.Stadtkarte'First (1) + 7
           and
             XAchseExtern >= Karten.Stadtkarte'Last (2) - 7)
      then
         FarbgebungKonsole.Farben  (EinheitIDExtern    => EinheitenKonstanten.LeerID,
                                    VerbesserungExtern => KartenVerbesserungDatentypen.Leer_Verbesserung_Enum,
                                    WegExtern          => KartenVerbesserungDatentypen.Leer_Weg_Enum,
                                    GrundExtern        => KartenGrundDatentypen.Leer_Grund_Enum,
                                    FlussExtern        => KartenGrundDatentypen.Leer_Fluss_Enum,
                                    RessourceExtern    => KartenGrundDatentypen.Leer_Ressource_Enum,
                                    CursorExtern       => True,
                                    EigeneRasseExtern  => RasseExtern,
                                    RasseExtern        => StadtKonstanten.LeerRasse);

      else
         FarbgebungKonsole.Farben  (EinheitIDExtern    => EinheitenKonstanten.LeerID,
                                    VerbesserungExtern => KartenVerbesserungDatentypen.Leer_Verbesserung_Enum,
                                    WegExtern          => KartenVerbesserungDatentypen.Leer_Weg_Enum,
                                    GrundExtern        => LeseKarten.Grund (KoordinatenExtern => GlobaleVariablen.CursorImSpiel (RasseExtern).KoordinatenAktuell),
                                    FlussExtern        => KartenGrundDatentypen.Leer_Fluss_Enum,
                                    RessourceExtern    => KartenGrundDatentypen.Leer_Ressource_Enum,
                                    CursorExtern       => True,
                                    EigeneRasseExtern  => RasseExtern,
                                    RasseExtern        => StadtKonstanten.LeerRasse);
      end if;
      
   end CursorDarstellung;
   
   
   
   procedure AnsichtUmgebung
     (YAchseExtern : in KartenDatentypen.Stadtfeld;
      XAchseExtern : in KartenDatentypen.Stadtfeld;
      StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
   is begin
      
      if
        YAchsenabstraktion < -Stadtumgebungsgröße
        or
          YAchsenabstraktion > Stadtumgebungsgröße
      then
         SchleifeAnsichtUmgebung (YAchseExtern => YAchseExtern,
                                  XAchseExtern => XAchseExtern,
                                  RasseExtern  => StadtRasseNummerExtern.Rasse);

      elsif
        Stadtumgebungsgröße = 1
        and
          YAchseExtern < 3
      then
         SchleifeAnsichtUmgebung (YAchseExtern => YAchseExtern,
                                  XAchseExtern => XAchseExtern,
                                  RasseExtern  => StadtRasseNummerExtern.Rasse);

      elsif
        Stadtumgebungsgröße = 2
        and
          YAchseExtern < 2
      then
         SchleifeAnsichtUmgebung (YAchseExtern => YAchseExtern,
                                  XAchseExtern => XAchseExtern,
                                  RasseExtern  => StadtRasseNummerExtern.Rasse);
                  
      else
         AnzeigeStadtUmgebung (StadtRasseNummerExtern => StadtRasseNummerExtern,
                               YAchseExtern           => YAchseExtern,
                               XAchseExtern           => XAchseExtern);
      end if;
      
   end AnsichtUmgebung;



   procedure SchleifeAnsichtUmgebung
     (YAchseExtern : in KartenDatentypen.Stadtfeld;
      XAchseExtern : in KartenDatentypen.Stadtfeld;
      RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      -- Hier muss nur von 0 .. 6 geloopt werden, da aber Stadtfeld nur von 1 .. 20 geht, wird eins weiter geloopt und im if eins abgezogen
      UmgebungSchleife:
      for UmgebungSchleifenwert in KartenDatentypen.Stadtfeld (1) .. 7 loop
                     
         if
           GlobaleVariablen.CursorImSpiel (RasseExtern).KoordinatenStadt = (YAchseExtern, XAchseExtern + UmgebungSchleifenwert - 1)
         then
            FarbgebungKonsole.Farben  (EinheitIDExtern    => EinheitenKonstanten.LeerID,
                                       VerbesserungExtern => KartenVerbesserungDatentypen.Leer_Verbesserung_Enum,
                                       WegExtern          => KartenVerbesserungDatentypen.Leer_Weg_Enum,
                                       GrundExtern        => KartenGrundDatentypen.Leer_Grund_Enum,
                                       FlussExtern        => KartenGrundDatentypen.Leer_Fluss_Enum,
                                       RessourceExtern    => KartenGrundDatentypen.Leer_Ressource_Enum,
                                       CursorExtern       => True,
                                       EigeneRasseExtern  => RasseExtern,
                                       RasseExtern        => StadtKonstanten.LeerRasse);

         else
            Put (Item => SystemKonstanten.LeerZeichen);
         end if;
                     
      end loop UmgebungSchleife;
      
      New_Line;
      
   end SchleifeAnsichtUmgebung;



   procedure AnzeigeStadtUmgebung
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      YAchseExtern : in KartenDatentypen.Stadtfeld;
      XAchseExtern : in KartenDatentypen.Stadtfeld)
   is begin
      
      UmgebungsSchleife:
      for UmgebungSchleifenwert in KartenDatentypen.UmgebungsbereichDrei'Range loop

         Cursor := CursorKonstant + UmgebungSchleifenwert;
         if
           GlobaleVariablen.CursorImSpiel (StadtRasseNummerExtern.Rasse).KoordinatenStadt = (YAchseExtern, XAchseExtern + Cursor)
         then
            AnzeigeUmgebungCursor (RasseExtern    => StadtRasseNummerExtern.Rasse,
                                   UmgebungExtern => UmgebungSchleifenwert);
                           
         elsif
           UmgebungSchleifenwert < -Stadtumgebungsgröße
           or
             UmgebungSchleifenwert > Stadtumgebungsgröße
         then
            Put (Item => SystemKonstanten.LeerZeichen);

         else            
            KartenWert := KarteKoordinatenPruefen.KarteKoordinatenPrüfen (KoordinatenExtern => GlobaleVariablen.CursorImSpiel (StadtRasseNummerExtern.Rasse).KoordinatenAktuell,
                                                                           ÄnderungExtern    => (0, YAchsenabstraktion, UmgebungSchleifenwert),
                                                                           LogikGrafikExtern => False);
            
            case
              KartenWert.XAchse
            is
               when KartenKonstanten.LeerXAchse =>
                  Put (Item => SystemKonstanten.LeerZeichen);

               when others =>
                  GrafischeAnzeigeKonsole.Sichtbarkeit (InDerStadtExtern  => True,
                                                        KoordinatenExtern => KartenWert,
                                                        RasseExtern       => StadtRasseNummerExtern.Rasse);
            end case;
         end if;

      end loop UmgebungsSchleife;

      New_Line;
      YAchsenabstraktion := YAchsenabstraktion + 1;
      
   end AnzeigeStadtUmgebung;
   
   
   
   procedure AnzeigeUmgebungCursor
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum;
      UmgebungExtern : in KartenDatentypen.UmgebungsbereichDrei)
   is begin
      
      if
        UmgebungExtern < -Stadtumgebungsgröße
        or
          UmgebungExtern > Stadtumgebungsgröße
      then
         FarbgebungKonsole.Farben  (EinheitIDExtern    => EinheitenKonstanten.LeerID,
                                    VerbesserungExtern => KartenVerbesserungDatentypen.Leer_Verbesserung_Enum,
                                    WegExtern          => KartenVerbesserungDatentypen.Leer_Weg_Enum,
                                    GrundExtern        => KartenGrundDatentypen.Leer_Grund_Enum,
                                    FlussExtern        => KartenGrundDatentypen.Leer_Fluss_Enum,
                                    RessourceExtern    => KartenGrundDatentypen.Leer_Ressource_Enum,
                                    CursorExtern       => True,
                                    EigeneRasseExtern  => RasseExtern,
                                    RasseExtern        => StadtKonstanten.LeerRasse);

      else
         InformationenStadtAufrufen := True;
         CursorYAchseabstraktion := GlobaleVariablen.CursorImSpiel (RasseExtern).KoordinatenStadt.YAchse - 4;
         CursorXAchseabstraktion := GlobaleVariablen.CursorImSpiel (RasseExtern).KoordinatenStadt.XAchse - 17;
               
         KartenWert := KarteKoordinatenPruefen.KarteKoordinatenPrüfen (KoordinatenExtern => GlobaleVariablen.CursorImSpiel (RasseExtern).KoordinatenAktuell,
                                                                        ÄnderungExtern    => (0, CursorYAchseabstraktion, CursorXAchseabstraktion),
                                                                        LogikGrafikExtern => False);
         case
           KartenWert.XAchse
         is
            when KartenKonstanten.LeerXAchse =>
               FarbgebungKonsole.Farben  (EinheitIDExtern    => EinheitenKonstanten.LeerID,
                                          VerbesserungExtern => KartenVerbesserungDatentypen.Leer_Verbesserung_Enum,
                                          WegExtern          => KartenVerbesserungDatentypen.Leer_Weg_Enum,
                                          GrundExtern        => KartenGrundDatentypen.Leer_Grund_Enum,
                                          FlussExtern        => KartenGrundDatentypen.Leer_Fluss_Enum,
                                          RessourceExtern    => KartenGrundDatentypen.Leer_Ressource_Enum,
                                          CursorExtern       => True,
                                          EigeneRasseExtern  => RasseExtern,
                                          RasseExtern        => StadtKonstanten.LeerRasse);

            when others =>
               FarbgebungKonsole.Farben  (EinheitIDExtern    => EinheitenKonstanten.LeerID,
                                          VerbesserungExtern => KartenVerbesserungDatentypen.Leer_Verbesserung_Enum,
                                          WegExtern          => KartenVerbesserungDatentypen.Leer_Weg_Enum,
                                          GrundExtern        => LeseKarten.Grund (KoordinatenExtern => KartenWert),
                                          FlussExtern        => KartenGrundDatentypen.Leer_Fluss_Enum,
                                          RessourceExtern    => KartenGrundDatentypen.Leer_Ressource_Enum,
                                          CursorExtern       => True,
                                          EigeneRasseExtern  => RasseExtern,
                                          RasseExtern        => StadtKonstanten.LeerRasse);
         end case;
      end if;
      
   end AnzeigeUmgebungCursor;
   
   
   
   procedure WeitereInformationen
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
   is begin

      CursorYAchseabstraktion := GlobaleVariablen.CursorImSpiel (StadtRasseNummerExtern.Rasse).KoordinatenStadt.YAchse - 4;
      CursorXAchseabstraktion := GlobaleVariablen.CursorImSpiel (StadtRasseNummerExtern.Rasse).KoordinatenStadt.XAchse - 17;
      
      KartenWert := KarteKoordinatenPruefen.KarteKoordinatenPrüfen (KoordinatenExtern => GlobaleVariablen.CursorImSpiel (StadtRasseNummerExtern.Rasse).KoordinatenAktuell,
                                                                     ÄnderungExtern    => (0, CursorYAchseabstraktion, CursorXAchseabstraktion),
                                                                     LogikGrafikExtern => False);
      
      case
        KartenWert.XAchse
      is
         when KartenKonstanten.LeerXAchse =>
            return;

         when others =>
            null;
      end case;
      
      case
        LeseKarten.Hügel (KoordinatenExtern => KartenWert)
      is
         when True =>
            TextAnzeigeKonsole.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleTexte.Leer,
                                                      TextDateiExtern        => GlobaleTexte.Beschreibungen_Kartenfelder_Kurz,
                                                      ÜberschriftZeileExtern => 0,
                                                      ErsteZeileExtern       => 34,
                                                      LetzteZeileExtern      => 34,
                                                      AbstandAnfangExtern    => GlobaleTexte.Leer,
                                                      AbstandMitteExtern     => GlobaleTexte.Leer,
                                                      AbstandEndeExtern      => GlobaleTexte.Leer);
         
         when False =>
            null;
      end case;
      
      -- Hier sollte eine Überprüfung ob der Grund nicht Leer ist nicht nötig sein, da weiter oben bereits geprüft wir ob das eine gültige Koordinate ist.
      Put (Item => KartenAllgemein.BeschreibungGrund (KartenGrundExtern => LeseKarten.Grund (KoordinatenExtern => KartenWert)));
      
      StadtInformationenKonsole.EinzelnesFeldNahrungsgewinnung (KoordinatenExtern => KartenWert,
                                                                RasseExtern       => StadtRasseNummerExtern.Rasse);
      StadtInformationenKonsole.EinzelnesFeldRessourcengewinnung (KoordinatenExtern => KartenWert,
                                                                  RasseExtern       => StadtRasseNummerExtern.Rasse);
      StadtInformationenKonsole.EinzelnesFeldGeldgewinnung (KoordinatenExtern => KartenWert,
                                                            RasseExtern       => StadtRasseNummerExtern.Rasse);
      StadtInformationenKonsole.EinzelnesFeldWissensgewinnung (KoordinatenExtern => KartenWert,
                                                               RasseExtern       => StadtRasseNummerExtern.Rasse);
      StadtInformationenKonsole.StadtfeldBewirtschaftet (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                                         CursorYAchseabstraktionExtern => CursorYAchseabstraktion,
                                                         CursorXAchseabstraktionExtern => CursorXAchseabstraktion);
      
   end WeitereInformationen;

end KarteStadtKonsole;
