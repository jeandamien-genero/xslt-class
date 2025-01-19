% __ENC/ XSLT/ Évaluation__
% Jean-Damien Généro
% 2025

**À rendre le 31 mars 2025.**

# Consignes générales
- Faire un projet individuel ;
- Rédiger une feuille de style XSL permettant de transformer votre projet XML-TEI en HTML ou en LaTeX.
  - La transformation HTML devra aboutir à plusieurs fichiers HTML ;
  - La transformation LaTeX devra aboutir à un seul fichier `.tex`.
- Déposer l'ensemble des documents dans un repository GitHub. Confirmer le dépôt *en indiquant son lien* **au plus tard le 31 mars 2025** à `jean-damien.genero[at]cnrs[.]fr`.

# Modalités d'évalution

# Feuille de style XSL (/16)

- Rédiger des règles simples avec un XPath valide pour insérer le maximum d'informations du document source dans le ou les document(s) de sortie (/5);
- Utiliser plusieurs fonctions XPath (/2);
- Utiliser plusieurs prédicats XPath (/2);
- Utiliser au moins une variable XSL, autre que celles contenant les noms de votre/vos fichier(s) de sortie (/1) ;
- Utiliser au moins une règle avec une ou plusieurs conditions (/2);
- Utiliser au moins une règle avec une ou plusieurs boucles (/2);
- Organiser votre feuille de style de manière claire et commenter votre code de manière à ce qu'il soit aisé à lire (/2).

# XML vers HTML (/4)
- Les documents HTML résultant de la transformation doivent contenir des liens hypertextes permettant de naviguer entre eux, autres que ceux de la barre de navigation ou du footer (/2) ;
- Ils doivent être valides (par exemple en passant le test du _W3C Markup Validation Service_ <https://validator.w3.org/>) (/O,5) ;
- Proposer un habillage CSS pour vos documents différents de celui vu dans les TD (/1,5).

# XML vers LaTeX (/4)
- Le fichier `.tex` doit pouvoir être compilé sans erreur avec la commande `pdflatex` ou `xelatex` (et tout autre commande _que vous indiquerez_) (/2). 
- Il doit contenir une page de titre et une table des matières cliquable (/2).