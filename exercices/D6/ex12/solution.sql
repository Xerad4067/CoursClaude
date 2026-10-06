-- Parmi les joueurs de niveau 5 ou plus, les villes dont l'argent total dépasse 18000.
-- WHERE filtre les LIGNES avant le regroupement ; HAVING filtre les GROUPES après.
SELECT ville, COUNT(*) AS nb_confirmes, SUM(argent) AS argent_total
FROM joueurs
WHERE niveau >= 5
GROUP BY ville
HAVING SUM(argent) > 18000
ORDER BY argent_total DESC;
