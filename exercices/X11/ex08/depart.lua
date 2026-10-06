-- Fichier : achat.lua
-- Outil : remplace « fichier.lua:12: » par « ligne 12 : » (même affichage chez tout le monde).
local function sansFichier(message)
  return (tostring(message):gsub("^.-:(%d+): ", "ligne %1 : "))
end

local function acheter(prix, quantite)
  -- À toi : si quantite n'est pas un nombre, lève « quantité invalide » en accusant l'APPELANT (niveau 2)
  return prix * quantite
end

local function caisse()
  local total = acheter(5, "trois")              -- c'est CETTE ligne qui est fautive
  return total
end

local ok, message = pcall(caisse)
print(ok)
print(sansFichier(message))
