<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    xmlns="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="tei"
    version="2.0">
    <xsl:output indent="yes" method="xml" encoding="UTF-8" omit-xml-declaration="no"/>
    
    <xsl:template match="//teiHeader">
        <xsl:copy-of select="."/>
    </xsl:template>
    
    <!-- 1. EXEMPLE D'UTILISATION DES FONCTIONS XPATH -->
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
        <div>
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    <xsl:template match="//div[@n]/p">
        <p>
            <xsl:attribute name="n">
                <xsl:value-of select="count(preceding-sibling::p) + 1"/>
            </xsl:attribute>
            <xsl:value-of select="replace(., 'Julien', 'saint Julien')"/>
        </p>
    </xsl:template>
    <xsl:template match="//body/div[@n]" mode="toc">
        <p><xsl:value-of select="$chap"/><xsl:value-of select="./head"/></p>
        <p><xsl:value-of select="count(./p)"/> paragraphes</p>
    </xsl:template>
    
</xsl:stylesheet>