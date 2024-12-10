<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="tei"
    xmlns="http://www.tei-c.org/ns/1.0"
    version="2.0">
    <xsl:output method="xml" indent="yes"/>
    
    <!-- EXEMPLE 1 -->
    <!-- Des balises peuvent être écrites directement dans un <xsl:template/> -->
    <!--<xsl:template match="/TEI/teiHeader"/>
    <xsl:template match="/TEI/text/body/div[1]">
        <body>
            <div>
                <head type="chap">
                    <xsl:value-of select="./head"/>
                </head>
                <xsl:copy-of select="./p"/>
            </div>
        </body>
    </xsl:template>
    <xsl:template match="/TEI/text/body/div[2]"/>-->
    
    <!-- EXEMPLE 2 -->
    <!-- Les balises XML ou HTML peuvent être écrites dans des <xsl:element name="tag"/> et les attributs dans des <xsl:attribute name="@tt"/> -->
    
    <!--<xsl:template match="/TEI/teiHeader"/>
    <xsl:template match="/TEI/text/body/div[1]"/>
    <xsl:template match="//body/div[2]">
        <xsl:element name="div">
            <xsl:element name="head">
                <xsl:attribute name="type">chap</xsl:attribute>
                <xsl:attribute name="n">2</xsl:attribute>
                Chapitre . <xsl:value-of select="./head"/>
            </xsl:element>
            <xsl:copy-of select="./p"/>
        </xsl:element>
    </xsl:template>-->

    <!-- EXEMPLE 3 -->
    <!-- Du texte peut être mis directement dans une règle -->
    
    <!--<xsl:template match="/">\documentclass[a4paper]{book}
\usepackage[utf8]{inputenc}
\usepackage[french]{babel}
\usepackage{fontspec}
\author{Jean-Damien Généro}
\begin{document}
        \textbf{<xsl:value-of select="./TEI/text/body/div[1]/head"/>}
\end{document}
    </xsl:template>-->
    
    <!-- EXEMPLE 4 -->
    <!-- Du texte peut être mis dans un <xsl:text/> -->
    
    <!--<xsl:template match="/TEI/teiHeader"/>
    <xsl:template match="/TEI/text/body/div[1]">
        <body>
            <div>
                <head type="chap">
                    <xsl:text>Chapitre n°1. </xsl:text><xsl:value-of select="./head"/>
                </head>
                <xsl:copy-of select="./p"/>
            </div>
        </body>
    </xsl:template>
    <xsl:template match="/TEI/text/body/div[2]"/>-->
    
    <!-- EXEMPLE 5 : <xsl:copy/> -->
    
    <!--<xsl:template match="/TEI/teiHeader"/>
    <xsl:template match="/TEI/text/body">
        <xsl:copy>
            ...
        </xsl:copy>
    </xsl:template>-->
    
    <!-- EXEMPLE 6 : <xsl:copy-of/> -->
    
    <!--<xsl:template match="/TEI/teiHeader"/>
    <xsl:template match="/TEI/text/body">
        <xsl:copy-of select="."/>
    </xsl:template>-->
    
    <!-- EXEMPLE 7 : <xsl:value-of/> -->
    
    <xsl:template match="/TEI/teiHeader"/>
    <xsl:template match="/TEI/text/body/div">
        <xsl:value-of select="."/>
    </xsl:template>
    
</xsl:stylesheet>














