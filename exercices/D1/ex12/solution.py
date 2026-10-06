# Fichier : piege_zero.py
# En Lua, seuls nil et false sont faux. En Python, 0 et "" le sont aussi :
# pour garder le même comportement, on teste explicitement None.
argent = 0
permis = None
metier = ""

if argent is not None:
    print("Compte ouvert")
else:
    print("Pas de compte")

if permis is not None:
    print("Permis valide")
else:
    print("Pas de permis")

if metier is not None:
    print("Métier : [" + metier + "]")
else:
    print("Sans métier")

salaire = None
# « valeur if condition else autre » : l'équivalent sûr de salaire or 1200
print("Salaire :", salaire if salaire is not None else 1200)
prime = 0
print("Prime :", prime if prime is not None else 300)
