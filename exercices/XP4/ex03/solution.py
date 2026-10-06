# Fichier : sac.py
inventaire = ["pain", "eau", "lampe", "corde"]

print("Dans ton sac : " + ", ".join(inventaire))   # le séparateur est devant .join
print("-".join(inventaire))

lettres = ["P", "Y", "T", "H", "O", "N"]
print("".join(lettres))                            # séparateur vide : on colle sans rien entre
