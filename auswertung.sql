DROP TABLE IF EXISTS auswertung;
CREATE TEMP TABLE auswertung AS 
WITH objektinfos AS 
(
    SELECT 
        gem.aname AS gemeinde_name,
        gr.aname AS gruppe_name,
        t.aname AS thema_name,
        JSON_GROUP_ARRAY(
            JSON_OBJECT(
                '@type', 'SO_ARP_SEin_Konfiguration_20250115.Objektinfo',
                'Information', o.information,
                'Link', o.link
            )    
        ) AS objektinfos
    FROM 
        arp_sein_konfig.grundlagen_objektinfo AS o
        LEFT JOIN arp_sein_konfig.grundlagen_gemeinde_objektinfo AS gemobj
        ON o.T_Id = gemobj.objektinfo_r
        LEFT JOIN arp_sein_konfig.grundlagen_gemeinde AS gem 
        ON gem.T_Id = gemobj.gemeinde_r 
        LEFT JOIN arp_sein_konfig.grundlagen_thema AS t 
        ON t.T_Id = o.thema_r
        LEFT JOIN arp_sein_konfig.grundlagen_gruppe AS gr 
        ON gr.T_Id = t.gruppe_r
    GROUP BY 
        gem.aname,
        gr.aname,
        t.aname 
)
,
objektinfos_by_gemeinde_gruppe_thema AS (
    SELECT
        o.gemeinde_name,
        o.gruppe_name,
        o.thema_name,
        JSON_OBJECT(
            '@type', 'SO_ARP_SEin_Konfiguration_20250115.Auswertung.Thema',
            'Name', thema_name,
            'LayerId', t.layerid,
            'ist_betroffen', true,
            'Objektinfos', o.objektinfos
        ) AS thema
    FROM 
        objektinfos AS o 
        LEFT JOIN arp_sein_konfig.grundlagen_thema AS t 
        ON t.aname = o.thema_name
)
,
-- Das ändert sich noch, aber vom Prinzip her geht es 
-- in diese Richtung.
themen_nicht_betroffen AS (
    SELECT 
        gem.aname AS gemeinde_name,
        gr.aname AS gruppe_name,
        t.aname AS thema_name,        
        JSON_OBJECT(
            '@type', 'SO_ARP_SEin_Konfiguration_20250115.Auswertung.Thema',
            'Name', t.aname,
            'LayerId', t.layerid,
            'ist_betroffen', false
        ) AS thema
    FROM 
        arp_sein_konfig.grundlagen_gemeinde AS gem,
        arp_sein_konfig.grundlagen_thema AS t
        LEFT JOIN arp_sein_konfig.grundlagen_gruppe AS gr 
        ON t.gruppe_r = gr.T_Id
    WHERE 
        NOT EXISTS (
            SELECT
                1 
            FROM
                objektinfos_by_gemeinde_gruppe_thema AS oggt 
            WHERE 
                t.aname = oggt.thema_name AND gem.aname = oggt.gemeinde_name
        )
)
,
alle_themen_pro_gemeinde_gruppe_thema AS (
    SELECT 
        * 
    FROM 
        objektinfos_by_gemeinde_gruppe_thema
    UNION ALL
    SELECT 
        * 
    FROM 
        themen_nicht_betroffen
    WHERE 
        -- zwecks Übersicht
        gemeinde_name = 'Solothurn'
)
,
alle_themen_pro_gemeinde_gruppe AS (
    SELECT 
        gemeinde_name,
        gruppe_name,
        JSON_GROUP_ARRAY(
            thema
        ) AS themen
    FROM 
        alle_themen_pro_gemeinde_gruppe_thema
    GROUP BY 
        gemeinde_name,
        gruppe_name
)
SELECT 
    gemeinde_name AS aname,
    ge.bfsnr,
    '['||ST_XMin(geometrie)||','||ST_YMin(geometrie)||','||ST_XMax(geometrie)||','||ST_YMax(geometrie)||']' AS boundingbox,
    JSON_GROUP_ARRAY(
        JSON_OBJECT(
            '@type', 'SO_ARP_SEin_Konfiguration_20250115.Auswertung.Gruppe',
            'Name', gruppe_name,
            'Themen', themen
        )     
    ) AS gruppen,
    ge.geometrie
FROM 
    alle_themen_pro_gemeinde_gruppe AS tpgg
    LEFT JOIN arp_sein_konfig.grundlagen_gemeinde AS ge 
    ON tpgg.gemeinde_name = ge.aname
GROUP BY 
    gemeinde_name,
    ge.bfsnr,
    boundingbox,
    ge.geometrie
;

DELETE FROM 
    arp_sein_konfig.auswertung_gemeinde
;
INSERT INTO 
    arp_sein_konfig.auswertung_gemeinde 
    (
        boundingbox,
        gruppen,
        aname,
        bfsnr,
        geometrie
    )
    SELECT 
        boundingbox,
        gruppen,
        aname,
        bfsnr,
        geometrie
    FROM 
        auswertung
;