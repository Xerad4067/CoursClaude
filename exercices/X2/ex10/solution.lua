-- Fichier : lecture.lua
print(1 and 2)
print(nil and 2)
print(1 or 2)
print(false or nil)
print(nil or false)
print("[" .. ("" or "vide") .. "]")
print(0 and "zéro")
print(not nil, not 0)
