-- Lecture : quelles lignes cette requête affiche-t-elle ?
SELECT cm.id AS commande, cl.pseudo, cm.passee_le
FROM commandes cm
INNER JOIN clients cl ON cl.id = cm.client_id
WHERE cm.id <= 4
ORDER BY cm.id;
