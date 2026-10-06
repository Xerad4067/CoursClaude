-- Fichier : devinettes.lua
local secret = math.random(1, 100)   -- nombre secret entre 1 et 100
local essais = 0
local trouve = false

print("J'ai choisi un nombre entre 1 et 100. À toi de deviner !")
while not trouve do
  io.write("Ton nombre : ")
  local saisie = tonumber(io.read())  -- nil si ce n'est pas un nombre
  if saisie == nil then
    print("Ce n'est pas un nombre, réessaie.")
  else
    essais = essais + 1
    if saisie < secret then
      print("C'est plus !")
    elseif saisie > secret then
      print("C'est moins !")
    else
      trouve = true
      print("Bravo, trouvé en " .. essais .. " essais !")
    end
  end
end
