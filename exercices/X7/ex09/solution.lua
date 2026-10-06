-- Fichier : commande.lua
for _ = 1, 3 do
  io.write("> ")
  local message = io.read()
  -- %S+ : un mot sans espace ; %s+ : un ou plusieurs espaces ; %d+ : des chiffres
  local cmd, cible, montant = string.match(message, "^/(%S+)%s+(%S+)%s+(%d+)$")
  if cmd then
    print(cmd .. " -> " .. cible .. " : " .. tonumber(montant) .. " €")
  else
    print("commande invalide : " .. message)
  end
end
