pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with TonDatentypen;

package NachSoundtask is

   AktuellerSound : TonDatentypen.Sound_Aktuelle_Auswahl_Enum := TonDatentypen.Sound_SFML_Enum;

end NachSoundtask;