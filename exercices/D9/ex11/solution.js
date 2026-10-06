const inventaire = { pain: 3, eau: 2, lampe: 1 };

// stringify : objet -> texte (utile pour sauvegarder ou envoyer)
const texte = JSON.stringify(inventaire);
console.log(texte);
console.log(typeof texte);

// parse : texte -> objet. On obtient une copie indépendante.
const copie = JSON.parse(texte);
copie.pain = copie.pain - 1;
console.log(copie.pain, inventaire.pain);

// Avec des arguments en plus, stringify met en forme (2 espaces d'indentation)
console.log(JSON.stringify({ nom: "Sam", argent: 1500 }, null, 2));

// Un texte qui n'est pas du JSON valide fait planter parse : try/catch rattrape l'erreur
try {
  JSON.parse("pas du json");
} catch (erreur) {
  console.log("Lecture impossible :", erreur.name);
}
