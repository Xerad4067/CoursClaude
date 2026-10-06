# Fichier : caisse.py
def payer(argent, prix):
    return argent - prix        # la fonction renvoie le résultat


argent = 100
argent = payer(argent, 30)      # on récupère le résultat dans la variable
print(f"Il reste {argent} €")
