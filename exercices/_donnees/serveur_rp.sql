-- serveur_rp.sql : la base d'exemple d'un petit serveur roleplay (modules D6 et D7).
-- Tu peux relancer ce fichier quand tu veux : il efface les tables puis les recrée avec les données de départ.

DROP TABLE IF EXISTS ventes;
DROP TABLE IF EXISTS vehicules;
DROP TABLE IF EXISTS joueurs;

-- Les joueurs : une ligne par joueur.
-- metier vaut NULL quand le joueur est sans emploi ; ville vaut NULL tant qu'il n'a pas choisi sa ville.
-- inscrit_le est une date écrite en texte, au format AAAA-MM-JJ.
CREATE TABLE joueurs (
  id         INTEGER PRIMARY KEY,
  pseudo     TEXT NOT NULL UNIQUE,
  metier     TEXT,
  argent     INTEGER NOT NULL DEFAULT 0,
  niveau     INTEGER NOT NULL DEFAULT 1,
  ville      TEXT,
  inscrit_le TEXT NOT NULL
);

INSERT INTO joueurs (id, pseudo, metier, argent, niveau, ville, inscrit_le) VALUES
  (1,  'Sam',   'taxi',        1500, 3, 'Port-Azur',    '2026-01-12'),
  (2,  'Kim',   'médecin',     8200, 7, 'Port-Azur',    '2025-11-03'),
  (3,  'Alex',  'mécanicien',  3100, 5, 'Mont-Rocheux', '2026-02-20'),
  (4,  'Lou',   'policier',    4800, 6, 'Port-Azur',    '2025-12-15'),
  (5,  'Noa',   'taxi',         950, 2, 'Val-Verdoyant','2026-03-08'),
  (6,  'Jade',  NULL,           120, 1, 'Mont-Rocheux', '2026-09-30'),
  (7,  'Max',   'pompier',     5200, 8, 'Val-Verdoyant','2025-10-01'),
  (8,  'Eli',   'médecin',     7400, 6, 'Mont-Rocheux', '2026-01-25'),
  (9,  'Tom',   'taxi',        2300, 4, 'Port-Azur',    '2026-04-14'),
  (10, 'Zoe',   'boulanger',   1800, 3, 'Val-Verdoyant','2026-05-02'),
  (11, 'Ravi',  'mécanicien',  2750, 4, 'Port-Azur',    '2026-02-02'),
  (12, 'Ines',  'policier',    5100, 7, 'Mont-Rocheux', '2025-12-01'),
  (13, 'Theo',  NULL,             0, 1, NULL,           '2026-10-01'),
  (14, 'Mia',   'pompier',     4300, 5, 'Port-Azur',    '2026-03-19'),
  (15, 'Hugo',  'boulanger',   2100, 4, 'Mont-Rocheux', '2026-06-11'),
  (16, 'Nina',  'médecin',     9600, 9, 'Val-Verdoyant','2025-09-15'),
  (17, 'Yan',   'taxi',        1200, 2, 'Val-Verdoyant','2026-07-07'),
  (18, 'Oscar', NULL,           600, 2, 'Port-Azur',    '2026-08-21'),
  (19, 'Lena',  'policier',    3900, 5, 'Val-Verdoyant','2026-01-30'),
  (20, 'Paul',  'mécanicien',  3500, 6, 'Mont-Rocheux', '2026-04-28');

-- Les véhicules : une ligne par véhicule.
-- proprietaire_id est le numéro (id) du joueur qui possède le véhicule ; NULL = encore en vente chez le concessionnaire.
CREATE TABLE vehicules (
  id              INTEGER PRIMARY KEY,
  plaque          TEXT NOT NULL UNIQUE,
  modele          TEXT NOT NULL,
  type            TEXT NOT NULL,
  prix            INTEGER NOT NULL,
  proprietaire_id INTEGER REFERENCES joueurs(id)
);

