#import "template.typ": base
#show: doc => base(
  // left_header:[],
  right_header : [Equipe scan-GUI-Automne-2024],
  title: [Projet Hekzam-GUI],
  subtitle: [Formalisation des spécifications fonctionnelles],
  version: [0.2],
  doc
)
//TODO : make it so requirement list numbering keeps incrementing properly past other headings
//can't query numbered lists (enums), currently a Typst limitation ?
// https://github.com/typst/typst/issues/1356
#set enum(
  numbering: ("EX_1.a :"),
  tight: false,
  full: true,
  spacing: 2em,
)

= Portée du projet:
12/03/2024 - Il nous a été demandé de plus se porter sur la partie `import` et manipulations des scans et moins sur la partie création des sujet, le document reflètera donc cela.

= Definitions :
(*HYPOTHÈSES DE DÉBUT DE PROJET*)
- *cadrage* : en pourcentage, métrique qui mesure la qualité de la numérisation
- *fichier source* : fichier texte suivant la #link("https://typst.app/docs/reference")[spécification] du langage Typst , ideally with a *.typ* extension
- *projet* : Un projet dans ce contexte est un *dossier* (?) contenant AU MOINS un fichier source et AU MOINS un fichier de configuration pour le projet (?) au format ??? (TOML ? JSON ?)
- *sujet* : fichier pdf obtenu en compilant un fichier source avec Typst, peut comprendre plusieurs pages
- *programme* : Logiciel Hekzam complet#link("https://github.com/hekzam")[(GUI + parser + generator)], supposé fonctionnel
- *feuille*: image extraite d'un fichier pdf; scan d'une feuille associé à une page d'un sujet
- *copie*: ensemble de feuilles regroupées, l'ensemble formant une copie d'examen associée à un étudiant
- *champs*: ce qu'on appelait question auparavant (un QCM = un champ, un True-False = un champ)

= Description des exigences 
== Création du sujet
+ L'utilisateur doit pouvoir accéder aux autres fonctionnalités du programme après avoir satisfait l'une de ces pré-conditions 
  + L'utilisateur doit pouvoir *importer* un "projet" localisé dans un dossier
  + L'utilisateur doit pouvoir *créer* un projet en sélectionnant un fichier source

+ L'utilisateur devrait pouvoir *modifier* le fichier source à partir du GUI du programme 
+ L'utilisateur doit pouvoir *compiler* un fichier source après l'avoir importé
  + Il doit être possible de préciser combien de sujets uniques devront être générés par le programme
  + #strike[Il doit être possible de *randomiser* ou non *l'ordre des questions* du sujet]
  + #strike[Il doit être possible de *randomiser* ou non *l'ordre des réponses* à chaque question]
  + *Réunion du 12/03* chaque sujet à les mêmes questions, dans le même ordre et chaque exemplaire(chaque feuille de chaque exemplaire aussi) possède un QR code unique 
+ Le bouton "*Générer*" (ou équivalent) sera grisé si aucun fichier source n'est donné
+ Les erreurs de compilation (= erreur de syntaxe dans le fichier source) devraient être remontées à l'utilisateur pour correction

== Import des copies scannées
#set enum(start: 6) //why do I have to do this
+ L'utilisateur devrait pouvoir importer : 
  - une *liste de scans de copies* au format à déterminer (png ?)
  - un *dossier* contenant les scans des copies correspondant à un projet. _Peut-on considérer dans ce cas que chaque élément du dossier est un scan associée au projet ?_
+ Si l'utilisateur se trompe de dossier de scans à l'import, le programme devrait (?) signifier à l'utilisateur que les copies scannées ne correspondent pas au projet actuellement ouvert
+ Si on importe exactement *le même scan*, il faut que le programme les détecte automatiquement

== Identification des feuilles en copies 
#set enum(start: 9)
+ L'utilisateur devrait pouvoir importer une "*feuille de présence*" ( liste de copies attendues) qui devrait être analysable par le programme
+ Le programme devrait détecter si certaines copies manquent en fonction du nombre d'entrées présentes sur la feuille de présence
  - Le programme devrait (?) pouvoir faire le lien entre les entrées de la feuille de présence et les copies scannées
  - on peut considérer qu'on a un fichier csv avec(peut être)
	  - soit une liste de personnes présentes
	  - soit une liste des inscrits avec un bool qui dit qui était inscrit
+ Le programme devra attibuer une copie (= un ensemble de feuilles scannées) à un identifiant

== Analyse de la copie
#set enum(start: 12)
+ L'utilisateur devrait pouvoir apprécier la qualité des scans grâce à des indicateur numériques (RMSE, taux de certitude...)
+ Le programme devra porter à l'attention de l'utilisateur si certaines copies scannées sont *illisibles* par le parser, ou se trouve en deçà d'un *seuil d'acceptabilité*
+ Le programme devra pouvoir afficher uniquement les informations syntaxiques:
	- cette case est remplie ou non ? case cochée/grisée/remplie ou non ?
	- cette case là est censée être un zéro
	- le parser fait une liste des caractères reconnues, il faut montrer les plus probables en premier
	- lors de l'analyse des copies, on montre les cases pour lesquels on est le moins sûr en premier
	- on devrait pouvoir parcourir toutes les copies et les afficher à la suite à l'utilisateur
+ Le programme devra pouvoir afficher uniquement les informations sémantiques importantes: (A COMPLÉTER)
	 - si plusieures cases incompatibles (genre vrai/faux) sont cochées, l'utilisateur  doit pouvoir visionner la copie
	 - que faire des annotations ?

== Correction des copies
#set enum(start: 16)
+ Le programme devra retourner des informations sur CHAQUE question (par exemple pour apprécier de la qualité des distracteurs): quel % d'étudiants ont répondu cette case à telle question 
	- on ne souhaite pas forcément attribuer une note à la copie
+ Le programme devrait retourner *en sortie* : des fichiers (csv? *json* ? html ?) pour *visualiser les données* et *indiquer si l'humain a changé une valeur*
+ Le programme peut être en mesure de corriger et d'attribuer une note à chaque copie, mais ce n'est pas obligatoire
+ le programme devrait laisser la possibilité à l’utilisateur de *modifier la correction* de chaque copie si besoin
+ Le programme doit afficher *le degré de certitude* apporté à la correction de chaque copie
+ Le programme doit *porter à l'attention de l'utilisateur* si des *annotations* sont présentes sur certaines copies
+ *Si elles existent*, le programme doit présenter visuellement les annotations à l'utilisateur 

== Déroulement du programme
#set enum(start: 23)
+ on doit pouvoir *recommencer du départ* à n'importe quel moment
+ on doit pouvoir retourner à l'étape précédente à tout moment
+ Il est préférable d'éviter de créer plusieurs fenêtres
+ Le programme devra avoir une interface navigable au clavier
et bien d'autres