<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    xmlns="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="tei"
    version="2.0">
    
    <!-- 1. INSTRUCTION D'OUTPUT : XML -->
    <xsl:output method="xml" indent="yes" omit-xml-declaration="no"/>
    
    <!-- 2. VARIABLE -->
    <xsl:variable name="apos">'</xsl:variable>
    
    <!-- 3. ÉLÉMENT RACINE + TEIHEADER -->
    <!-- Sélection l'élément racine et travail sur le <teiHeader> -->
    <xsl:template match="/">
        <!-- reproduction des balises <TEI>, <teiHeader> et <fileDesc> -->
        <TEI>
            <teiHeader>
                <fileDesc>
                    <!-- Reproduction des <titleStmt> et <publicationStmt> -->
                    <titleStmt>
                        <xsl:for-each select="//titleStmt/title">
                            <xsl:copy>  <!-- copie de la balise <title> -->
                                <xsl:attribute name="level">  <!-- ajout de l'@level -->
                                    <xsl:value-of select="./@level"/>
                                </xsl:attribute>
                                <!-- copie du texte de <title> dans un nouveau <title> -->
                                <title><xsl:value-of select="."/></title>
                                <!-- ajout de "par" -->
                                par
                                <!-- ajout d'un <persName avec pour valeur le texte de <author> -->
                                <persName><xsl:value-of select="parent::titleStmt/author"/></persName>
                                <!-- ajout entre () de la date de publication -->
                                (<xsl:value-of select="ancestor::fileDesc//sourceDesc/biblStruct//date"/>)
                            </xsl:copy> <!-- copie de la balise </title> -->
                        </xsl:for-each>
                        <xsl:copy-of select="//titleStmt/author"/>
                    </titleStmt>
                    <xsl:copy-of select="//publicationStmt"/>
                    <sourceDesc>
                        <xsl:copy-of select="//sourceDesc/biblStruct"/>
                        <listBibl>
                            <xsl:apply-templates select="//listBibl"/>
                        </listBibl>
                    </sourceDesc>
                </fileDesc>
            </teiHeader>
            <!-- instruction pour que le processeur applique **uniquement** les règles qui concernent le <text> -->
            <xsl:apply-templates select="./TEI/text"/>
        </TEI>
    </xsl:template>
    
    <xsl:template match="//listBibl">
        <xsl:for-each select="./biblStruct">
            <xsl:sort select=".//date"/>
            <xsl:copy-of select="."/>
        </xsl:for-each>
    </xsl:template>
    
    <!-- 4. TEXTE -->
    <xsl:template match="//text">
        <!-- reproduction des balises <text> et <body> -->
        <text>
            <body>
                <xsl:copy-of select=".//div"/>
                <div>
                    <head>Index</head>
                    <!-- BOUCLE N°1 : créer une <div> pour les individus et une autre pour les lieux -->
                    <xsl:for-each-group select=".//hi" group-by="./@rend">
                        <div>
                            <xsl:attribute name="type">
                                <xsl:choose>
                                    <xsl:when test="./@rend='b'">
                                        <xsl:text>name</xsl:text>
                                    </xsl:when>
                                    <xsl:when test="./@rend='i'">
                                        <xsl:text>place</xsl:text>
                                    </xsl:when>
                                </xsl:choose>
                            </xsl:attribute>
                            <!-- BOUCLE N°2 : créer un seul <p> par entrée d'index -->
                            <xsl:for-each-group select="current-group()" group-by=".">
                                <p><xsl:value-of select="."/> :
                                    <!-- BOUCLE N°3 : ajouter le n° de la ou des <div> où apparaissent les entrées d'index -->
                                    <xsl:for-each-group select="current-group()" group-by="ancestor::div">
                                        <xsl:value-of select="ancestor::div/@n"/>
                                        <xsl:if test="position()!= last()">, 
                                        </xsl:if><xsl:if test="position() = last()">.</xsl:if>
                                    </xsl:for-each-group>
                                </p>
                            </xsl:for-each-group>
                        </div>
                    </xsl:for-each-group>
                </div>
            </body>
        </text>
    </xsl:template>
</xsl:stylesheet>