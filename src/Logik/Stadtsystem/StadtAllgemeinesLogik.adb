pragma Warnings (Off, "*array aggregate*");

with SchreibeStadtGebaut;

with TexteingabeLogik;

package body StadtAllgemeinesLogik is

   procedure NeuerStadtname
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord)
   is begin
      
      NeuerName := TexteingabeLogik.StadtName (StadtRasseNummerExtern => StadtRasseNummerExtern);
               
      case
        NeuerName.ErfolgreichAbbruch
      is
         when True =>
            SchreibeStadtGebaut.Name (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                      NameExtern             => NeuerName.EingegebenerText);
            
         when False =>
            null;
      end case;
        
   end NeuerStadtname;

end StadtAllgemeinesLogik;
