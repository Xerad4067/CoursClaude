-- Tableau de bord du serveur : quatre requêtes.

-- 1) Les chiffres clés des joueurs.
SELECT COUNT(*) AS nb_joueurs,
       SUM(argent) AS argent_total,
       ROUND(AVG(niveau), 1) AS niveau_moyen,
       MAX(niveau) AS niveau_max
FROM joueurs;

-- 2) Le nombre de joueurs par métier (les sans-emploi sont ignorés), du plus fréquent au moins fréquent.
SELECT metier, COUNT(*) AS nb_joueurs
FROM joueurs
WHERE metier IS NOT NULL
GROUP BY metier
ORDER BY nb_joueurs DESC, metier;

-- 3) Les véhicules encore en vente, par type : combien, et quelle valeur totale.
SELECT type, COUNT(*) AS nb, SUM(prix) AS valeur
FROM vehicules
WHERE proprietaire_id IS NULL
GROUP BY type
ORDER BY valeur DESC;

-- 4) Les trois articles les plus vendus (en nombre de pièces).
SELECT article, SUM(quantite) AS total_vendu
FROM ventes
GROUP BY article
ORDER BY total_vendu DESC
LIMIT 3;
