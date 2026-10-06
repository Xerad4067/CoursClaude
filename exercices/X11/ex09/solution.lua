-- Fichier : retrait.lua
local function retirer(solde, montant)
  if montant > solde then
    -- L'erreur est une TABLE : elle transporte un code et des données utilisables.
    error({ code = "SOLDE_INSUFFISANT", manque = montant - solde })
  end
  return solde - montant
end

local ok, resultat = pcall(retirer, 100, 40)
print(ok, resultat)

local ok2, erreur = pcall(retirer, 60, 100)
if not ok2 then
  print("Refusé (" .. erreur.code .. ") : il manque " .. erreur.manque .. " €")
end
