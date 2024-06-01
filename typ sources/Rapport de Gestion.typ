#import "template.typ": base
#import "@preview/cheq:0.1.0": checklist
#show: doc => base(
  // left_header:[],
  right_header : [Equipe scan-GUI-Printemps-2024],
  title: [Projet Hekzam-GUI],
  subtitle: [Rapport de gestion],
  version: [],
  authors:(
    (
    name: "REGRAGUI MARTINS Marco",
    affiliation:"Paul Sabatier University",
    email:"",
    ),
    ( 
    name: "ROSET Nathan",
    affiliation:"Paul Sabatier University",
    email:"",
    ),
    (
    name: "SANCHEZ Emilien",
    affiliation:"Paul Sabatier University",
    email:"",
    ),
    (
    name: "YABAR Fabio",
    affiliation:"Paul Sabatier University",
    email:"",
    )
  ),
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
Lors de ce projet, j’eu trois tâches majeures à accomplir, devant implémenter et maintenir l’*interface générale* du programme, manipuler les *données de sauvegarde* et la *configuration utilisateur* et enfin créer une *CLI*. Je vais m’étendre sur chacun de ces points afin d’en relever les réussites et les échecs, pour finalement conclure sur ce projet.

Concernant la phase de développement de l’*interface*, il était nécessaire de la finir au plus vite afin que les autres membres de l’équipe puissent avancer, je m’y suis donc concentré sur l’espace d’une à deux journées pour créer quelque chose de cohérent et stable, mais d’incomplet. En effet, le *menu principal* et la structure de la *fenêtre d’évaluation* furent simples à implémenter, cependant la *fenêtre de création* prit plus de temps, ceci résultat d’un changement de widget pour la conception du formulaire. Par la suite, j’eu à maintenir cette structure en adéquation avec les changements de mon groupe et les demandes effectuées par le client, menant par exemple à l’inversion de l’ordre des `QSplitter` dans la fenêtre d’évaluation. En résumé, cette phase fut la moins périlleuse.

Ce ne fut pas le cas de la seconde phase de développement à laquelle j’ai fait face, celle-ci étant de créer et manipuler les *données de sauvegarde* et la *configuration utilisateur*. Concernant la *sauvegarde*, on s’est rapidement rendu compte en réunion qu’on serait dans l’incapacité de sauvegarder l’état actuel du tableau tant que celui-ci ne serait pas complet, il fut donc décidé de ne sauvegarder que l’état originel des données, ce que j’ai pû faire avec succès. Cependant, je pense que j’aurai pû faire mieux que cela, surtout dans la façon de sauvegarder un fichier où il aurait été plus logique de laisser à l’utilisateur nommer sa sauvegarde et choisir le répertoire où sauvegarder, plutôt que de juste demander un répertoire, ceci permettant d’avoir plusieurs sauvegardes en un emplacement. Pour la *configuration*, celle-ci aussi fut très dépendante de l’évolution des modules des autres, ceci menant à une conception de bas niveau, avec seulement la taille et position de la fenêtre retenues. Je suis un peu déçu de moi sur cette partie et je pense que si je n’avais pas été aussi encombré par les examens, j’aurai pû créer un système de configuration bien plus exhaustif que ce qui est aujourd’hui présent.

Enfin, il fut demandé d’intégrer une *CLI*, ce qui s'avèrera être une tâche complexe, moi même travaillant sur *Windows*. En effet, mon Powershell ne voulait en aucun cas exécuter le programme et j’eu donc à programmer à l’aveugle, ceci quelques jours avant la dernière réunion. Heureusement, mon premier essai fut le bon, mais on m’a fait savoir que j’aurai pû utiliser un `QCommandLineParser` qui, après lecture de la documentation, serait en effet plus simple à implémenter et beaucoup plus efficace. J'aurais souhaité créer une CLI beaucoup plus extensive avant la fin du projet, mais ce ne fut malheureusement pas le cas.

En conclusion, ce projet m’a apporté de nouvelles compétences en programmation et en travail de groupe. J’ai découvert le langage *C++* ainsi que l’API *Qt* qui pourront m’être utiles dans le futur, étant donné que j’ai trouvé cela très intuitif et efficace. J’ai pû également découvrir de nouvelles fonctionnalités de *Git* et le langage *Typst* qui fut utile pour nos rapports. Travailler sur ce projet et avec ce groupe fut une bonne expérience, il n’y a pas eu de conflits interne et notre rythme de travail est toujours resté fluide, permettant ainsi au projet de ne pas stagner, même lors de périodes d’examens, d’autant plus qu’on était là pour aider les autres. En général, si on me proposait de travailler sur un projet similaire avec la même équipe, j’accepterais sans hésiter, et en évitant de refaire les mêmes erreurs du passé.

