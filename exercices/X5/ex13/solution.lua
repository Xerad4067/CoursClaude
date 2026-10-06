-- Fichier : annuler.lua
-- Une pile : le dernier arrivé est le premier sorti.
local actions = {}

local function empiler(action)
  table.insert(actions, action)       -- on pose au sommet
end

local function annuler()
  return table.remove(actions)        -- on retire le sommet (nil si la pile est vide)
end

empiler("poser mur")
empiler("poser porte")
empiler("poser fenêtre")

for _ = 1, 4 do
  local derniere = annuler()
  if derniere then
    print("Annulé : " .. derniere)
  else
    print("Rien à annuler")
  end
end
