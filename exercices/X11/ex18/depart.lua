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
