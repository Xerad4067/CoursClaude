-- Fichier : format.lua
print(string.format("%.2f", 3.14159))                    -- 2 décimales
print(string.format("%d pièces", 5))                     -- un entier
print(string.format("%s gagne %d € par heure", "Sam", 12))
print(string.format("%5d|", 42))                         -- 5 caractères, aligné à droite
