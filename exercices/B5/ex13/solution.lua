-- Fichier : distributeur.lua
-- Renvoie quatre valeurs : billets de 50, billets de 20, billets de 10, et ce qui reste.
local function decomposer(montant)
  local b50 = montant // 50
  montant = montant % 50                -- un paramètre est une variable locale : on peut la modifier
  local b20 = montant // 20
  montant = montant % 20
  local b10 = montant // 10
  local reste = montant % 10
  return b50, b20, b10, reste
end

local function afficherRetrait(montant)
  local b50, b20, b10, reste = decomposer(montant)
  print(montant .. " € = " .. b50 .. " x 50 + " .. b20 .. " x 20 + " .. b10 .. " x 10 (reste " .. reste .. " €)")
end

afficherRetrait(130)
afficherRetrait(185)
afficherRetrait(40)
