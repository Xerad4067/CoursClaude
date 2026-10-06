# Fichier : joueur.py
class Joueur:
    def __init__(self, nom, argent):
        self.nom = nom
        self.argent = argent

    def __str__(self):
        # __str__ doit RENVOYER un texte (pas l'afficher avec print)
        return f"{self.nom} ({self.argent} €)"


sam = Joueur("Sam", 1500)
kim = Joueur("Kim", 900)

print(sam)  # print appelle __str__ automatiquement
print(kim)
message = "Bienvenue " + str(sam)  # str() appelle aussi __str__
print(message)
