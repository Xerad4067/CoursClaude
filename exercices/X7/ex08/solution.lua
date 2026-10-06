-- Fichier : lecture-match.lua
local plaque = "AB-123-CD"
print(string.match(plaque, "%a+"))
print(string.match(plaque, "%d+"))
print(string.match(plaque, "^%d+"))
print(string.match(plaque, "(%a+)%-(%d+)"))
print(string.find(plaque, "%d+"))
print(string.match(plaque, "%-(%a+)$"))
print(string.match("AB123CD", "^%u%u%-?%d%d%d%-?%u%u$"))
