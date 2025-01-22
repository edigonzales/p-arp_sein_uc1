# p-arp_sein_uc1

```
java -jar /Users/stefan/apps/ili2duckdb-5.2.2-SNAPSHOT/ili2duckdb-5.2.2-SNAPSHOT.jar --dbfile sein_konfig.duckdb --defaultSrsCode 2056 --nameByTopic --strokeArcs --createEnumTabs --coalesceJson --smart2Inheritance --models SO_ARP_SEin_Konfiguration_20250115 --modeldir ".;https://models.geo.admin.ch" --dbschema arp_sein_konfig --schemaimport
```

```
java -jar /Users/stefan/apps/ili2duckdb-5.2.2-SNAPSHOT/ili2duckdb-5.2.2-SNAPSHOT.jar --dbfile sein_konfig.duckdb --models SO_ARP_SEin_Konfiguration_20250115 --modeldir ".;https://models.geo.admin.ch" --dbschema arp_sein_konfig --export sein_konfig.xtf
```

```
java -jar /Users/stefan/apps/ili2gpkg-5.2.1/ili2gpkg-5.2.1.jar --dbfile sein_konfig_relational.gpkg --defaultSrsCode 2056 --strokeArcs --nameByTopic --createEnumTabs --smart1Inheritance --models SO_ARP_SEin_Konfiguration_20250115 --modeldir ".;https://models.geo.admin.ch" --doSchemaImport --import sein_konfig_auswertung.xtf
```

```
java -jar /Users/stefan/apps/ili2gpkg-5.2.1/ili2gpkg-5.2.1.jar --dbfile sein_konfig_json.gpkg --defaultSrsCode 2056 --strokeArcs --nameByTopic --createEnumTabs --smart2Inheritance --coalesceJson --iliMetaAttrs metaattrs.ini --createMetaInfo --models SO_ARP_SEin_Konfiguration_20250115 --modeldir ".;https://models.geo.admin.ch" --doSchemaImport --import sein_konfig_auswertung.xtf
```