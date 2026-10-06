-- Les joueurs sans emploi, du plus riche au plus pauvre.
-- Pour tester l'absence de valeur, on écrit IS NULL (jamais = NULL).
SELECT pseudo, argent
FROM joueurs
WHERE metier IS NULL
ORDER BY argent DESC;
