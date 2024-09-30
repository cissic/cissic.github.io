
# Table of Contents

1.  [Org-mode files to html one more time](#org96ec9cb)
    1.  [To run the project](#org3f17e80)
        1.  [Evaluate this line](#orgef9c5c2)
        2.  [Tangle this file](#org43f29b4)
    2.  [Content](#org5ecf787)
        1.  [Basics](#org9c399f5)
        2.  ['**scratch**' buffer content](#orgcd3a11a)
        3.  [css files](#orgcac25ec)
        4.  [index.org](#orgb4da88f)
        5.  [Presentation of different stylesheets](#orgbf1ec98)
        6.  [remember.org content](#orgc88536a)
        7.  [secondFile.org content](#org53925f7)
        8.  [Inside dir1 content](#orgf3a89d5)



<a id="org96ec9cb"></a>

# TODO Org-mode files to html one more time

<https://orgmode.org/worg/org-tutorials/org-publish-html-tutorial.html#sec-8-1>


<a id="org3f17e80"></a>

## To run the project


<a id="orgef9c5c2"></a>

### Evaluate this line

    dir=2024-09-12-Org-mode-files-to-html-one-more-time
    rm -rf $dir
    
    pwd
    dir=2024-09-12-Org-mode-files-to-html-one-more-time
    mkdir $dir
    
    cd $dir
    mkdir css
    mkdir img
    mkdir dir1
    touch index.org
    touch remember.org
    
    cd img 
    curl https://orgmode.org/resources/img/org-mode-unicorn.svg >> org-mode-unicorn.svg
    curl https://upload.wikimedia.org/wikipedia/commons/d/d4/Cool_jump.gif >> Cool_jump.gif
    
    cd ..


<a id="org43f29b4"></a>

### Tangle this file

    (setq this-dir "./2024-09-12-Org-mode-files-to-html-one-more-time/")
    (org-babel-tangle)
    ; :tangle (concat (org-entry-get nil "PRJ-DIR" t) "scratch.el") :noweb yes 
    (require 'ox-publish)
    (setq org-publish-project-alist
          '(
    
           ;; ... add all the components here (see below)...
    
    ("org-notes"
     :base-directory "./2024-09-12-Org-mode-files-to-html-one-more-time/" ;"~/org/"
     :base-extension "org"
     :publishing-directory "./2024-09-12-Org-mode-files-to-html-one-more-time/public_html/"
     :recursive t
     :publishing-function org-html-publish-to-html
     :headline-levels 4             ; Just the default for this project.
     :auto-preamble t
     )
    
    ("org-static"
     :base-directory "./2024-09-12-Org-mode-files-to-html-one-more-time/" ;"~/org/"
     :base-extension "css\\|js\\|png\\|jpg\\|gif\\|pdf\\|mp3\\|ogg\\|swf"
     :publishing-directory "./2024-09-12-Org-mode-files-to-html-one-more-time/public_html/"
     :recursive t
     :publishing-function org-publish-attachment
     )
    
    ("org" :components ("org-notes" "org-static"))
    
    
          ))

and that's all!!!


<a id="org5ecf787"></a>

## Content


<a id="org9c399f5"></a>

### Basics

    dir=2024-09-12-Org-mode-files-to-html-one-more-time
    rm -rf $dir
    
    pwd
    dir=2024-09-12-Org-mode-files-to-html-one-more-time
    mkdir $dir
    
    cd $dir
    mkdir css
    mkdir img
    mkdir dir1
    touch index.org
    touch remember.org
    
    cd img 
    curl https://orgmode.org/resources/img/org-mode-unicorn.svg >> org-mode-unicorn.svg
    curl https://upload.wikimedia.org/wikipedia/commons/d/d4/Cool_jump.gif >> Cool_jump.gif
    
    cd ..


<a id="orgcd3a11a"></a>

### '**scratch**' buffer content

    ; :tangle (concat (org-entry-get nil "PRJ-DIR" t) "scratch.el") :noweb yes 
    (require 'ox-publish)
    (setq org-publish-project-alist
          '(
    
           ;; ... add all the components here (see below)...
    
    ("org-notes"
     :base-directory "./2024-09-12-Org-mode-files-to-html-one-more-time/" ;"~/org/"
     :base-extension "org"
     :publishing-directory "./2024-09-12-Org-mode-files-to-html-one-more-time/public_html/"
     :recursive t
     :publishing-function org-html-publish-to-html
     :headline-levels 4             ; Just the default for this project.
     :auto-preamble t
     )
    
    ("org-static"
     :base-directory "./2024-09-12-Org-mode-files-to-html-one-more-time/" ;"~/org/"
     :base-extension "css\\|js\\|png\\|jpg\\|gif\\|pdf\\|mp3\\|ogg\\|swf"
     :publishing-directory "./2024-09-12-Org-mode-files-to-html-one-more-time/public_html/"
     :recursive t
     :publishing-function org-publish-attachment
     )
    
    ("org" :components ("org-notes" "org-static"))
    
    
          ))


<a id="orgcac25ec"></a>

### css files

taken from

1.  worg

    <https://orgmode.org/worg/style/worg.css>
    
        /* latin */
        @font-face {
          font-family: 'Droid Sans';
          font-style: normal;
          font-weight: 400;
          src: url(fonts/SlGVmQWMvZQIdix7AFxXkHNSbQ.woff2) format('woff2');
          unicode-range: U+0000-00FF, U+0131, U+0152-0153, U+02BB-02BC, U+02C6, U+02DA, U+02DC, U+2000-206F, U+2074, U+20AC, U+2122, U+2191, U+2193, U+2212, U+2215, U+FEFF, U+FFFD;
        }
        /* latin */
        @font-face {
          font-family: 'Droid Sans Mono';
          font-style: normal;
          font-weight: 400;
          src: url(fonts/6NUO8FuJNQ2MbkrZ5-J8lKFrp7pRef2r.woff2) format('woff2');
          unicode-range: U+0000-00FF, U+0131, U+0152-0153, U+02BB-02BC, U+02C6, U+02DA, U+02DC, U+2000-206F, U+2074, U+20AC, U+2122, U+2191, U+2193, U+2212, U+2215, U+FEFF, U+FFFD;
        }
        /* latin */
        @font-face {
          font-family: 'Droid Serif';
          font-style: normal;
          font-weight: 400;
          src: url(fonts/tDbI2oqRg1oM3QBjjcaDkOr9rAU.woff2) format('woff2');
          unicode-range: U+0000-00FF, U+0131, U+0152-0153, U+02BB-02BC, U+02C6, U+02DA, U+02DC, U+2000-206F, U+2074, U+20AC, U+2122, U+2191, U+2193, U+2212, U+2215, U+FEFF, U+FFFD;
        }
        
        @media all
        {
        
            html {
        	margin: 0;
        	background-image: url(/worg/images/orgmode/org-mode-unicorn-original-logo.png);
        	background-attachment: fixed;
        	background-position: right bottom;
        	background-repeat: no-repeat;
        	background-color: white;
            }
        
            body {
        	color: black;
        	margin-top: 0;
        	line-height: 1.4rem;
        
            }
            body #content {
        	padding-top: 2em;
        	margin: auto;
        	max-width: 48em;
        	background-color: white;
            }
        
            body #support {
        	position: fixed;
        	top:0;
        	display:block;
        	font-size: 10pt;
        	right:0pt;
        	text-align: right;
        	padding: .2em 1em;
        	background: #EEE;
        	border-radius: 10px;
            }
            
            body .title {
        	margin-left: 0px;
        	font-size: 2.5em;
            }
        
            #org-div-home-and-up{
        	position: fixed;
        	right: 0.5em;
        	margin-top: 70px;
        	font-family:sans-serif;
            }
        
            /* TOC inspired by http://jashkenas.github.com/coffee-script */
            #table-of-contents {
        	z-index: 1;
        	margin-top: 105px;
        	font-size: 10pt;
        	font-family:sans-serif;
        	position: fixed;
        	right: 0em;
        	top: 0em;
        	background: white;
        	line-height: 12pt;
        	text-align: right;
        	box-shadow: 0 0 1em #777777;
        	-webkit-box-shadow: 0 0 1em #777777;
        	-moz-box-shadow: 0 0 1em #777777;
        	-webkit-border-bottom-left-radius: 5px;
        	-moz-border-radius-bottomleft: 5px;
        	/* ensure doesn't flow off the screen when expanded */
        	max-height: 80%;
        	overflow: auto; }
            /* Hide when screen is too narrow */
            @media only screen and (max-width: 67em) {
        	#table-of-contents {
                    display: none;
        	}
            }
            #table-of-contents h2 {
        	font-size: 13pt;
        	max-width: 9em;
        	border: 0;
        	font-weight: normal;
        	margin-top: 0.75em;
        	padding-left: 0.5em;
        	padding-right: 0.5em;
        	padding-top: 0.05em;
        	padding-bottom: 0.05em; }
            #table-of-contents #text-table-of-contents {
        	display: none;
        	text-align: left; }
            #table-of-contents:hover #text-table-of-contents {
        	display: block;
        	padding: 0.5em;
        	margin-top: -1.5em; }
        
            #license {
              background-color: #eeeeee;
              padding-top: 2px 0;
              border-radius: 5px;
            }
        
            .footpara:first-of-type {
        	display:inline;
            }
        
            h1 {
        	margin-bottom: 1em;
        	margin-right: 7%;
            }
        
            h2 {
        	color: #587e72;
        	border-bottom: 1px solid #ddd;
        	margin-top: 1.5em;
        	padding-bottom: 8px;
            }
        
            .outline-text-2 {
        	margin-left: 0.1em
            }
        
            h3 {
        	color: #587e72;
        	margin-left: 0.6em;
            }
        
            /* #A34D32;*/
        
            .outline-text-3 {
        	margin-left: 0.9em;
            }
        
            h4 {
        	color: #587e72;
        	margin-left: 1.2em;
            }
        
            .outline-text-4 {
        	margin-left: 1.45em;
            }
        
            a {
        	color: black;
        	font-weight: 400;
        	text-decoration: underline #587e72;
            }
            a:visited {
        	font-weight: 400;
        	text-decoration: purple;
            }
            a:hover {
        	color: #587e72;
            }
        
            .todo {
        	color: #CA0000;
            }
        
            .done {
        	color: #006666;
            }
        
            .timestamp-kwd {
        	color: #444;
            }
        
            .tag {
        
            }
        
            li {
        	margin: .4em;
            }
        
            dt {
        	margin: .4rem 0 .4rem 0;
            }
        
            table {
        	border: 0;
            }
        
            thead {
        	border: 0;
            }
        
            tbody {
        	border: 0;
            }
        
            tr {
        	border: 0;
            }
        
            td {
        	border-left: 0px;
        	border-right: 0px;
        	border-top: 0px;
        	border-bottom: 0px;
            }
        
            th {
        	border-left: 0px;
        	border-right: 0px;
        	border-top: 1px solid grey;
        	border-bottom: 1px solid grey;
            }
        
            code {
        	font-size: 0.9rem;
        	color: black;
        	padding: 0px 0.2em;
            }
        
            img {
        	border: 0;
            }
        
            .share img {
        	opacity: .4;
        	-moz-opacity: .4;
        	filter: alpha(opacity=40);
            }
        
            .share img:hover {
        	opacity: 1;
        	-moz-opacity: 1;
        	filter: alpha(opacity=100);
            }
        
            pre {
        	font-family: Droid Sans Mono, Monaco, Consolas, "Lucida Console", monospace;
        	color: black;
        	font-size: 90%;
        	padding: 0.5em;
        	overflow: auto;
        	border: none;
        	background-color: #f2f2f2;
        	border-radius: 5px;
            }
        
            .builtin {
        	/* font-lock-builtin-face */
        	color: #f4a460;
            }
            .comment {
        	/* font-lock-comment-face */
        	color: #737373;
            }
            .comment-delimiter {
        	/* font-lock-comment-delimiter-face */
        	color: #666666;
            }
            .constant {
        	/* font-lock-constant-face */
        	color: #db7093;
            }
            .doc {
        	/* font-lock-doc-face */
        	color: #b3b3b3;
            }
            .function-name {
        	/* font-lock-function-name-face */
        	color: #5f9ea0;
            }
            .headline {
        	/* headline-face */
        	color: #ffffff;
        	background-color: #000000;
        	font-weight: bold;
            }
            .blindtext {
        	color: #aaaaaa;
            }	
            .infobox, .highlightbox, .warningbox {
        	clear:both;
        	padding:0.5em;
        	margin-left: 1em;
        	margin-right: 1em;
        	border-radius: 0.7em;
                min-width: fit-content;
            }
            .infobox {
        	background-color: #f3f3f3;
            }
            .highlightbox {
        	font-size: 120%;
        	color: #337f67;
            }
            .warningbox, .inlinetask {
        	background-color: #fcf2f2;
            }
            .infobox p, .warningbox p {
        	margin:0em;
                margin-left:0.7em;
        	padding:0em;
            }
            .infobox::before, .warningbox::before {
        	content: "";
        	display: inline-block;
        	float: left;
        	margin: 0em 0.5em 0em 0em;
        	vertical-align: top;
        	width: 1.7em;
        	height: 1.7em;
        	padding: 0.4em;
        	background-size: cover;
            }
            .infobox::before {
        	background-image: url('/worg/images/icons/info.svg');
            }
            .warningbox::before {
        	background-image: url('/worg/images/icons/warning.svg');
            }
            .minipage {
        	width: inherit;
        	border:1px solid #aaaaaa;
        	padding:0.5em;
        	margin-left:auto;
        	margin-right:auto;
            }
            .inlinetask {
        	clear:both;
        	padding:0.5em;
        	margin-left: 1em;
        	margin-right: 1em;
        	background-color: #fcf2f2;
        	border-radius: 0.7em;
                min-width: fit-content;
            }
            .inlinetask::before {
        	content: "";
        	display: inline-block;
        	vertical-align: top;
        	width: 1.3em;
        	height: 1.3em;
        	background-image: url('/worg/images/icons/warning.svg');
        	background-size: cover;
            }
        
            .keyword {
        	/* font-lock-keyword-face */
        	color: #4682b4;
            }
            .negation-char {
            }
            .regexp-grouping-backslash {
            }
            .regexp-grouping-construct {
            }
            .string {
        	/* font-lock-string-face */
        	color: #ccc79a;
            }
            .subtitle {
        	font-size: 1.5em;
        	font-style: italic;
            }
            .todo-comment {
        	/* todo-comment-face */
        	color: #ffffff;
        	background-color: #000000;
        	font-weight: bold;
            }
            .variable-name {
        	/* font-lock-variable-name-face */
        	color: #ff6a6a;
            }
            .warning {
        	/* font-lock-warning-face */
        	color: #ffffff;
        	background-color: #cd5c5c;
        	font-weight: bold;
            }
            pre.a {
        	color: inherit;
        	background-color: inherit;
        	font: inherit;
        	text-decoration: inherit;
            }
            pre.a:hover {
        	text-decoration: underline;
            }
        
            /* Styles for org-info.js */
        
            .org-info-js_info-navigation
            {
        	border-style:none;
            }
        
            #org-info-js_console-label
            {
        	font-size:10px;
        	font-weight:bold;
        	white-space:nowrap;
            }
        
            .org-info-js_search-highlight
            {
        	background-color:#ffff00;
        	color:#000000;
        	font-weight:bold;
            }
        
            #org-info-js-window
            {
        	border-bottom:1px solid black;
        	padding-bottom:10px;
        	margin-bottom:10px;
            }
        
            .org-info-search-highlight
            {
        	background-color:#adefef; /* same color as emacs default */
        	color:#000000;
        	font-weight:bold;
            }
        
            .org-bbdb-company {
        	/* bbdb-company */
        	font-style: italic;
            }
            .org-bbdb-field-name {
            }
            .org-bbdb-field-value {
            }
            .org-bbdb-name {
        	/* bbdb-name */
        	text-decoration: underline;
            }
            .org-bold {
        	/* bold */
        	font-weight: bold;
            }
            .org-bold-italic {
        	/* bold-italic */
        	font-weight: bold;
        	font-style: italic;
            }
            .org-border {
        	/* border */
        	background-color: #000000;
            }
            .org-buffer-menu-buffer {
        	/* buffer-menu-buffer */
        	font-weight: bold;
            }
            .org-builtin {
        	/* font-lock-builtin-face */
        	color: #da70d6;
            }
            .org-button {
        	/* button */
        	text-decoration: underline;
            }
            .org-c-nonbreakable-space {
        	/* c-nonbreakable-space-face */
        	background-color: #ff0000;
        	font-weight: bold;
            }
            .org-calendar-today {
        	/* calendar-today */
        	text-decoration: underline;
            }
            .org-center {
        	text-align: center;
        	margin-top: 1em;
        	margin-bottom: 1em;
        	padding-top: 0.2em;
        	padding-bottom: 0.2em;
            }
            .org-comment {
        	/* font-lock-comment-face */
        	color: #b22222;
            }
            .org-comment-delimiter {
        	/* font-lock-comment-delimiter-face */
        	color: #b22222;
            }
            .org-constant {
        	/* font-lock-constant-face */
        	color: #5f9ea0;
            }
            .org-cursor {
        	/* cursor */
        	background-color: #000000;
            }
            .org-default {
        	/* default */
        	color: #000000;
        	background-color: #ffffff;
            }
            .org-diary {
        	/* diary */
        	color: #ff0000;
            }
            .org-doc {
        	/* font-lock-doc-face */
        	color: #bc8f8f;
            }
            .org-escape-glyph {
        	/* escape-glyph */
        	color: #a52a2a;
            }
            .org-file-name-shadow {
        	/* file-name-shadow */
        	color: #7f7f7f;
            }
            .org-fixed-pitch {
            }
            .org-fringe {
        	/* fringe */
        	background-color: #f2f2f2;
            }
            .org-function-name {
        	/* font-lock-function-name-face */
        	color: #0000ff;
            }
            .org-header-line {
        	/* header-line */
        	color: #333333;
        	background-color: #e5e5e5;
            }
            .org-help-argument-name {
        	/* help-argument-name */
        	font-style: italic;
            }
            .org-highlight {
        	/* highlight */
        	background-color: #b4eeb4;
            }
            .org-holiday {
        	/* holiday */
        	background-color: #ffc0cb;
            }
            .org-info-header-node {
        	/* info-header-node */
        	color: #a52a2a;
        	font-weight: bold;
        	font-style: italic;
            }
            .org-info-header-xref {
        	/* info-header-xref */
        	color: #0000ff;
        	text-decoration: underline;
            }
            .org-info-menu-header {
        	/* info-menu-header */
        	font-weight: bold;
            }
            .org-info-menu-star {
        	/* info-menu-star */
        	color: #ff0000;
            }
            .org-info-node {
        	/* info-node */
        	color: #a52a2a;
        	font-weight: bold;
        	font-style: italic;
            }
            .org-info-title-1 {
        	/* info-title-1 */
        	font-size: 172%;
        	font-weight: bold;
            }
            .org-info-title-2 {
        	/* info-title-2 */
        	font-size: 144%;
        	font-weight: bold;
            }
            .org-info-title-3 {
        	/* info-title-3 */
        	font-size: 120%;
        	font-weight: bold;
            }
            .org-info-title-4 {
        	/* info-title-4 */
        	font-weight: bold;
            }
            .org-info-xref {
        	/* info-xref */
        	color: #0000ff;
        	text-decoration: underline;
            }
            .org-isearch {
        	/* isearch */
        	color: #b0e2ff;
        	background-color: #cd00cd;
            }
            .org-italic {
        	/* italic */
        	font-style: italic;
            }
            .org-keyword {
        	/* font-lock-keyword-face */
        	color: #a020f0;
            }
            .org-lazy-highlight {
        	/* lazy-highlight */
        	background-color: #afeeee;
            }
            .org-link {
        	/* link */
        	color: #0000ff;
        	text-decoration: underline;
            }
            .org-link-visited {
        	/* link-visited */
        	color: #8b008b;
        	text-decoration: underline;
            }
            .org-match {
        	/* match */
        	background-color: #ffff00;
            }
            .org-menu {
            }
            .org-message-cited-text {
        	/* message-cited-text */
        	color: #ff0000;
            }
            .org-message-header-cc {
        	/* message-header-cc */
        	color: #191970;
            }
            .org-message-header-name {
        	/* message-header-name */
        	color: #6495ed;
            }
            .org-message-header-newsgroups {
        	/* message-header-newsgroups */
        	color: #00008b;
        	font-weight: bold;
        	font-style: italic;
            }
            .org-message-header-other {
        	/* message-header-other */
        	color: #4682b4;
            }
            .org-message-header-subject {
        	/* message-header-subject */
        	color: #000080;
        	font-weight: bold;
            }
            .org-message-header-to {
        	/* message-header-to */
        	color: #191970;
        	font-weight: bold;
            }
            .org-message-header-xheader {
        	/* message-header-xheader */
        	color: #0000ff;
            }
            .org-message-mml {
        	/* message-mml */
        	color: #228b22;
            }
            .org-message-separator {
        	/* message-separator */
        	color: #a52a2a;
            }
            .org-minibuffer-prompt {
        	/* minibuffer-prompt */
        	color: #0000cd;
            }
            .org-mm-uu-extract {
        	/* mm-uu-extract */
        	color: #006400;
        	background-color: #ffffe0;
            }
            .org-mode-line {
        	/* mode-line */
        	color: #000000;
        	background-color: #bfbfbf;
            }
            .org-mode-line-buffer-id {
        	/* mode-line-buffer-id */
        	font-weight: bold;
            }
            .org-mode-line-highlight {
            }
            .org-mode-line-inactive {
        	/* mode-line-inactive */
        	color: #333333;
        	background-color: #e5e5e5;
            }
            .org-mouse {
        	/* mouse */
        	background-color: #000000;
            }
            .org-negation-char {
            }
            .org-next-error {
        	/* next-error */
        	background-color: #eedc82;
            }
            .org-nobreak-space {
        	/* nobreak-space */
        	color: #a52a2a;
        	text-decoration: underline;
            }
            .org-org-agenda-date {
        	/* org-agenda-date */
        	color: #0000ff;
            }
            .org-org-agenda-date-weekend {
        	/* org-agenda-date-weekend */
        	color: #0000ff;
        	font-weight: bold;
            }
            .org-org-agenda-restriction-lock {
        	/* org-agenda-restriction-lock */
        	background-color: #ffff00;
            }
            .org-org-agenda-structure {
        	/* org-agenda-structure */
        	color: #0000ff;
            }
            .org-org-archived {
        	/* org-archived */
        	color: #7f7f7f;
            }
            .org-org-code {
        	/* org-code */
        	color: #7f7f7f;
            }
            .org-org-column {
        	/* org-column */
        	background-color: #e5e5e5;
            }
            .org-org-column-title {
        	/* org-column-title */
        	background-color: #e5e5e5;
        	font-weight: bold;
        	text-decoration: underline;
            }
            .org-org-date {
        	/* org-date */
        	color: #a020f0;
        	text-decoration: underline;
            }
            .org-org-done {
        	/* org-done */
        	color: #228b22;
        	font-weight: bold;
            }
            .org-org-drawer {
        	/* org-drawer */
        	color: #0000ff;
            }
            .org-org-ellipsis {
        	/* org-ellipsis */
        	color: #b8860b;
        	text-decoration: underline;
            }
            .org-org-formula {
        	/* org-formula */
        	color: #b22222;
            }
            .org-org-headline-done {
        	/* org-headline-done */
        	color: #bc8f8f;
            }
            .org-org-hide {
        	/* org-hide */
        	color: #e5e5e5;
            }
            .org-org-latex-and-export-specials {
        	/* org-latex-and-export-specials */
        	color: #8b4513;
            }
            .org-org-level-1 {
        	/* org-level-1 */
        	color: #0000ff;
            }
            .org-org-level-2 {
        	/* org-level-2 */
        	color: #b8860b;
            }
            .org-org-level-3 {
        	/* org-level-3 */
        	color: #a020f0;
            }
            .org-org-level-4 {
        	/* org-level-4 */
        	color: #b22222;
            }
            .org-org-level-5 {
        	/* org-level-5 */
        	color: #228b22;
            }
            .org-org-level-6 {
        	/* org-level-6 */
        	color: #5f9ea0;
            }
            .org-org-level-7 {
        	/* org-level-7 */
        	color: #da70d6;
            }
            .org-org-level-8 {
        	/* org-level-8 */
        	color: #bc8f8f;
            }
            .org-org-link {
        	/* org-link */
        	color: #a020f0;
        	text-decoration: underline;
            }
            .org-org-property-value {
            }
            .org-org-scheduled-previously {
        	/* org-scheduled-previously */
        	color: #b22222;
            }
            .org-org-scheduled-today {
        	/* org-scheduled-today */
        	color: #006400;
            }
            .org-org-sexp-date {
        	/* org-sexp-date */
        	color: #a020f0;
            }
            .org-org-special-keyword {
        	/* org-special-keyword */
        	color: #bc8f8f;
            }
            .org-org-table {
        	/* org-table */
        	color: #0000ff;
            }
            .org-org-tag {
        	/* org-tag */
        	font-weight: bold;
            }
            .org-org-target {
        	/* org-target */
        	text-decoration: underline;
            }
            .org-org-time-grid {
        	/* org-time-grid */
        	color: #b8860b;
            }
            .org-org-todo {
        	/* org-todo */
        	color: #ff0000;
            }
            .org-org-upcoming-deadline {
        	/* org-upcoming-deadline */
        	color: #b22222;
            }
            .org-org-verbatim {
        	/* org-verbatim */
        	color: #7f7f7f;
        	text-decoration: underline;
            }
            .org-org-warning {
        	/* org-warning */
        	color: #ff0000;
        	font-weight: bold;
            }
            .org-outline-1 {
        	/* outline-1 */
        	color: #0000ff;
            }
            .org-outline-2 {
        	/* outline-2 */
        	color: #b8860b;
            }
            .org-outline-3 {
        	/* outline-3 */
        	color: #a020f0;
            }
            .org-outline-4 {
        	/* outline-4 */
        	color: #b22222;
            }
            .org-outline-5 {
        	/* outline-5 */
        	color: #228b22;
            }
            .org-outline-6 {
        	/* outline-6 */
        	color: #5f9ea0;
            }
            .org-outline-7 {
        	/* outline-7 */
        	color: #da70d6;
            }
            .org-outline-8 {
        	/* outline-8 */
        	color: #bc8f8f;
            }
            .outline-text-1, .outline-text-2, .outline-text-3, .outline-text-4, .outline-text-5, .outline-text-6 {
        	/* Add more spacing between section. Padding, so that folding with org-info.js works as expected. */
        
            }
        
            .org-preprocessor {
        	/* font-lock-preprocessor-face */
        	color: #da70d6;
            }
            .org-query-replace {
        	/* query-replace */
        	color: #b0e2ff;
        	background-color: #cd00cd;
            }
            .org-regexp-grouping-backslash {
        	/* font-lock-regexp-grouping-backslash */
        	font-weight: bold;
            }
            .org-regexp-grouping-construct {
        	/* font-lock-regexp-grouping-construct */
        	font-weight: bold;
            }
            .org-region {
        	/* region */
        	background-color: #eedc82;
            }
            .org-rmail-highlight {
            }
            .org-scroll-bar {
        	/* scroll-bar */
        	background-color: #bfbfbf;
            }
            .org-secondary-selection {
        	/* secondary-selection */
        	background-color: #ffff00;
            }
            .org-shadow {
        	/* shadow */
        	color: #7f7f7f;
            }
            .org-show-paren-match {
        	/* show-paren-match */
        	background-color: #40e0d0;
            }
            .org-show-paren-mismatch {
        	/* show-paren-mismatch */
        	color: #ffffff;
        	background-color: #a020f0;
            }
            .org-string {
        	/* font-lock-string-face */
        	color: #bc8f8f;
            }
            .org-texinfo-heading {
        	/* texinfo-heading */
        	color: #0000ff;
            }
            .org-tool-bar {
        	/* tool-bar */
        	color: #000000;
        	background-color: #bfbfbf;
            }
            .org-tooltip {
        	/* tooltip */
        	color: #000000;
        	background-color: #ffffe0;
            }
            .org-trailing-whitespace {
        	/* trailing-whitespace */
        	background-color: #ff0000;
            }
            .org-type {
        	/* font-lock-type-face */
        	color: #228b22;
            }
            .org-underline {
        	/* underline */
        	text-decoration: underline;
            }
            .org-variable-name {
        	/* font-lock-variable-name-face */
        	color: #b8860b;
            }
            .org-variable-pitch {
            }
            .org-vertical-border {
            }
            .org-warning {
        	/* font-lock-warning-face */
        	color: #ff0000;
        	font-weight: bold;
            }
            .rss_box {}
            .rss_title, rss_title a {}
            .rss_items {}
            .rss_item a:link, .rss_item a:visited, .rss_item a:active {}
            .rss_item a:hover {}
            .rss_date {}
        
            label.org-src-name {
        	font-size: 80%;
        	font-style: italic;
            }
        
            #show_source {margin: 0; padding: 0;}
        
            #postamble {
        	font-size: 75%;
        	min-width: 700px;
        	max-width: 80%;
        	line-height: 14pt;
        	margin-left: 20px;
        	margin-top: 10px;
        	padding: .2em;
        	background-color: #ffffff;
        	z-index: -1000;
            }
        
        
        } /* END OF @media all */
        
        @media screen
        {
            #table-of-contents {
        	position: fixed;
        	margin-top: 105px;
        	float: right;
        	border: 1px solid #red;
        	max-width: 50%;
        	overflow: auto;
            }
        } /* END OF @media screen */

2.  zenburn

    <https://orgmode.org/worg/style/worg-zenburn.css>
    
        @media all
        {
          body {
              color: #dcdccc;
              background-color: #3f3f3f;
              font:0.9em serif;
              max-width: 95%;
              margin: auto;
              background-image: url(https://orgmode.org/tmp/org-mode-unicorn.png);
              background-repeat: no-repeat;
          }
            body #content {
              padding-top: 45px;
            }
            body pre {
              border: none; }
            body a {
              color: #8cd0d3; }
            body #content {
              padding-top: 100px; }
            body .title {
              margin-left: 120px;
            }
        
          /* TOC inspired by http://jashkenas.github.com/coffee-script */
          #table-of-contents {
            font-size: 10pt;
            position: fixed;
            right: 0em;
            top: 0em;
            background: #2b2b2b;
            color: #dcdccc;
            -webkit-box-shadow: 0 0 1em #777777;
            -moz-box-shadow: 0 0 1em #777777;
            -webkit-border-bottom-left-radius: 5px;
            -moz-border-radius-bottomleft: 5px;
            text-align: right;
            /* ensure doesn't flow off the screen when expanded */
            max-height: 80%;
            overflow: auto; }
            #table-of-contents h2 {
              font-size: 10pt;
              max-width: 8em;
              font-weight: normal;
              padding-left: 0.5em;
              padding-left: 0.5em;
              padding-top: 0.05em;
              padding-bottom: 0.05em; }
            #table-of-contents #text-table-of-contents {
              display: none;
              text-align: left; }
            #table-of-contents:hover #text-table-of-contents {
              display: block;
              padding: 0.5em;
              margin-top: -1.5em; }
            
          .rss_box {}
          .rss_title, rss_title a {}
          .rss_items {}
          .rss_item a:link, .rss_item a:visited, .rss_item a:active {}
          .rss_item a:hover {}
          .rss_date {}
        
        } /* END OF @media all */
        
        @media screen
        {
          #table-of-contents {
            float: right;
            border: 1px solid #CCC;
            max-width: 50%;
            overflow: auto;
          }
        } /* END OF @media screen */

