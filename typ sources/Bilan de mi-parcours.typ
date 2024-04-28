#import "template.typ": base
#show: doc => base(
  // left_header:[],
  right_header : [Equipe scan-GUI-Printemps-2024],
  title: [Projet Hekzam-GUI],
  subtitle: [CC2 - Bilan de mi-Parcours],
  version: [],
  doc
)
= Échéancier mis à jour

= Retours personnels

== Emilien SANCHEZ

== Fabio YABAR

== Marco REGRAGUI-MARTINS

== Nathan ROSET
Durant cette période, j'ai implémenté la classe `ExamPreview` dont l'utilité première sera à terme de *visualiser* et d'*intéragir* avec les pages des copies afin de montrer à l'utilisateur les éléments reconnus par le programmen d'apprécier la qualité de la reconnaissance automatique, et de modifier/calibrer l'interprétation du scan au besoin.\ 
La partie *visualisation* de l'interface devait permettre de montrer à la fois la page sélectionnée en entier ainsi que des champs en particulier. Cela a été implémenté avec un `QDialog` et un `QStackedWidget`.\ 
J'ai rencontré quelques difficultés du fait de mon manque d'expérience avec Qt en essayant d'utiliser des classes non adaptées au besoin. 