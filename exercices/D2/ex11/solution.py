# Fichier : solution.py (à côté de taxes.py)
import taxes
from taxes import TAUX_TVA

prix_ht = 200
print(f"TVA : {TAUX_TVA} %")
print(f"Prix TTC : {taxes.ttc(prix_ht)} €")
print(f"Avec 10 % de remise : {taxes.appliquer_remise(prix_ht)} €")
