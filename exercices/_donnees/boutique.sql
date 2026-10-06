-- boutique.sql : la base d'exemple de la boutique du serveur roleplay (module D7).
-- 4 tables : clients, produits, commandes, lignes_commande.
-- Tu peux relancer ce fichier quand tu veux : il efface les tables puis les recrée avec les données de départ.

-- On efface d'abord les tables qui dépendent des autres (les « enfants »), puis les autres.
DROP TABLE IF EXISTS lignes_commande;
DROP TABLE IF EXISTS commandes;
DROP TABLE IF EXISTS produits;
DROP TABLE IF EXISTS clients;

-- Les clients : une ligne par client.
CREATE TABLE clients (
  id     INTEGER PRIMARY KEY,
  pseudo TEXT NOT NULL UNIQUE,
  ville  TEXT NOT NULL
);

-- Les produits en vente : une ligne par produit.
CREATE TABLE produits (
  id        INTEGER PRIMARY KEY,
  nom       TEXT NOT NULL UNIQUE,
  categorie TEXT NOT NULL,
  prix      INTEGER NOT NULL,
  stock     INTEGER NOT NULL DEFAULT 0
);

-- Les commandes : une ligne par commande. client_id renvoie à la table clients (relation 1-N :
-- un client peut passer plusieurs commandes, une commande appartient à un seul client).
CREATE TABLE commandes (
  id        INTEGER PRIMARY KEY,
  client_id INTEGER NOT NULL REFERENCES clients(id),
  passee_le TEXT NOT NULL
);

-- Les lignes de commande : la table de liaison entre commandes et produits (relation N-N :
-- une commande contient plusieurs produits, un produit apparaît dans plusieurs commandes).
-- La clé primaire est le couple (commande_id, produit_id) : un produit n'apparaît qu'une fois par commande.
CREATE TABLE lignes_commande (
  commande_id INTEGER NOT NULL REFERENCES commandes(id),
  produit_id  INTEGER NOT NULL REFERENCES produits(id),
  quantite    INTEGER NOT NULL,
  PRIMARY KEY (commande_id, produit_id)
);

INSERT INTO clients (id, pseudo, ville) VALUES
  (1,  'Sam',  'Port-Azur'),
  (2,  'Kim',  'Port-Azur'),
  (3,  'Alex', 'Mont-Rocheux'),
  (4,  'Lou',  'Port-Azur'),
  (5,  'Noa',  'Val-Verdoyant'),
  (6,  'Max',  'Val-Verdoyant'),
  (7,  'Eli',  'Mont-Rocheux'),
  (8,  'Tom',  'Port-Azur'),
  (9,  'Zoe',  'Val-Verdoyant'),
  (10, 'Ravi', 'Port-Azur');

INSERT INTO produits (id, nom, categorie, prix, stock) VALUES
  (1,  'pain',            'nourriture', 3,  120),
  (2,  'eau',             'nourriture', 2,  200),
  (3,  'sandwich',        'nourriture', 6,  60),
  (4,  'lampe',           'outil',      25, 15),
  (5,  'corde',           'outil',      12, 30),
  (6,  'trousse de soin', 'soin',       40, 8),
  (7,  'essence',         'carburant',  30, 50),
  (8,  'carte de la ville', 'divers',   8,  25),
  (9,  'tente',           'camping',    70, 0),
  (10, 'boussole',        'divers',     15, 12);

INSERT INTO commandes (id, client_id, passee_le) VALUES
  (1,  1, '2026-09-28'),
  (2,  2, '2026-09-28'),
  (3,  3, '2026-09-29'),
  (4,  1, '2026-09-29'),
  (5,  4, '2026-09-30'),
  (6,  5, '2026-09-30'),
  (7,  2, '2026-10-01'),
  (8,  6, '2026-10-01'),
  (9,  1, '2026-10-02'),
  (10, 7, '2026-10-02'),
  (11, 3, '2026-10-02'),
  (12, 8, '2026-10-03'),
  (13, 4, '2026-10-03'),
  (14, 2, '2026-10-04');

INSERT INTO lignes_commande (commande_id, produit_id, quantite) VALUES
  (1,  1, 2), (1,  2, 3),
  (2,  3, 2), (2,  7, 1), (2,  4, 1),
  (3,  6, 1),
  (4,  1, 4), (4,  2, 4), (4,  3, 1),
  (5,  5, 2), (5,  4, 1),
  (6,  7, 2),
  (7,  2, 6), (7,  3, 3),
  (8,  6, 2), (8,  8, 1),
  (9,  4, 2), (9,  5, 1), (9,  7, 1),
  (10, 1, 5),
  (11, 8, 2), (11, 2, 2),
  (12, 3, 4),
  (13, 6, 1), (13, 1, 3),
  (14, 7, 3), (14, 2, 5), (14, 1, 2);
