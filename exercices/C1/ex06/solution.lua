-- Fichier : ticket.lua
-- Décomposition du problème « afficher un ticket de caisse » :
--   afficherTicket(panier)
--     ├── pour chaque ligne : afficherLigne(ligne)
--     │       └── totalLigne(ligne)        (prix × quantité)
--     └── totalPanier(panier)              (somme des totalLigne)
local panier = {
  { nom = "pain",  prix = 2,  quantite = 2 },
  { nom = "eau",   prix = 1,  quantite = 3 },
  { nom = "lampe", prix = 15, quantite = 1 },
}

-- Sous-problème 1 : le total d'une ligne.
local function totalLigne(ligne)
  return ligne.prix * ligne.quantite
end

-- Sous-problème 2 : le total de tout le panier.
local function totalPanier(articles)
  local total = 0
  for _, ligne in ipairs(articles) do
    total = total + totalLigne(ligne)
  end
  return total
end

-- Sous-problème 3 : afficher une ligne.
local function afficherLigne(ligne)
  print(ligne.nom .. " x" .. ligne.quantite .. " : " .. totalLigne(ligne) .. " €")
end

-- Le problème de départ : il ne fait qu'assembler les petits morceaux.
local function afficherTicket(articles)
  print("=== Ticket ===")
  for _, ligne in ipairs(articles) do
    afficherLigne(ligne)
  end
  print("Total : " .. totalPanier(articles) .. " €")
end

afficherTicket(panier)
