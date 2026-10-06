-- Le prix TTC (20 % de taxe) des 5 véhicules les plus chers.
-- prix * 120 / 100 ajoute 20 % ; AS donne un nom à la colonne calculée.
SELECT modele, prix, prix * 120 / 100 AS prix_ttc
FROM vehicules
ORDER BY prix DESC
LIMIT 5;
