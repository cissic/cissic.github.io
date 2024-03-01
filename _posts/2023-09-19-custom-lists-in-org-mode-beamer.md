
# Table of Contents

1.  [Custom (per slide) list environments in beamer](#org4c33060)
    1.  [Example of an org-mode/beamer document where list fonts should be customized per slide or per list](#orga54b0a1)

---
author: cissic
date: 2023-09-19 Tue
tags: 'org-mode beamer itemize enumerate'
title: 'Custom (per slide) list environments in beamer'
---


<a id="org4c33060"></a>

# TODO Custom (per slide) list environments in beamer


<a id="orga54b0a1"></a>

## Example of an org-mode/beamer document where list fonts should be customized per slide or per list

    #+latex_class: beamer
    #+OPTIONS: H:2
    #+beamer_header: \setbeamertemplate{itemize item}[circle]
    #+beamer_header: \setbeamertemplate{itemize subitem}[square]
    
    # #+beamer_header: \setbeamerfont{itemize/enumerate body}{size=\footnotesize}
    #+beamer_header: \setbeamerfont{itemize/enumerate subbody}{size=\scriptsize}
    
    
    * Section 1
    ** Frame 1
      - item 1
      - item 2
      - @@latex:[\Large $\bullet$] \tiny@@ change per item [[https://emacs.stackexchange.com/questions/35976/how-to-change-the-appearance-of-list-bullets-in-latex-beamer-exports][link]]
        1. item A
        2. item B
    
    #+begin_export beamer
    % \tiny
    % \setbeamerfont{itemize/enumerate body}{size=\size}
    \setbeamerfont{itemize/enumerate body}{size=\tiny}
    \setbeamerfont{itemize/enumerate subbody}{size=\Large}
    
    \setbeamercolor{itemize/enumerate body}{fg=red}
    \setbeamercolor{itemize/enumerate subbody}{fg=green}
    \setbeamercolor{itemize/enumerate subsubbody}{fg=blue}
    
    % \setbeamertemplate{enumerate items}[square]
    \setbeamertemplate{enumerate items}[square]
    \setbeamertemplate{itemize items}[square]
    #+end_export
    
      - item 1
      - item 2
        1. item A
        2. item B
    
    
    * Section 2
    ** Frame 2
    
      - item 1
      - item 2
        1. item A
        2. item B
    
    #+begin_export beamer
    % \tiny
    % \setbeamerfont{itemize/enumerate body}{size=\size}
    \setbeamerfont{itemize/enumerate body}{size=\tiny}
    \setbeamerfont{itemize/enumerate subbody}{size=\Large}
    % \setbeamertemplate{enumerate items}[square]
    
    \setbeamertemplate{itemize items}{\color{red}$\blacktriangleright$}
    #+end_export
    
      - item 1
      - item 2
        1. item A
        2. item B

