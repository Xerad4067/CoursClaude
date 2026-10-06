# Fichier : chat.py
messages = [
    "/aide",
    "Bonjour tout le monde",
    "/donner Kim 50",
    "Qui veut jouer ?",
    "/quitter",
]

commandes = []
nb_questions = 0
for message in messages:
    if message.startswith("/"):      # le message commence par / ?
        commandes.append(message)
    if message.endswith("?"):        # le message finit par ? ?
        nb_questions += 1

print("Commandes :", commandes)
print("Messages normaux :", len(messages) - len(commandes))
print("Questions :", nb_questions)
