-- Fichier : lecture-glouton.lua
local texte = "[taxi] puis [bus] puis [parc]"
print(string.match(texte, "%[(.*)%]"))
print(string.match(texte, "%[(.-)%]"))
print(string.match(texte, "%[(%a+)%]"))
for nom in string.gmatch(texte, "%[(.-)%]") do
  print(nom)
end
print(string.gsub(texte, "%[(.-)%]", "<%1>"))
