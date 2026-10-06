# Fichier : tarif_parc.py
age = int(input("Ton âge : "))
if age < 6:
    tarif = 0
elif age < 18:
    tarif = 5
elif age < 65:
    tarif = 12
else:
    tarif = 8
print(f"Âge : {age} ans")
print(f"Entrée du parc : {tarif} €")
