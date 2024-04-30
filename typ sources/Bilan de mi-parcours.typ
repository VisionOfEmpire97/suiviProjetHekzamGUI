#import "template.typ": base
#import "@preview/cheq:0.1.0": checklist
#show: doc => base(
  // left_header:[],
  right_header : [Equipe scan-GUI-Printemps-2024],
  title: [Projet Hekzam-GUI],
  subtitle: [CC2 - Bilan de mi-Parcours],
  version: [],
  doc
)
#outline(
  title: none,
  target: heading.where(level: 1)
)

= Retours personnels

== Emilien SANCHEZ
La première partie du projet consistait, pour ma part, à travailler sur la *réalisation des exigences fonctionnelles*, des cas de test et des plans de test en se basant sur le prototype moyenne fidélité, en duo avec Nathan. 

La régularité des réunions de groupes et des rencontres avec notre responsable de projet nous a permis de rapidement identifier et éclaircir les différentes zones d’ombres du sujet.

Une fois le prototype validé, nous sommes passé à la seconde phase, la programmation. J’ai travaillé en collaboration avec Marco sur le tableau servant à lister et rechercher des copies. Nous nous sommes divisés les tâches: je devais personnellement m’occuper de la barre de recherche. 

Une des difficultés fut le choix entre utiliser un `QTableWidget` ou un `QStandardItemModel`, un `QSortFilterProxyModel` et une `QTableView` (c’est un affichage tableau suivant l’architecture Model/View en trois composants). Nous avons décidé de partir sur la `QTableWidget`, malgré son manque de flexibilité, pour sa lisibilité et facilité de compréhension. 

Pour la barre de recherche, je devais programmer 2 fonctionnalités : une recherche fonctionnant comme un ctrl+f, qui doit nous permettre de faire ressortir n’importe quel texte. La deuxième fonctionnalité était la recherche par tag. Je n’ai pas eu de difficulté particulière lors de la programmation.

Nous avons, en parallèle, mis en commun nos parties ce qui a généré différents problèmes d’affichage en fonction des systèmes d’exploitation. Une fois les problèmes réglés, il nous restera entre autre à définir un modèle de données pour les fichiers de l’utilisateur ainsi qu’à faire communiquer nos différents composants.

== Fabio YABAR
Mon objectif lors de ce projet était de conceptualiser et d'implémenter la base de *l'interface de l'application*, sans fonctionnalités. Etant donné que sans cette étape, le projet n'aurait pas pu avancer, il était nécessaire de la finir au plus tôt que possible.\ 

Heureusement, j'ai pu atteindre la majorité de mes objectifs dans les temps en créant le *menu principal* et la structure de la *fenêtre d'évaluation*, cependant je me suis confronté à quelques problèmes lors de la programmation de la *fenêtre de création*, résultant d’un mauvais ajout de layout.

Ce problème fut réglé en temps et en heure du premier milestone, me permettant ainsi de continuer vers la prochaine étape dans laquelle je vais devoir rendre l’ouverture des fichiers de scans fonctionnelle, ceci en collaboration avec les autres membres de l’équipe.
== Marco REGRAGUI MARTINS
Lors de la phase de prototypage, la tâche que je devais réaliser était *l’élaboration de la fenêtre d’évaluation*. La difficulté principale de cette tâche était d’obtenir un rendu qui correspondait aux attentes de notre encadrant. Grâce à ses retours sur les premières versions de la fenêtre j’ai pu finaliser le prototype avec succès. \ 
Concernant la phase de développement, le défi principal était de proposer un code qui respecte les normes du langage *C++* étant donné que je n’étais pas familier avec celui-ci.\  Afin de pallier à cela j’ai dû suivre une formation sur le langage *C++* et la librairie *Qt* avant de pouvoir commencer à coder. \ 
Nous sommes désormais au milieu de la phase de développement durant laquelle mon rôle est d’implémenter le tableau d’évaluation ainsi que le tri et l’affichage des différentes métriques qu’il contient. La difficulté principale à laquelle j’ai dû faire face était de trouver les modèles de composants les plus adaptés afin d’optimiser l’ergonomie de l’interface utilisateur. Ma tâche actuelle est d’assurer la communication du tableau avec le reste des composants en collaboration avec les autres membres du groupe. 

== Nathan ROSET
Durant cette période, j'ai implémenté la classe `ExamPreview` dont l'utilité première sera à terme de *visualiser* et d'*intéragir* avec les pages des copies afin de montrer à l'utilisateur les éléments reconnus par le programmen d'apprécier la qualité de la reconnaissance automatique, et de modifier/calibrer l'interprétation du scan au besoin.\ 
La partie *visualisation* de l'interface devait permettre de montrer à la fois la page sélectionnée en entier ainsi que des champs en particulier. Cela a été implémenté avec un `QDialog` et un `QStackedWidget`.\ 
J'ai rencontré quelques difficultés du fait de mon manque d'expérience avec Qt en essayant d'utiliser des classes non adaptées au besoin. De ce fait il m'a fallu remanier plusieures parties du programme afin d'obtenir un résultat agréable à utiliser pour l'utilisateur.


