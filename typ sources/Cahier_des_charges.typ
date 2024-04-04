#import "template.typ": base
#show: doc => base(
  // left_header:[],
  right_header : [Equipe scan-GUI-Automne-2024],
  title: [Projet Hekzam-GUI],
  subtitle: [Cahier des charges],
  version: [1.1],
  doc
)
//TODO : make it so requirement list numbering keeps incrementing properly past other headings
//can't query numbered lists (enums), currently a Typst limitation
#set enum(
  numbering: ("EX_1.a :"),
  tight: false,
  full: true,
  spacing: 2em,
)

#set list( 
  tight: false,
  spacing: 1fr,
  indent: 5pt
)

#outline(
  title: none,
  target : heading
)

= Objectifs 
Le but du projet est de réaliser une interface graphique principale pour le logiciel Hekzam, dont l'objectif est d'évaluer automatiquement des copies d'examens afin d'en extraire des informations statistiques. Les utilisateurs ciblés font partie du personnel de l'université (enseignants, secrétaires).
= Definitions :
(*HYPOTHÈSES DE DÉBUT DE PROJET*)
- *projet* : représente un répertoire regroupant tous les fichiers relatifs à la l'évaluations des copies
- *sujet* : fichier pdf obtenu en compilant un fichier source avec Typst, peut comprendre plusieurs pages
- *programme* : Logiciel Hekzam complet#link("https://github.com/hekzam")[(GUI + parser + generator)], supposé fonctionnel
- *pages*: image extraite d'un fichier pdf; scan d'une page associé à une page d'un sujet
- *copie*: ensemble de pages regroupées, l'ensemble formant une copie d'examen associée à un étudiant 
#pagebreak()
= Capture du besoin
== Exigences non-fonctionnelles 
-  Le programme doit être performant et léger
-  Le programme doit être développé de manière maintenable
// -  #strike[Le programme doit proposer des fonctions unitaire]
// ne pas modifier autre chose que les paramètres
-  Le programme doit proposer une documentation utilisateur devra être robuste, mais minimale et simple
-  Le programme doit être développé dans un des langages mentionnés Qt C++, GTK Rust
// -  #strike[Le programme ne doit pas utiliser de templates (méta-programmation)]
// pas une obligation
-  Le programme doit proposer une interface simple pour tout utilisateur (informaticien on non)
-  Le programme doit être open source sous licence APACHE2
-  Les tests du programme doivent être effectués en même temps que le développement
-  Le projet utilisera le système de Version contrôle Git
-  Fournir un fichier README 
-  Faire des commits de moins de 50 caractères à l'impératif
-  Un compte rendu sera fait à chaque réunion avec l'encadrant
-  Les fonctionnalités (features) devront être séparées sous différentes branches dans GitHub 
== Exigence fonctionnelles
// mieux sous forme de schéma ?
// #show figure: set block(breakable: true)
#figure(
  image("Exigences_rev1_f1.svg"
  ),
)
#figure(
    image("Exigences_rev1_f2.svg"    
  ),
)
#figure(
  image("Exigences_rev1_f3.svg"    
  ),
)
// === Création du sujet
// - L'utilisateur doit pouvoir accéder aux autres fonctionnalités du programme après avoir satisfait l'une de ces pré-conditions 
//   - L'utilisateur doit pouvoir *ouvrir* un "projet" localisé dans un dossier
//   - L'utilisateur doit pouvoir *créer* un projet en sélectionnant un fichier source


// === Import des copies scannées
// #set enum(start: 6) //why do I have to do this
// - L'utilisateur devrait pouvoir importer tout ou partie des items suivants: 
//   - un *fichier de scans de copies* au format pdf 
//   - des scans de copies au format jpeg

// === Identification des pages en copies 
// #set enum(start: 9)
// - L'utilisateur devrait pouvoir importer une "*feuille de présence*" ( liste de copies attendues) qui devrait être analysable par le programme *ou* garder les copies anonymes.
// - L'interface devra remonter si certaines copies manquent en fonction du nombre d'entrées présentes sur la feuille de présence

// === Analyse de la copie
// #set enum(start: 12)
// - L'interface devra indiquer à l'utilisateur la qualité des scans grâce à des indicateur numériques (RMSE, taux de certitude...)
// - L'interface devra porter à l'attention de l'utilisateur les erreurs :
//   - relatives à la qualité de la numérisation
//   - syntaxiques
//   - sémantiques
// - Le programme devra porter à l'attention de l'utilisateur si certaines copies scannées sont *illisibles* par le parser, ou se trouve en deçà d'un *seuil d'acceptabilité*

// === Correction des copies
// #set enum(start: 16)
// - Le programme devrait retourner *en sortie* des fichiers (*json?*) pour *visualiser les données*
// - le programme devrait laisser la possibilité à l’utilisateur de *modifier la correction* de chaque copie si besoin
// - L'interface devra indiquer si *l'utilisateur a modifié une valeur*, telle que réponse à une question ou numéro étudiant...
// - L'interface doit afficher chaque question présente sur chaque copie  individuellement 

// === Déroulement du programme
// #set enum(start: 23)
// - on doit pouvoir sauvegarder le projet et exporter le fichier de sortie
// - Le programme devra avoir une interface navigable au clavier

= Rôles 

#figure(
  image("wbs-OBS.svg",
  width: 100%),
//   caption: [
//     #grid(columns: 2,
//     stroke: (x, y) => if x == 0 and y == 0 {
//       (right: (
//         paint: luma(50),
//         thickness: 1.5pt,
//         dash: "dotted"
//       ))
//     },)[
// - ROSET Nathan, SANCHEZ Emilien : 
// rédactions des spécifications et cas de tests, briques de codes
//     ][
// - YABAR Fabio, REGRAGUI MARTINS Marco :
// chargés prototypages et documentation
//     ]  
//   ]
)

= Délivrables
- Rapport de groupe
- Cahier des charges
- Code prototype 
- Comptes rendu personnels	
- Dépôt GIT
- Soutenance
- Documentation utilisateur + Fichier README

#figure(
  image("wbs-WBS.drawio.svg",
  format: "svg",
  )
)
= Echéancier

#figure(
  image("SCANGUI.png",
  width: 100%)
)
