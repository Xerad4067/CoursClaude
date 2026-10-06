-- Fichier : commandes.lua
local saisies = { "/AIDE", "/Aide", "/aide", "/aid" }

for _, saisie in ipairs(saisies) do
  -- on compare la version en minuscules : la casse du joueur n'a plus d'importance
  if string.lower(saisie) == "/aide" then
    print(saisie .. " : reconnue")
  else
    print(saisie .. " : inconnue")
  end
end
