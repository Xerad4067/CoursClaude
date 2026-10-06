-- Fichier : commandes.lua
-- Le serveur traite les commandes de chat, une par une, et ne s'arrête jamais.
local solde = 100

local commandes = {
  acheter = function(argument)
    local prix = tonumber(argument)
    if prix == nil then
      error("montant invalide", 0)          -- on vérifie la saisie du joueur
    end
    solde = solde - prix
    return "Achat de " .. prix .. " €, il reste " .. solde .. " €"
  end,
  solde = function()
    return "Solde : " .. solde .. " €"
  end,
}

local messages = { "/solde", "/acheter 30", "/acheter beaucoup", "/danser", "/solde" }

for _, texte in ipairs(messages) do
  print("> " .. texte)
  -- Chaque commande est exécutée dans un pcall : une erreur ne sort pas de ce bloc.
  local ok, reponse = pcall(function()
    local nom, argument = texte:match("^/(%a+)%s*(.*)$")
    local commande = commandes[nom]
    if commande == nil then
      error("commande inconnue", 0)
    end
    return commande(argument)
  end)
  if ok then
    print(reponse)
  else
    print("Erreur : " .. reponse)
  end
end
