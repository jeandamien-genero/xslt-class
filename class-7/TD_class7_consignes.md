% __ENC/ XSLT/ TD XML vers LaTeX (séance 7)__
% Jean-Damien Généro
% 2023

# Environnement de travail

- Document XML : `saint_julien_complet_3_chap.xml`.
- **Un exemple du document de sortie se trouve dans le dossier `/class-7/out`, avec sa compilation en PDF.**

# Consigne générale

- Transformer le fichier `saint_julien_complet_3_chap.xml` en un fichier LaTeX (`.tex`) pouvant être compilé _sans erreur avec le terminal_ à l'aide des commandes `pdflatex st_julien.tex` et `splitindex st_julien.idx`.
- Le fichier de sortie devra contenir :
  - une page de titre ;
  - une page avec le contexte de publication du PDF ;
  - les trois chapitres de _La légende de saint Julien l'hospitalier_ ;
  - un index des noms de personnes et un index des noms de lieux ;
  - une table des matières.
- Faire attention aux espaces et sauts de ligne dans votre document de sortie.

# Compilation

- Compiler une première fois le `.tex` avec `pdflatex` ;
- Compiler deux fois le fichier d'index (`.idx`) avec `splitindex` ;
- Compiler une deuxième fois le `.tex` avec `pdflatex`.

# Template LaTeX

- En-tête :
```tex
\documentclass[]{book}
\usepackage[utf8]{inputenc}
\usepackage[T1]{fontenc}
\usepackage[a4paper]{geometry}
\usepackage[french]{babel}

\usepackage{titlesec}
\titleformat{\chapter}[block]{\Large\bfseries}{}{1em}{}

\usepackage[splitindex]{imakeidx}
\makeindex[name=indiv,title=Index des noms de personnes]
\makeindex[name=lieux,title=Index des noms de lieux]

\usepackage[hidelinks, pdfstartview=FitH, plainpages=false]{hyperref}

\title{}
\author{}
\date{}

\begin{document}
\maketitle

%% Votre code ici

\printindex[indiv]
\addcontentsline{toc}{chapter}{Index des noms de personnes}
\printindex[lieux]
\addcontentsline{toc}{chapter}{Index des noms de lieux}

%% Table des matières ici

\end{document}
```

# Étape 1

- Paramétrer l'en-tête XSL et l'instruction `output` pour une transformation vers LaTeX.
- Écrire une variable contenant le nom du fichier LaTeX de sortie.

# Étape 2 : titre du document

- Compléter les commandes de titre :
  - Dans `\title{}`, ajouter le contenu du `<title level="a"/>` ;
  - Dans `\author{}`, ajouter le contenu de `<author/>` ; 
  - Dans `\date{}`, ajouter le contenu de `<date/>`.

# Étape 3 : contexte de publication

- Ourvir le PDF du dossier `/class-7/out` et reproduire le paragraphe de la page 2 à partir du contenu des balises `<title level="m"/>`, `<title level="a"/>`, `<author/>`, `<edition/>`.

# Étape 4 : les chapitres

- Pour chaque chapitre :
  - Dans une commande `\chapter{}`, écrire `Chapitre` suivi du contenu du `<head/>` du chapitre.
  - Reproduire chaque paragraphe.

# Étape 5 : les index

- Transformer les `<hi/>` en `\index[indiv/lieux]{contenu de <hi/>}`.
  - Exemple pour un nom de personne : `\index[indiv]{Julien}` ;
  - Exemple pour un nom de lieu : `\index[lieux]{Milan}`.

_**Reprenez l'ensemble de l'exercice chez vous jusqu'à obtenir un document PDF similaire au modèle. Cela vous sera utile pour le projet à rendre pour l'évaluation finale !**_