-- Fichier : inventaire.lua
local inventaire = {}   -- objet -> quantité

local function ajouter(objet, quantite)
  inventaire[objet] = (inventaire[objet] or 0) + quantite
  print("+ " .. quantite .. " " .. objet)
end

local function retirer(objet, quantite)
  local actuel = inventaire[objet] or 0
  if actuel < quantite then
    print("Impossible : il n'y a que " .. actuel .. " " .. objet)
    return false
  end
  inventaire[objet] = actuel - quantite
  if inventaire[objet] == 0 then
    inventaire[objet] = nil       -- on supprime les objets épuisés
  end
  print("- " .. quantite .. " " .. objet)
  return true
end

local function afficher()
  local noms = {}
  for nom in pairs(inventaire) do
    table.insert(noms, nom)
  end
  table.sort(noms)                -- ordre alphabétique garanti
  print("Inventaire :")
  for _, nom in ipairs(noms) do
    print("  " .. nom .. " x" .. inventaire[nom])
  end
end

ajouter("pain", 2)
ajouter("eau", 3)
ajouter("pain", 1)
retirer("eau", 1)
retirer("lampe", 1)
afficher()
