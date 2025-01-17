# p-arp_sein_uc1

```
java -jar /Users/stefan/apps/ili2duckdb-5.2.2-SNAPSHOT/ili2duckdb-5.2.2-SNAPSHOT.jar --dbfile sein_konfig.duckdb --defaultSrsCode 2056 --nameByTopic --strokeArcs --createEnumTabs --coalesceJson --smart2Inheritance --models SO_ARP_SEin_Konfiguration_20250115 --modeldir ".;https://models.geo.admin.ch" --dbschema arp_sein_konfig --schemaimport
```

```
java -jar /Users/stefan/apps/ili2duckdb-5.2.2-SNAPSHOT/ili2duckdb-5.2.2-SNAPSHOT.jar --dbfile sein_konfig.duckdb --models SO_ARP_SEin_Konfiguration_20250115 --modeldir ".;https://models.geo.admin.ch" --dbschema arp_sein_konfig --export sein_konfig.xtf
```