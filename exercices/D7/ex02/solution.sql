INSERT INTO joueurs (pseudo, inscrit_le)   -- on ne donne que deux colonnes…
VALUES ('Sacha', '2026-10-06');            -- …les autres prennent leur valeur par défaut, ou NULL

-- On vérifie ce que la base a rempli toute seule.
SELECT pseudo, metier, argent, niveau, ville
FROM joueurs
WHERE pseudo = 'Sacha';
