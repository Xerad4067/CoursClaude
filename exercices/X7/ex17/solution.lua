-- Fichier : palindromes.lua
local function estPalindrome(texte)
  -- [^%a] : tout ce qui n'est PAS une lettre ; on le remplace par rien.
  -- gsub renvoie aussi un nombre : avec « local x = », on ne garde que le texte.
  local sansSymboles = string.gsub(texte, "[^%a]", "")
  local lettres = string.lower(sansSymboles)
  return lettres == string.reverse(lettres)
end

local phrases = {
  "Kayak",
  "Engage le jeu que je le gagne",
  "Le taxi de Sam",
  "Esope reste ici et se repose",
}
for _, phrase in ipairs(phrases) do
  if estPalindrome(phrase) then
    print(phrase .. " : oui")
  else
    print(phrase .. " : non")
  end
end
