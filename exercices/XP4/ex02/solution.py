# Fichier : commande.py
message = "/donner Sam 250"

morceaux = message.split()        # sans argument : coupe sur les espaces
print(morceaux)

commande = morceaux[0]
cible = morceaux[1]
montant = int(morceaux[2])        # les morceaux sont des textes : on convertit en nombre

print("Commande :", commande)
print("Cible :", cible)
print("Montant doublé :", montant * 2)

# split peut aussi couper sur un autre séparateur, par exemple la virgule
objets = "pain,eau,lampe".split(",")
print(objets)
