<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    xmlns="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="tei"
    version="2.0">
    <!-- 1. INSTRUCTION D'OUTPUT : XML -->
    <xsl:output method="xml" indent="yes" omit-xml-declaration="no"/>
    
    <!-- 2. VARIABLES ET PARAMÈTRES -->
    <xsl:param name="booktitle" select="//titleStmt/title"/>
    <xsl:variable name="institution" select="concat(//msIdentifier/repository, ', ', //msIdentifier/idno[@source='bnf'])"/>
    <xsl:variable name="today" select="current-date()"/>
    
    <!-- 3. REPRODUCTION DE L'ÉLÉMENT RACINE <TEI> -->
    <xsl:template match="/">
        <TEI>
            <xsl:apply-templates/>
        </TEI>
    </xsl:template>
    
    
    <!-- 4. REPRODUCTION DU <TEIHEADER> -->
    
    <!-- 4.1 reproduction du <teiHeader> -->
    <xsl:template match="//teiHeader">
        <xsl:copy>
            <xsl:apply-templates select="//fileDesc"/>
            <xsl:copy-of select="//encodingDesc"/>
            <xsl:copy-of select="//profileDesc"/>
            <xsl:apply-templates select="//revisionDesc"/>
        </xsl:copy>
    </xsl:template>
    
    <!-- 4.2 reproduction du <fileDesc> -->
    <xsl:template match="//fileDesc">
        <xsl:copy>
            <titleStmt>
                <title><xsl:value-of select="$booktitle"/> (<xsl:value-of select="$institution"/>)</title>
                <xsl:copy-of select=".//titleStmt/author"/>
            </titleStmt>
            <xsl:copy-of select="//publicationStmt"/>
            <xsl:copy-of select="//sourceDesc"/>
        </xsl:copy>
    </xsl:template>
    
    <!-- 4.3 ajout d'un <change> dans le <revisionDesc> -->
    <xsl:template match="//revisionDesc">
        <revisionDesc>
            <xsl:copy-of select="./change"/>
            <change when="{$today}">Modification effectuée au cours de la troisième séance par [VOTRE NOM].</change>
        </revisionDesc>
    </xsl:template>
    
    
    <!-- 5. Reproduction à l'identique du <text> -->
    <xsl:template match="//text">
        <xsl:element name="text">
            <xsl:element name="body">
                <xsl:apply-templates/>
            </xsl:element>
        </xsl:element>
    </xsl:template>
    <xsl:template match="//text//div">
        <xsl:copy>
                <xsl:apply-templates/>
        </xsl:copy>
    </xsl:template>
    <xsl:template match="//text//div/head">
        <head><xsl:apply-templates/></head>
    </xsl:template>
    <xsl:template match="//text//div/p">
        <p>
            <xsl:if test="parent::div/@n = '2'">
                <xsl:attribute name="n">#<!-- à vous de compléter pour ajouter la valeur du @n --></xsl:attribute>
            </xsl:if>
            <xsl:value-of select="."/>
        </p>
    </xsl:template>
</xsl:stylesheet>