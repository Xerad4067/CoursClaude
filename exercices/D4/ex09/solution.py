# Fichier : joueur.py
class Joueur:
    serveur = "RP Horizon"  # attribut de classe : commun à tous les joueurs
    nombre = 0              # attribut de classe : compteur partagé

    def __init__(self, nom):
        self.nom = nom      # attribut d'instance : propre à chaque joueur
        Joueur.nombre = Joueur.nombre + 1


sam = Joueur("Sam")
kim = Joueur("Kim")
alex = Joueur("Alex")

print(Joueur.nombre)
print(sam.serveur)

Joueur.serveur = "RP Horizon 2"  # on change la valeur pour tout le monde
print(kim.serveur)

# crée un attribut d'instance, qui masque celui de la classe pour Kim seule
kim.serveur = "Serveur de Kim"
print(kim.serveur, "/", alex.serveur, "/", Joueur.serveur)
