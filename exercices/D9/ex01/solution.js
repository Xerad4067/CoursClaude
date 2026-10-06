// bonjour.js : lance-le avec « node bonjour.js »

const serveur = "Port-Soleil RP"; // const : cette valeur ne changera jamais
let joueur = "Sam";               // let : cette valeur pourra changer
let argent = 1500;

console.log("Bienvenue sur " + serveur);
// Entre des accents graves (backticks), ${...} insère la valeur d'une variable
console.log(`Bonjour ${joueur}, tu as ${argent} €.`);

argent = argent + 250;            // let permet de modifier la variable
console.log(`Après ton salaire : ${argent} €`);
