with Ada.Wide_Wide_Text_IO; use Ada.Wide_Wide_Text_IO;

with AufgabenDatentypen;
with TextnummernKonstanten;

with LeseEinheitenGebaut;
with LeseEinheitenDatenbank;
with LeseWeltkarte;
with LeseForschungenDatenbank;

with ForschungstestsLogik;
with AufgabenAllgemeinLogik;
with WegErmittelnLogik;
with MineErmittelnLogik;
with RodenErmittelnLogik;
with FarmErmittelnLogik;
with FestungErmittelnLogik;
with WaldErmittelnLogik;
with EinheitHeilenLogik;
with VerbesserungPluendernLogik;
with EinheitVerbessernLogik;
with EinheitVerschanzenLogik;
with EinheitAufloesenLogik;
with UmwandlungenVerschiedeneDatentypen;
with JaNeinLogik;
with MeldungFestlegenLogik;
with NachGrafiktask;

package body AufgabenLogik is
   
   function AufgabeTesten
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord;
      BefehlExtern : in BefehleDatentypen.Einheiten_Aufgaben_Baulos_Enum;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
      return Boolean
   is begin
      
      case
        Anfangstest (SpeziesExtern        => EinheitSpeziesNummerExtern.Spezies,
                     EinheitartExtern   => LeseEinheitenDatenbank.Einheitenart (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies,
                                                                                IDExtern    => LeseEinheitenGebaut.ID (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern)),
                     BefehlExtern       => BefehlExtern,
                     VerbesserungExtern => LeseWeltkarte.Verbesserung (KoordinatenExtern => KoordinatenExtern))
      is
         when True =>
            return AufgabeFestlegen (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                                     BefehlExtern             => BefehlExtern,
                                     AnlegenTestenExtern      => False,
                                     KoordinatenExtern        => KoordinatenExtern);
            
         when False =>
            return False;
      end case;
      
   end AufgabeTesten;
   
   
   
   function Aufgabe
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord;
      BefehlExtern : in BefehleDatentypen.Einheiten_Aufgaben_Baulos_Enum;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
      return Boolean
   is
      use type AufgabenDatentypen.Einheiten_Aufgaben_Enum;
   begin
      
      case
        Anfangstest (SpeziesExtern        => EinheitSpeziesNummerExtern.Spezies,
                     EinheitartExtern   => LeseEinheitenDatenbank.Einheitenart (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies,
                                                                                IDExtern    => LeseEinheitenGebaut.ID (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern)),
                     BefehlExtern       => BefehlExtern,
                     VerbesserungExtern => LeseWeltkarte.Verbesserung (KoordinatenExtern => KoordinatenExtern))
      is
         when True =>
            null;
            
         when False =>
            return False;
      end case;
     
      -- Kann dieser Fall so noch auftreten? äöü
      if
        LeseEinheitenGebaut.Beschäftigung (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern) /= EinheitenKonstanten.LeerBeschäftigung
        and
          LeseSpeziesbelegung.Belegung (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies) /= SpeziesDatentypen.KI_Spieler_Enum
      then
         case
           JaNeinLogik.JaNein (FrageZeileExtern => TextnummernKonstanten.FrageBeschäftigungAbbrechen)
         is
            when True =>
               null;
               
            when False =>
               Put_Line ("Prüfung ob das hier jemals aufgerufen wird oder entfernt werden kann.");
               NachGrafiktask.AktuelleEinheit := EinheitenKonstanten.LeerNummer;
               return False;
         end case;
         
      else
         null;
      end if;
      
      return AufgabeFestlegen (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                               BefehlExtern             => BefehlExtern,
                               AnlegenTestenExtern      => True,
                               KoordinatenExtern        => KoordinatenExtern);
   
   end Aufgabe;
   
   
   
   function Anfangstest
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
      EinheitartExtern : in EinheitenDatentypen.Einheitart_Vorhanden_Enum;
      BefehlExtern : in BefehleDatentypen.Einheiten_Aufgaben_Baulos_Enum;
      VerbesserungExtern : in KartenverbesserungDatentypen.Karten_Verbesserung_Enum)
      return Boolean
   is
      use type EinheitenDatentypen.Einheitart_Enum;
      use type BefehleDatentypen.Einheitenbelegung_Enum;
      use type KartenverbesserungDatentypen.Karten_Verbesserung_Enum;
   begin
      
      if
        BefehlExtern in BefehleDatentypen.Siedler_Verbesserung_Enum'Range
        and
          EinheitartExtern /= EinheitenDatentypen.Arbeiter_Enum
      then
         MeldungFestlegenLogik.SpielermeldungFestlegen (MeldungExtern => TextnummernKonstanten.MeldungBefehl,
                                                        SpeziesExtern   => SpeziesExtern);
         return False;
         
      elsif
        BefehlExtern = BefehleDatentypen.Plündern_Enum
        and
          EinheitartExtern = EinheitenDatentypen.Arbeiter_Enum
      then
         MeldungFestlegenLogik.SpielermeldungFestlegen (MeldungExtern => TextnummernKonstanten.MeldungBefehl,
                                                        SpeziesExtern   => SpeziesExtern);
         return False;
         
      else
         null;
      end if;
      
      case
        BefehlExtern
      is
         when BefehleDatentypen.Siedler_Verbesserung_Enum'Range =>
            VerbesserungErforscht := ForschungstestsLogik.TechnologieVorhanden (SpeziesExtern       => SpeziesExtern,
                                                                                TechnologieExtern => LeseForschungenDatenbank.Verbesserungen (VerbesserungExtern => BefehlExtern,
                                                                                                                                              SpeziesExtern        => SpeziesExtern));
            
            if
              VerbesserungErforscht = False
              and
                LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) = SpeziesDatentypen.Mensch_Spieler_Enum
            then
               MeldungFestlegenLogik.SpielermeldungFestlegen (MeldungExtern => TextnummernKonstanten.MeldungVerbesserungTechnologie,
                                                              SpeziesExtern   => SpeziesExtern);
               return False;
               
            elsif
              VerbesserungErforscht = False
            then
               return False;
               
            else
               null;
            end if;
            
         when others =>
            null;
      end case;
      
      -- Das hier immer berücksichtigen bei einer Änderung von Tastenbelegung_Konstruktionen_Enum.
      case
        BefehlExtern
      is
         when BefehleDatentypen.Siedler_Konstruktionen_Enum'Range =>
            if
              VerbesserungExtern in KartenverbesserungDatentypen.Karten_Verbesserung_Städte_Enum'Range
            then
               MeldungFestlegenLogik.SpielermeldungFestlegen (MeldungExtern => TextnummernKonstanten.MeldungVerbesserung,
                                                              SpeziesExtern   => SpeziesExtern);
               return False;
               
            elsif
              VerbesserungExtern = UmwandlungenVerschiedeneDatentypen.BefehleNachKartenverbesserung (TasteExtern => BefehlExtern)
            then
               MeldungFestlegenLogik.SpielermeldungFestlegen (MeldungExtern => TextnummernKonstanten.MeldungVerbesserungExistiert,
                                                              SpeziesExtern   => SpeziesExtern);
               return False;
               
            elsif
              (LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) = SpeziesDatentypen.Mensch_Spieler_Enum
               and
                 VerbesserungExtern /= KartenverbesserungDatentypen.Leer_Verbesserung_Enum)
              and then
                JaNeinLogik.JaNein (FrageZeileExtern => TextnummernKonstanten.FrageLandverbesserungErsetzen) = False
            then
               return False;
               
            else
               null;
            end if;
            
         when others =>
            null;
      end case;
      
      return True;
                  
   end Anfangstest;
   


   function AufgabeFestlegen
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord;
      BefehlExtern : in BefehleDatentypen.Einheiten_Aufgaben_Baulos_Enum;
      AnlegenTestenExtern : in Boolean;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
      return Boolean
   is begin
      
      AufgabenAllgemeinLogik.Nullsetzung (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern);
      
      case
        BefehlExtern
      is
         when BefehleDatentypen.Straße_Bauen_Enum =>
            return WegErmittelnLogik.WegErmitteln (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                                                   AnlegenTestenExtern      => AnlegenTestenExtern,
                                                   KoordinatenExtern        => KoordinatenExtern);
         
         when BefehleDatentypen.Mine_Bauen_Enum =>
            return MineErmittelnLogik.MineErmitteln (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                                                     AnlegenTestenExtern      => AnlegenTestenExtern,
                                                     KoordinatenExtern        => KoordinatenExtern);
            
         when BefehleDatentypen.Farm_Bauen_Enum =>
            return FarmErmittelnLogik.FarmErmitteln (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                                                     AnlegenTestenExtern      => AnlegenTestenExtern,
                                                     KoordinatenExtern        => KoordinatenExtern);
            
         when BefehleDatentypen.Festung_Bauen_Enum =>
            return FestungErmittelnLogik.FestungErmitteln (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                                                           AnlegenTestenExtern      => AnlegenTestenExtern,
                                                           KoordinatenExtern        => KoordinatenExtern);
            
         when BefehleDatentypen.Wald_Aufforsten_Enum =>
            return WaldErmittelnLogik.WaldErmitteln (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                                                     AnlegenTestenExtern      => AnlegenTestenExtern,
                                                     KoordinatenExtern        => KoordinatenExtern);
         
         when BefehleDatentypen.Roden_Trockenlegen_Enum =>
            return RodenErmittelnLogik.RodenErmitteln (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                                                       AnlegenTestenExtern      => AnlegenTestenExtern,
                                                       KoordinatenExtern        => KoordinatenExtern);
         
         when BefehleDatentypen.Heilen_Enum =>
            return EinheitHeilenLogik.EinheitHeilen (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                                                     AnlegenTestenExtern      => AnlegenTestenExtern);
            
         when BefehleDatentypen.Verschanzen_Enum =>
            return EinheitVerschanzenLogik.Verschanzen (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern);
         
         when BefehleDatentypen.Auflösen_Enum =>
            return EinheitAufloesenLogik.EinheitAuflösen (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern);
         
         when BefehleDatentypen.Plündern_Enum =>
            return VerbesserungPluendernLogik.VerbesserungPlündern (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                                                                     AnlegenTestenExtern      => AnlegenTestenExtern,
                                                                     KoordinatenExtern        => KoordinatenExtern);
         
         when BefehleDatentypen.Einheit_Verbessern_Enum =>
            return EinheitVerbessernLogik.VerbesserungEinheit (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                                                               AnlegenTestenExtern      => AnlegenTestenExtern);
      end case;
      
   end AufgabeFestlegen;

end AufgabenLogik;