== Marco REGRAGUI MARTINS
Lors de la phase de prototypage, la tâche que je devais réaliser était *l’élaboration de la fenêtre d’évaluation*. La difficulté principale de cette tâche était d’obtenir un rendu qui correspondait aux attentes de notre encadrant. Grâce à ses retours sur les premières versions de la fenêtre j’ai pu finaliser le prototype avec succès.

Concernant la phase de développement, le défi principal était de proposer un code qui respecte les normes du langage *C++* tout en exploitant les fonctionnalités de la librairie *Qt*. Étant donné que je n’étais pas familier avec ces langages, j’ai dû suivit deux formations afin d'avoir une meilleure compréhension sur le sujet avant de pouvoir commencer à coder.

La première tâche qui m'a été assignée était d'*effectuer le tableau d'évaluation* visant à donner une vue détaillée de chaque donnée provenant d'un examen. La difficulté principale à laquelle j’ai dû faire face était de trouver les modèles de composants les plus adaptés afin d’optimiser l’ergonomie de l’interface utilisateur. J'ai dû tester plusieurs dispositions avant de trouver le tableau le plus optimal ce qui m'a aussi permis de prendre la librairie *Qt* en main ainsi que sa notion de *Qt Widgets*. \ Le tableau résultant de ces tests est un `QTableWidget` comportant 5 colonnes au moment de sa réalisation : *Nom*, *Syntaxe*, *Sémantique* et deux métriques arbitraires visant à démontrer la modularité du tableau.\ En parallèle, j'ai dû *créer un composant personnalisé* couplant un `QTableWidgetItem` et une `QProgressBar` afin de pouvoir afficher l'évolution de la syntaxe sous forme de barre de progression. Ceci m'a introduit à la notion de *double héritage* et aux potentielles difficultés d'une telle approche tel que le *problème du diamant*. Fort heureusement, je n'ai jamais eu à faire face à ce genre de problématiques lors de la phase de développement.

Après avoir réalisé le tableau, je me suis occupé de *programmer une interface de filtrage de colonnes*. Ceci m'a permis de me familiariser avec les `QLayouts` car il était important de disposer correctement tous les modules que j'avais effectué. Après avoir discuté avec le reste de mon groupe vis-à-vis de la structure à aborder, j'ai mis en place le système de filtrage qui est représenté par un `QButton` qui lorsqu'on clique dessus affiche un `QDockWidget` dans lequel il est possible de modifier des `QCheckBox` pour afficher où cacher une colonne spécifique du tableau.

Lors d'une réunion organisée avec notre encadrant, nous avons eu l'occasion de montrer l'avancée de notre travail et avec son approbation, nous sommes passés à la *phase de gestion de données*. En effet, bien que nous eussions tous les composants nécessaires permettant l'évaluation de copies d'examen, il était primordial d'implémenter une gestion de données efficace visant à *charger* les scans, *stocker* les informations d'examen, les *afficher* dans le tableau et la fenêtre d'évaluation et les *sauvegarder* à la fermeture du programme. La première chose que nous avons effectué à été de demander une série de cas de tests à notre encadrant afin que l'on puisse tester les différentes fonctionnalités de notre programme.

Après que Fabio ait mit en place un système de sélection de fichiers à l'aide de `QFileDialog,` je devais établir un système d'*association de scans avec leur fichier **JSON** correspondant* étant donné que la librairie responsable de cette tâche n'était pas encore implémentée. Cette tâche fût assez laborieuse car je devais *réaliser un système de structures de données* à là fois clair et performant. \ Mon premier prototype avait pour objectif de me familiariser avec la structure de donnée *std::map* en *C++*, j'avais simplement associé les fichiers *JSON* avec les fichiers de scan comportant le même identifiant dans leur nom de fichier. \ Après avoir établit les fondations, j'ai effectué un second prototype faisant usage du parser de *JSON* que Nathan avait programmé au préalable. Avec ce prototype, les *champs* présents dans les pages étaient stockés dans une structure de donnée appelée `FieldInfo` avant de les associer à l'identifiant utilisé précédemment. Bien que ce système fût efficace pour l'affichage de champs individuels, il était trop fastidieux d'affilier ces champs à une *page* ou a une *copie* d'examen. Cette particularité n'était pas négligeable si nous voulions afficher plusieurs pages d'une même *copie*. \ Une réunion avec notre encadrant nous permit de réaliser que nous avions mal interprété les cas de tests ce qui nous à empêcher d'intégrer la notion de sujet à notre programme. J'ai donc totalement restructuré la manière dont je collectais les données de scan en intégrant un *système hiérarchique* de structures de données. \ Chaque structure d'un *champ* (`FieldInfo`) issu de la même *page* était rassemblée dans une structure représentant une *page* (`PageInfo`) qui à son tour était regroupée avec d'autres *pages* provenant de la même *copie* dans une structure `CopyInfo.` Enfin, chaque *copies* du même *sujet* étaient à leur tour réunies dans une structure `ExamInfo` décrivant plusieurs informations y compris les données provenant du *JSON*. \ Avant d'ajouter ces données au tableau, il m'a fallu modifier les colonnes pour les faire correspondre à ce qui allait figurer dans le tableau. J'ai donc retiré la colonne "*Sémantique*" qui s'est avéré être incohérente au fil du temps et j'ai remplacé la colonne "*Nom*" par les colonnes *Exam*, *Paper*, *Page* et *Field*.

