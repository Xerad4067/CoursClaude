-- Fichier : commandes.lua
local commandes = {
  aide = function() print("Commandes : /aide, /argent") end,
  argent = function() print("Tu as 1500 €") end,
}
commandes.aide()
commandes["argent"]()
local tapee = "aide"          -- comme si le joueur avait tapé /aide
commandes[tapee]()
