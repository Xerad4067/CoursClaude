-- Fichier : soldes.lua
local nom1, prix1, remise1 = "Casquette", 24.5, 15
local nom2, prix2, remise2 = "Jean", 39.9, 30

-- %s : texte · %.1f : décimal avec 1 chiffre après la virgule
-- %d : entier · %% : le signe % lui-même
print(string.format("%s : %.1f € (-%d%%)", nom1, prix1, remise1))
print(string.format("%s : %.1f € (-%d%%)", nom2, prix2, remise2))
