-- Fichier : boutique.lua
local Boutique = {}
Boutique.__index = Boutique

function Boutique.nouvelle(nom)
  local b = setmetatable({}, Boutique)
  b.nom = nom
  b.stock = {}
  return b
end

function Boutique:ajouterProduit(produit, prix, quantite)
  self.stock[produit] = { prix = prix, quantite = quantite }
end

-- Lève une erreur claire, ou renvoie le coût de l'achat.
function Boutique:acheter(client, produit, quantite)
  local article = self.stock[produit]
  if article == nil then
    error("Produit inconnu : " .. produit, 0)
  end
  if article.quantite < quantite then
    error("Stock insuffisant pour " .. produit, 0)
  end
  local cout = article.prix * quantite
  if client.argent < cout then
    error("Il te manque " .. (cout - client.argent) .. " €", 0)
  end
  client.argent = client.argent - cout
  article.quantite = article.quantite - quantite
  return cout
end

local superette = Boutique.nouvelle("Supérette du parc")
superette:ajouterProduit("pain", 2, 10)
superette:ajouterProduit("lampe", 15, 1)
superette:ajouterProduit("eau", 1, 5)

local client = { nom = "Sam", argent = 30 }
local commandes = { "/acheter pain 2", "/acheter lampe 1", "/acheter eau 10", "/acheter velo 1", "/acheter lampe 1", "/solde" }

print("=== " .. superette.nom .. " ===")
for _, texte in ipairs(commandes) do
  local action, produit, quantite = string.match(texte, "^/(%a+)%s*(%a*)%s*(%d*)$")
  if action == "acheter" then
    local ok, resultat = pcall(superette.acheter, superette, client, produit, tonumber(quantite))
    if ok then
      print(string.format("OK : %s x%s pour %d €", produit, quantite, resultat))
    else
      print("Refusé : " .. resultat)
    end
  elseif action == "solde" then
    print(client.nom .. " a " .. client.argent .. " €")
  end
end
