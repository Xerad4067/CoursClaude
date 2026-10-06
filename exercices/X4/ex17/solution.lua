-- Fichier : plaques.lua
-- Un mot est un palindrome s'il se lit pareil dans les deux sens.
local function estPalindrome(mot)
  if #mot <= 1 then
    return true                                      -- cas de base : 0 ou 1 lettre
  end
  if string.sub(mot, 1, 1) ~= string.sub(mot, -1, -1) then
    return false                                     -- première et dernière lettres différentes
  end
  return estPalindrome(string.sub(mot, 2, -2))       -- on enlève les deux bouts et on recommence
end

for _, plaque in ipairs({ "ABBA", "TAXI", "RADAR", "GARAGE", "A" }) do
  if estPalindrome(plaque) then
    print(plaque .. " : palindrome")
  else
    print(plaque .. " : pas un palindrome")
  end
end
