-- Fichier : porte.lua
local porte = { ouverte = false }

function porte:ouvrir()
  self.ouverte = true            -- self = la table devant le :
end

function porte:fermer()
  self.ouverte = false
end

function porte:etat()
  if self.ouverte then
    return "ouverte"
  end
  return "fermée"
end

print(porte:etat())
porte:ouvrir()
print(porte:etat())
porte:fermer()
print(porte:etat())
