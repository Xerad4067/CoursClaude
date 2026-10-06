-- Fichier : retrait.lua
local function retirer(solde, montant)
  if montant > solde then
    error("Solde insuffisant", 0)
  end
  return solde - montant
end

print(pcall(retirer(100, 500)))
print(pcall(retirer(100, 30)))
