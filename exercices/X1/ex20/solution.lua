-- Fichier : fiche-paie.lua
local nom = "Sam"
local metier = "taxi"
local brut = 2150
local tauxCotisations = 22      -- en pourcentage
local prime = 85.5

local cotisations = brut * tauxCotisations / 100
local net = brut - cotisations + prime

local largeur = 26
print(string.rep("=", largeur))
print(string.format("FICHE DE PAIE : %s (%s)", string.upper(nom), metier))
print(string.rep("=", largeur))
print(string.format("%-13s: %9.2f €", "Brut", brut))
print(string.format("%-13s: %9.2f €", "Cotisations", cotisations))
print(string.format("%-13s: %9.2f €", "Prime", prime))
print(string.rep("-", largeur))
print(string.format("%-13s: %9.2f €", "Net", net))
