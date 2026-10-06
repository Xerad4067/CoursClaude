const sac = ["pain", "eau", "lampe"];

console.log(sac[0]);                 // pain : le premier est à l'indice 0 (en Lua, ce serait 1)
console.log(sac.length);             // 3 : nombre d'éléments (en Lua : #sac)

sac.push("corde");                   // ajoute à la fin (en Lua : table.insert)
console.log(sac[sac.length - 1]);    // corde : le dernier est à l'indice taille - 1

console.log(sac[10]);                // undefined : cette case n'existe pas (en Lua : nil)

// for...of parcourt les éléments dans l'ordre
for (const objet of sac) {
  console.log(`- ${objet}`);
}
