# Fichier : quantite.py
def lire_quantite(texte):
    try:
        quantite = int(texte)
    except ValueError:
        raise ValueError("« " + texte + " » n'est pas un nombre entier")
    if quantite < 1:
        raise ValueError("la quantité doit être au moins 1")
    return quantite


while True:
    saisie = input("Quantité à acheter : ")
    try:
        quantite = lire_quantite(saisie)
    except ValueError as erreur:               # erreur contient le message du raise
        print("Refusé :", erreur)
    else:
        print("Quantité acceptée :", quantite)
        break                                  # saisie valide : on sort de la boucle
