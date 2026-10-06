# Fichier : ticket.py
article = "pain"
prix = 3
quantite = 4
total = prix * quantite
print("Article : " + article)      # texte + texte : correct
print(f"Total : {total} €")         # la f-string convertit le nombre toute seule
# Autre solution possible : print("Total : " + str(total) + " €")
