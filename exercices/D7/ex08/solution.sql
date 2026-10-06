-- 1) INNER JOIN : seulement les motos qui ont un propriétaire.
SELECT v.plaque, j.pseudo
FROM vehicules v
INNER JOIN joueurs j ON j.id = v.proprietaire_id
WHERE v.type = 'moto'
ORDER BY v.plaque;

-- 2) LEFT JOIN : toutes les motos, avec NULL quand il n'y a pas de propriétaire.
SELECT v.plaque, j.pseudo
FROM vehicules v
LEFT JOIN joueurs j ON j.id = v.proprietaire_id
WHERE v.type = 'moto'
ORDER BY v.plaque;
