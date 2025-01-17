
WITH objektinfo_by_gemeinde_thema AS 
(
    SELECT 
        gem.aname AS gem_name,
        t.aname AS thema_name,
        JSON_GROUP_ARRAY(
            JSON_OBJECT(
                '@Type', 'SO_ARP_SEin_Konfiguration_20250115.Objektinfo',
                'Information', o.information,
                'Link', o.link
            )    
        )
    FROM 
        arp_sein_konfig.grundlagen_objektinfo AS o
        LEFT JOIN arp_sein_konfig.grundlagen_gemeinde_objektinfo AS gemobj
        ON o.T_Id = gemobj.objektinfo_r
        LEFT JOIN arp_sein_konfig.grundlagen_gemeinde AS gem 
        ON gem.T_Id = gemobj.gemeinde_r 
        LEFT JOIN arp_sein_konfig.grundlagen_thema AS t 
        ON t.T_Id = o.thema_r
    GROUP BY 
        gem.aname,
        t.aname 
)

SELECT * FROM objektinfo_grouped

-- Auch Thema gruppieren nach gemeinde. Dann sollte ich 106 Zeilen haben oder so.

;

/*
DELETE FROM 
    arp_sein_konfig.auswertung_gemeinde
;


SELECT 
    *
FROM 
    arp_sein_konfig.grundlagen_objektinfo AS o
    LEFT JOIN arp_sein_konfig.grundlagen_gemeinde_objektinfo AS geo
    ON o.T_Id = geo.objektinfo_r 
WHERE 



SELECT 
    g.aname,
    JSON_GROUP_ARRAY(
        JSON_OBJECT(
            '@Type', 'SO_ARP_SEin_Konfiguration_20250115.Auswertung.Thema',
            'Name', t.aname,
            'LayerId', t.layerid
        )
    )
FROM 
    arp_sein_konfig.grundlagen_thema AS t
    LEFT JOIN arp_sein_konfig.grundlagen_gruppe AS g 
    ON t.gruppe_r = g.T_Id 
GROUP BY
    g.aname 
;


INSERT INTO
    arp_sein_konfig.auswertung_gemeinde
    (
        aname,
        boundingbox,
        bfsnr,
        geometrie,
        gruppen
    )

SELECT 
    ge.aname,
    --'['||ST_XMin(geometrie)||','||ST_YMin(geometrie)||','||ST_XMax(geometrie)||','||ST_YMax(geometrie)||']' AS bbox,
    ge.bfsnr,
    ge.geometrie,
    JSON_GROUP_ARRAY(
        JSON_OBJECT(
            '@type', 'SO_ARP_SEin_Konfiguration_20250115.Auswertung.Gruppe',
            'Name', gr.aname,
            'Themen', t.themen
        )    
    )
FROM    
    arp_sein_konfig.grundlagen_gemeinde AS ge,
    arp_sein_konfig.grundlagen_gruppe AS gr
    LEFT JOIN 
    (
        SELECT 
            g.aname,
            JSON_GROUP_ARRAY(
                JSON_OBJECT(
                    '@Type', 'SO_ARP_SEin_Konfiguration_20250115.Auswertung.Thema',
                    'Name', t.aname,
                    'LayerId', t.layerid
                )
            ) AS themen
        FROM 
            arp_sein_konfig.grundlagen_thema AS t
            LEFT JOIN arp_sein_konfig.grundlagen_gruppe AS g 
            ON t.gruppe_r = g.T_Id 
        GROUP BY
            g.aname 
    ) AS t 
    ON t.aname = gr.aname 
WHERE 
    ge.aname = 'Buchegg'
GROUP BY
    ge.aname,
    --bbox,
    ge.bfsnr,
    ge.geometrie 
;


DELETE FROM 
    arp_sein_konfig.auswertung_gemeinde
;

INSERT INTO
    arp_sein_konfig.auswertung_gemeinde
    (
        aname,
        boundingbox,
        bfsnr,
        geometrie,
        gruppen
    )

SELECT 
    ge.aname,
    '['||ST_XMin(geometrie)||','||ST_YMin(geometrie)||','||ST_XMax(geometrie)||','||ST_YMax(geometrie)||']' AS bbox,
    ge.bfsnr,
    ge.geometrie,
    JSON_GROUP_ARRAY(
        JSON_OBJECT(
            '@type', 'SO_ARP_SEin_Konfiguration_20250115.Auswertung.Gruppe',
            'Name', gr.aname
        )    
    )
FROM    
    arp_sein_konfig.grundlagen_gruppe AS gr,
    arp_sein_konfig.grundlagen_gemeinde AS ge
WHERE 
    ge.aname = 'Buchegg'
GROUP BY
    ge.aname,
    bbox,
    ge.bfsnr,
    ge.geometrie 
;
