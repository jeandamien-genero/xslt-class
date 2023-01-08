% __ENC/ XSLT/ Noeuds et axes XPath__
% Jean-Damien Généro
% 2023

---

## 1. Les noeuds

Pour XPath, un document XML est un "_tree of nodes_" ("arbre avec des noeuds"). Chaque noeud est une "étape" possible dans une expression XPath. Il y a sept types de noeud :

### 1.1 _Root node_

- Notation : `/`.
- Il contient l'ensemble du document ; c'est le seul noeud "orphelin" (il ne peut pas avoir de parent). On parle parfois du _document node_.
- À ne pas confondre avec l'élément racine (_root element_) d'un document XML : `<TEI>` est entièrement contenu dans le _root node_ tout en étant le seul _root element_ du document.

### 1.2 _Element nodes_

- Notation : `element()`.
- Les éléments (i. e. balises) du document XML, notés entre `< >`.

### 1.3 _Attribute Nodes_

- Notation : `attribute()`.
- Les attributs sont des balises XML. Le parent direct d'un _attribute node_ est forcément un _element node_.

### 1.4 _Text nodes_

- Notation : `text()`.
- Le texte d'un _element node_ ou d'un _attribute node_.

### 1.5 _Comment nodes_

- Notation : `comment()`.
- Les commentaires d'un document XML (notés entre `<!-- -->`).
- Le _comment node_ sélectionne le texte du commentaire sans les `<!-- -->`.

### 1.6 _Namespace nodes_

- Notation : _via_ l'axe `namespace::`.
- Les noms de domaine, généralement stockés dans des `xmlns:`. Cela signifie que dans `<TEI xmlns="http://www.tei-c.org/ns/1.0">`, `xmlns` n'est pas un `attribute node` mais un `namespace node`. On y accède par l'expression `/TEI/namespace::*`.
- Très peu utilisés en XSLT. 

### 1.7 _Processing instruction nodes_

- Notation : `processing-instruction()`.
- Les instructions de traitement XML (notées entre `<? ?>`) indiquent à une application comment traiter le document XML qu'elle lit.
- Elles possèdent un nom (`name()`) et une valeur (`string()`).
- Exemple : `<?xml-stylesheet href="exemple.xsl" type="text/xsl" title="Exemple"?>`.
- À ne pas confondre avec l'entête XML (`<?xml version="1.0" encoding="UTF-8"?>` au début du document).

---

## 2. Les axes

- Les axes (_axis_) permettent de s'émanciper de la direction de base _parent>enfant_ d'un chemin XPath ou précisant ou en changeant cette direction.
- Il y a treize axes.
- Ils se notent avec des `::` à la fin ; certains peuvent être abrégés.

### 2.1 _Child axis_

- Notation : `child::`.
- Sélection : la balise hiérarchiquement inférieure au noeud de contexte.
- Attention :
  - C'est l'axe par défaut, ce qui signie que `/child::TEI/child::teiHeader` est identique à `/TEI/teiHeader`.
  - Les `attribute nodes` et `namespace nodes` sont exclus de cet axe.

### 2.2 _Parent axis_

- Notation et abréviation : `child::` et `..` (deux points).
- Sélection : la balise hiérarchiquement supérieure au noeud de contexte.
- Exemples : `//fileDesc/parent::teiHeader` et `//fileDesc/..` sélectionnent le `<teiHeader>` depuis le `<fileDesc>`.

### 2.3 _Self axis_

- Notation et abréviation : `self::` et `.` (un point).
- Sélection : le noeud de contexte.

### 2.4 _Attribute axis_

- Notation et abréviation : `attribute::` et `@`.
- Sélection : les attributs du noeud de contexte.
- Attention : si le noeud de contexte est un _attribute node_, il n'y a pas d'axe attribut.
- Exemples : `//titleStmt/title/attribute::level` et `//titleStmt/title/@level` sélectionnent l'attribut `level` de `<title>`.

### 2.5 _Ancestor axis_

- Notation : `ancestor::`.
- Sélection : tous les noeuds entre la balise hiérarchiquement supérieure au noeud de contexte (= le parent) et le premier du document (= le _root node_).
- Exemple : `//titleStmt/title/ancestor::fileDesc/sourceDesc//author` sélectionne tous les `<author>` dans `<sourceDesc>` depuis `<title>`.

### 2.6 _Ancestor-or-self axis_

- Notation : `ancestor-or-self::`.
- Sélection : le noeud de contexte et _ancestor axis_.

### 2.7 _Descendant axis_

- Notation : `descendant::`.
- Sélection : tous les enfants du noeud de contexte, et leurs enfants, et ainsi de suite.
- Exemple : `//descendant::sourceDesc`.
- Attention : les `attribute nodes` et `namespace nodes` ne sont pas pris en compte par cet axe.

### 2.8 _Descendant-or-self axis_

- Notation : `descendant-or-self::`.
- Sélection : le noeud de contexte et _descendant-axis_
- Attention : les `attribute nodes` et `namespace nodes` ne sont pas pris en compte par cet axe.

### 2.9 _Preceding-sibling axis_

- Notation : `preceding-sibling::`.
- Sélection : tous les noeuds qui ont le même parent que le noeud de contexte et qui sont avant lui dans l'arbre.
- Exemples : `//sourceDesc/preceding-sibling::titleStmt` sélectionne le `<titleStmt>` depuis le `<sourceDesc>` ; `//sourceDesc/preceding-sibling::*` sélectionne le `<titleStmt>` et le `<publicationStmt>`.

### 2.9 _Following-sibling axis_

- Notation : `following-sibling::`.
- Sélection : tous les noeuds qui ont le même parent que le noeud de contexte et qui sont après lui dans l'arbre.
- Exemple : `//publicationStmt/following-sibling::sourceDesc` sélectionne le `<sourceDesc>` depuis le `<publicationStmt>`.

### 2.10 _Preceding axis_

- Notation : `preceding::`.
- Sélection : tous les noeuds qui précèdent le noeud de contexte, peu importe leur parent.
- Attention : les `ancestor`, les `attribute` et les `namespace` ne sont pas pris en compte.

### 2.12 _Following axis_

- Notation : `following::`.
- Sélection : tous les noeuds qui suivent le noeud de contexte, peu importe leur parent.
- Attention : les `ancestor`, les `attribute` et les `namespace` ne sont pas pris en compte.

### 2.13 _Namespace axis_
- Notation : `namespace::`.
- Sélection : les noms de domaine du noeud de contexte.
- Attention : ne fonctionne pas avec un _attribute node_.