3.  worg-classic

    <https://orgmode.org/worg/style/worg-classic.css>
    
        @media all
        {
            body {
        	margin: 10px 8% 10px 8%;
        	font-family: Verdana;
        	text-align: justify;
        	font-size: 10pt;
        	padding: 10px;
        	line-height: 1.2em;
            }
        
            #table-of-contents {
        	color: black;
        	background: #FFF;
        	font-size: 80%;
        	padding: .5em;
        	margin: 1em -2em 1em 1em;
        	display: block;
            }
        
            #table-of-contents a  {
        	color: #003333;
            }
        
            #table-of-contents a:hover {
        	color: #003333;
        	text-decoration: underline;
            }
        
            #table-of-contents li  {
        	margin: .2em;
            }
        
            #table-of-contents h2 {
        	margin-top: .2em;
        	border: none;
            }
        
            #license {
        	padding: .3em;
        	border: 1px solid grey;
        	background-color: #eeeeee;
        	font-size: 80%;
            }
        
            h1 {
        	font-size: 12pt;
            }
        
            .title {
        	color: #990000;
        	padding-bottom: 7px;
        	margin-bottom: 20px;
        	border-bottom: 1px solid #222;
            }
        
            h2 {
        	font-size: 12pt;
        	padding-bottom: 4px;
        	margin-bottom: 5px;
        	border-bottom: 3px solid #DDD;
            }
        
            h3 {
        	font-size: 11pt;
        	color: #333333;
            }
        
            h4 {
        	font-size: 9pt;
            }
        
            a {
        	text-decoration: none;
        	color: #006666
            }
        
            a:visited {
        	text-decoration: none;
        	color: #336666
            }
        
            a:hover {
        	text-decoration: underline;
        	color: #003333
            }
        
            .todo {
        	color: #990000;
            }
        
            .done {
        	color: #006666;
            }
        
            .timestamp-kwd {
        	color: #444;
            }
        
            .tag {
        	color: #DDD;
        	font-size: 70%;
        	font-weight: 500;
            }
        
            li {
        	margin: .4em;
            }
        
            table {
        	border: none;
            }
        
            td {
        	border: none;
        	padding: .1em .7em .1em .3em;
            }
        
            th {
        	border: none;
            }
        
            code {
        	font-size: 100%;
            }
        
            img {
        	border: none;
            }
        
            .share img {
        	opacity: .4;
        	-moz-opacity: .4;
        	filter: alpha(opacity=40);
            }
        
            .share img:hover {
        	opacity: 1;
        	-moz-opacity: 1;
        	filter: alpha(opacity=100);
            }
        
            /* pre {border: 1px solid #555; */
            /*      background: #EEE; */
            /*      font-size: 9pt; */
            /*      padding: 1em; */
            /*     } */
        
            /* pre { */
            /*     color: #e5e5e5; */
            /*     background-color: #000000; */
            /*     padding: 1.4em; */
            /*     border: 2px solid grey; */
            /* } */
        
            pre {
        	background-color: black;
        	border: 4px solid grey;
        	color: #EEE;
        	overflow: auto;
        	padding: 1em;
            }
        
            .builtin {
        	/* font-lock-builtin-face */
        	color: #f4a460;
            }
            .comment {
        	/* font-lock-comment-face */
        	color: #737373;
            }
            .comment-delimiter {
        	/* font-lock-comment-delimiter-face */
        	color: #666666;
            }
            .constant {
        	/* font-lock-constant-face */
        	color: #db7093;
            }
            .doc {
        	/* font-lock-doc-face */
        	color: #b3b3b3;
            }
            .function-name {
        	/* font-lock-function-name-face */
        	color: #5f9ea0;
            }
            .headline {
        	/* headline-face */
        	color: #ffffff;
        	background-color: #000000;
        	font-weight: bold;
            }
            .blindtext {
        	color: #aaaaaa;
            }
            .infobox, .highlightbox, .warningbox {
        	clear:both;
        	padding:0.5em;
        	margin-left: 1em;
        	margin-right: 1em;
        	border-radius: 0.7em;
                min-width: fit-content;
            }
            .infobox {
        	background-color: #f3f3f3;
            }
            .highlightbox {
        	font-size: 120%;
        	color: #337f67;
            }
            .warningbox, .inlinetask {
        	background-color: #fcf2f2;
            }
            .infobox p, .warningbox p {
        	margin:0em;
        	margin-left:0.7em;
                padding:0em;
            }
            .infobox::before, .warningbox::before {
        	content: "";
        	display: inline-block;
        	float: left;
        	margin: 0em 0.5em 0em 0em;
        	vertical-align: top;
        	width: 1.7em;
        	height: 1.7em;
        	padding: 0.4em;
        	background-size: cover;
            }
            .infobox::before {
        	background-image: url('/worg/images/icons/info.svg');
            }
            .warningbox::before {
        	background-image: url('/worg/images/icons/warning.svg');
            }
            .minipage {
        	width: inherit;
        	border:1px solid #aaaaaa;
        	padding:0.5em;
        	margin-left:auto;
        	margin-right:auto;
            }
            .inlinetask {
        	clear:both;
        	padding:0.5em;
        	margin-left: 1em;
        	margin-right: 1em;
        	background-color: #fcf2f2;
        	border-radius: 0.7em;
                min-width: fit-content;
            }
            .inlinetask::before {
        	content: "";
        	display: inline-block;
        	vertical-align: top;
        	width: 1.3em;
        	height: 1.3em;
        	background-image: url('/worg/images/icons/warning.svg');
        	background-size: cover;
            }
        
            .keyword {
        	/* font-lock-keyword-face */
        	color: #4682b4;
            }
            .negation-char {
            }
            .regexp-grouping-backslash {
            }
            .regexp-grouping-construct {
            }
            .string {
        	/* font-lock-string-face */
        	color: #ccc79a;
            }
            .todo-comment {
        	/* todo-comment-face */
        	color: #ffffff;
        	background-color: #000000;
        	font-weight: bold;
            }
            .variable-name {
        	/* font-lock-variable-name-face */
        	color: #ff6a6a;
            }
            .warning {
        	/* font-lock-warning-face */
        	color: #ffffff;
        	background-color: #cd5c5c;
        	font-weight: bold;
            }
            pre.a {
        	color: inherit;
        	background-color: inherit;
        	font: inherit;
        	text-decoration: inherit;
            }
            pre.a:hover {
        	text-decoration: underline;
            }
        
            /* Styles for org-info.js  @import url(/worg/style/worg-boxes.css)
             */
        
            .org-info-js_info-navigation
            {
        	border-style:none;
            }
        
            #org-info-js_console-label
            {
        	font-size:10px;
        	font-weight:bold;
        	white-space:nowrap;
            }
        
            .org-info-js_search-highlight
            {
        	background-color:#ffff00;
        	color:#000000;
        	font-weight:bold;
            }
        
            #org-info-js-window
            {
        	border-bottom:1px solid black;
        	padding-bottom:10px;
        	margin-bottom:10px;
            }
        
        
        
            .org-info-search-highlight
            {
        	background-color:#adefef; /* same color as emacs default */
        	color:#000000;
        	font-weight:bold;
            }
        
            .org-bbdb-company {
        	/* bbdb-company */
        	font-style: italic;
            }
            .org-bbdb-field-name {
            }
            .org-bbdb-field-value {
            }
            .org-bbdb-name {
        	/* bbdb-name */
        	text-decoration: underline;
            }
            .org-bold {
        	/* bold */
        	font-weight: bold;
            }
            .org-bold-italic {
        	/* bold-italic */
        	font-weight: bold;
        	font-style: italic;
            }
            .org-border {
        	/* border */
        	background-color: #000000;
            }
            .org-buffer-menu-buffer {
        	/* buffer-menu-buffer */
        	font-weight: bold;
            }
            .org-builtin {
        	/* font-lock-builtin-face */
        	color: #da70d6;
            }
            .org-button {
        	/* button */
        	text-decoration: underline;
            }
            .org-c-nonbreakable-space {
        	/* c-nonbreakable-space-face */
        	background-color: #ff0000;
        	font-weight: bold;
            }
            .org-calendar-today {
        	/* calendar-today */
        	text-decoration: underline;
            }
            .org-comment {
        	/* font-lock-comment-face */
        	color: #b22222;
            }
            .org-comment-delimiter {
        	/* font-lock-comment-delimiter-face */
        	color: #b22222;
            }
            .org-constant {
        	/* font-lock-constant-face */
        	color: #5f9ea0;
            }
            .org-cursor {
        	/* cursor */
        	background-color: #000000;
            }
            .org-default {
        	/* default */
        	color: #000000;
        	background-color: #ffffff;
            }
            .org-diary {
        	/* diary */
        	color: #ff0000;
            }
            .org-doc {
        	/* font-lock-doc-face */
        	color: #bc8f8f;
            }
            .org-escape-glyph {
        	/* escape-glyph */
        	color: #a52a2a;
            }
            .org-file-name-shadow {
        	/* file-name-shadow */
        	color: #7f7f7f;
            }
            .org-fixed-pitch {
            }
            .org-fringe {
        	/* fringe */
        	background-color: #f2f2f2;
            }
            .org-function-name {
        	/* font-lock-function-name-face */
        	color: #0000ff;
            }
            .org-header-line {
        	/* header-line */
        	color: #333333;
        	background-color: #e5e5e5;
            }
            .org-help-argument-name {
        	/* help-argument-name */
        	font-style: italic;
            }
            .org-highlight {
        	/* highlight */
        	background-color: #b4eeb4;
            }
            .org-holiday {
        	/* holiday */
        	background-color: #ffc0cb;
            }
            .org-info-header-node {
        	/* info-header-node */
        	color: #a52a2a;
        	font-weight: bold;
        	font-style: italic;
            }
            .org-info-header-xref {
        	/* info-header-xref */
        	color: #0000ff;
        	text-decoration: underline;
            }
            .org-info-menu-header {
        	/* info-menu-header */
        	font-weight: bold;
            }
            .org-info-menu-star {
        	/* info-menu-star */
        	color: #ff0000;
            }
            .org-info-node {
        	/* info-node */
        	color: #a52a2a;
        	font-weight: bold;
        	font-style: italic;
            }
            .org-info-title-1 {
        	/* info-title-1 */
        	font-size: 172%;
        	font-weight: bold;
            }
            .org-info-title-2 {
        	/* info-title-2 */
        	font-size: 144%;
        	font-weight: bold;
            }
            .org-info-title-3 {
        	/* info-title-3 */
        	font-size: 120%;
        	font-weight: bold;
            }
            .org-info-title-4 {
        	/* info-title-4 */
        	font-weight: bold;
            }
            .org-info-xref {
        	/* info-xref */
        	color: #0000ff;
        	text-decoration: underline;
            }
            .org-isearch {
        	/* isearch */
        	color: #b0e2ff;
        	background-color: #cd00cd;
            }
            .org-italic {
        	/* italic */
        	font-style: italic;
            }
            .org-keyword {
        	/* font-lock-keyword-face */
        	color: #a020f0;
            }
            .org-lazy-highlight {
        	/* lazy-highlight */
        	background-color: #afeeee;
            }
            .org-link {
        	/* link */
        	color: #0000ff;
        	text-decoration: underline;
            }
            .org-link-visited {
        	/* link-visited */
        	color: #8b008b;
        	text-decoration: underline;
            }
            .org-match {
        	/* match */
        	background-color: #ffff00;
            }
            .org-menu {
            }
            .org-message-cited-text {
        	/* message-cited-text */
        	color: #ff0000;
            }
            .org-message-header-cc {
        	/* message-header-cc */
        	color: #191970;
            }
            .org-message-header-name {
        	/* message-header-name */
        	color: #6495ed;
            }
            .org-message-header-newsgroups {
        	/* message-header-newsgroups */
        	color: #00008b;
        	font-weight: bold;
        	font-style: italic;
            }
            .org-message-header-other {
        	/* message-header-other */
        	color: #4682b4;
            }
            .org-message-header-subject {
        	/* message-header-subject */
        	color: #000080;
        	font-weight: bold;
            }
            .org-message-header-to {
        	/* message-header-to */
        	color: #191970;
        	font-weight: bold;
            }
            .org-message-header-xheader {
        	/* message-header-xheader */
        	color: #0000ff;
            }
            .org-message-mml {
        	/* message-mml */
        	color: #228b22;
            }
            .org-message-separator {
        	/* message-separator */
        	color: #a52a2a;
            }
            .org-minibuffer-prompt {
        	/* minibuffer-prompt */
        	color: #0000cd;
            }
            .org-mm-uu-extract {
        	/* mm-uu-extract */
        	color: #006400;
        	background-color: #ffffe0;
            }
            .org-mode-line {
        	/* mode-line */
        	color: #000000;
        	background-color: #bfbfbf;
            }
            .org-mode-line-buffer-id {
        	/* mode-line-buffer-id */
        	font-weight: bold;
            }
            .org-mode-line-highlight {
            }
            .org-mode-line-inactive {
        	/* mode-line-inactive */
        	color: #333333;
        	background-color: #e5e5e5;
            }
            .org-mouse {
        	/* mouse */
        	background-color: #000000;
            }
            .org-negation-char {
            }
            .org-next-error {
        	/* next-error */
        	background-color: #eedc82;
            }
            .org-nobreak-space {
        	/* nobreak-space */
        	color: #a52a2a;
        	text-decoration: underline;
            }
            .org-org-agenda-date {
        	/* org-agenda-date */
        	color: #0000ff;
            }
            .org-org-agenda-date-weekend {
        	/* org-agenda-date-weekend */
        	color: #0000ff;
        	font-weight: bold;
            }
            .org-org-agenda-restriction-lock {
        	/* org-agenda-restriction-lock */
        	background-color: #ffff00;
            }
            .org-org-agenda-structure {
        	/* org-agenda-structure */
        	color: #0000ff;
            }
            .org-org-archived {
        	/* org-archived */
        	color: #7f7f7f;
            }
            .org-org-code {
        	/* org-code */
        	color: #7f7f7f;
            }
            .org-org-column {
        	/* org-column */
        	background-color: #e5e5e5;
            }
            .org-org-column-title {
        	/* org-column-title */
        	background-color: #e5e5e5;
        	font-weight: bold;
        	text-decoration: underline;
            }
            .org-org-date {
        	/* org-date */
        	color: #a020f0;
        	text-decoration: underline;
            }
            .org-org-done {
        	/* org-done */
        	color: #228b22;
        	font-weight: bold;
            }
            .org-org-drawer {
        	/* org-drawer */
        	color: #0000ff;
            }
            .org-org-ellipsis {
        	/* org-ellipsis */
        	color: #b8860b;
        	text-decoration: underline;
            }
            .org-org-formula {
        	/* org-formula */
        	color: #b22222;
            }
            .org-org-headline-done {
        	/* org-headline-done */
        	color: #bc8f8f;
            }
            .org-org-hide {
        	/* org-hide */
        	color: #e5e5e5;
            }
            .org-org-latex-and-export-specials {
        	/* org-latex-and-export-specials */
        	color: #8b4513;
            }
            .org-org-level-1 {
        	/* org-level-1 */
        	color: #0000ff;
            }
            .org-org-level-2 {
        	/* org-level-2 */
        	color: #b8860b;
            }
            .org-org-level-3 {
        	/* org-level-3 */
        	color: #a020f0;
            }
            .org-org-level-4 {
        	/* org-level-4 */
        	color: #b22222;
            }
            .org-org-level-5 {
        	/* org-level-5 */
        	color: #228b22;
            }
            .org-org-level-6 {
        	/* org-level-6 */
        	color: #5f9ea0;
            }
            .org-org-level-7 {
        	/* org-level-7 */
        	color: #da70d6;
            }
            .org-org-level-8 {
        	/* org-level-8 */
        	color: #bc8f8f;
            }
            .org-org-link {
        	/* org-link */
        	color: #a020f0;
        	text-decoration: underline;
            }
            .org-org-property-value {
            }
            .org-org-scheduled-previously {
        	/* org-scheduled-previously */
        	color: #b22222;
            }
            .org-org-scheduled-today {
        	/* org-scheduled-today */
        	color: #006400;
            }
            .org-org-sexp-date {
        	/* org-sexp-date */
        	color: #a020f0;
            }
            .org-org-special-keyword {
        	/* org-special-keyword */
        	color: #bc8f8f;
            }
            .org-org-table {
        	/* org-table */
        	color: #0000ff;
            }
            .org-org-tag {
        	/* org-tag */
        	font-weight: bold;
            }
            .org-org-target {
        	/* org-target */
        	text-decoration: underline;
            }
            .org-org-time-grid {
        	/* org-time-grid */
        	color: #b8860b;
            }
            .org-org-todo {
        	/* org-todo */
        	color: #ff0000;
            }
            .org-org-upcoming-deadline {
        	/* org-upcoming-deadline */
        	color: #b22222;
            }
            .org-org-verbatim {
        	/* org-verbatim */
        	color: #7f7f7f;
        	text-decoration: underline;
            }
            .org-org-warning {
        	/* org-warning */
        	color: #ff0000;
        	font-weight: bold;
            }
            .org-outline-1 {
        	/* outline-1 */
        	color: #0000ff;
            }
            .org-outline-2 {
        	/* outline-2 */
        	color: #b8860b;
            }
            .org-outline-3 {
        	/* outline-3 */
        	color: #a020f0;
            }
            .org-outline-4 {
        	/* outline-4 */
        	color: #b22222;
            }
            .org-outline-5 {
        	/* outline-5 */
        	color: #228b22;
            }
            .org-outline-6 {
        	/* outline-6 */
        	color: #5f9ea0;
            }
            .org-outline-7 {
        	/* outline-7 */
        	color: #da70d6;
            }
            .org-outline-8 {
        	/* outline-8 */
        	color: #bc8f8f;
            }
            .outline-text-1, .outline-text-2, .outline-text-3, .outline-text-4, .outline-text-5, .outline-text-6 {
        	/* Add more spacing between section. Padding, so that folding with org-info.js works as expected. */
        	padding-bottom:2em;
            }
            .org-preprocessor {
        	/* font-lock-preprocessor-face */
        	color: #da70d6;
            }
            .org-query-replace {
        	/* query-replace */
        	color: #b0e2ff;
        	background-color: #cd00cd;
            }
            .org-regexp-grouping-backslash {
        	/* font-lock-regexp-grouping-backslash */
        	font-weight: bold;
            }
            .org-regexp-grouping-construct {
        	/* font-lock-regexp-grouping-construct */
        	font-weight: bold;
            }
            .org-region {
        	/* region */
        	background-color: #eedc82;
            }
            .org-rmail-highlight {
            }
            .org-scroll-bar {
        	/* scroll-bar */
        	background-color: #bfbfbf;
            }
            .org-secondary-selection {
        	/* secondary-selection */
        	background-color: #ffff00;
            }
            .org-shadow {
        	/* shadow */
        	color: #7f7f7f;
            }
            .org-show-paren-match {
        	/* show-paren-match */
        	background-color: #40e0d0;
            }
            .org-show-paren-mismatch {
        	/* show-paren-mismatch */
        	color: #ffffff;
        	background-color: #a020f0;
            }
            .org-string {
        	/* font-lock-string-face */
        	color: #bc8f8f;
            }
            .org-texinfo-heading {
        	/* texinfo-heading */
        	color: #0000ff;
            }
            .org-tool-bar {
        	/* tool-bar */
        	color: #000000;
        	background-color: #bfbfbf;
            }
            .org-tooltip {
        	/* tooltip */
        	color: #000000;
        	background-color: #ffffe0;
            }
            .org-trailing-whitespace {
        	/* trailing-whitespace */
        	background-color: #ff0000;
            }
            .org-type {
        	/* font-lock-type-face */
        	color: #228b22;
            }
            .org-underline {
        	/* underline */
        	text-decoration: underline;
            }
            .org-variable-name {
        	/* font-lock-variable-name-face */
        	color: #b8860b;
            }
            .org-variable-pitch {
            }
            .org-vertical-border {
            }
            .org-warning {
        	/* font-lock-warning-face */
        	color: #ff0000;
        	font-weight: bold;
            }
            .rss_box {}
            .rss_title, rss_title a {}
            .rss_items {}
            .rss_item a:link, .rss_item a:visited, .rss_item a:active {}
            .rss_item a:hover {}
            .rss_date {}
        
        } /* END OF @media all */
        
        
        
        @media screen
        {
          #table-of-contents {
            float: right;
            border: 1px solid #CCC;
            max-width: 50%;
            overflow: auto;
          }
        } /* END OF @media screen */


