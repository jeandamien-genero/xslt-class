% __ENC/ XSLT/ Évaluation__
% Jean-Damien Généro
% 2023

**À rendre le 31 mars 2023.**

# Consignes générales
- Faire un projet individuel ;
- Rédiger une feuille de style XSL permettant de transformer votre projet XML-TEI en HTML ou en LaTeX.
  - La transformation HTML devra aboutir à plusieurs fichiers HTML ;
  - La transformation LaTeX devra aboutir à un seul fichier `.tex`.
- Déposer l'ensemble des documents sur un repository GitHub, _de préférence celui dans lequel vous aviez rendu votre projet TEI_. Confirmer le dépôt à <jean-damien.genero@cnrs.fr>.

# Modalités d'évalution

# Feuille de style XSL

- Rédiger des règles simples avec un XPath valide pour insérer le maximum d'informations du document source dans le ou les document(s) de sortie (/5);
- Utiliser plusieurs fonctions et prédicats XPath (/1);
- Utiliser au moins une variable XSL (/1) ;
- Utiliser au moins une règle avec une ou plusieurs condition(s) et, _si nécessaire_, une ou plusieurs boucles `for-each` (/3);
- Organiser votre feuille de style de manière claire et commenter votre code de manière à ce qu'il soit facile à lire (/5).

# XML vers HTML
- Les documents HTML résultant de la transformation doivent contenir des liens hypertextes permettant de naviguer entre eux (/2) ;
- Ils doivent être valides (par exemple en passant le test du _W3C Markup Validation Service_ <https://validator.w3.org/>) (/1,5) ;
- Proposer un habillage CSS pour vos documents (/1,5).

# XML vers LaTeX
- Le fichier `.tex` doit pouvoir être compilé sans erreur avec la commande `pdflatex` (et tout autre commande _que vous indiquerez_, par exemple `splitindex`) (/2,5). 
- Il doit contenir une page de titre, du contenu et une table des matières cliquable (/2,5).