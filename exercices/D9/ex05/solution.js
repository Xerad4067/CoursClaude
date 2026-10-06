let metier = "mécanicien";
let salaire = 15;

// === compare sans rien modifier. Un seul = AFFECTE (il écrase la variable).
if (metier === "taxi") {
  salaire = salaire + 3; // bonus réservé aux taxis
}

console.log(`Métier : ${metier}, salaire : ${salaire} €`);
