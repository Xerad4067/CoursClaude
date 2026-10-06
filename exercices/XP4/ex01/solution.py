# Fichier : pseudo.py
# Un joueur a tapé son pseudo avec des espaces autour et sans majuscules.
saisie = "   kim la conductrice  "

pseudo = saisie.strip().title()   # strip : enlève les espaces autour ; title : une majuscule par mot

print("Avant : [" + saisie + "]")
print("Après : [" + pseudo + "]")
print("En majuscules : " + pseudo.upper())
