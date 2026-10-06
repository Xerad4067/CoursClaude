-- Fichier : tests.lua (dans le même dossier que banque.lua)
local banque = require("banque")

local reussis, total = 0, 0

local function egal(obtenu, attendu)
  if obtenu ~= attendu then
    error("attendu " .. tostring(attendu) .. ", obtenu " .. tostring(obtenu), 0)
  end
end

local function test(nom, fonction)
  total = total + 1
  local ok, erreur = pcall(fonction)
  if ok then
    reussis = reussis + 1
    print("OK    " .. nom)
  else
    print("ÉCHEC " .. nom .. " : " .. tostring(erreur))
  end
end

-- Vérifie que la fonction lève une erreur-table portant le code attendu.
local function leve(code, fonction)
  local ok, erreur = pcall(fonction)
  if ok then
    error("aucune erreur levée (code " .. code .. " attendu)", 0)
  end
  egal(type(erreur) == "table" and erreur.code, code)
end

test("retrait valide", function()
  local compte = { solde = 100 }
  egal(banque.retirer(compte, 30), 70)
  egal(compte.solde, 70)
end)

test("retrait de tout le solde", function()
  local compte = { solde = 50 }
  egal(banque.retirer(compte, 50), 0)
end)

test("solde insuffisant -> SOLDE", function()
  local compte = { solde = 20 }
  leve("SOLDE", function() banque.retirer(compte, 50) end)
  egal(compte.solde, 20)                         -- rien n'a été retiré
end)

test("montant négatif -> MONTANT", function()
  leve("MONTANT", function() banque.retirer({ solde = 100 }, -5) end)
end)

test("montant en texte -> MONTANT", function()
  leve("MONTANT", function() banque.retirer({ solde = 100 }, "dix") end)
end)

print(reussis .. " / " .. total .. " tests réussis")
