-- Fichier : panneau.lua
local function encadrer(texte)
  -- la bordure fait 2 tirets de plus que le texte (un espace de chaque côté)
  local bordure = "+" .. string.rep("-", #texte + 2) .. "+"
  print(bordure)
  print("| " .. texte .. " |")
  print(bordure)
end

encadrer("Garage de Sam")
encadrer("Parc")
