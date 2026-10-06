# Fichier : structures.py
a = [1, 2, 3]
b = a                  # b désigne la MÊME liste que a
b[0] = 100
print(a)

c = a[:]               # une vraie copie (tranche complète)
c[1] = 200
print(a, c)

courses = ["pain", "eau", "lampe", "corde", "sel"]
print(courses[1:3])
print(courses[:2])
print(courses[-2:])

position = (3, 7)      # un tuple : une liste figée
x, y = position        # déballage : x vaut 3, y vaut 7
print(x + y)

tags = {"rp", "taxi", "rp", "taxi", "bus"}   # un ensemble : pas de doublon
print(len(tags))
print("bus" in tags)
