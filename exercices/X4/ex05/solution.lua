-- Fichier : prix-final.lua
local function retirerRemise(prix)    -- 10 % de remise
  return prix - prix * 10 // 100
end

local function ajouterTaxe(prix)      -- 20 % de taxe
  return prix + prix * 20 // 100
end

-- Une fonction peut en appeler d'autres : d'abord la remise, puis la taxe.
local function prixFinal(prix)
  return ajouterTaxe(retirerRemise(prix))
end

print("Prix final pour 200 € : " .. prixFinal(200) .. " €")
print("Prix final pour 50 € : " .. prixFinal(50) .. " €")
