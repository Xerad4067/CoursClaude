# Fichier : caisse.py
argent = 100


def payer(prix):
    argent = argent - prix
    return argent


payer(30)
print(f"Il reste {argent} €")
