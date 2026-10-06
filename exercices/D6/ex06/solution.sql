-- Lecture : combien de lignes cette requête renvoie-t-elle, et lesquelles ?
SELECT pseudo, ville, niveau
FROM joueurs
WHERE ville = 'Port-Azur' OR ville = 'Mont-Rocheux' AND niveau >= 6
ORDER BY pseudo;
