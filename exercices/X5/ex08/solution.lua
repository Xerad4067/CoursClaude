-- Fichier : prix-ttc.lua
local prixHT = { 10, 25, 40, 65 }

-- On transforme chaque élément pour fabriquer une nouvelle liste (la taxe est de 20 %).
local prixTTC = {}
for i, prix in ipairs(prixHT) do
  prixTTC[i] = prix + prix * 20 // 100
end

print("Prix HT : " .. table.concat(prixHT, ", "))
print("Prix TTC : " .. table.concat(prixTTC, ", "))
