-- Les joueurs sans emploi, du plus riche au plus pauvre.
SELECT pseudo, argent
FORM joueurs
WHERE metier = NULL
ORDER BY argent DESC;