Lors de la réunion qui a précédé la restructuration des structures de données, mon encadrant m'avait aussi fait part du fait qu'il désirait l'ajout d'une *vue groupée* du tableau afin d'apporter plus de clarté à l'utilisateur. J'ai donc *séparé le tableau principal en deux sous tableaux* contenant les mêmes données mais organisant les cellules d'une manière différente. \ Suite à cela, Emilien et moi avons réfléchit à une nouvelle manière de parcourir les données du tableau car l'ajout d'un nouveau tableau avait modifié la logique de sa barre de recherche. \ Une fois que les fonctionnalités permettant l'association des données, l'ajout d'un nouveau tableau et la barre de recherche étaient optimales, j'ai pu finaliser la méthode permettant d'*afficher le contenu d'une cellule* dans la fenêtre de prévisualisation que j'avais développé en parallèle de tout cela. \ La difficulté de cette méthode était le fait de réfléchir avec Nathan à toutes les données dont il aurait besoin afin d'afficher précisément le contenu du tableau en fonction de la colonne dans laquelle étaient situées les cellules à afficher.

Finalement, nous avons mis en place une ultime réunion avec notre encadrant qui visait à présenter la version finale de notre interface graphique. Bien que nous n’ayons pas eu assez de temps pour implémenter certaines fonctionnalités qui étaient demandées tel que la *modification des valeurs des champs* directement depuis le tableau, notre encadrant avait l'air d'être satisfait du travail que nous lui avons fourni.

Dans l'ensemble, ce projet m'a permis d'acquérir beaucoup d'expérience en ce qui concerne mes compétences en matière de *développement*. Lorsque j'ai commencé à coder en *C++*, j'ai rencontré plusieurs difficultés car je manquais d'expérience dans ce langage, mais après m'être familiarisé avec la syntaxe, j'ai pris de plus en plus confiance en mes capacités au fur et à mesure que je travaillais sur ma section de l'interface utilisateur. Outre les compétences techniques que j'ai acquis, j'ai beaucoup progressé en matière de *résolution de problèmes*, de *communication* et de *gestion de projet* lorsque je collaborais avec d'autres développeurs. \ Je suis fier d'avoir contribué à un projet qui aura potentiellement un impact sur le domaine de l'éducation en abordant un problème commun rencontré par la plupart des enseignants et j'ai hâte d'assister à son évolution dans les années à venir.

== Nathan ROSET
Durant cette période, j'ai implémenté la classe `ExamPreview` dont l'utilité première sera à terme de *visualiser* et d'*intéragir* avec les pages des copies afin de montrer à l'utilisateur les éléments reconnus par le programmen d'apprécier la qualité de la reconnaissance automatique, et de modifier/calibrer l'interprétation du scan au besoin.\ 
La partie *visualisation* de l'interface devait permettre de montrer à la fois la page sélectionnée en entier ainsi que des champs en particulier. Cela a été implémenté avec un `QDialog` et un `QStackedWidget`.\ 
J'ai rencontré quelques difficultés du fait de mon manque d'expérience avec Qt en essayant d'utiliser des classes non adaptées au besoin. De ce fait il m'a fallu remanier plusieures parties du programme afin d'obtenir un résultat agréable à utiliser pour l'utilisateur.


= Échéancier mis à jour 
#figure(
  image(
    "gantt final.png"
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
    [*ID tâche*],[*Nom de la tâche*], [Nathan], [Fabio], [Marco], [Emilien],
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
  [WP 3.9], [Prise en charge des options du CLI] ,[] ,f ,[] ,[],
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
  - [x] Remplissage de la structure ScanInfo utilisée plus tard.
  - [x] Lecture et interprétation des fichiers JSON

- *Interaction tableau/visualisation*
  - [x] Définition d'une interface de communication entre les modules
  - [x] Méthodes de correspondances entre cellules du tableau et fichiers

- *Interaction avec le scan*
  - [x] Reglage des métriques de cadrage
  - [x] Interactions aves les différents champs d'une page (modifier, déplacer, highlight)

- *Configuration de l'UI.*
  - [ ] Options de configurations dans menu Affichage.
  - [x] Sauvegarde de la configuration dans un fichier.

- *Test, déploiement, cross platform*
  - [x] Tests non automatisés

- *Prise en charge des options du CLI *
  - [x] Gestion des options (help, version...)
