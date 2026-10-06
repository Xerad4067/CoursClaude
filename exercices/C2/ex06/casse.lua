-- Fichier : age.lua
-- Le videur de la boîte de nuit lit l'âge de trois clients au clavier.
for i = 1, 3 do
  io.write("Âge du client " .. i .. " : ")
  local age = io.read()
  if age >= 18 then
    print("Entrée acceptée")
  else
    print("Entrée refusée")
  end
end