<a id="orgb4da88f"></a>

### index.org

    #+TITLE: This is my page
    #+AUTHOR: marbor
    
    
    [[file:css-styles-presentation.org][Presentation of different css styles]]
    
    
    [[file:worg/index.org][1]]
    
    [[file:worg/blorgit.org][2]]
    
    [[file:worg/org-web.org][3]]
    
    [[file:worg/orgcard.org][4]]
    
    
    [[file:orgweb/index.org][orgweb-index]]
    
    
    [[file:secondFile.org][secondFile]]  [[file:dir1/dir1file1.org][FilesInsideADir]] \ \ \ \quad
    [[file:remember.org][remember]]
    
    
    #+INCLUDE: secondFile.org
    
    * COMMENT html style specifications
    
    # Local Variables:
    # org-html-head: "<link rel=\"stylesheet\" type=\"text/css\" href=\"css/worg-zenburn.css\" />"
    # End:


<a id="orgbf1ec98"></a>

### Presentation of different stylesheets

    #+TITLE: Presentation of different stylesheets
     
    [[file:css-worg.org][worg]]
    
    [[file:css-worg-zenburn.org][zenburn]]
    
    [[file:css-worg-classic.org][worg-classic]]

    
    * Worg classic 
    Content
    
    $\alpha^2$
    
    
    
    $$
    \beta_2 = x_1
    $$
    
    \begin{equation}
    mc^2 = E
    \label{Eq:equ1}
    \end{equation}
    
    Równanie \ref{Eq:equ1}
    
    #+begin_export latex
    $\alpha$ + 3^2 = 4
    #+end_export
    
    
    * COMMENT html style specifications

