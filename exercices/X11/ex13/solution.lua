-- Fichier : salaire.lua
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
    print("ÉCHEC " .. nom .. " : " .. erreur)
  end
end

-- 35 premières heures au taux normal, heures supplémentaires payées 50 % de plus.
local function calculerSalaire(heures, taux)
  local normales = math.min(heures, 35)
  local sup = math.max(heures - 35, 0)           -- jamais négatif : pas d'heures sup avant 35 h
  return normales * taux + sup * taux * 3 // 2
end

test("35 h pile", function() egal(calculerSalaire(35, 10), 350) end)
test("40 h", function() egal(calculerSalaire(40, 10), 425) end)
test("30 h", function() egal(calculerSalaire(30, 10), 300) end)
test("0 h", function() egal(calculerSalaire(0, 10), 0) end)

print(reussis .. " / " .. total .. " tests réussis")
