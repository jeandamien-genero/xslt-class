<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="xs tei"
    xmlns="http://www.tei-c.org/ns/1.0"
    version="2.0">
    <xsl:output method="xml" indent="yes" omit-xml-declaration="no" encoding="UTF-8"/>
    <!-- SOLUTION 1 = on applique une règle vide pour le <teiHEader> et une règle pour le <body> -->
    <xsl:template match="/TEI/teiHeader"/>
    <xsl:template match="/TEI/text/body">
        <div>
            <head>Trois comtes</head>
            <xsl:copy-of select="./div"/>
        </div>
    </xsl:template>
    <!-- SOLUTION 2 = on match la racine et on applique une sous-règle aux <div> du <body> -->
    <!--<xsl:template match="/">
        <div>
            <head>Trois comtes</head>
            <xsl:copy-of select="//body//div"/>
        </div>
    </xsl:template>-->
</xsl:stylesheet>