1.  worg

        
        
        * Worg classic 
        Content
        
        $\alpha^2$
        
        
        
        $$
        \beta_2 = x_1
        $$
        
        \begin{equation}
        mc^2 = E
        \label{Eq:equ1}
        \end{equation}
        
        Równanie \ref{Eq:equ1}
        
        #+begin_export latex
        $\alpha$ + 3^2 = 4
        #+end_export
        
        
        * COMMENT html style specifications
        
        # Local Variables:
        # org-html-head: "<link rel=\"stylesheet\" type=\"text/css\" href=\"css/worg.css\" />"
        # End:

2.  zenburn

        
        
        * Worg classic 
        Content
        
        $\alpha^2$
        
        
        
        $$
        \beta_2 = x_1
        $$
        
        \begin{equation}
        mc^2 = E
        \label{Eq:equ1}
        \end{equation}
        
        Równanie \ref{Eq:equ1}
        
        #+begin_export latex
        $\alpha$ + 3^2 = 4
        #+end_export
        
        
        * COMMENT html style specifications
        
        # Local Variables:
        # org-html-head: "<link rel=\"stylesheet\" type=\"text/css\" href=\"css/worg-zenburn.css\" />"
        # End:

3.  worg-classic

        
        
        * Worg classic 
        Content
        
        $\alpha^2$
        
        
        
        $$
        \beta_2 = x_1
        $$
        
        \begin{equation}
        mc^2 = E
        \label{Eq:equ1}
        \end{equation}
        
        Równanie \ref{Eq:equ1}
        
        #+begin_export latex
        $\alpha$ + 3^2 = 4
        #+end_export
        
        
        * COMMENT html style specifications
        
        # Local Variables:
        # org-html-head: "<link rel=\"stylesheet\" type=\"text/css\" href=\"css/worg-classic.css\" />"
        # End:


<a id="orgc88536a"></a>

### remember.org content

    * First heading remember
    Content
    
    $\alpha^2$
    
    
    
    $$
    \beta_2 = x_1
    $$
    
    \begin{equation}
    mc^2 = E
    \label{Eq:equ1}
    \end{equation}
    
    Równanie \ref{Eq:equ1}
    
    #+begin_export latex
    $\alpha$ + 3^2 = 4
    #+end_export
    
    
    
    Equation above


<a id="org53925f7"></a>

### secondFile.org content

    * Yet another first heading
    Look inside [[file:remember.org][remember]].
    
    [[file:./img/Cool_jump.gif]]
    
    [[file:./img/org-mode-unicorn.svg]]


<a id="orgf3a89d5"></a>

### Inside dir1 content

    #+TITLE: TO jest przykładowe coś
    
    * Rozdział 1
    ** Podrozdział 1
    
    ** Podrozdział 2
    
    
    * Rozdział 2
