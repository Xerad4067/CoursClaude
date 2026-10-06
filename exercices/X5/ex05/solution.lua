-- Fichier : lecture.lua
local sac = { "pain", "eau", "lampe" }
table.insert(sac, 2, "corde")
print(table.concat(sac, ","))
local retire = table.remove(sac, 1)
print(retire)
print(table.concat(sac, ","))
table.insert(sac, "clé")
print(#sac)
print(table.remove(sac))
print(table.concat(sac, ","))
