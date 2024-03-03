

# TODO {{{title}}


## Problem description

Exporting org-mode documents in synchronous and asynchronous
way can lead to different results.
The most important for me (at the time of writing it)
is uniform way of exporting source blocks
and special blocks.


## Source code blocks

Source code blocks of text are less problematic.


### `init.el`

`minted` package should be configured in `init.el`.


### `Local variables` mechanism

-   overwrites `init.el` configuration
-   per file-opening
-   seen when file

Up to now I was working with minted coloring mechanism by adding a special
piece of code, like the one below:

    ,# Local Variables:
    ,# org-beamer-outline-frame-title: "55"
    ,# org-latex-listings: minted
    ,# org-latex-packages-alist: (("" "minted"))
    ,# org-latex-minted-options: (("bgcolor=yellow") ("frame" "lines"))
    ,# eval: (add-to-list 'load-path "~/.emacs.d/myarch")
    ,# eval: (require 'MB-org-special-block-extras)
    ,# End:

appended at the end of an org file. It is properly parsed by both
`sync` and `async` exporter.


### `#+BIND:` mechanism

-   overwrites `init.el` and `local variables` configurations
-   seen at the time of exporting for synchronous
-   seen at the time of exporting for asynchronous *provided that* `(setq org-export-allow-bind-keywords t)` is included in `async_init.el`!


### `async_init.el`

-   configuration should be declared in here to have it working globally in case of asynchronous exporting

    ;; org-to-latex exporter to have nice code formatting
    (setq org-latex-listings 'minted
          org-export-with-sub-superscripts 'nil
          org-latex-minted-options '(("bgcolor=lightgray") ("frame" "lines"))
          org-latex-packages-alist '(("" "minted"))
          org-latex-pdf-process
          '("pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f"
            "pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f"
            "pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f"))

In order to have them working with asynchronous exporter one needs
to add special 

The source code is exported via `minted` package.
In order to make it working with asynch


## Special blocks

-   `org-special-block-extras`


### Special block captions

1.  English org-latex names

        # Special block captions in English
        
        #+LATEX_HEADER: \providecommand{\warningBoxCaption}{}       \renewcommand{\warningBoxCaption}         {Warning!}
        #+LATEX_HEADER: \providecommand{\remarkBoxCaption}{}        \renewcommand{\remarkBoxCaption}          {Remark:}
        
        #+LATEX_HEADER: \providecommand{\problemBoxCaption}{}       \renewcommand{\problemBoxCaption}         {Problem:}
        #+LATEX_HEADER: \providecommand{\questionBoxCaption}{}      \renewcommand{\questionBoxCaption}        {Question:}
        #+LATEX_HEADER: \providecommand{\answerBoxCaption}{}        \renewcommand{\answerBoxCaption}          {Answer:}    
        #+LATEX_HEADER: \providecommand{\taskBoxCaption}{}          \renewcommand{\taskBoxCaption}            {Task:}
        #+LATEX_HEADER: \providecommand{\solutionBoxCaption}{}      \renewcommand{\solutionBoxCaption}        {Solution}
        
        #+LATEX_HEADER: \providecommand{\hintBoxCaption}{}          \renewcommand{\hintBoxCaption}            {Hint:}
        #+LATEX_HEADER: \providecommand{\resumeBoxCaption}{}        \renewcommand{\resumeBoxCaption}          {Resume:}
        #+LATEX_HEADER: \providecommand{\resultsBoxCaption}{}       \renewcommand{\resultsBoxCaption}         {Results:}
        
        #+LATEX_HEADER: \providecommand{\observationBoxCaption}{}   \renewcommand{\observationBoxCaption}     {Observation:}
        #+LATEX_HEADER: \providecommand{\conclusionBoxCaption}{}    \renewcommand{\conclusionBoxCaption}      {Conclusion:}
        #+LATEX_HEADER: \providecommand{\summaryBoxCaption}{}       \renewcommand{\summaryBoxCaption}         {Summary:}
        
        #+LATEX_HEADER: \providecommand{\definitionBoxCaption}{}    \renewcommand{\definitionBoxCaption}      {Definition:}  
        #+LATEX_HEADER: \providecommand{\exampleBoxCaption}{}       \renewcommand{\exampleBoxCaption}         {Example:}
        #+LATEX_HEADER: \providecommand{\theoremBoxCaption}{}       \renewcommand{\theoremBoxCaption}         {Theorem:}
        #+LATEX_HEADER: \providecommand{\lemmaBoxCaption}{}         \renewcommand{\lemmaBoxCaption}           {Lemma:} 

