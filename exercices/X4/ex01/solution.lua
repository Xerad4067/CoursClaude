-- Fichier : taxi.lua
-- Prise en charge de 3 €, puis 2 € par kilomètre.
local function prixCourse(km)
  return 3 + km * 2          -- la fonction renvoie le prix, elle n'affiche rien
end

print("Course de 1 km : " .. prixCourse(1) .. " €")
print("Course de 5 km : " .. prixCourse(5) .. " €")
print("Course de 12 km : " .. prixCourse(12) .. " €")
