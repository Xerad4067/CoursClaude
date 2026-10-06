# Fichier : comparer.py
class Joueur:
    def __init__(self, nom, argent):
        self.nom = nom
        self.argent = argent

    def __eq__(self, autre):
        # deux joueurs sont « égaux » s'ils ont le même nom et le même argent
        return self.nom == autre.nom and self.argent == autre.argent


a = Joueur("Sam", 1500)
b = Joueur("Sam", 1500)
c = Joueur("Kim", 900)

print(a == b)       # même contenu
print(a is b)       # mais deux objets différents
print(a == c)
joueurs = [a, c]
print(b in joueurs)  # `in` utilise == pour chercher dans la liste
