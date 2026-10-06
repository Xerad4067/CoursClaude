-- Crée la table des maisons du serveur.
CREATE TABLE maisons (
  id           INTEGER PRIMARY KEY,   -- numéro attribué automatiquement
  adresse      TEXT NOT NULL,         -- obligatoire
  prix         INTEGER NOT NULL,      -- obligatoire
  proprietaire TEXT                   -- facultatif : NULL = maison à vendre
);

INSERT INTO maisons (adresse, prix, proprietaire) VALUES   -- trois maisons, dont une sans propriétaire
  ('12 rue des Pins', 85000, 'Kim'),
  ('3 impasse du Lac', 120000, 'Sam'),
  ('7 avenue du Port', 64000, NULL);

-- On relit tout pour vérifier.
SELECT id, adresse, prix, proprietaire
FROM maisons
ORDER BY id;
