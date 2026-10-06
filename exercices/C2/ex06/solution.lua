-- Fichier : age.lua
-- Le videur de la boîte de nuit lit l'âge de trois clients au clavier.
for i = 1, 3 do
  io.write("Âge du client " .. i .. " : ")
  local age = tonumber(io.read())          -- io.read() donne du TEXTE : on le convertit
  if age == nil then
    print("Ce n'est pas un nombre")        -- tonumber a renvoyé nil : on ne compare pas
  elseif age >= 18 then
    print("Entrée acceptée")
  else
    print("Entrée refusée")
  end
end
