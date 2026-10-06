# Fichier : controle.py
age = 19
permis = True
suspendu = False
vitesse = 90
vehicule = None

if age >= 18 and permis and not suspendu:
    print("Conduite autorisée")
if 50 <= vitesse <= 130:          # comparaison « enchaînée » : possible en Python
    print("Vitesse légale")
if vehicule is None:              # pour tester None, on écrit « is None »
    print("Pas de véhicule enregistré")
