with ForschungenDatentypen;
with EinheitenDatentypen;
with KampfDatentypen;
with EinheitenRecords;
with EinheitendatenbankRecord;
with SystemRecords;
with KartengrundDatentypen;
with KartenRecordKonstanten;

package DebugobjekteLogik is
   use type ForschungenDatentypen.ForschungIDNichtMöglich;

   Debug : SystemRecords.DebugRecord := (others => True);

   Alleskönner : constant EinheitendatenbankRecord.EinheitenlisteRecord := (
                                                                             Einheitenart            => EinheitenDatentypen.Cheat_Enum,
                                                                             PreisGeld               => 1,
                                                                             Produktionskosten       => 1,
                                                                             PermanenteKosten        => (others => 0),
                                                                             Anforderungen           => -1,
                                                                             Passierbarkeit          => (others => True),
                                                                             MaximaleLebenspunkte    => EinheitenDatentypen.VorhandeneLebenspunkte'Last,
                                                                             MaximaleBewegungspunkte => EinheitenDatentypen.VorhandeneBewegungspunkte'Last,
                                                                             VerbesserungZu          => 0,
                                                                             Beförderungsgrenze      => 1,
                                                                             MaximalerRang           => KampfDatentypen.RangVorhanden'Last,
                                                                             Reichweite              => KampfDatentypen.ReichweiteVorhanden'Last,
                                                                             Angriff                 => KampfDatentypen.KampfwerteEinheiten'Last,
                                                                             Verteidigung            => KampfDatentypen.KampfwerteEinheiten'Last,
                                                                             KannTransportieren      => EinheitenDatentypen.Gigantisch_Transport_Enum,
                                                                             KannTransportiertWerden => EinheitenDatentypen.Klein_Transport_Enum,
                                                                             Transportkapazität      => EinheitenRecords.TransporterArray'Last,
                                                                             Zusatzeffekt            => KartengrundDatentypen.Leer_Effekt_Enum,
                                                                             Effektreichweite        => KartenRecordKonstanten.LeerEffektbereich
                                                                            );

end DebugobjekteLogik;
