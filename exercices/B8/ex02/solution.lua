-- Fichier : retrait.lua
local function retirer(solde, montant)
  if montant > solde then
    error("Solde insuffisant", 0)     -- 0 : message sans fichier ni ligne
  end
  return solde - montant
end

local ok, resultat = pcall(retirer, 100, 30)
print(ok, resultat)
local ok2, erreur = pcall(retirer, 100, 500)
print(ok2, erreur)
