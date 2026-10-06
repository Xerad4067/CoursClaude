# Fichier : json_texte.py
import json

inventaire = {"pain": 3, "eau": 12, "épée": 1}

texte = json.dumps(inventaire)                       # dict -> texte (les accents sont codés \uXXXX)
print(texte)

texte_lisible = json.dumps(inventaire, ensure_ascii=False)   # garde les accents tels quels
print(texte_lisible)

retour = json.loads(texte_lisible)                   # texte -> dict
print(retour == inventaire)
print(type(texte).__name__, type(retour).__name__)

retour["pain"] += 2
print(retour["pain"])
