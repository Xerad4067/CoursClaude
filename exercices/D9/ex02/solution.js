// Une fonction classique : elle renvoie le gain d'une journée
function salaireJour(heures, tauxHoraire) {
  return heures * tauxHoraire;
}

// Une fonction fléchée (arrow function) : même idée, écriture plus courte
const salaireSemaine = (jours, parJour) => jours * parJour;

// Un paramètre peut avoir une valeur par défaut (ici 10 %)
const prixRemise = (prix, pourcentage = 10) => prix - (prix * pourcentage) / 100;

console.log(salaireJour(7, 12));        // 84
console.log(salaireSemaine(5, 84));     // 420
console.log(`Kim gagne ${salaireJour(4, 15)} €`);
console.log(prixRemise(200));           // 180 : le pourcentage par défaut est utilisé
console.log(prixRemise(200, 25));       // 150
