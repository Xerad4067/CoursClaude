# Fichier : division.py
def diviser(a, b):
    try:
        resultat = a / b
    except ZeroDivisionError:
        print("  erreur : division par zéro")
        return None
    else:
        print("  ça a marché")
        return resultat
    finally:
        print("  fin du calcul")


print("Essai 1")
print(diviser(10, 2))
print("Essai 2")
print(diviser(5, 0))
