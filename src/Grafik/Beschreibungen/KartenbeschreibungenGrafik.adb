with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

with Kartentexte;

-- Später die Beschreibungen noch um RasseExtern erweitern damit jede Rasse ihren eigenen Text haben kann? äöü
-- Gilt auch für alle anderen Beschreibungen die noch nicht rassenspezifisch sind. äöü
package body KartenbeschreibungenGrafik is

   function KurzbeschreibungBasisgrund
     (KartenGrundExtern : in KartengrundDatentypen.Basisgrund_Vorhanden_Enum)
      return Wide_Wide_String
   is begin
   
      return To_Wide_Wide_String (Source => Kartentexte.Basisgrund (2 * KartengrundDatentypen.Basisgrund_Vorhanden_Enum'Pos (KartenGrundExtern) - 1));
      
   end KurzbeschreibungBasisgrund;
   
   
   
   function LangbeschreibungBasisgrund
     (KartenGrundExtern : in KartengrundDatentypen.Basisgrund_Vorhanden_Enum)
      return Wide_Wide_String
   is begin
   
      return To_Wide_Wide_String (Source => Kartentexte.Basisgrund (2 * KartengrundDatentypen.Basisgrund_Vorhanden_Enum'Pos (KartenGrundExtern)));
      
   end LangbeschreibungBasisgrund;
   


   function KurzbeschreibungZusatzgrund
     (KartenGrundExtern : in KartengrundDatentypen.Zusatzgrund_Vorhanden_Enum)
      return Wide_Wide_String
   is begin
   
      return To_Wide_Wide_String (Source => Kartentexte.Zusatzgrund (2 * KartengrundDatentypen.Zusatzgrund_Vorhanden_Enum'Pos (KartenGrundExtern) - 1));
      
   end KurzbeschreibungZusatzgrund;
   


   function LangbeschreibungZusatzgrund
     (KartenGrundExtern : in KartengrundDatentypen.Zusatzgrund_Vorhanden_Enum)
      return Wide_Wide_String
   is begin
   
      return To_Wide_Wide_String (Source => Kartentexte.Zusatzgrund (2 * KartengrundDatentypen.Zusatzgrund_Vorhanden_Enum'Pos (KartenGrundExtern)));
      
   end LangbeschreibungZusatzgrund;
   
   
   
   function KurzbeschreibungFluss
     (KartenFlussExtern : in KartengrundDatentypen.Kartenfluss_Vorhanden_Enum)
      return Wide_Wide_String
   is begin
      
      return To_Wide_Wide_String (Source => Kartentexte.Kartenflüsse (2 * KartengrundDatentypen.Kartenfluss_Vorhanden_Enum'Pos (KartenFlussExtern) - 1));
      
   end KurzbeschreibungFluss;
   
   
   
   function LangbeschreibungFluss
     (KartenFlussExtern : in KartengrundDatentypen.Kartenfluss_Vorhanden_Enum)
      return Wide_Wide_String
   is begin
      
      return To_Wide_Wide_String (Source => Kartentexte.Kartenflüsse (2 * KartengrundDatentypen.Kartenfluss_Vorhanden_Enum'Pos (KartenFlussExtern)));
      
   end LangbeschreibungFluss;
   
   
   
   function KurzbeschreibungRessource
     (KartenRessourceExtern : in KartengrundDatentypen.Kartenressourcen_Vorhanden_Enum)
      return Wide_Wide_String
   is begin
   
      return To_Wide_Wide_String (Source => Kartentexte.Kartenressourcen (2 * KartengrundDatentypen.Kartenressourcen_Vorhanden_Enum'Pos (KartenRessourceExtern) - 1));
      
   end KurzbeschreibungRessource;
   
   
   
   function LangbeschreibungRessource
     (KartenRessourceExtern : in KartengrundDatentypen.Kartenressourcen_Vorhanden_Enum)
      return Wide_Wide_String
   is begin
   
      return To_Wide_Wide_String (Source => Kartentexte.Kartenressourcen (2 * KartengrundDatentypen.Kartenressourcen_Vorhanden_Enum'Pos (KartenRessourceExtern)));
      
   end LangbeschreibungRessource;

end KartenbeschreibungenGrafik;
