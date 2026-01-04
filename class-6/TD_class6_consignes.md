% __ENC/ XSLT/ TD XML vers LaTeX (séance 7)__
% Jean-Damien Généro
% 2025

# Environnement de travail

- Document XML : `class_7_journal_lefevre.xml`.
- Document XSL: `class_7_journal_lefevre.xsl`.
- **Un exemple du document de sortie se trouve dans le dossier `/class-7/out`, avec sa compilation en PDF.**

# Consigne générale

- Transformer le fichier `class_7_journal_lefevre.xml` en un fichier LaTeX (`.tex`) pouvant être compilé _avec le terminal_ à l'aide des commandes `xelatex journal-lefevre.tex` et `splitindex journal-lefevre.idx`.
- Le fichier de sortie devra contenir :
  - une page de titre ;
  - une page avec des informations sur le manuscrit ;
  - les quatres chapitres du _Journal_ ;
  - un index des noms de personnes et un index des noms de lieux ;
  - une table des matières.
- Faire attention aux espaces et sauts de ligne dans votre document de sortie.

# Compilation

- Compiler une première fois le `.tex` avec `xelatex` ;
- Compiler deux fois le fichier d'index (`.idx`) avec `splitindex` ;
- Compiler une deuxième fois le `.tex` avec `xelatex`.

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
     
        \title{...} % <msName/>
        \author{...} % <author/>
        \date{...} % <origDate/>
        
        \begin{document}
        \maketitle
        
        %% Votre code ici
        
        \chapter*{Informations sur le manuscrit}
        \addcontentsline{toc}{chapter}{Informations sur le manuscrit}
        
        \section*{Institution de conservation}
        \addcontentsline{toc}{section}{Institution de conservation}
        
        \begin{itemize}
            \item Institution: % <repository/>
            \item Cote: % <idno/> (bnf)
            \item Numérisation: % <idno/> (gallica)
        \end{itemize}
        
        \section*{Description du manuscrit}
        \addcontentsline{toc}{section}{Description du manuscrit}
        
        \begin{itemize}
            \item Support: % <support/>
            \item Feuillet: % <extent/>
            \item Note: % <collation/>
        \end{itemize}
        
        % code pour les chapitres
        
        \printindex[indiv]
        \addcontentsline{toc}{chapter}{Index des noms de personnes}
        \printindex[lieux]
        \addcontentsline{toc}{chapter}{Index des noms de lieux}
        
        %% Table des matières
        
        \tableofcontents
        
        \end{document}
```

# Étape 1

- Paramétrer l'en-tête XSL et l'instruction `output` pour une transformation vers LaTeX.

# Étape 2 : titre du document

- Compléter les commandes de titre :
  - Dans `\title{}`, ajouter le contenu du `<msName/>` ;
  - Dans `\author{}`, ajouter le contenu de `<author/>` ; 
  - Dans `\date{}`, ajouter le contenu de `<origDate/>`.

# Étape 3 : contexte de publication

- Ouvrir le PDF du dossier `/class-7/out` et compléter les informations de la section `Informations sur le manuscrit` (les balises correspondantes sont indiquées en commentaire dans le code LaTeX).

# Étape 4 : les chapitres

- Pour chaque chapitre :
  - Dans une commande `\chapter{}`, écrire son numéro (`@n` de la `<div/>`) suivi du contenu du `<head/>` du chapitre.
  - Reproduire chaque paragraphe en laissant la possibilité d'appliquer des règles aux enfants.

# Étape 5 : les index

- Transformer les `<persName/>` et les `<placeName/>` en `\index[indiv/lieux]{contenu du @ref}`.
  - Exemple pour un nom de personne : `\index[indiv]{Blois (Marie de)}` ;
  - Exemple pour un nom de lieu : `\index[lieux]{Angiers}`.

_**Reprenez l'ensemble de l'exercice chez vous jusqu'à obtenir un document PDF similaire au modèle. Cela vous sera utile pour le projet à rendre pour l'évaluation finale !**_