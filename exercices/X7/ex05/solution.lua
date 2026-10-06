-- Fichier : codes.lua
print(string.byte("A"))                    -- code de la lettre A
print(string.byte("a"))                    -- code de la lettre a (différent !)
print(string.char(76, 117, 97))            -- de codes vers texte
print(string.char(string.byte("C") + 1))   -- code de C, plus 1, redevenu une lettre
