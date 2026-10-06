# Fichier : ticket.py
articles = [("Pain", 3, 1.5), ("Eau", 12, 0.8), ("Lampe", 1, 24.99)]

print(f"{'Article':<10}{'Qté':>5}{'Montant':>9}")
print("-" * 24)
total = 0
for nom, quantite, prix in articles:     # chaque tuple est « déballé » en 3 variables
    montant = quantite * prix
    total += montant
    print(f"{nom:<10}{quantite:>5}{montant:>9.2f}")
print("-" * 24)
print(f"{'Total':<15}{total:>9.2f}")
