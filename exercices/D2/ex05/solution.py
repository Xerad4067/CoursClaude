# Fichier : file_attente.py
file_attente = ["Kim", "Alex", "Sam"]
file_attente.sort()                          # trie sur place, comme table.sort
print("File : " + ", ".join(file_attente))   # join : le séparateur d'abord
premier = file_attente.pop(0)                # retire et renvoie le premier
print("Servi : " + premier)
print("Reste : " + ", ".join(file_attente))
