-- Fichier : serialiser.lua
local function serialiser(t)
  local cles = {}
  for cle in pairs(t) do
    table.insert(cles, cle)
  end
  table.sort(cles)                          -- ordre stable
  local morceaux = {}
  for _, cle in ipairs(cles) do
    local v = t[cle]
    if type(v) == "string" then
      v = string.format("%q", v)            -- ajoute les guillemets
    else
      v = tostring(v)
    end
    table.insert(morceaux, cle .. " = " .. v)
  end
  return "{" .. table.concat(morceaux, ", ") .. "}"
end

local fiche = { nom = "Sam", argent = 1500, permis = true }
local texte = serialiser(fiche)
print(texte)

-- Uniquement pour NOS données : load exécute le texte comme du code.
local copie = load("return " .. texte)()
print(copie.nom, copie.argent, copie.permis)
