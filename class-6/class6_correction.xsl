<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    version="2.0">
    
    <!-- 1. INSTRUCTION D'OUTPUT : HTML -->
    <xsl:output method="html" indent="yes"/>
    
    
    <!-- 2. DÉBUT DES DÉCLARATIONS DES VARIABLES -->
    <!-- CHEMINS DES FICHIERS DE SORTIE -->
    
    <xsl:variable name="home">
        <xsl:value-of select="concat('st_julien_home','.html')"/>
        <!-- variable pour le contenu du home  -->
    </xsl:variable>
    <xsl:variable name="chap1">
        <xsl:value-of select="concat('st_julien_chap1','.html')"/>
        <!-- variable pour le contenu du premier chapitre  -->
    </xsl:variable>
    <xsl:variable name="chap2">
        <xsl:value-of select="concat('st_julien_chap2','.html')"/>
        <!-- variable pour le contenu du deuxième chapitre  -->
    </xsl:variable>
    <xsl:variable name="index">
        <xsl:value-of select="concat('st_julien_index','.html')"/>
        <!-- variable pour le contenu du deuxième chapitre  -->
    </xsl:variable>
    
    <!-- VARIABLE AVEC LE <HEAD> -->
    <xsl:variable name="header">
        <head>
            <meta name="viewport" content="width=device-width, initial-scale=1"/>
            <title><xsl:value-of select="//titleStmt/title[@level='a']"/></title>
            <meta name="description">
                <xsl:attribute name="content">
                    <xsl:value-of select="//titleStmt/title[@level='a']"/><xsl:text> par </xsl:text><xsl:value-of select="//titleStmt/author"/>
                </xsl:attribute>
            </meta>
            <meta name="author">
                <xsl:attribute name="content">
                    <xsl:value-of select="//editionStmt/editor"/>
                </xsl:attribute>
            </meta>
        </head>
    </xsl:variable>
    
    <!-- VARIABLE AVEC LE <FOOTER> -->
    <xsl:variable name="footer">
        <footer>
            <p><i><xsl:value-of select="//editionStmt/edition"/>.</i></p>
        </footer>
    </xsl:variable>
    
    <!-- VARIABLE AVEC LE CSS DU <BODY> -->
    <xsl:variable name="body_css">
        <xsl:text>margin-right: 20%; margin-left: 20%; margin-top: 6%;</xsl:text>
    </xsl:variable>
    
    <!-- VARIABLES AVEC LES LIENS DE RETOUR -->
    <xsl:variable name="return_home">
        <i><a href="{concat('./', $home)}">Revenir à l'accueil</a></i>
    </xsl:variable>
    
    <xsl:variable name="return_index">
        <i><a href="{concat('./', $index)}">Index des noms de lieux et de personnes</a></i>
    </xsl:variable>
    
    <!-- VARIABLE AVEC L'EN-TÊTE DU <BODY> DES PAGES -->
    <xsl:variable name="body_header">
        <div style="text-align: center; margin-bottom: 8%;">
            <h1>Édition en ligne de <i><xsl:value-of select="//titleStmt/title[@level='m']"/></i></h1>
            <h2>Conte n°2, <i><xsl:value-of select="//titleStmt/title[@level='a']"/></i></h2>
            <p><xsl:value-of select="//titleStmt/author"/></p>
        </div>
    </xsl:variable>
    
    <!-- FIN DES DÉCLARATIONS DES VARIABLES -->
    
    
    
    <!-- TEMPLATE MATCH SUR LA RACINE AVEC LES CALL TEMPLATES DES PAGES-->
    <xsl:template match="/">
        <xsl:call-template name="home"/>
        <xsl:call-template name="chapter1"/>
        <xsl:call-template name="chapter2"/>
        <xsl:call-template name="index_st_julien"/>
    </xsl:template>
    
    <!-- TEMPLATE DE LA PAGE HOME -->
    <xsl:template name="home">
        <xsl:result-document href="{$home}" method="html">
            <html lang="fr">
                <xsl:copy-of select="$header"/>
                <body>
                    <xsl:attribute name="style">
                        <xsl:value-of select="$body_css"/>
                    </xsl:attribute>
                    <xsl:copy-of select="$body_header"/>
                    <div style="text-align: justify;">  
                        <p><b>Résumé : </b><xsl:value-of select="//abstract/p"/></p>
                    </div>
                    <div>
                        <p><a href="./{$chap1}">Chapitre 1</a> – <a href="./{$chap2}">Chapitre 2</a> – <a href="./{$index}">Index.</a></p>
                    </div>
                    <xsl:copy-of select="$footer"/>
                </body>
            </html>
        </xsl:result-document>
    </xsl:template>
    
    <!-- TEMPLATES DE LA PAGE CHAPITRE 1 -->
    <xsl:template name="chapter1">
        <xsl:result-document href="{$chap1}" method="html">
            <html lang="fr">
                <xsl:copy-of select="$header"/>
                <body>
                    <xsl:attribute name="style">
                        <xsl:value-of select="$body_css"/>
                    </xsl:attribute>
                    <xsl:copy-of select="$body_header"/>
                    <div>
                        <h3 style="text-align: center; padding-bottom: 2%;">Chapitre I.</h3>
                        <xsl:apply-templates select="./TEI/text"/>
                    </div>
                    <xsl:copy-of select="$footer"/>
                </body>
            </html>
        </xsl:result-document>
    </xsl:template>
    
    <xsl:template match="//text">
        <div style="text-align: justify;">
            <xsl:for-each select="//div[@n='1']/p">
                <!-- boucle afin de reproduire chaque <p> séparément -->
                <p><xsl:apply-templates/></p>
            </xsl:for-each>
            <p>>> <a href="./{$chap2}">Chapitre suivant.</a></p>
            <xsl:copy-of select="$return_home"/> – <xsl:copy-of select="$return_index"/>
        </div>
    </xsl:template>
    
    <!-- TEMPLATES DE LA PAGE CHAPITRE 2 -->
    <xsl:template name="chapter2">
        <xsl:result-document href="{$chap2}" method="html">
            <html lang="fr">
                <xsl:copy-of select="$header"/>
                <body>
                    <xsl:attribute name="style">
                        <xsl:value-of select="$body_css"/>
                    </xsl:attribute>
                    <xsl:copy-of select="$body_header"/>
                    <div style="text-align: justify;">
                        <h3 style="text-align: center; padding-bottom: 2%;">Chapitre II.</h3>
                        <!-- ajout d'un @mode pour différencier le traitement du texte -->
                        <!-- texte du chapitre 2 de celui du chapitre 1 -->
                        <xsl:apply-templates select="./TEI/text" mode="chapter2"/>
                        <p>>> <a href="./{$chap1}">Chapitre précédent.</a></p>
                        <xsl:copy-of select="$return_home"/> - <xsl:copy-of select="$return_index"/>
                    </div>
                    <xsl:copy-of select="$footer"/>
                </body>
            </html>
        </xsl:result-document>
    </xsl:template>
    
    <xsl:template match="//text" mode="chapter2">
        <xsl:for-each select="//div[@n='2']/p">
            <!-- boucle afin de reproduire chaque <p> séparément -->
            <p><xsl:apply-templates/></p>
        </xsl:for-each>
    </xsl:template>
    
    <!-- TEMPLATES DE LA PAGE INDEX -->
    <xsl:template name="index_st_julien">
        <xsl:result-document href="{$index}">
            <html lang="fr">
                <xsl:copy-of select="$header"/>
                <body>
                    <xsl:attribute name="style">
                        <xsl:value-of select="$body_css"/>
                    </xsl:attribute>
                    <xsl:copy-of select="$body_header"/>
                    <div>
                        <!-- BOUCLE N°1 : créer une <div> pour les individus et une autre pour les lieux -->
                        <xsl:for-each-group select="//body//hi" group-by="./@rend">
                            <div>
                                <xsl:choose>
                                    <xsl:when test="./@rend='b'">
                                        <h3>Index des noms de personnes</h3>
                                    </xsl:when>
                                    <xsl:when test="./@rend='i'">
                                        <h3>Index des noms de lieux</h3>
                                    </xsl:when>
                                </xsl:choose>
                                <!-- BOUCLE N°2 : créer un seul <p> par entrée d'index -->
                                <xsl:for-each-group select="current-group()" group-by=".">
                                    <p><i><xsl:value-of select="."/></i> :
                                        <!-- BOUCLE N°3 : ajouter le n° de la ou des <div> où apparaissent les entrées d'index -->
                                        <xsl:for-each-group select="current-group()" group-by="ancestor::div">
                                            <a>
                                                <xsl:attribute name="href">
                                                    <xsl:choose>
                                                        <xsl:when test="ancestor::div/@n = '1'">
                                                            <xsl:text>./</xsl:text><xsl:value-of select="$chap1"/>
                                                        </xsl:when>
                                                        <xsl:when test="ancestor::div/@n = '2'">
                                                            <xsl:text>./</xsl:text><xsl:value-of select="$chap2"/>
                                                        </xsl:when>
                                                    </xsl:choose>
                                                </xsl:attribute>
                                                <xsl:value-of select="ancestor::div/@n"/>
                                            </a>
                                            <xsl:if test="position()!= last()">, 
                                            </xsl:if><xsl:if test="position() = last()">.</xsl:if>
                                        </xsl:for-each-group>
                                    </p>
                                </xsl:for-each-group>
                            </div>
                        </xsl:for-each-group>
                        <p><xsl:copy-of select="$return_home"/> – <a href="./{$chap1}">Chapitre 1</a> – <a href="./{$chap2}">Chapitre 2</a></p>
                    </div>
                    <xsl:copy-of select="$footer"/>
                </body>
            </html>
        </xsl:result-document>
    </xsl:template>
    
    <!-- 7. CHAPITRES 1 & 2. TRANSFORMATION DES <HI> EN <SPAN> -->
    <xsl:template match="//body//hi">
        <span>
            <xsl:value-of select="."/>
        </span>
    </xsl:template>
    
</xsl:stylesheet>