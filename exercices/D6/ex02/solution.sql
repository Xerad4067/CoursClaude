-- Les 5 joueurs les plus riches : on trie par argent décroissant (DESC),
-- puis on ne garde que les 5 premières lignes (LIMIT 5).
SELECT pseudo, argent
FROM joueurs
ORDER BY argent DESC
LIMIT 5;