= Échéancier mis à jour 
#figure(
  image(
    "SCANGUI.png"
    )
)



= Répartition des tâches en %
// #pagebreak()

#let a = table.cell(        // 25%
  fill: blue.lighten(75%),
)[25%]
#let b = table.cell(        // 50%
  fill: blue.lighten(50%),
)[50%]
#let c = table.cell(        // 20%
  fill: blue.lighten(85%),
)[20%]
#let d = table.cell(        // 40%
  fill: blue.lighten(60%),
)[40%]
#let e = table.cell(        // 33%
  fill: blue.lighten(70%),
)[33%]
#let f = table.cell(        // 100%
  fill: blue.lighten(20%),
)[100%]


#table(
  columns: (auto, auto, auto, auto, auto ,auto),
  align: center,
  table.header(
    [ID tâche],[*Nom de la tâche*], [Nathan], [Fabio], [Marco], [Emilien],
  ),
  [WP 0.1], [Capture du besoin] ,a ,a ,a ,a,
  [WP 1], [Pilotage projet] ,a ,a ,a ,a,
  [WP 2], [Prototypage] ,a ,a ,a ,a,
  [WP 3.1], [Conception Fenêtre Principale] ,[] ,f ,[] ,[],
  [WP 3.1.1], [Implementation de la barre de menu] ,[] ,f ,[] ,[],
  [WP 3.2], [Elaboration du tableau] ,[] ,[] ,f ,[],
  [WP 3.2.2], [Filtrage du Tableau] ,[] ,[] ,[] ,f,
  [WP 3.3], [Visualisation du scan] ,f ,[] ,[] ,[],
  [WP 3.4], [Traitement des fichiers] ,e ,e ,e ,[],
  [WP3.5], [Interaction tableau/visualisation] ,e ,[] ,e ,e,
  [WP 3.6], [Interaction avec le scan] ,f ,[] ,[] ,[],
  [WP 3.7], [Configuration de l'UI] ,c ,d ,c ,c,
  [WP 3.8], [Test, déploiement, cross platform] ,a ,a ,a ,a,
  [WP 3.9], [Prise en charge des options du CLI] ,a ,a ,a ,a,
)

#pagebreak()
= Description des tâches
#linebreak()
#show: checklist.with(unchecked: sym.ballot, checked: sym.ballot.x)
- [x] *Capture du Besoin*
- [x] *Pilotage de projet*
- *Prototypage*
  - [x] Spécification des exigences
  - [x] Création Prototype moyenne fidélité

- *Conception fenêtre principale*
  - [x] Création du menu principal.
  - [x] Création du menu de création.
  - [x] Création du menu d'évaluation.

- *Implémentation de la barre menu.*
  - [ ] Fonctionnalités fichier (ouvrir, sauvegarder, fermer).
  - [ ] Fonctionnalités édition (undo, redo).
  - [ ] Fonctionnalités d'aide (ouverture de la doc utilisateur).

- *Elaboration du tableau*
  - [x] Création et remplissage du tableau
  - [x] Implémentation d'une barre de progression sous forme de cellule
  - [x] Gestion de l'affichage et du tri des colonnes

- *Filtrage du tableau*
  - [x] Création du champ de recherche
  - [x] Création de la fonction simple et multiples (fuzzy search...)
  - [x] Création de la fonction de recherche par tags

- *Visualisation du scan*
  - [x] Création des différentes scènes (grille et vue globale)
  - [x] Affichage de la fenêtre de visualisation externe

- *Traitement des fichiers*
  - [x] Ouverture via menu création.
  - [ ] Remplissage de la structure utilisée plus tard.
  - [x] Lecture et interprétation des fichiers JSON

- *Interaction tableau/visualisation*
  - [ ] Définition d'une interface de communication entre les modules
  - [ ] Méthodes de correspondances entre cellules du tableau et fichiers

- *Interaction avec le scan*
  - [ ] Reglage des métriques de cadrage
  - [ ] Interactions aves les différents champs d'une page (modifier, déplacer, highlight)

- *Configuration de l'UI.*
  - [ ] Options de configurations dans menu Affichage.
  - [ ] Sauvegarde de la configuration dans un fichier.

- *Test, déploiement, cross platform*
  - Tests non automatisés

- *Prise en charge des options du CLI *
  - [ ] Gestion des options (help,charger les fichiers de configs...)