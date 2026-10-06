DELETE FROM vehicules          -- on retire du catalogue les véhicules en vente à plus de 30000
WHERE prix > 30000;

SELECT plaque, modele, proprietaire_id
FROM vehicules
WHERE prix > 30000
ORDER BY plaque;

SELECT COUNT(*) AS nb_vehicules
FROM vehicules;
