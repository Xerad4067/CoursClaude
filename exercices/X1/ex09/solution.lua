-- Fichier : tickets.lua
local a, b, c = 7, 123, 4567

-- %05d : un entier sur 5 caractères, complété par des zéros à gauche.
print(string.format("TICKET-%05d", a))
print(string.format("TICKET-%05d", b))
print(string.format("TICKET-%05d", c))
