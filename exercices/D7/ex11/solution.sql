-- 1) Les lignes de la commande 4 : on relie les quatre tables avec trois JOIN.
SELECT cl.pseudo, p.nom AS produit, l.quantite, p.prix, l.quantite * p.prix AS total_ligne
FROM commandes cm
INNER JOIN clients cl ON cl.id = cm.client_id
INNER JOIN lignes_commande l ON l.commande_id = cm.id
INNER JOIN produits p ON p.id = l.produit_id
WHERE cm.id = 4
ORDER BY p.nom;

-- 2) Le total de la commande 4 : on additionne les totaux de ligne.
SELECT cm.id AS commande, SUM(l.quantite * p.prix) AS total
FROM commandes cm
INNER JOIN lignes_commande l ON l.commande_id = cm.id
INNER JOIN produits p ON p.id = l.produit_id
WHERE cm.id = 4
GROUP BY cm.id;
