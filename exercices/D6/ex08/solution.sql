-- 1) Les médecins, policiers et pompiers : IN remplace une suite de OR.
SELECT pseudo, metier
FROM joueurs
WHERE metier IN ('médecin', 'policier', 'pompier')
ORDER BY metier, pseudo;

-- 2) Les joueurs inscrits au premier trimestre 2026 (BETWEEN inclut les deux bornes).
-- Les dates sont du texte AAAA-MM-JJ : l'ordre alphabétique est aussi l'ordre chronologique.
SELECT pseudo, inscrit_le
FROM joueurs
WHERE inscrit_le BETWEEN '2026-01-01' AND '2026-03-31'
ORDER BY inscrit_le;