2.  Polish org-latex names

        # Special block captions in English
        
        #+LATEX_HEADER: \providecommand{\warningBoxCaption}{}       \renewcommand{\warningBoxCaption}         {Uwaga!} 
        #+LATEX_HEADER: \providecommand{\remarkBoxCaption}{}        \renewcommand{\remarkBoxCaption}          {Uwaga:} 
        
        #+LATEX_HEADER: \providecommand{\problemBoxCaption}{}       \renewcommand{\problemBoxCaption}         {Problem:} 
        #+LATEX_HEADER: \providecommand{\questionBoxCaption}{}      \renewcommand{\questionBoxCaption}        {Pytanie:}
        #+LATEX_HEADER: \providecommand{\answerBoxCaption}{}        \renewcommand{\answerBoxCaption}          {Odpowiedź:}  
        #+LATEX_HEADER: \providecommand{\taskBoxCaption}{}          \renewcommand{\taskBoxCaption}            {Zadanie:} 
        #+LATEX_HEADER: \providecommand{\solutionBoxCaption}{}      \renewcommand{\solutionBoxCaption}        {Rozwiązanie:}
        
        
        #+LATEX_HEADER: \providecommand{\hintBoxCaption}{}          \renewcommand{\hintBoxCaption}            {Podpowiedź:} 
        #+LATEX_HEADER: \providecommand{\resumeBoxCaption}{}        \renewcommand{\resumeBoxCaption}          {Przypomnienie:} 
        #+LATEX_HEADER: \providecommand{\resultsBoxCaption}{}       \renewcommand{\resultsBoxCaption}         {Wyniki:} 
        
        #+LATEX_HEADER: \providecommand{\observationBoxCaption}{}   \renewcommand{\observationBoxCaption}     {Spostrzeżenie:} 
        #+LATEX_HEADER: \providecommand{\conclusionBoxCaption}{}    \renewcommand{\conclusionBoxCaption}      {Wniosek:} 
        #+LATEX_HEADER: \providecommand{\summaryBoxCaption}{}       \renewcommand{\summaryBoxCaption}         {Podsumowanie:} 
        
        #+LATEX_HEADER: \providecommand{\definitionBoxCaption}{}    \renewcommand{\definitionBoxCaption}      {Definicja:} 
        #+LATEX_HEADER: \providecommand{\exampleBoxCaption}{}       \renewcommand{\exampleBoxCaption}         {Przykład:} 
        #+LATEX_HEADER: \providecommand{\theoremBoxCaption}{}       \renewcommand{\theoremBoxCaption}         {Twierdzenie:}
        #+LATEX_HEADER: \providecommand{\lemmaBoxCaption}{}         \renewcommand{\lemmaBoxCaption}           {Lemat:}


### Special block colors

