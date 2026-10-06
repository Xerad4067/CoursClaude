-- Fichier : journal.lua
local stock = { lampe = 3 }

local function acheter(produit)
  if stock[produit] == nil then
    error("produit inconnu : " .. produit, 0)
  end
  stock[produit] = stock[produit] - 1
  return stock[produit]
end

local journal = {}
local erreurs = 0

local function noter(niveau, texte)
  table.insert(journal, "[" .. niveau .. "] " .. texte)
end

-- Exécute l'action, note le résultat dans le journal, et ne plante jamais.
local function proteger(nom, action)
  local ok, resultat = pcall(action)
  if ok then
    noter("INFO", nom .. " : réussi")
    return resultat
  end
  erreurs = erreurs + 1
  noter("ERREUR", nom .. " : " .. resultat)
  return nil
end

proteger("acheter lampe", function() return acheter("lampe") end)
proteger("acheter velo", function() return acheter("velo") end)
local reste = proteger("acheter lampe", function() return acheter("lampe") end)

for _, ligne in ipairs(journal) do
  print(ligne)
end
print(#journal .. " opérations, " .. erreurs .. " erreur, il reste " .. reste .. " lampe")
