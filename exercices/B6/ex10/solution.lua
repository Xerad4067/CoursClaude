-- Fichier : connectes.lua
-- Renvoie la position de « valeur » dans la liste, ou nil si elle n'y est pas.
local function positionDe(liste, valeur)
  for i, element in ipairs(liste) do
    if element == valeur then
      return i                    -- trouvé : on sort tout de suite de la fonction
    end
  end
  return nil                      -- la boucle est finie sans trouver
end

local function estConnecte(liste, nom)
  return positionDe(liste, nom) ~= nil
end

local connectes = { "Sam", "Kim", "Alex" }
print(positionDe(connectes, "Kim"))
print(positionDe(connectes, "Robin"))
print(estConnecte(connectes, "Alex"))
print(estConnecte(connectes, "Robin"))
