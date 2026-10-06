-- Les joueurs de Port-Azur qui ont au moins 3000, du plus riche au moins riche.
-- AND : les deux conditions doivent être vraies en même temps.
SELECT pseudo, metier, argent
FROM joueurs
WHERE ville = 'Port-Azur' AND argent >= 3000
ORDER BY argent DESC;
