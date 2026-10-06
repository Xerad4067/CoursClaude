-- Fichier : ticket.lua
local prixPain, qtePain = 1.20, 2
local prixEau, qteEau = 0.80, 3

local totalPain = prixPain * qtePain
local totalEau = prixEau * qteEau     -- vaut en réalité 2.4000000000000004
local total = totalPain + totalEau

print("=== Supérette du parc ===")
print(string.format("%s x%d : %.2f €", "Pain", qtePain, totalPain))
print(string.format("%s x%d : %.2f €", "Eau", qteEau, totalEau))
print(string.rep("-", 20))
print(string.format("TOTAL : %.2f €", total))   -- %.2f arrondit proprement
print("Merci et à bientôt !")
