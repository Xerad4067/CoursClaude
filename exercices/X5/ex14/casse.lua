-- Fichier : clients.lua
local clients = { "Sam", "ABSENT", "ABSENT", "Kim", "ABSENT", "Alex" }

for i = 1, #clients do
  if clients[i] == "ABSENT" then
    table.remove(clients, i)
  end
end

print(table.concat(clients, ", "))
