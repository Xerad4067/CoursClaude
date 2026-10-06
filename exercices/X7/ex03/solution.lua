-- Fichier : chercher.lua
local message = "Le taxi de Kim attend devant le parc"

-- string.find renvoie deux nombres : la position de début et celle de fin
local debut, fin = string.find(message, "taxi")
print("taxi : de " .. debut .. " à " .. fin)
debut, fin = string.find(message, "parc")
print("parc : de " .. debut .. " à " .. fin)

-- si le mot est absent, string.find renvoie nil : c'est « faux » dans un if
for _, mot in ipairs({ "taxi", "bus", "parc" }) do
  if string.find(message, mot) then
    print(mot .. " : présent")
  else
    print(mot .. " : absent")
  end
end
