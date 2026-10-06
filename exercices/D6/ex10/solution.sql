-- Le bilan de l'épicerie en une seule ligne : une fonction d'agrégation par colonne.
-- ROUND(..., 1) arrondit la moyenne à une décimale.
SELECT COUNT(*) AS nb_ventes,
       SUM(quantite) AS articles_vendus,
       MIN(prix_unitaire) AS prix_mini,
       MAX(prix_unitaire) AS prix_maxi,
       ROUND(AVG(quantite), 1) AS quantite_moyenne
FROM ventes;
