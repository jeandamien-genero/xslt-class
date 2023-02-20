<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    version="2.0">
    
    <xsl:output method="text" indent="yes"/>
    
    <xsl:template match="/">
        <xsl:result-document href="st_julien.tex" method="text">
            <xsl:text>\documentclass[]{book}
            \usepackage[utf8]{inputenc}
            \usepackage[T1]{fontenc}
            \usepackage[a4paper]{geometry}
            \usepackage[french]{babel}
            
            \usepackage{titlesec}
            \titleformat{\chapter}[block]{\Large\bfseries}{}{1em}{}
            

            \usepackage[splitindex]{imakeidx}
            \makeindex[name=indiv,title=Index des noms de personnes]
            \makeindex[name=lieux,title=Index des noms de lieux]

            \usepackage[hidelinks, pdfstartview=FitH, plainpages=false]{hyperref}</xsl:text>
            
            \title{\textbf{<xsl:value-of select="//titleStmt/title[@level='a']"/>}}
            \author{<xsl:value-of select="//titleStmt/author"/>}
            \date{<xsl:value-of select="//sourceDesc/biblStruct//date"/>}
            
            
            \begin{document}
            \maketitle
            
            \vspace*{3cm}
            \begin{Large}
            <xsl:value-of select="//editionStmt/edition"/><xsl:text> Il contient \textit{</xsl:text>
            <xsl:value-of select="//titleStmt/title[@level='a']"/>
            <xsl:text>}, deuxième texte du livre \textit{</xsl:text><xsl:value-of select="//titleStmt/title[@level='m']"/>
            <xsl:text>} de </xsl:text><xsl:value-of select="//titleStmt/author"/><xsl:text>.</xsl:text>
            <xsl:text>
            \end{Large}
                
            \newpage
                
            </xsl:text>
            
            <xsl:apply-templates select="//body"/>
            
            \printindex[indiv]
            \addcontentsline{toc}{chapter}{Index des noms de personnes}
            \printindex[lieux]
            \addcontentsline{toc}{chapter}{Index des noms de lieux}
            
            \tableofcontents
            \addcontentsline{toc}{chapter}{Table des matières}
            
            \end{document}
        </xsl:result-document>
    </xsl:template>
    <xsl:template match="//body">
        <xsl:for-each select="./div">
            \chapter{Chapitre <xsl:value-of select="./head"/>}
            
            <xsl:for-each select="./p">
                <xsl:apply-templates/><xsl:text>
                    
                </xsl:text>
            </xsl:for-each>
        </xsl:for-each>
    </xsl:template>
    <xsl:template match="//body//hi">
        <xsl:choose>
            <xsl:when test="./@rend='b'">
                <xsl:apply-templates/><xsl:text>\index[indiv]{</xsl:text><xsl:apply-templates/><xsl:text>}</xsl:text>
            </xsl:when>
            <xsl:when test="./@rend='i'">
                <xsl:apply-templates/><xsl:text>\index[lieux]{</xsl:text><xsl:apply-templates/><xsl:text>}</xsl:text>
            </xsl:when>
        </xsl:choose>
    </xsl:template>
</xsl:stylesheet>