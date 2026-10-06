BEGIN;                                   -- début de la transaction : tout ce qui suit est provisoire

DELETE FROM ventes                       -- grand ménage des vieilles ventes…
WHERE jour < '2026-09-30';               -- …avant le 30 septembre

SELECT COUNT(*) AS ventes_restantes      -- dans la transaction, on voit le résultat du ménage
FROM ventes;

ROLLBACK;                                -- finalement non : on annule tout depuis BEGIN

SELECT COUNT(*) AS ventes_restantes      -- les ventes sont revenues
FROM ventes;
