-- Fichier : achat.lua
-- Outil : remplace « fichier.lua:12: » par « ligne 12 : » (même affichage chez tout le monde).
local function sansFichier(message)
  return (tostring(message):gsub("^.-:(%d+): ", "ligne %1 : "))
end

local function acheter(prix, quantite)
  if type(quantite) ~= "number" then error("quantité invalide", 2) end   -- niveau 2 : la faute est chez l'appelant
  return prix * quantite
end

local function caisse()
  local total = acheter(5, "trois")              -- c'est CETTE ligne qui est fautive
  return total
end

local ok, message = pcall(caisse)
print(ok)
print(sansFichier(message))
