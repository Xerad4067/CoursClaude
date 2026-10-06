-- Fichier : permis.lua
-- Une fonction qui répond par vrai ou faux : son nom commence par « est » ou « peut ».
local function estMajeur(age)
  return age >= 18                      -- la comparaison EST déjà un booléen
end

local function peutConduire(age, aLePermis)
  return estMajeur(age) and aLePermis   -- une fonction qui en utilise une autre
end

local function afficherVerdict(nom, age, aLePermis)
  if peutConduire(age, aLePermis) then  -- on peut l'utiliser directement dans un if
    print(nom .. " peut prendre le volant.")
  else
    print(nom .. " doit rester piéton.")
  end
end

afficherVerdict("Sam", 25, true)
afficherVerdict("Kim", 17, true)
afficherVerdict("Alex", 30, false)
print(estMajeur(18))
