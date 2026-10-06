# Fichier : fiche_et_ticket.py
# Partie 1 : la fiche de personnage (retrouve B1)
nom = input("Nom du personnage : ")
metier = input("Métier : ")
argent = int(input("Argent : "))
age = 24
permis = True

print("=== Fiche du personnage ===")
print("Nom :", nom)
print("Âge :", age)
print("Métier :", metier)
print(f"Argent : {argent} €")
print("Permis de conduire :", permis)
if argent >= 1000:
    statut = "à l'aise"
elif argent >= 100:
    statut = "correct"
else:
    statut = "fauché"
print("Situation :", statut)

# Partie 2 : le ticket de caisse (retrouve B2)
prix_pain, quantite_pain = 1.20, 2
prix_eau, quantite_eau = 0.80, 3

total_pain = prix_pain * quantite_pain
total_eau = prix_eau * quantite_eau
total = total_pain + total_eau

print()
print("=== Supérette du parc ===")
print(f"Pain x{quantite_pain} : {total_pain:.2f} €")
print(f"Eau x{quantite_eau} : {total_eau:.2f} €")
print("-" * 20)
print(f"TOTAL : {total:.2f} €")
print(f"dont TVA (20 %) : {total * 20 / 120:.2f} €")

# Partie 3 : le paiement
if total <= argent:
    print(f"{nom} paie et garde {argent - total:.2f} €")
else:
    print(f"{nom} n'a pas assez d'argent")
