% __ENC/ XSLT/ Exercice (séance 3)__
% Jean-Damien Généro
% 2024

# Environnement de travail
- Document XML : `class3_st_julien_hospitalier.xml`.
- Document XSL :
  - Ouvrir une feuille de style XSLT dans Oxygen.
  - Compléter son en-tête et ajouter l'instruction d'output avec XML comme méthode.

# Consignes
## 1/ Les variables
- écrire le "Trois contes" du premier `<title>` en majuscule. Stocker cette balise dans une variable `$booktitle`.
- enlever la majuscule à "Saint" dans le deuxième `<title>`. Stocker cette balise dans une variable `$chaptitle`.

## 2/ Le `<teiHeader>`
- Dans le `<titleStmt>` : reproduire les balises `<title>`, mais en changeant leurs textes par le contenu des variables définies précédemment.
- Ajouter un `<editionStmt/>` (avec `<edition/>` et `<respStmt/>`).
- Reproduire les autres balises sans changement.

## 3/ Le `<text>`
- Ajouter dans le `<body>` une balise `<head>` avec pour contenu : `$booktitle`, `$chaptitle`.
- Changer le format de numérotation des `<div>`.
- Numéroter les paragraphes en continu.
- Appliquer une condition aux `<hi>` pour :
  - Transformer en `<placename>` ceux qui ont un `@rend="i"`.
  - Transformer en `<persName>` ceux qui ont un `@rend="b"` et y remplacer "Julien" par "saint Julien" et transformer la balise en `<persName>`.
  - Bonus : ajouter une majuscule à "saint" dans le `<hi rend="b">` du dernier paragraphe du deuxième chapitre.