1.  Black and white (paper print ink-saving)

        # Color schemes for BW printed version
        
        #+LATEX_HEADER: \providecommand{\warningBoxCol}{}      \renewcommand{\warningBoxCol}      {white} 
        #+LATEX_HEADER: \providecommand{\remarkBoxCol}{}       \renewcommand{\remarkBoxCol}       {white}
        
        #+LATEX_HEADER: \providecommand{\problemBoxCol}{}      \renewcommand{\problemBoxCol}      {white}    
        #+LATEX_HEADER: \providecommand{\questionBoxCol}{}     \renewcommand{\questionBoxCol}     {white}
        #+LATEX_HEADER: \providecommand{\answerBoxCol}{}       \renewcommand{\answerBoxCol}       {white}
        #+LATEX_HEADER: \providecommand{\taskBoxCol}{}         \renewcommand{\taskBoxCol}         {white}  
        #+LATEX_HEADER: \providecommand{\solutionBoxCol}{}     \renewcommand{\solutionBoxCol}     {white}
        
        #+LATEX_HEADER: \providecommand{\hintBoxCol}{}         \renewcommand{\hintBoxCol}         {white} 
        #+LATEX_HEADER: \providecommand{\resumeBoxCol}{}       \renewcommand{\resumeBoxCol}       {white} 
        #+LATEX_HEADER: \providecommand{\resultsBoxCol}{}      \renewcommand{\resultsBoxCol}      {white} 
        
        #+LATEX_HEADER: \providecommand{\observationBoxCol}{}  \renewcommand{\observationBoxCol}  {white}   
        #+LATEX_HEADER: \providecommand{\conclusionBoxCol}{}   \renewcommand{\conclusionBoxCol}   {white} 
        #+LATEX_HEADER: \providecommand{\summaryBoxCol}{}      \renewcommand{\summaryBoxCol}      {white} 
        
        #+LATEX_HEADER: \providecommand{\definitionBoxCol}{}   \renewcommand{\definitionBoxCol}   {white} 
        #+LATEX_HEADER: \providecommand{\exampleBoxCol}{}      \renewcommand{\exampleBoxCol}      {white}   
        #+LATEX_HEADER: \providecommand{\theoremBoxCol}{}      \renewcommand{\theoremBoxCol}      {white} 
        #+LATEX_HEADER: \providecommand{\lemmaBoxCol}{}        \renewcommand{\lemmaBoxCol}        {white}

2.  Colorful (sanitized eye-candy electronic version)

        # Color schemes for documents in color (sanitized version)
        
        #+LATEX_HEADER: \providecommand{\warningBoxCol}{}      \renewcommand{\warningBoxCol}      {my-salmon}
        #+LATEX_HEADER: \providecommand{\remarkBoxCol}{}       \renewcommand{\remarkBoxCol}       {my-salmon}
        
        #+LATEX_HEADER: \providecommand{\problemBoxCol}{}      \renewcommand{\problemBoxCol}      {my-olive}   
        #+LATEX_HEADER: \providecommand{\questionBoxCol}{}     \renewcommand{\questionBoxCol}     {my-olive}
        #+LATEX_HEADER: \providecommand{\answerBoxCol}{}       \renewcommand{\answerBoxCol}       {my-olive}  
        #+LATEX_HEADER: \providecommand{\taskBoxCol}{}         \renewcommand{\taskBoxCol}         {my-olive} 
        #+LATEX_HEADER: \providecommand{\solutionBoxCol}{}     \renewcommand{\solutionBoxCol}     {my-olive}
        
        #+LATEX_HEADER: \providecommand{\hintBoxCol}{}         \renewcommand{\hintBoxCol}         {my-sand}
        #+LATEX_HEADER: \providecommand{\resumeBoxCol}{}       \renewcommand{\resumeBoxCol}       {my-sand}
        #+LATEX_HEADER: \providecommand{\resultsBoxCol}{}      \renewcommand{\resultsBoxCol}      {my-sand}
        
        #+LATEX_HEADER: \providecommand{\observationBoxCol}{}  \renewcommand{\observationBoxCol}  {my-olive}  
        #+LATEX_HEADER: \providecommand{\conclusionBoxCol}{}   \renewcommand{\conclusionBoxCol}   {my-olive}
        #+LATEX_HEADER: \providecommand{\summaryBoxCol}{}      \renewcommand{\summaryBoxCol}      {my-olive}
        
        #+LATEX_HEADER: \providecommand{\definitionBoxCol}{}   \renewcommand{\definitionBoxCol}   {my-steel}
        #+LATEX_HEADER: \providecommand{\exampleBoxCol}{}      \renewcommand{\exampleBoxCol}      {my-steel} 
        #+LATEX_HEADER: \providecommand{\theoremBoxCol}{}      \renewcommand{\theoremBoxCol}      {my-steel}
        #+LATEX_HEADER: \providecommand{\lemmaBoxCol}{}        \renewcommand{\lemmaBoxCol}        {my-steel}

3.  TODO Colorful (frantic eye-candy electronic version)


