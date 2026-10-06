# Fichier : sac.py
import json
import os

inventaire = {"pain": 3, "eau": 12}

try:
    with open("sac.json", "w", encoding="utf-8") as fichier:
        json.dumps(inventaire, fichier)
    with open("sac.json", "r", encoding="utf-8") as fichier:
        recharge = json.loads(fichier)
    print(recharge)
    print(recharge == inventaire)
finally:
    os.remove("sac.json")                        # nettoyage, même si le programme plante
