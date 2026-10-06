# Fichier : plein.py
while True:
    texte = input("Combien de litres ? ")
    try:
        litres = int(texte)               # peut lever ValueError
    except ValueError:
        print("Ce n'est pas un nombre entier, recommence.")
        continue                          # retour au début de la boucle
    if litres <= 0:
        print("Il faut un nombre positif, recommence.")
        continue
    break                                 # saisie valide : on sort
print(f"Plein de {litres} litres validé")