## Preamble

    
    #+AUTHOR: MB
    
    #+LATEX_HEADER:\usepackage{hyperref} 
    #+LATEX_HEADER:\usepackage[a4paper,left=1.5cm,right=2cm,top=2cm,bottom=3.5cm,includefoot=false,includehead=false,footskip=1.16cm]{geometry} 
    
    #+LATEX_HEADER:\hypersetup{colorlinks=true,linkcolor=blue,filecolor=magenta,urlcolor=blue}
    
    # #+LATEX_HEADER:\usepackage{hyphenat}
    #+LATEX_HEADER:\usepackage{babel}
    #+LATEX_HEADER:\usepackage{polski}
    #+LATEX_HEADER:\sloppy               % make hyphenation a bit easier for latex
    
    #+LATEX_HEADER: \usepackage{amsmath}
    #+LATEX_HEADER: \usepackage{amsthm}
    
    # %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    # ############ Full-stop after (sub)section title
    # ## HTML
    #+HTML_HEAD_EXTRA: <style>span[class^="section-number-"]:after { content: '.'; }</style>
    # ## LaTeX
    #+LATEX_HEADER: \usepackage{titlesec}
    #+LATEX_HEADER: \titlelabel{\thetitle.\quad}


### Special blocks part

Special blocks in latex built on
[tcolorbox](https://texdoc.org/serve/tcolorbox.pdf/0) package.

-   [noindent for colorbox](https://tex.stackexchange.com/questions/503220/controlling-indent-and-vertical-space-at-top-of-a-tcolorbox)

    # # Default settings for macros based on org-special-block
    # ############################# #+SETUPFILE: ./lang_pl.org
    # #############################  #+INCLUDE: /myarch/colscheme_bw.org
    # ############################# #+SETUPFILE: ./colscheme_col.org
    
    #+LATEX_HEADER: \usepackage[svgnames,x11names]{xcolor}
    
    #+LATEX_HEADER: \definecolor{my-olive}{cmyk} {0.10, 0.00, 0.34, 0.26, 1.00}
    #+LATEX_HEADER: \definecolor{my-salmon}{cmyk}{0.00, 0.31, 0.10, 0.16, 1.00}
    #+LATEX_HEADER: \definecolor{my-sand}{cmyk}  {0.00, 0.07, 0.39, 0.05, 1.00}
    #+LATEX_HEADER: \definecolor{my-steel}{cmyk} {0.23, 0.08, 0.00, 0.26, 1.00}
    #+LATEX_HEADER: \definecolor{my-sky}{cmyk}   {0.25, 0.00, 0.08, 0.04, 1.00}
    #+LATEX_HEADER: \definecolor{my-gray}{cmyk}  {0.20, 0.20, 0.20, 0.20, 1.00}
    
    #+SETUPFILE: ./colscheme_col_tex.org
    #+SETUPFILE: ./lang_pl_tex.org
    
    # ############################################
    # https://tex.stackexchange.com/questions/611875/newtcbtheorem-with-3-entries-1-2-3
    
    #+LATEX_HEADER: \usepackage{amsmath}
    #+LATEX_HEADER: \usepackage{mathtools}
    #+LATEX_HEADER: \usepackage{amsthm}
    #+LATEX_HEADER: \usepackage[notextcomp]{stix}
    #+LATEX_HEADER: \usepackage[most]{tcolorbox}
    #+LATEX_HEADER: \tcbuselibrary{theorems}
    
    #+LATEX_HEADER: \newcommand{\setBox}[2]{
    #+LATEX_HEADER: \tcbset{
    #+LATEX_HEADER: #1/.style={
    #+LATEX_HEADER: nobeforeafter, tcbox raise base, enhanced, boxrule=0pt,
    #+LATEX_HEADER: interior style={top color=#2!10!white, bottom color=#2!10!white, middle color=#2!50!#2},
    #+LATEX_HEADER: colframe=#2, fuzzy halo=1pt with #2, description color = black, coltitle=black, fonttitle=\bfseries, separator sign={\ ---}, before=\par\medskip\noindent
    #+LATEX_HEADER: }}}


### Special blocks latex configurations and definitions

    #+LATEX_HEADER: \setBox{tc_warning}{\warningBoxCol}
    #+LATEX_HEADER: \newtcbtheorem[number within=section]{mbwarning}{\warningBoxCaption}{tc_warning}{th}
    #+LATEX_HEADER: \setBox{tc_remark}{\remarkBoxCol}
    #+LATEX_HEADER: \newtcbtheorem[number within=section]{mbremark}{\remarkBoxCaption}{tc_remark}{th}
    
    #+LATEX_HEADER: \setBox{tc_problem}{\problemBoxCol}
    #+LATEX_HEADER: \newtcbtheorem[number within=section]{mbproblem}{\problemBoxCaption}{tc_problem}{th}
    #+LATEX_HEADER: \setBox{tc_question}{\questionBoxCol}
    #+LATEX_HEADER: \newtcbtheorem[number within=section]{mbquestion}{\questionBoxCaption}{tc_question}{th}
    #+LATEX_HEADER: \setBox{tc_answer}{\answerBoxCol}
    #+LATEX_HEADER: \newtcbtheorem[number within=section]{mbanswer}{\answerBoxCaption}{tc_answer}{th}
    #+LATEX_HEADER: \setBox{tc_task}{\taskBoxCol}
    #+LATEX_HEADER: \newtcbtheorem[number within=section]{mbtask}{\taskBoxCaption}{tc_task}{th}
    #+LATEX_HEADER: \setBox{tc_solution}{\solutionBoxCol}
    #+LATEX_HEADER: \newtcbtheorem[number within=section]{mbsolution}{\solutionBoxCaption}{tc_solution}{th}
    
    
    #+LATEX_HEADER: \setBox{tc_hint}{\hintBoxCol}
    #+LATEX_HEADER: \newtcbtheorem[number within=section]{mbhint}{\hintBoxCaption}{tc_hint}{th}
    #+LATEX_HEADER: \setBox{tc_resume}{\resumeBoxCol}
    #+LATEX_HEADER: \newtcbtheorem[number within=section]{mbresume}{\resumeBoxCaption}{tc_resume}{th}
    #+LATEX_HEADER: \setBox{tc_results}{\resultsBoxCol}
    #+LATEX_HEADER: \newtcbtheorem[number within=section]{mbresults}{\resultsBoxCaption}{tc_results}{th}
    
    #+LATEX_HEADER: \setBox{tc_observation}{\observationBoxCol}
    #+LATEX_HEADER: \newtcbtheorem[number within=section]{mbobservation}{\observationBoxCaption}{tc_observation}{th}
    #+LATEX_HEADER: \setBox{tc_conclusion}{\conclusionBoxCol}
    #+LATEX_HEADER: \newtcbtheorem[number within=section]{mbconclusion}{\conclusionBoxCaption}{tc_conclusion}{th}
    #+LATEX_HEADER: \setBox{tc_summary}{\summaryBoxCol}
    #+LATEX_HEADER: \newtcbtheorem[number within=section]{mbsummary}{\summaryBoxCaption}{tc_summary}{th}
    
    #+LATEX_HEADER: \setBox{tc_definition}{\definitionBoxCol}
    #+LATEX_HEADER: \newtcbtheorem[number within=section]{mbdefinition}{\definitionBoxCaption}{tc_definition}{th}
    
    #+LATEX_HEADER: \setBox{tc_example}{\exampleBoxCol}
    #+LATEX_HEADER: \newtcbtheorem[number within=section]{mbexample}{\exampleBoxCaption}{tc_example}{th}
    
    #+LATEX_HEADER: \setBox{tc_theorem}{\theoremBoxCol}
    #+LATEX_HEADER: \newtcbtheorem[number within=section]{mbtheorem}{\theoremBoxCaption}{tc_theorem}{th}
    
    #+LATEX_HEADER: \setBox{tc_lemma}{\lemmaBoxCol}
    #+LATEX_HEADER: \newtcbtheorem[number within=section]{mblemma}{\lemmaBoxCaption}{tc_lemma}{th}


### Preamble part with environments/box macros

    
    #+MACRO: begin_warning  @@latex:\begin{mbwarning}{$1}{$2}@@
    #+MACRO: end_warning    @@latex:\end{mbwarning}@@
    
    #+MACRO: begin_remark  @@latex:\begin{mbremark}{$1}{$2}@@
    #+MACRO: end_remark    @@latex:\end{mbremark}@@
    
    
    #+MACRO: begin_problem  @@latex:\begin{mbproblem}{$1}{$2}@@
    #+MACRO: end_problem    @@latex:\end{mbproblem}@@
    
    #+MACRO: begin_question  @@latex:\begin{mbquestion}{$1}{$2}@@
    #+MACRO: end_question    @@latex:\end{mbquestion}@@
    
    #+MACRO: begin_answer  @@latex:\begin{mbanswer}{$1}{$2}@@
    #+MACRO: end_answer    @@latex:\end{mbanswer}@@
    
    #+MACRO: begin_task  @@latex:\begin{mbtask}{$1}{$2}@@
    #+MACRO: end_task    @@latex:\end{mbtask}@@
    
    #+MACRO: begin_solution  @@latex:\begin{mbsolution}{$1}{$2}@@
    #+MACRO: end_solution    @@latex:\end{mbsolution}@@
    
    
    #+MACRO: begin_hint  @@latex:\begin{mbhint}{$1}{$2}@@
    #+MACRO: end_hint    @@latex:\end{mbhint}@@
    
    #+MACRO: begin_resume  @@latex:\begin{mbresume}{$1}{$2}@@
    #+MACRO: end_resume    @@latex:\end{mbresume}@@
    
    #+MACRO: begin_results  @@latex:\begin{mbresults}{$1}{$2}@@
    #+MACRO: end_results    @@latex:\end{mbresults}@@
    
    
    #+MACRO: begin_observation  @@latex:\begin{mbobservation}{$1}{$2}@@
    #+MACRO: end_observation    @@latex:\end{mbobservation}@@
    
    #+MACRO: begin_conclusion  @@latex:\begin{mbconclusion}{$1}{$2}@@
    #+MACRO: end_conclusion    @@latex:\end{mbconclusion}@@
    
    #+MACRO: begin_summary  @@latex:\begin{mbsummary}{$1}{$2}@@
    #+MACRO: end_summary    @@latex:\end{mbsummary}@@
    
    
    #+MACRO: begin_definition  @@latex:\begin{mbdefinition}{$1}{$2}@@
    #+MACRO: end_definition    @@latex:\end{mbdefinition}@@
    
    #+MACRO: begin_example  @@latex:\begin{mbexample}{$1}{$2}@@
    #+MACRO: end_example    @@latex:\end{mbexample}@@
    
    #+MACRO: begin_theorem  @@latex:\begin{mbtheorem}{$1}{$2}@@
    #+MACRO: end_theorem    @@latex:\end{mbtheorem}@@
    
    #+MACRO: begin_lemma  @@latex:\begin{mblemma}{$1}{$2}@@
    #+MACRO: end_lemma    @@latex:\end{mblemma}@@


### Math commands

    # %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    #    Math Latex commands
    # %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    #+LATEX_HEADER: \newcommand{\intab}{\int_{x_a}^{x_b}}
    #+LATEX_HEADER: \newcommand{\dotp}[1]{\langle #1 \rangle}
    
    #+LATEX_HEADER: \newcommand{\dif}{\mathrm{d} }
    #+LATEX_HEADER: \newcommand{\dx}{\mathrm{d} x}
    #+LATEX_HEADER: \newcommand{\dy}{\mathrm{d} y}


## Test file

    #+TITLE: Test of sync/async exporter of color code blocks and special blocks
    
    #+BIND: org-beamer-outline-frame-title "AAAAAAAAA"
    # #+BIND: org-latex-listings minted
    # #+BIND: org-latex-packages-alist (("" "minted"))
    # #+BIND: org-latex-minted-options (("bgcolor=red") ("frame" "lines"))
    
    
    #+LATEX_CLASS: article
    #+SETUPFILE: ./Preamble2023_07.org
    
    * Test
    ** Code block example
    #+begin_src python 
      stri = 'string'
    
      print(stri)
    #+end_src
    
    ** Special block macro
    {{{begin_warning}}}
    Something
    {{{end_warning}}}
    
    {{{begin_remark}}}
    Uwaga przykladowa
    {{{end_remark}}}
    
    * COMMENT Local Variables
    # Local Variables:
    # org-beamer-outline-frame-title: "55"
    # org-latex-listings: minted
    # org-latex-packages-alist: (("" "minted"))
    # org-latex-minted-options: (("bgcolor=yellow") ("frame" "lines"))
    # eval: (add-to-list 'load-path "~/.emacs.d/myarch")
    # eval: (require 'MB-org-special-block-extras)
    # End:

