-- Fichier : caisse.lua
local function creerCaisse(soldeInitial)
  local solde = soldeInitial          -- privé : seul ce qui suit y a accès
  local caisse = {}
  function caisse.deposer(montant)
    solde = solde + montant
  end
  function caisse.retirer(montant)
    if montant > solde then
      return false
    end
    solde = solde - montant
    return true
  end
  function caisse.solde()
    return solde
  end
  return caisse
end

local c = creerCaisse(100)
c.deposer(50)
print(c.solde())
print(c.retirer(500))
print(c.retirer(30))
print(c.solde())
