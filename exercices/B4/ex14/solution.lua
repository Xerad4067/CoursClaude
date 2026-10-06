-- Fichier : sept-essais.lua
local secret = math.random(1, 100)
local essaisMax = 7
local essais = 0
local trouve = false

print("J'ai choisi un nombre entre 1 et 100. Tu as " .. essaisMax .. " essais.")
while not trouve and essais < essaisMax do      -- deux raisons d'arrêter : gagné OU plus d'essais
  io.write("Ton nombre : ")
  local saisie = tonumber(io.read())
  if saisie == nil then
    print("Ce n'est pas un nombre, réessaie.")  -- pas d'essai compté
  else
    essais = essais + 1
    if saisie < secret then
      print("C'est plus ! (essais restants : " .. essaisMax - essais .. ")")
    elseif saisie > secret then
      print("C'est moins ! (essais restants : " .. essaisMax - essais .. ")")
    else
      trouve = true
      print("Bravo, trouvé en " .. essais .. " essais !")
    end
  end
end

if not trouve then                              -- la boucle s'est arrêtée faute d'essais
  print("Perdu ! Le nombre secret était " .. secret .. ".")
end
