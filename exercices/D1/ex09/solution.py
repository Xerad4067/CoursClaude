# Fichier : location.py
argent = 150
permis = True
if argent >= 100 and permis:
    print("Location autorisée")
elif argent >= 50:
    print("Scooter seulement")
else:
    print("Marche à pied")
