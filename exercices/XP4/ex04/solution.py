# Fichier : censure.py
message = "Ce serveur est nul, vraiment nul !"

filtre = message.replace("nul", "***")   # replace renvoie un NOUVEAU texte

print("Reçu : " + message)               # l'original n'a pas changé
print("Affiché : " + filtre)
