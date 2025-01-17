DELETE FROM
    arp_sein_konfig.grundlagen_gemeinde_objektinfo 
;
DELETE FROM 
    arp_sein_konfig.grundlagen_objektinfo
;
DELETE FROM 
    arp_sein_konfig.grundlagen_thema 
;
DELETE FROM 
    arp_sein_konfig.grundlagen_gruppe
;

INSERT INTO 
    arp_sein_konfig.grundlagen_gruppe
    (
        aname
    )
VALUES
    ('Bundesinventare'),
    ('Agglomerationsprogramm'),
    ('Richtplaninhalt'),
    ('Langsamverkehr')
;

INSERT INTO
    arp_sein_konfig.grundlagen_thema
    (
        aname,
        layerid,
        gruppe_r
    )
SELECT 
    'Velonetzkarte',
    '-',
    gruppe_t_id
FROM 
(
    SELECT 
        t_id AS gruppe_t_id,
    FROM 
        arp_sein_konfig.grundlagen_gruppe AS g 
    WHERE 
        aname = 'Langsamverkehr'
)
;

INSERT INTO
    arp_sein_konfig.grundlagen_thema
    (
        aname,
        layerid,
        gruppe_r
    )
SELECT 
    'Ortsbild von nationaler Bedeutung (ISOS)',
    'ch.bak.bundesinventar-schuetzenswerte-ortsbilder',
    gruppe_t_id
FROM 
(
    SELECT 
        t_id AS gruppe_t_id,
    FROM 
        arp_sein_konfig.grundlagen_gruppe AS g 
    WHERE 
        aname = 'Bundesinventare'
)
;
INSERT INTO
    arp_sein_konfig.grundlagen_thema
    (
        aname,
        layerid,
        gruppe_r
    )
SELECT 
    'Amphibienlaichgebiete von nationaler Bedeutung - Ortsfeste Objekte',
    'ch.bafu.bundesinventare-amphibien',
    gruppe_t_id
FROM 
(
    SELECT 
        t_id AS gruppe_t_id,
    FROM 
        arp_sein_konfig.grundlagen_gruppe AS g 
    WHERE 
        aname = 'Bundesinventare'
)
;
INSERT INTO
    arp_sein_konfig.grundlagen_thema
    (
        aname,
        layerid,
        gruppe_r
    )
SELECT 
    'Perimeter Agglomerationsprogramme 5. Generation',
    'ch.so.arp.agglomerationsprogramme.uebersicht',
    gruppe_t_id
FROM 
(
    SELECT 
        t_id AS gruppe_t_id,
    FROM 
        arp_sein_konfig.grundlagen_gruppe AS g 
    WHERE 
        aname = 'Agglomerationsprogramm'
)
;
INSERT INTO
    arp_sein_konfig.grundlagen_thema
    (
        aname,
        layerid,
        gruppe_r
    )
SELECT 
    'Umsetzungsstrand 1. Generation (Agglomerationsprogramme)',
    'ch.so.arp.agglomerationsprogramme.massnahmen_1g',
    gruppe_t_id
FROM 
(
    SELECT 
        t_id AS gruppe_t_id,
    FROM 
        arp_sein_konfig.grundlagen_gruppe AS g 
    WHERE 
        aname = 'Agglomerationsprogramm'
)
;
INSERT INTO
    arp_sein_konfig.grundlagen_thema
    (
        aname,
        layerid,
        gruppe_r
    )
SELECT 
    'Weiler',
    '-',
    gruppe_t_id
FROM 
(
    SELECT 
        t_id AS gruppe_t_id,
    FROM 
        arp_sein_konfig.grundlagen_gruppe AS g 
    WHERE 
        aname = 'Richtplaninhalt'
)
;

INSERT INTO
    arp_sein_konfig.grundlagen_objektinfo
    (
        information,
        link,
        thema_r
    )
    SELECT 
        'Gächliwil',
        'https://so.ch/fileadmin/internet/bjd/bjd-arp/Richtplanung/pdf/Richtplantext/S-2_1.pdf',
        thema_t_id
    FROM 
    (
        SELECT
            t_id AS thema_t_id
        FROM    
            arp_sein_konfig.grundlagen_thema
        WHERE 
            aname = 'Weiler'
    )
; 

INSERT INTO
    arp_sein_konfig.grundlagen_objektinfo
    (
        information,
        link,
        thema_r
    )
    SELECT 
        'Staad',
        'https://so.ch/fileadmin/internet/bjd/bjd-arp/Richtplanung/pdf/Richtplantext/S-2_1.pdf',
        thema_t_id
    FROM 
    (
        SELECT
            t_id AS thema_t_id
        FROM    
            arp_sein_konfig.grundlagen_thema
        WHERE 
            aname = 'Weiler'
    )
; 

INSERT INTO
    arp_sein_konfig.grundlagen_objektinfo
    (
        information,
        link,
        thema_r
    )
    SELECT 
        'Velonetzkarte',
        'https://so.ch/fileadmin/internet/bjd/bjd-avt/pdf/Langsamverkehr/Velonetzplan_2019_web.pdf',
        thema_t_id
    FROM 
    (
        SELECT
            t_id AS thema_t_id
        FROM    
            arp_sein_konfig.grundlagen_thema
        WHERE 
            aname = 'Velonetzkarte'
    )
; 

INSERT INTO
    arp_sein_konfig.grundlagen_gemeinde_objektinfo
    (
        objektinfo_r,
        gemeinde_r
    )
SELECT 
    objekt_t_id,
    gemeinde_t_id
FROM 
(
    SELECT
        t_id AS objekt_t_id
    FROM 
        arp_sein_konfig.grundlagen_objektinfo  
    WHERE 
        information = 'Gächliwil'
),
(
    SELECT
        t_id AS gemeinde_t_id
    FROM 
        arp_sein_konfig.grundlagen_gemeinde 
    WHERE 
        aname = 'Buchegg'
)
;

INSERT INTO
    arp_sein_konfig.grundlagen_gemeinde_objektinfo
    (
        objektinfo_r,
        gemeinde_r
    )
SELECT 
    objekt_t_id,
    gemeinde_t_id
FROM 
(
    SELECT
        t_id AS objekt_t_id
    FROM 
        arp_sein_konfig.grundlagen_objektinfo  
    WHERE 
        information = 'Staad'
),
(
    SELECT
        t_id AS gemeinde_t_id
    FROM 
        arp_sein_konfig.grundlagen_gemeinde 
    WHERE 
        aname = 'Grenchen'
)
;

INSERT INTO
    arp_sein_konfig.grundlagen_gemeinde_objektinfo
    (
        objektinfo_r,
        gemeinde_r
    )
SELECT 
    objekt_t_id,
    gemeinde_t_id
FROM 
(
    SELECT
        t_id AS objekt_t_id
    FROM 
        arp_sein_konfig.grundlagen_objektinfo  
    WHERE 
        information = 'Velonetzkarte'
),
(
    SELECT
        t_id AS gemeinde_t_id
    FROM 
        arp_sein_konfig.grundlagen_gemeinde 
    WHERE 
        aname IN ('Buchegg', 'Solothurn', 'Grenchen')
)
;