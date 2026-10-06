-- Fichier : tests.lua
local function prixAvecRemise(prix, pourcent)
  return prix - prix * pourcent // 100
end

local reussis, total = 0, 0

-- Lève une erreur si les deux valeurs diffèrent.
local function egal(obtenu, attendu)
  if obtenu ~= attendu then
    error("attendu " .. tostring(attendu) .. ", obtenu " .. tostring(obtenu), 0)
  end
end

-- Lance la fonction de test dans un pcall et affiche le verdict.
local function test(nom, fonction)
  total = total + 1
  local ok, erreur = pcall(fonction)
  if ok then
    reussis = reussis + 1
    print("OK    " .. nom)
  else
    print("ÉCHEC " .. nom .. " : " .. erreur)
  end
end

test("remise de 10 %", function() egal(prixAvecRemise(200, 10), 180) end)
test("remise nulle", function() egal(prixAvecRemise(80, 0), 80) end)
test("remise de 50 %", function() egal(prixAvecRemise(80, 50), 30) end)   -- faux exprès

print(reussis .. " / " .. total .. " tests réussis")
