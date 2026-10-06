-- Fichier : clients.lua
local clients = { "Sam", "ABSENT", "ABSENT", "Kim", "ABSENT", "Alex" }

-- On parcourt de la FIN vers le début : retirer une case ne décale que celles
-- qu'on a déjà visitées.
for i = #clients, 1, -1 do
  if clients[i] == "ABSENT" then
    table.remove(clients, i)
  end
end

print(table.concat(clients, ", "))
