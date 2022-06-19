pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with EinheitenDatentypen; use EinheitenDatentypen;
with KartenDatentypen; use KartenDatentypen;
with EinheitenKonstanten;

with KIKonstanten;

with SchreibeEinheitenGebaut;
with LeseEinheitenGebaut;

with BewegungBerechnen;
with EinheitSuchen;
with KampfsystemEinheiten;
with StadtSuchen;
with KampfsystemStadt;

with KIBewegungBerechnen;
with KIBewegungAllgemein;

package body KIBewegungDurchfuehren is
   
   procedure KIBewegungNeu
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
   is begin
      
      BewegungSchleife:
      loop
         
         if
           LeseEinheitenGebaut.Koordinaten (EinheitRasseNummerExtern => EinheitRasseNummerExtern) = LeseEinheitenGebaut.KIZielKoordinaten (EinheitRasseNummerExtern => EinheitRasseNummerExtern)
         then
            SpielVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Nummer).KIZielKoordinaten := KIKonstanten.LeerKoordinate;
            SpielVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Nummer).KIBewegungPlan := (others => KIKonstanten.LeerKoordinate);
            return;
            
         elsif
           LeseEinheitenGebaut.Bewegungspunkte (EinheitRasseNummerExtern => EinheitRasseNummerExtern) = EinheitenKonstanten.LeerBewegungspunkte
         then
            return;
            
         elsif
           LeseEinheitenGebaut.KIBewegungPlan (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                               PlanschrittExtern        => 1)
           = KIKonstanten.LeerKoordinate
         then
            case
              KIBewegungBerechnen.BewegungPlanen (EinheitRasseNummerExtern => EinheitRasseNummerExtern)
            is
               when True =>
                  null;
                  
               when False =>
                  return;
            end case;
            
         else
            BewegungDurchführen (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
         end if;
         
      end loop BewegungSchleife;
      
   end KIBewegungNeu;



   procedure BewegungDurchführen
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
   is begin
      
      NeuePosition := LeseEinheitenGebaut.KIBewegungPlan (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                          PlanschrittExtern        => 1);
      
      case
        KIBewegungAllgemein.FeldBetreten (FeldKoordinatenExtern    => NeuePosition,
                                          EinheitRasseNummerExtern => EinheitRasseNummerExtern)
      is
         when KIKonstanten.BewegungNormal =>
            BewegtSich (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
            
         when KIKonstanten.KeineBewegung =>
            SpielVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Nummer).KIBewegungPlan := (others => KIKonstanten.LeerKoordinate);
            
         when KIKonstanten.BewegungAngriff =>
            Blockiert (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      end case;
      
   end BewegungDurchführen;
   
   
   
   procedure BewegtSich
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
   is begin
      
      BewegungBerechnen.BewegungEinheitenBerechnung (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                     NeueKoordinatenExtern    => LeseEinheitenGebaut.KIBewegungPlan (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                                                                                     PlanschrittExtern        => 1));
      BewegungPlanVerschiebenSchleife:
      for PositionSchleifenwert in EinheitenRecords.KIBewegungPlanArray'First + 1 .. EinheitenRecords.KIBewegungPlanArray'Last loop
               
         SchreibeEinheitenGebaut.KIBewegungPlan (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                 KoordinatenExtern        => LeseEinheitenGebaut.KIBewegungPlan (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                                                                                 PlanschrittExtern        => PositionSchleifenwert),
                                                 PlanplatzExtern          => (PositionSchleifenwert - 1));
         
      end loop BewegungPlanVerschiebenSchleife;
            
      SchreibeEinheitenGebaut.KIBewegungPlan (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                              KoordinatenExtern        => KIKonstanten.LeerKoordinate,
                                              PlanplatzExtern          => EinheitenRecords.KIBewegungPlanArray'Last);
      
   end BewegtSich;
   
   
   
   procedure Blockiert
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
   is begin
      
      FremdeEinheit := EinheitSuchen.KoordinatenEinheitOhneRasseSuchen (KoordinatenExtern => NeuePosition);
      FremdeStadt := StadtSuchen.KoordinatenStadtOhneRasseSuchen (KoordinatenExtern => NeuePosition);
            
      if
        FremdeStadt.Rasse = EinheitenKonstanten.LeerRasse
      then
         case
           KampfsystemEinheiten.KampfsystemNahkampf (AngreiferExtern   => EinheitRasseNummerExtern,
                                                     VerteidigerExtern => FremdeEinheit)
         is
            when True =>
               BewegtSich (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
              
            when False =>
               null;
         end case;
         
      else
         case
           KampfsystemStadt.KampfsystemStadt (AngreifendeEinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                              VerteidigendeStadtRasseNummerExtern => FremdeStadt)
         is
            when True =>
               BewegtSich (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
              
            when False =>
               null;
         end case;
      end if;
         
   end Blockiert;

end KIBewegungDurchfuehren;
