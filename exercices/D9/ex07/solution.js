const vehicules = [
  { nom: "scooter", prix: 800 },
  { nom: "berline", prix: 12000 },
  { nom: "camionnette", prix: 9500 },
  { nom: "vélo", prix: 150 },
];
const budget = 1000;

// filter garde seulement les éléments pour lesquels la condition est vraie
const abordables = vehicules.filter((v) => v.prix <= budget);

// map transforme chaque élément (ici : on ne garde que le nom)
const noms = abordables.map((v) => v.nom);
console.log(noms.join(", "));

// map ne modifie pas la liste d'origine : elle en renvoie une nouvelle
const prixTTC = vehicules.map((v) => (v.prix * 120) / 100);
console.log(prixTTC.join(" / "));
console.log(vehicules.length);        // la liste d'origine est intacte
