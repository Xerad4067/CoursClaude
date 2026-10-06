-- Fichier : fizzbang.lua
local n = 105
local mot = ""

-- Trois if indépendants (pas de elseif) : chaque règle peut s'ajouter aux autres.
if n % 3 == 0 then mot = mot .. "Fizz" end
if n % 5 == 0 then mot = mot .. "Buzz" end
if n % 7 == 0 then mot = mot .. "Bang" end

if mot == "" then
  mot = tostring(n)       -- aucune règle ne s'applique : on affiche le nombre lui-même
end
print(mot)
