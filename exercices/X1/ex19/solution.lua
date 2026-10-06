-- Fichier : moyenne.lua
-- Moyenne des trois notes de Sam : 12, 15 et 18.
local note1, note2, note3 = 12, 15, 18
local moyenne = (note1 + note2 + note3) / 3   -- les parenthèses imposent d'additionner AVANT de diviser
print("Moyenne : " .. moyenne)
