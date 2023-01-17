<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    xmlns="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="tei"
    version="2.0">
    <xsl:output indent="yes" method="xml" encoding="UTF-8" omit-xml-declaration="no"/>
    
    <xsl:param name="booktitle" select="upper-case(//titleStmt/title[@level='m'])"/>
    <xsl:param name="parttitle" select="//titleStmt/title[@level='a']"/>
    <xsl:variable name="chap">Chapitre </xsl:variable>
    <xsl:variable name="num">n°</xsl:variable>
    
    <xsl:variable name="witfile">
        <xsl:value-of select="replace(base-uri(class3_st_julien_hospitalier), '.xml', '')"/>
        <!-- récupération du nom et du chemin du fichier courant -->
    </xsl:variable>
    <xsl:variable name="chap1">
        <xsl:value-of select="concat($witfile,'st_julien_chap1','.xml')"/>
        <!-- variable pour le contenu du premier chapitre  -->
    </xsl:variable>
    <xsl:variable name="chap2">
        <xsl:value-of select="concat($witfile,'st_julien_chap2','.xml')"/>
        <!-- variable pour le contenu du deuxième chapitre  -->
    </xsl:variable>
    
    <xsl:template match="/">
        <TEI>
            
        </TEI>
    </xsl:template>
    
</xsl:stylesheet>