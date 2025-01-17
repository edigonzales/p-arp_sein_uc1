INSTALL postgres;
LOAD postgres;

INSTALL spatial;
LOAD spatial;

ATTACH 'dbname=pub user=bjsvwzie password=333S.pellegrino host=geodb.rootso.org' AS pubdb (TYPE POSTGRES, READ_ONLY);

DELETE FROM
    arp_sein_konfig.grundlagen_gemeinde
;

/**
 * Ggf. ist es sinnvoller mit postgres_query() eine native postgis-Query 
 * auszuführen und dann ST_GeomFromWKB. Ob untenstehendes Verhalten
 * on purpose ist, weiss ich nicht.
 */
INSERT INTO
    arp_sein_konfig.grundlagen_gemeinde
    (
        aname,
        bfsnr,
        geometrie
    )
SELECT
    gemeindename,
    bfs_gemeindenummer,
    ST_GeomFromHEXWKB(geometrie)
FROM 
    pubdb.agi_hoheitsgrenzen_pub.hoheitsgrenzen_gemeindegrenze
;

