# Fichier : plein.py
# Traduction du programme Lua : pas de « local », # pour les commentaires,
# f-string à la place de .., len() à la place de #.
argent = 130
prix_plein = 40
pleins = argent // prix_plein
reste = argent % prix_plein
nom = "Sam"
print(f"{nom} peut faire {pleins} pleins")
print(f"Il lui reste {reste} €")
print(f"La moitié de son argent : {argent / 2}")
print(len(nom))
