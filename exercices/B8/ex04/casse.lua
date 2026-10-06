-- Fichier : banque.lua
local compte = { solde = 100 }
function compte:deposer(montant)
  self.solde = self.solde + montant
end
compte.deposer(50)
print(compte.solde)
