# Fichier : distributeur.py
montant = int(input("Montant à retirer : "))

billets_50 = montant // 50      # combien de billets de 50 ?
montant = montant % 50          # ce qu'il reste à distribuer
billets_20 = montant // 20
montant = montant % 20
billets_10 = montant // 10
reste = montant % 10            # moins de 10 € : impossible à distribuer

print(f"Billets de 50 : {billets_50}")
print(f"Billets de 20 : {billets_20}")
print(f"Billets de 10 : {billets_10}")
print(f"Reste non distribuable : {reste} €")
