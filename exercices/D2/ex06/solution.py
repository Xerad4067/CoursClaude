# Fichier : garage.py
garage = ["taxi", "bus", "moto"]
for numero, vehicule in enumerate(garage, start=1):   # numérote à partir de 1
    print(f"{numero}. {vehicule}")
# Autre solution : for i in range(len(garage)): print(f"{i + 1}. {garage[i]}")
