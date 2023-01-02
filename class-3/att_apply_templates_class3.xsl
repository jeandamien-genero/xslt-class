<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    xmlns="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="xs tei"
    version="2.0">
    <xsl:output indent="yes" method="xml" encoding="UTF-8" omit-xml-declaration="no"/>
    
    <xsl:template match="//teiHeader">
        <xsl:copy-of select="."/>
    </xsl:template>
    
    <!-- 1. EXEMPLE AVEC LE @SELECT -->
    <!--<xsl:template match="/">
        <TEI>
            <xsl:apply-templates select="//text"/>
            <xsl:apply-templates select="//teiHeader"/>
        </TEI>
    </xsl:template>
    <xsl:template match="//text">
        <xsl:copy-of select="."/>
    </xsl:template>-->
    
    <!-- 2. EXEMPLE AVEC LE @MODE -->
    <!--<xsl:template match="/TEI">
        <xsl:copy>
            <xsl:apply-templates/>
        </xsl:copy>
    </xsl:template>
    <xsl:template match="//text">
        <xsl:copy>
            <xsl:apply-templates/>
        </xsl:copy>
    </xsl:template>
    <xsl:template match="//body">
        <xsl:copy>
            <xsl:apply-templates />
            <div>
                <head>Table des matières</head>
                <xsl:apply-templates mode="toc"/>
            </div>
        </xsl:copy>
    </xsl:template>
    <xsl:template match="//body/div[@n]">
        <xsl:copy-of select="."/>
    </xsl:template>
    <xsl:template match="//body/div[@n]" mode="toc">
        <p>Chapitre <xsl:value-of select="./head"/></p>
    </xsl:template>-->
    
    <!-- 3. EXEMPLE D'UTILISATION DES VARIABLES XSL -->
    <xsl:variable name="chap">Chapitre </xsl:variable>
    <xsl:template match="/TEI">
        <xsl:copy>
            <xsl:apply-templates/>
        </xsl:copy>
    </xsl:template>
    <xsl:template match="//text">
        <xsl:copy>
            <xsl:apply-templates/>
        </xsl:copy>
    </xsl:template>
    <xsl:template match="//body">
        <xsl:copy>
            <xsl:apply-templates />
            <div>
                <head>Table des matières</head>
                <xsl:apply-templates mode="toc"/>
            </div>
        </xsl:copy>
    </xsl:template>
    <xsl:template match="//body/div[@n]">
        <xsl:copy-of select="."/>
    </xsl:template>
    <xsl:template match="//body/div[@n]" mode="toc">
        <p><xsl:value-of select="$chap"/><xsl:value-of select="./head"/></p>
    </xsl:template>
</xsl:stylesheet>