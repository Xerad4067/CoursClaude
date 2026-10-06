-- Table « parent » : on la crée en premier.
CREATE TABLE quartiers (
  id  INTEGER PRIMARY KEY,
  nom TEXT NOT NULL UNIQUE
);

-- Table « enfant » : quartier_id doit toujours désigner un quartier qui existe.
CREATE TABLE maisons (
  id          INTEGER PRIMARY KEY,
  adresse     TEXT NOT NULL,
  quartier_id INTEGER NOT NULL REFERENCES quartiers(id)
);

INSERT INTO quartiers (nom) VALUES ('Port-Azur'), ('Mont-Rocheux');

INSERT INTO maisons (adresse, quartier_id) VALUES
  ('12 rue des Pins', 1),
  ('3 impasse du Lac', 2),
  ('7 avenue du Port', 1);

SELECT id, adresse, quartier_id
FROM maisons
ORDER BY id;

-- Affiche la relation déclarée entre maisons et quartiers.
PRAGMA foreign_key_list(maisons);
