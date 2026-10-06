-- Chaque ville une seule fois (DISTINCT supprime les doublons), rangées par ordre alphabétique.
SELECT DISTINCT ville
FROM joueurs
ORDER BY ville;