INSERT INTO vehicules (id, plaque, modele, type, prix, proprietaire_id) VALUES
  (1,  'TX-001-RP', 'Berline Aster',   'voiture',    18000, 1),
  (2,  'TX-002-RP', 'Berline Aster',   'voiture',    18000, 5),
  (3,  'MD-777-RP', 'SUV Orion',       'voiture',    32000, 2),
  (4,  'PL-210-RP', 'Pickup Rhino',    'utilitaire', 24000, 4),
  (5,  'ME-042-RP', 'Fourgon Relais',  'utilitaire', 21000, 3),
  (6,  'PO-911-RP', 'Camion Titan',    'camion',     45000, 7),
  (7,  'MO-050-RP', 'Moto Foudre',     'moto',        6500, 9),
  (8,  'MO-051-RP', 'Moto Foudre',     'moto',        6500, NULL),
  (9,  'CI-300-RP', 'Citadine Pico',   'voiture',     9000, NULL),
  (10, 'CI-301-RP', 'Citadine Pico',   'voiture',     9000, 17),
  (11, 'CP-880-RP', 'Coupe Eclair',    'voiture',    38000, NULL),
  (12, 'BA-120-RP', 'Berline Aster',   'voiture',    18000, 12),
  (13, 'SC-001-RP', 'Scooter Gazelle', 'moto',        2800, 14),
  (14, 'SC-002-RP', 'Scooter Gazelle', 'moto',        2800, NULL),
  (15, 'CA-450-RP', 'Camion Colosse',  'camion',     52000, NULL),
  (16, 'FO-310-RP', 'Fourgon Relais',  'utilitaire', 21000, 15);

-- Les ventes de l'épicerie du serveur : une ligne par vente (un article, une quantité, un prix à l'unité).
CREATE TABLE ventes (
  id            INTEGER PRIMARY KEY,
  jour          TEXT NOT NULL,
  article       TEXT NOT NULL,
  quantite      INTEGER NOT NULL,
  prix_unitaire INTEGER NOT NULL
);

INSERT INTO ventes (id, jour, article, quantite, prix_unitaire) VALUES
  (1,  '2026-09-28', 'pain',            4,  3),
  (2,  '2026-09-28', 'eau',             6,  2),
  (3,  '2026-09-28', 'lampe',           1, 25),
  (4,  '2026-09-28', 'sandwich',        3,  6),
  (5,  '2026-09-28', 'corde',           2, 12),
  (6,  '2026-09-28', 'essence',         2, 30),
  (7,  '2026-09-29', 'pain',            5,  3),
  (8,  '2026-09-29', 'eau',             4,  2),
  (9,  '2026-09-29', 'trousse de soin', 2, 40),
  (10, '2026-09-29', 'sandwich',        2,  6),
  (11, '2026-09-29', 'essence',         3, 30),
  (12, '2026-09-29', 'lampe',           2, 25),
  (13, '2026-09-30', 'pain',            6,  3),
  (14, '2026-09-30', 'eau',             8,  2),
  (15, '2026-09-30', 'corde',           1, 12),
  (16, '2026-09-30', 'essence',         1, 30),
  (17, '2026-09-30', 'trousse de soin', 1, 40),
  (18, '2026-09-30', 'sandwich',        4,  6),
  (19, '2026-10-01', 'lampe',           3, 20),
  (20, '2026-10-01', 'pain',            3,  2),
  (21, '2026-10-01', 'eau',             5,  2),
  (22, '2026-10-01', 'corde',           3, 12),
  (23, '2026-10-01', 'essence',         2, 30),
  (24, '2026-10-01', 'sandwich',        1,  6),
  (25, '2026-10-02', 'pain',            7,  3),
  (26, '2026-10-02', 'eau',             3,  2),
  (27, '2026-10-02', 'trousse de soin', 3, 40),
  (28, '2026-10-02', 'lampe',           1, 25),
  (29, '2026-10-02', 'essence',         4, 30),
  (30, '2026-10-02', 'sandwich',        5,  6);
