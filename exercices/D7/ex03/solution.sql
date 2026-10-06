UPDATE joueurs                 -- on modifie la table joueurs…
SET argent = argent + 500      -- …en ajoutant 500 à l'argent actuel…
WHERE metier = 'taxi';         -- …mais seulement pour les taxis

-- On vérifie.
SELECT pseudo, argent
FROM joueurs
WHERE metier = 'taxi'
ORDER BY pseudo;
