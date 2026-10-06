-- Fichier : commandes.lua
-- Le serveur traite les commandes de chat, une par une.
local solde = 100

local commandes = {
  acheter = function(argument)
    local prix = tonumber(argument)
    solde = solde - prix
    return "Achat de " .. prix .. " €, il reste " .. solde .. " €"
  end,
  solde = function()
    return "Solde : " .. solde .. " €"
  end,
}

local messages = { "/solde", "/acheter 30", "/acheter beaucoup", "/danser", "/solde" }

for _, texte in ipairs(messages) do
  local nom, argument = texte:match("^/(%a+)%s*(.*)$")
  print("> " .. texte)
  print(commandes[nom](argument))
end
