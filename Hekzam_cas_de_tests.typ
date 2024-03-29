#import "template.typ": base
#show: doc => base(
  // left_header:[],
  right_header:[Equipe scan-GUI-Automne-2024],
  title:[Projet Hekzam-GUI],
  subtitle:[Cas de tests pour le test du GUI],
  version:[0.1],
  doc
)

= Cas 1 : Idéal
L'utilisateur importe un *fichier source sans erreur de syntaxe*, choisi de générer 10 sujets différents dont les *questions* et *réponses* ont été *randomisées*.

Les copies récupérées après l'examen sont *propres et sans rature*, chaque champ est correctement reconnu, toutes les cases sont remplies au feutre noir et le scan de chaque copie est parfaitement lisible pour le logiciel

...

= Cas 2 : Vraisemblable
L'utilisateur importe un fichier source avec des erreurs de syntaxe, choisi de générer 10 sujets différents dont les questions et réponses ont été randomisées, mais reproduit chaque sujet 5 fois pour les distribuer à 50 étudiants. 

Les copies récupérées après l'examen sont pour certaines pliées, avec des agrafes dans certaines d'entre-elles. le résultat est que le scan de certaines copies paraissent plus gris que d'autres. On remarque des annotations sur chaque copie, des traces de Tippex sur certaines cases, des ratures. 
...

= Cas 3 : Nightmare
L'utilisateur importe un fichier source avec des erreurs de syntaxe et sémantiques (il manque des questions => _peut-on les détecter et avertir l'utilisateur?_), choisi de générer 5 sujets différents dont les questions et réponses ont été randomisées, mais reproduit chaque sujet 100 fois pour les distribuer à 500 étudiants. => très peu d'envie de la part du correcteur d'intervenir manuellement

Les copies récupérées après l'examen sont toutes *froissées*, avec des *agrafes* dans certaines d'entre-elles. le résultat est que le scan de certaines copies paraissent plus gris que d'autres, et le scanner a avalé de multiples copies en même temps (_quel solutions peut ont apporter à l'utilisateur ?_) On remarque des *annotations* sur chaque copie, des traces de *Tippex* sur certaines cases, des *ratures*, des réponses qui dépassent sur d'autres champs...
...A compléter