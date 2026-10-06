-- 1) Les plaques de taxi : elles commencent par TX (% remplace n'importe quelle suite de caractères).
SELECT plaque, modele
FROM vehicules
WHERE plaque LIKE 'TX%'
ORDER BY plaque;

-- 2) Les véhicules encore en vente (aucun propriétaire), du moins cher au plus cher.
SELECT plaque, modele, prix
FROM vehicules
WHERE proprietaire_id IS NULL
ORDER BY prix, plaque;
