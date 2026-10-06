# Fichier : fiche.py
joueur = {"nom": "Sam", "argent": 1500, "metier": "taxi"}
print(joueur["nom"])
joueur["argent"] = joueur["argent"] + 100
print(joueur["argent"])
joueur["permis"] = True                       # ajouter une clé
del joueur["metier"]                          # supprimer une clé (Lua : = nil)
print(joueur.get("metier", "sans métier"))    # get : valeur par défaut si absent
print("permis" in joueur)                     # in teste les CLÉS
for cle, valeur in joueur.items():            # items : clé ET valeur
    print(f"{cle} : {valeur}")
print(len(joueur))
