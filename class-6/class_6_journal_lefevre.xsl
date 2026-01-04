<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    version="2.0">
    
    <!-- AJOUTER LE <XSL:OUTPUT/> -->
    
    <xsl:template match="/">
        <!-- AJOUTER LE <XSL:RESULT-DOCUMENT/> -->
        \documentclass[]{book}
        \usepackage[utf8]{inputenc}
        \usepackage[T1]{fontenc}
        \usepackage[a4paper]{geometry}
        \usepackage[french]{babel}
        
        \usepackage{titlesec}
        \titleformat{\chapter}[block]{\Large\bfseries}{}{1em}{}
        
        \usepackage[splitindex]{imakeidx}
        \makeindex[name=indiv,title=Index des noms de personnes]
        \makeindex[name=lieux,title=Index des noms de lieux]
        
        \usepackage[hidelinks, pdfstartview=FitH, plainpages=false]{hyperref}
        
        \title{...} % <msName/>
        \author{...} % <author/>
        \date{...} % <origDate/>
        
        \begin{document}
        \maketitle
        
        %% Votre code ici
        
        \chapter*{Informations sur le manuscrit}
        \addcontentsline{toc}{chapter}{Informations sur le manuscrit}
        
        \section*{Institution de conservation}
        \addcontentsline{toc}{section}{Institution de conservation}
        
        \begin{itemize}
        \item Institution: % <repository/>
        \item Cote: % <idno/> (bnf)
        \item Numérisation: % <idno/> (gallica)
        \end{itemize}
        
        \section*{Description du manuscrit}
        \addcontentsline{toc}{section}{Description du manuscrit}
        
        \begin{itemize}
        \item Support: % <support/>
        \item Feuillet: % <extent/>
        \item Note: % <collation/>
        \end{itemize}
        
        % code pour les chapitres
        
        \printindex[indiv]
        \addcontentsline{toc}{chapter}{Index des noms de personnes}
        \printindex[lieux]
        \addcontentsline{toc}{chapter}{Index des noms de lieux}
        
        %% Table des matières
        
        \tableofcontents
        
        \end{document}
    </xsl:template>
    
</xsl:stylesheet>