DELETE FROM vehicules                              -- on retire du catalogue…
WHERE proprietaire_id IS NULL AND prix > 30000;    -- …les véhicules encore en vente ET à plus de 30000

-- Ceux qui restent à plus de 30000 appartiennent bien à des joueurs.
SELECT plaque, modele, proprietaire_id
FROM vehicules
WHERE prix > 30000
ORDER BY plaque;

SELECT COUNT(*) AS nb_vehicules
FROM vehicules;
