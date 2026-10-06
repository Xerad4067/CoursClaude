# Fichier : pains.py
for _ in range(3):
    saisie = input("Combien de pains ? ")
    try:
        quantite = int(saisie)                 # lève ValueError si ce n'est pas un nombre entier
        print("  ->", quantite, "pain(s) :", quantite * 2, "euros")
    except ValueError:
        print("  -> « " + saisie + " » n'est pas un nombre entier")
