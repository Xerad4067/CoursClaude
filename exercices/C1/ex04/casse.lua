-- Fichier : achat.lua
-- Pseudo-code :
--   ENTRÉE : argent, prix
--   SI argent ≥ prix ALORS
--       argent ← argent − prix
--       AFFICHER « Achat réussi, il te reste » argent « € »
--   SINON
--       AFFICHER « Pas assez d'argent »
--   FIN SI
local function acheter(argent, prix)
  if argent > prix then
    argent = argent - prix
    print("Achat réussi, il te reste " .. argent .. " €")
  else
    print("Pas assez d'argent")
  end
end

acheter(50, 40)
acheter(40, 40)
acheter(30, 40)
