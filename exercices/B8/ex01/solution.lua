-- Fichier : compte.lua
local compte = { solde = 100 }

function compte:deposer(montant)      -- self = la table devant le :
  self.solde = self.solde + montant
end

compte:deposer(50)
compte:deposer(25)
print(compte.solde)
