-- Le nombre de commandes de chaque client, y compris ceux qui n'ont jamais commandé.
-- LEFT JOIN garde tous les clients ; COUNT(cm.id) ignore les NULL, donc compte 0 pour eux.
SELECT cl.pseudo, COUNT(cm.id) AS nb_commandes
FROM clients cl
LEFT JOIN commandes cm ON cm.client_id = cl.id
GROUP BY cl.id, cl.pseudo
ORDER BY nb_commandes DESC, cl.pseudo;
