# Fichier : fonctions.py
def saluer(nom):
    print(f"Bienvenue, {nom} !")


def salaire_jour(heures, taux_horaire=12):   # 12 : valeur par défaut
    return heures * taux_horaire


def diviser(a, b):
    return a // b, a % b                     # deux valeurs renvoyées (un tuple)


saluer("Sam")
saluer("Kim")
print(salaire_jour(7))          # taux par défaut : 7 * 12
print(salaire_jour(4, 15))      # taux donné : 4 * 15
pleins, reste = diviser(130, 40)
print(f"{pleins} pleins, reste {reste} €")
