# Fichier : salaire.py
total = 0
for jour in range(1, 8):
    if jour == 4:
        continue            # jour de repos : on saute au tour suivant
    total += 85             # += ajoute 85 à total
print("Salaire de la semaine :", total)

argent = 100
tours = 0
while True:                 # boucle « infinie » volontaire…
    argent = argent * 2
    tours += 1
    if argent >= 1000:
        break               # … dont on sort avec break
print(f"{argent} € après {tours} tours")
