-- Fichier : promo.lua
local affiche = "Promo : -20%"
-- % est le caractère d'échappement des motifs : pour chercher un vrai %, on écrit %%
local lisible = string.gsub(affiche, "%%", " pour cent")
print(lisible)
