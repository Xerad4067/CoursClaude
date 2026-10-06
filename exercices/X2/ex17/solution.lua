-- Fichier : lecture.lua
local a, b, c = nil, false, 0

print(a == nil and "vide" or "plein")
print(c == 0 and false or "plein")
print(a or b)
print(a and b)
print(b or c)
print(not a == not b)
print(not a == b)
