-- Fichier : defi-types.lua
print(type("42"))       -- du texte, à cause des guillemets
print(type(42.0))       -- un nombre…
print(math.type(42))    -- … entier
print(math.type(42.0))  -- … ou décimal
print(type(print))      -- une fonction est aussi une valeur
print(10 / 2)           -- la division / donne toujours un décimal
