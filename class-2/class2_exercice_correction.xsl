<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    xmlns="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="tei"
    version="2.0">
    <!-- 1. INSTRUCTION D'OUTPUT : XML -->
    <xsl:output method="xml" indent="yes" omit-xml-declaration="no"/>
    
    
    <!-- 2. REPRODUCTION DE L'ÉLÉMENT RACINE <TEI> -->
    <xsl:template match="/">
        <TEI>
            <xsl:apply-templates/>
            <!-- apply-templates = instruction pour que le processeur applique les règles (xsl:template) aux enfants de <TEI> -->
        </TEI>
    </xsl:template>
    
    
    <!-- 3. REPRODUCTION DU <TEIHEADER> -->
    
    <!-- reproduction du <teiHeader> -->
    <xsl:template match="//teiHeader">
        <!-- copie de la balise ouvrante <teiHeader> -->
        <xsl:copy>
            <xsl:apply-templates/>
            <!-- apply-templates = instruction pour que le processeur applique les règles (xsl:template) aux enfants de <teiHeader/> -->
        </xsl:copy>
        <!-- copie de la balise fermante </teiHeader> -->
    </xsl:template>
 
    <!-- <FILEDESC> : 2 SOLUTIONS -->
    <!-- NB : le but est d'ajouter un <editionStmt> entre le <titleStmt> et <publicationStmt> -->
    
    <!-- Solution n°1 : <xsl:copy> et <xsl:apply-templates>, puis trois règles pour <titleStmt>, <publicationStmt> et <sourceDesc> -->
    <!--<xsl:template match="//fileDesc">
        <xsl:copy>
            <xsl:apply-templates/>
        </xsl:copy>
    </xsl:template>
    <xsl:template match="//titleStmt">
        <xsl:copy-of select="."/>
        <editionStmt>
            <edition>
                Édition dans le cadre du M2 TNAH 2023.
            </edition>
            <respStmt>
                <name>Jean-Damien Généro</name>
                <resp>encodage</resp>
            </respStmt>
        </editionStmt>
    </xsl:template>
    <xsl:template match="//publicationStmt">
        <xsl:copy-of select="."/>
    </xsl:template>
    <xsl:template match="//sourceDesc">
        <xsl:copy-of select="."/>
    </xsl:template>-->
    
    <!-- Solution n°2 : une seule règle sur le <fileDesc> -->
    <!-- le principe est de matcher le <fileDesc>, et d'appliquer des règles à ses enfants -->
    <xsl:template match="//fileDesc">
        <xsl:copy>
            <xsl:copy-of select="//titleStmt"/>
            <editionStmt>
                <edition>
                    Édition dans le cadre du M2 TNAH 2023.
                </edition>
                <respStmt>
                    <name>Jean-Damien Généro</name>
                    <resp>encodage</resp>
                </respStmt>
            </editionStmt>
            <xsl:copy-of select="//publicationStmt"/>
            <xsl:copy-of select="//sourceDesc"/>
        </xsl:copy>
    </xsl:template>
    
    
    <!-- 4. Le <TEXT> -->
    
    <!-- match sur le <text> avec un apply-tempaltes -->
    <xsl:template match="//text">
        <!-- on matche le <text> et on reproduit directement le <text> et son enfant <body> -->
        <xsl:element name="text">
            <xsl:element name="body">
                <xsl:apply-templates/>
                <!-- Partie bonus : vous pouviez ajouter le début du chap III ici -->
                <div n="3">
                    <head n="C">III.</head>
                    <p>Il s’en alla, mendiant sa vie par le monde.</p>
                    <p>Il tendait sa main aux cavaliers sur les routes, avec des génuflexions s’approchait des moissonneurs, ou restait immobile devant la barrière des cours ; et son visage était si triste que jamais on ne lui refusait l’aumône.</p>
                </div>
            </xsl:element>
        </xsl:element>
    </xsl:template>
    
    <xsl:template match="//body/div">
        <!-- reproduction des <div> et leur attribut @n -->
        <xsl:element name="div">
            <xsl:attribute name="n">
                <xsl:value-of select="./@n"/>
            </xsl:attribute>
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>
    
    <xsl:template match="//div/head">
        <!-- reproduction des <head> et ajout d'un @n -->
        <head>
            <xsl:attribute name="n">
                <xsl:number level="any" format="A" count="//div[@n]/head"/>
            </xsl:attribute>
            <xsl:apply-templates/>
        </head>
    </xsl:template>
    
    <xsl:template match="//div/p">
        <!-- reproduction des <p> et ajout d'un @n -->
        <!-- attention à bien ajouter un <apply-templates/> et non un <copy-of/> -->
        <!-- car avec <copy-of/> il ne serait pas possible d'appliquer des règles aux <hi/> -->
        <p>
            <xsl:attribute name="n">
                <xsl:number level="single" format="1" count="//div[@n]/p"/>
            </xsl:attribute>
            <xsl:apply-templates/>
        </p>
    </xsl:template>
    
    <!-- pour transformer les balises <hi> : il faut les matcher et les remplacer par des <persName>/<placename> -->
    <!-- NB : avec les cours suivants, il sera possible d'utiliser des boucles -->
    <xsl:template match="//hi[@rend='b']">
        <persName>
            <xsl:value-of select="."/>
        </persName>
    </xsl:template>
    <xsl:template match="//hi[@rend='i']">
        <placename>
            <xsl:value-of select="."/>
        </placename>
    </xsl:template>
</xsl:stylesheet>