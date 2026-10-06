-- 1) Les produits qui n'apparaissent dans aucune ligne de commande.
-- La sous-requête (entre parenthèses) fournit la liste des produits déjà commandés.
SELECT nom, categorie, stock
FROM produits
WHERE id NOT IN (SELECT produit_id FROM lignes_commande)
ORDER BY nom;

-- 2) Les produits plus chers que le prix moyen, du plus cher au moins cher.
-- Ici la sous-requête renvoie un seul nombre : le prix moyen.
SELECT nom, prix
FROM produits
WHERE prix > (SELECT AVG(prix) FROM produits)
ORDER BY prix DESC, nom;
