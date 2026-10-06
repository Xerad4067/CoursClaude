# Fichier : sac.py
inventaire = ["pain", "eau", "lampe"]
print(inventaire[0])           # le premier : indice 0 !
print(len(inventaire))         # la taille : len(), pas #
inventaire.append("corde")     # ajoute à la fin
print(inventaire[-1])          # le dernier : indice -1
retire = inventaire.pop()      # retire ET renvoie le dernier
print(retire, len(inventaire))
print(inventaire[0:2])         # tranche : de l'indice 0 à 2 (2 exclu)
