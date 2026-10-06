-- Fichier : file-vip.lua
local file = { "Kim", "Alex" }
table.insert(file, "Sam")                 -- arrivée normale : à la fin
table.insert(file, 1, "Robin (VIP)")      -- le VIP passe devant : position 1

print(table.concat(file, ", "))
print("Dans la file : " .. #file)
print("Premier : " .. file[1])
print("Dernier : " .. file[#file])
