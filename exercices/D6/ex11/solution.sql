-- Le chiffre d'affaires de chaque article : SUM(quantité × prix) pour chaque groupe d'articles identiques.
-- En cas d'égalité, on range par ordre alphabétique d'article.
SELECT article, SUM(quantite * prix_unitaire) AS chiffre_affaires
FROM ventes
GROUP BY article
ORDER BY chiffre_affaires DESC, article;
