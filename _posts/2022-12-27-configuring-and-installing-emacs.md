---
author: cissic
date: 2022-12-27 Tue
tags: 'emacs packages'
title: 'Initialization files setup in Emacs'
---


# Initialization files setup in Emacs


## Problem description

The aim of this post is to finally have clean and tidy Emacs initialization file.
After some time of battling with Emacs with the use of 
find-and-copy-snippets-from-internet I decided I had achieved sufficient level of 
experience to rewrite init.el from the scratch.
In the post I'm going to implement the following rules:

1.  Installation/Updating of packages is perfomed in separate file 
    `install-packages.el` (abbreviation for `install or upgrage packages`) which is intended to be executed every now and then,
    while Emacs initialization is done in `init.el`.
2.  I'm not going to use `use-package` since I still don't get it well. What is
     more, according to [this post](https://emacs.stackexchange.com/questions/44266/require-vs-package-initialize) `use-package` is just 
    a fancier way of doing things that can be done in vanilla Emacs.
3.  The style of init.el presented on [this page](https://docs.freebsd.org/en/books/developers-handbook/tools/#emacs) is something that seems to 
    look nice and I'm going to implement this approach.
4.  I'm not going to use multi-init-files approach presented ... somewhere 
    I saw some time ago and I'm unable to locate it now... 
    As for now I think all-setup-in-one-file approach means less clutter.
5.  I want to do things in emacsian way. So most of the comments are going to be
    included in this org file. `install-packages.el` and `init.el` will be tangled
    from it: `C-c C-v t`. If this shortcut does not work (for plain emacs 27.1
    installation tangling didn't work out of the box so I needed to load 
    `ox` package: 
    -> `M-x eval-expression` 
    -> `(require 'ox)` )
    
    There is an optional way of approaching this point presented 
    [here](http://gewhere.github.io/orgmode-emacs-init-file). It comes down to extracting `emacs-lisp` source snippets directly
    from an .org file when evaluating `init.el`. I have no idea whether there are
    any relevant differences between both approaches.


### Sources worth further reading

-   <https://ruzkuku.com/emacs.d.html#org804158b> - with a list of other useful
    pages with configurations

-   <https://docs.freebsd.org/en/books/developers-handbook/tools/#emacs>

-   <https://karthinks.com/software/batteries-included-with-emacs/>
-   <https://karthinks.com/software/more-batteries-included-with-emacs/>

-   <https://stackoverflow.com/questions/5500035/set-custom-keybinding-for-specific-emacs-mode>
-   <https://tuhdo.github.io/emacs-tutor3.html>
-   <https://karthinks.com>

1.  Latex (not interesting after getting used to org?)

    <https://karthinks.com/software/latex-input-for-impatient-scholars/>


## Installation/upgrade script

This script is meant to (re-)install/prepare/upgrade Emacs packages in order
to have fully working Emacs environment.  

This is an installation (or upgrade) script to keep installation commands 
outside init.el, in order to have everything clean and tidy (for details and 
discussion [check this](https://stackoverflow.com/questions/55038594/setting-up-emacs-on-new-machine-with-init-el-and-package-installation)).
Each time this script is run, the packages are not only installed but also
upgraded. Thus, it might happen that a new version of some package
breaks your installation. In order to prevent this troublesome situation
it's better to keep whole .emacs.d directory as a git repository and
make a commit before executing this script. Then, in case any problems
you can go back to restore properly working emacs installation.

Before running this script you should have git repository initialized in emacs
directory.
The repository should contain the following content:

-   init.el
-   install-packages.el
-   elpa/
-   .gitignore
-   ...

Synchronization of the local repository with the remote one is not
performed in this script. It should be performed explicitely by the user
in a convenient time.


### Preparation

First, there is a configuration line. The user needs to set the directory where Emacs initialization files are located (I know in new Emacs there exist some 
variable for this but a bit of redundancy won't do much harm).

Each time this script is run, the packages are not only installed but also
upgraded. Thus, it might happen that a new version of some package
breaks your installation. In order to prevent this troublesome situation
it's better to keep whole .emacs.d directory as a git repository and
make a commit before executing this script. Then, in case any problems
you can go back to restore properly working emacs installation.
Before running this script you should have a git repository initialized in emacs
directory and git itself installed in the system (see Sec. [1.4](#org0f7e72e)).
Synchronization of the local repository with the remote one is not
performed in this script. It should be performed explicitely by the user
in a convenient time.

In order to make a git commit from within elisp script I followed [this post](https://emacs.stackexchange.com/questions/48954/the-elisp-function-to-run-the-shell-command-in-specific-file-path).

    ;; Make a git commit of your repository.
    ;; 
    (let ((default-directory my-emacs-dir)) ; run command `git add -u` in the context of my-emacs-dir
      (shell-command "git add -u"))
    (let ((default-directory my-emacs-dir)) ; run command `git commmit` in the context of my-emacs-dir
      (shell-command
       "git commit -m 'Precautionary commit before running install-mb-packages.el'"))

Perform [package initialization](https://emacs.stackexchange.com/questions/44266/require-vs-package-initialize), only for Emacs < 27.1, since in Emacs 27.1
`package-initialize` is executed automatically, before
loading the init file ([see here](https://www.masteringemacs.org/article/whats-new-in-emacs-27-1)).

    
    (when (< emacs-major-version 27)
      (package-initialize)) ;  set up the load-paths and autoloads for installed packages
    (setq package-check-signature nil)

then declare repositories where emacs packages can be found. It used to be more  
addresses here, something like:

    
    (setq package-archives
          '(("gnu" . "http://elpa.gnu.org/packages/")  ;; default value of package-archives in Emacs 27.1
    	; ("marmalade" . "http://marmalade-repo.org/packages/")
    	("melpa" . "https://melpa.org/packages/")
    	("melpa-stable" . "http://stable.melpa.org/packages/")
    	; ("org" . "https://orgmode.org/elpa/")    ;;; removed as a way of dealing with https://emacs.stackexchange.com/questions/70081/how-to-deal-with-this-message-important-please-install-org-from-gnu-elpa-as-o
    	))

but, at the time of writing this (Jan, 2023), the biggest, the freshest etc. 
repository is `melpa` and it is advised to work with it. `Marmalade` is 
outdated, and I also needed to get rid of `orgmode` as a remedy for 
[some problem](https://emacs.stackexchange.com/questions/70081/how-to-deal-with-this-message-important-please-install-org-from-gnu-elpa-as-o) ([BTW](https://www.reddit.com/r/emacs/comments/9rj5ou/comment/e8iizni/?utm_source=share&utm_medium=web2x&context=3)).
So now my list of repositories looks as follows: 

    
    ;;first, declare repositories
    (setq package-archives
          '(("gnu" . "http://elpa.gnu.org/packages/")  ;; default value of package-archives in Emacs 27.1
    	("melpa" . "https://melpa.org/packages/")
    	("melpa-stable" . "http://stable.melpa.org/packages/")
    	))

Now, synchronize your data: download descriptions of ELPA packages 
and update the cache with current versions of
packages kept in remote repositories:

    ;; Refresh the repositories to have the newest versions of the packages
    (package-refresh-contents)

In Emacs 27.1 it [shouldn't be necessary to use](https://emacs.stackexchange.com/a/44287)
`(require 'packagename)`, so I can leave out the following code:

    ;; ;; Comment out if you've already loaded this package...
    ;; (require 'cl-lib)       ;; built-in in 27.1
    ;; (require 'package)      ;; built-in in 27.1


### The main part of the script - list the packages

I used to have `(defvar my-packages ...` instead of `(setq my-packages ...` 
below but... **Do not** use `defvar` for declaring a list of packages to be installed!
If the variable is already defined 
[`defvar` does nothing](https://emacs.stackexchange.com/questions/29710/whats-the-difference-between-setq-and-defvar) with it so it does 
not refresh a list after editing it and thus it prevents from the 
expected way of reevaluating of the `package-install.el`.

The main point of the file. Set the list of packages to be installed

    (setq my-packages
      '(

      ; counsel ; for ivy
      company
      ;dockerfile-mode    
      ;flycheck
      ;flycheck-pos-tip
      flyspell
      ;; google-this
      ido
      ; ivy
      ; jedi
      magit
      markdown-mode
      ;matlab-mode 
      modus-themes ; theme by Protesilaos Stavrou
      ;moe-theme ; https://github.com/kuanyui/moe-theme.el
      ;mh
      ;ob-async
      ;; org   ; ver. 9.3  built-in in Emacs 27.1
      org-ac
      ;org-download
      ;org-mime
      ;org-ref
      org-special-block-extras
      ;ox-gfm
      ;ox-pandoc
      ; ox-ipynb -> manual-download
      ;pandoc-mode
      ;pdf-tools
      popup   ; for yasnippet
      ;projectile
      ;pyenv-mode
      ;Pylint  ; zeby dzialal interpreter python'a po:  C-c C-c 
      ;rebox2
      ;recentf
      ;session-async
      ;shell-pop
      smex
      ; tramp  ; ver. 2.4.2 built-in in Emacs 27.1
      ;tao-theme ; https://github.com/11111000000/tao-theme-emacs
      ;treemacs
      ;use-package
      workgroups2
      ;w3m
      yasnippet
      )
    ;; "A list of packages to be installed at Emacs launch."
    )

And finally, perform the installation/upgrade of packages and 
print an information message.

    
    (defun my-packages-installed-p ()
      (cl-loop for p in my-packages
    	   when (not (package-installed-p p)) do (cl-return nil)
    	   finally (cl-return t)))
    
    (unless (my-packages-installed-p)
      ;; check for new packages (package versions)
      (package-refresh-contents)
      ;; install the missing packages
      (dolist (p my-packages)
        (when (not (package-installed-p p))
          (package-install p))))
    
    ;; ; (jedi:install-server)
    
    (message "All done in install-packages.")


### Problems/errors during installation of packages

No problems so far...


## My init.el

There's something like `early-init.el` in modern versions of Emacs that is intended
to speed up the launching process, however I'm not going to use this approach as
for now. An interesting discussion about this can be found [here](https://www.reddit.com/r/emacs/comments/enmbv4/earlyinitel_reduce_init_time_about_02_sec_and/).


### A note:

[When Emacs `init.el` does not load at startup](https://stackoverflow.com/questions/12224575/emacs-init-el-file-doesnt-load).

1.  [DEPRECATED] Setting an auxiliary variable

    This section is deprecated in favour of [`workgroups2 package`](#org525c8fd).
    
        ;; This file is designed to be re-evaled; use the variable first-time
        ;; to avoid any problems with this.
        (defvar first-time t
          "Flag signifying this is the first time that .emacs has been evaled")

2.  Package `package`  initialization

    In theory, in new Emacs two following lines shouldn't be required to have 
    everything working fine.
    However, it seems that some packages (`modus-themes`, `workgroups2`?) cannot 
    run without it when emacs commands are to be executed from command line 
    without invoking Emacs 
    window (Post with demonstration makefile should be published soon).
    
        (require 'package)
        (package-initialize)


### Setting separate file for emacs custom entries

If you don't set the separate for custom entries, Emacs appends its code
directly into `init.el`. To prevent this we need to define other file. 
Remember to create `custom-file.el` file by hand! Emacs won't create it 
for you.

    (setq custom-file "~/.emacs.d/custom-file.el")

Assuming that the code in custom-file is execute before the code
ahead of this line is not a safe assumption. So load this file
proactively.

    (load-file custom-file)


### Global emacs customization

Here are global Emacs customization. 
If necessary some useful infomation or link is added to the customization.

1.  Self-descriptive oneliners <a id="orgc143f22"></a>

        (auto-revert-mode 1)       ; Automatically reload file from a disk after change
        (global-auto-revert-mode) 
        
        (delete-selection-mode 1)  ; Replace selected text
        
        (show-paren-mode 1)        ; Highlight matching parenthesis
        
        (global-linum-mode 1)      ; Enable line numbering
        
        (setq line-number-mode t)  ; Show line number
        
        (setq column-number-mode t); Show column number
        
        (define-key global-map (kbd "RET") 'newline-and-indent) ; Auto-indent new lines
        
        (desktop-save-mode 1)      ; Save windows layout on closing
        (setq desktop-load-locked-desktop t) ; and don't ask for confirmation when 
        			   ; opening locked desktop
        (setq desktop-save t)
        
        (save-place-mode t)        ; When re-entering a file, return to the place, 
        			   ; where I was when I left it the last time.

2.  Emacs shell history from previous sessions

    [Emacs wiki page](https://www.emacswiki.org/emacs/SaveHist)
    
        (savehist-mode 1)          ; Save history for future sessions

3.  Easily restore previous/next window layout

    -   undo = previous window view
        
            C-c left
    -   redo (undo undo)
        
            C-c right
    
        (winner-mode 1)            ; Toggle between previous window layouts

4.  Line truncation

    There are some other ways of [truncating](https://stackoverflow.com/questions/7577614/emacs-truncate-lines-in-all-buffers):
    
        (setq-default truncate-lines t) ; ugly way of truncating
    
    or
    
        ; fancier way of truncating (word truncating) THIS DOES NOT WORK!!!
        (setq-default global-visual-line-mode t) 
    
    however I didn't find them pretty and finally this command is useful:
    
        (global-visual-line-mode t) ; Truncate lines 

5.  Prevent from deselecting text after M-w copying

    [Link](https://www.reddit.com/r/emacs/comments/1vdumz/emacs_to_keep_selection_after_copy/)
    
        ;; Do not deselect after M-w copying -> 
         (defadvice kill-ring-save (after keep-transient-mark-active ())
           "Override the deactivation of the mark."
           (setq deactivate-mark nil))
         (ad-activate 'kill-ring-save)
        ;; <- Do not deselect after M-w copying

6.  Setting default font

    To get the list of available fonts:
    Type the following in the **scratch** buffer, and press `C-j` at the end of it:
       `(font-family-list)`
    You may need to expand the result to see all of them, by hitting enter on 
    the `...` at the end.
    ([Source](https://stackoverflow.com/questions/13747749/font-families-for-emacs)).
    
    The font of my choice is:
    
        (set-frame-font "liberation mono 11" nil t) ; Set default font

7.  Time and calendar

    1.  DONE Locale for names of days of the week in org-mode
    
        Setting names of the days of the week and months to arbitrarily language:
        [Link 1](https://emacs.stackexchange.com/questions/50543/insert-date-using-a-calendar-where-other-language-rather-than-english-is-desir),
        [Link 2](https://emacs.stackexchange.com/questions/19602/org-calendar-change-date-language/19611#19611)
        
        [Link 1](https://emacs.stackexchange.com/questions/50543/insert-date-using-a-calendar-where-other-language-rather-than-english-is-desir)
        
        [Link 3](https://stackoverflow.com/questions/28913294/emacs-org-mode-language-of-time-stamps)
        
        The best method I found working for my purposes is:
        
            (setq system-time-locale "C")         ; Force Emacs to use English timestamps
        
        It makes Emacs use English language and not the system localization language
        when inserting weekdays abreviations in org-mode timestamps and in org-agenda.
    
    2.  DONE Calendar
    
        Inserting the date from the calendar. 
        Here's the way how one can insert date in org-mode by hitting `C-c .`
        choosing the day and hitting `RET`.
        
        The above shortcuts are listed in `Scroll` menu item which is visible in menu bar,
        when you're in Calendar buffer.
        
            ;; Calendar ->
            (defun calendar-insert-date ()
              "Capture the date at point, exit the Calendar, insert the date."
              (interactive)
              (seq-let (month day year) (save-match-data (calendar-cursor-to-date))
                (calendar-exit)
                (insert (format "%d-%02d-%02d" year month day))))
        
        Warning! Here, instead of using:
        
            (define-key calendar-mode-map (kbd "RET") 'calendar-insert-date)
        
        it's better to define the action as
        
            (eval-after-load "calendar"
              `(progn
                 (define-key calendar-mode-map (kbd "RET") 'calendar-insert-date)))
            ;; <- Calendar
        
        Otherwise, you may get `calendar-mode-map is void` error, 
        if `calendar-mode-map` it's not loaded at the moment of executing the command ([Link](https://emacs.stackexchange.com/questions/3548/how-to-change-key-bindings-for-calendar-mode)).
        
        Moving in calendar buffer is like follows:
        
        <table border="2" cellspacing="0" cellpadding="6" rules="groups" frame="hsides">
        
        
        <colgroup>
        <col  class="org-left" />
        
        <col  class="org-left" />
        
        <col  class="org-left" />
        </colgroup>
        <thead>
        <tr>
        <th scope="col" class="org-left">Move by</th>
        <th scope="col" class="org-left">Backward</th>
        <th scope="col" class="org-left">Forward</th>
        </tr>
        </thead>
        
        <tbody>
        <tr>
        <td class="org-left">a day</td>
        <td class="org-left">S-<left></td>
        <td class="org-left">S-<right></td>
        </tr>
        
        
        <tr>
        <td class="org-left">a week</td>
        <td class="org-left">S-<up></td>
        <td class="org-left">S-<down></td>
        </tr>
        
        
        <tr>
        <td class="org-left">a month</td>
        <td class="org-left">></td>
        <td class="org-left"><</td>
        </tr>
        
        
        <tr>
        <td class="org-left">3 months</td>
        <td class="org-left">M-v</td>
        <td class="org-left">C-v</td>
        </tr>
        
        
        <tr>
        <td class="org-left">a year</td>
        <td class="org-left">4 M-v</td>
        <td class="org-left">4 C-v</td>
        </tr>
        </tbody>
        </table>

8.  Easy moving between windows

    It is managed by [WindMove package](https://www.emacswiki.org/emacs/WindMove) that is built-in in Emacs.
    The default keybindings of this package is `Shift arrow`, which sometimes
    may be inconvenient (there are conflicts for example in org-mode, other 
    packages that conflict with org are [listed here](https://orgmode.org/manual/Conflicts.html)).
    That is why it's better to remap those keybindings to other 
    combination (`Super-Key-<arrow>` in the code below). 
    
        ;; windmove ->
        ;; Easy moving between windows
        
          ;; setting windmove-default-keybindings to super-<arrow> in order
          ;; to avoid org-mode conflicts
          (global-set-key (kbd "s-<left>")  'windmove-left)
          (global-set-key (kbd "s-<right>") 'windmove-right)
          (global-set-key (kbd "s-<up>")    'windmove-up)
          (global-set-key (kbd "s-<down>")  'windmove-down)
        ;; <- windmove
    
    1.  [DEPRECATED] Useful For Emacs < 27.1
    
        (This section is deprecated. In Emacs 27.1 the package works ok without
        the need of application of `ignore-error-wrapper` function.)
        
        According to [package's wikipage](https://www.emacswiki.org/emacs/WindMove) there exist some problem with the package,
        namely:
        "When you run for instance windmove-left and there is no window on the left,
         windmove will throw exception (and if you have debug-on-error enabled) 
        you will see Debugger complaining."
        
        Proposed workaround requires `cl` package, which unfortunately is
        [deprecated in Emacs 27.1](https://github.com/kiwanami/emacs-epc/issues/35) (The workaround worked in Emacs < 27).
        With the use of 
        [this post](https://emacs.stackexchange.com/questions/15189/alternative-to-lexical-let) and 
        [this part of emacs manual](https://www.gnu.org/software/emacs/manual/html_node/elisp/Using-Lexical-Binding.html) I sort of solved the problem and with the 
        following code Emacs does not throw warnings or errors.
        
            ;; windmove ->
            ;; Easy moving between windows
              (when (fboundp 'windmove-default-keybindings)
                (windmove-default-keybindings))
            
              (eval-when-compile (require 'cl))
              (setq lexical-binding t)
            
              (defun ignore-error-wrapper (fn)
                "Funtion return new function that ignore errors.
                 The function wraps a function with `ignore-errors' macro."
                (lexical-let ((fn fn))
                  (lambda ()
            	(interactive)
            	(ignore-errors
            	  (funcall fn)))))
            
              ;; setting windmove-default-keybindings to super-<arrow> in order
              ;; to avoid org-mode conflicts
              (global-set-key (kbd "s-<left>") (ignore-error-wrapper 'windmove-left))
              (global-set-key (kbd "s-<right>") (ignore-error-wrapper 'windmove-right))
              (global-set-key (kbd "s-<up>") (ignore-error-wrapper 'windmove-up))
              (global-set-key (kbd "s-<down>") (ignore-error-wrapper 'windmove-down))
            ;; <- windmove

9.  Easy windows resize

        ;; Easy windows resize ->
          (define-key global-map (kbd "C-s-<left>") 'shrink-window-horizontally)
          (global-set-key        (kbd "C-s-<right>") 'enlarge-window-horizontally)
          (global-set-key        (kbd "C-s-<down>") 'shrink-window)
          (global-set-key        (kbd "C-s-<up>") 'enlarge-window)
        ;; <- Easy windows resize 


### Completing

ido/smex vs ivy/counsel/swiper vs helm 

1.  ido-mode

    They say that `ido` is a [powerful package](https://www.masteringemacs.org/article/introduction-to-ido-mode) and you should have it enabled...
    I'm not going to argue with that, yet I haven't studied much its capabilities.
    
        ;; ido-mode ->
          (ido-mode 1)          
          (setq ido-enable-flex-matching t)
          (setq ido-everywhere t)  ; ido-mode for file searching
        ;; <- ido-mode

2.  smex

    This package is installed because I was inspired by some post. 
    Just for tests.
    <https://github.com/nonsequitur/smex/>
    
        ;; smex ->
        (global-set-key (kbd "M-x") 'smex)
        (global-set-key (kbd "M-X") 'smex-major-mode-commands)
        ;; This is your old M-x.
        (global-set-key (kbd "C-c C-c M-x") 'execute-extended-command) 
        ;; <- smex

3.  TODO Ivy (for testing) <a id="org726997c"></a>

    Furthermore, according to [some other users](https://ruzkuku.com/emacs.d.html#org804158b)
    "Ivy is simpler (and faster) than Helm but more powerful than Ido".


### Autocomplete

`auto-complete` vs `company`

    ;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ;; ;; *** Auto-completing
    ;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    (add-hook 'after-init-hook 'global-company-mode)

1.  Recently opened files

        ;; Recently opened files ->
          (recentf-mode 1)
          (setq recentf-max-menu-items 50)
          (setq recentf-max-saved-items 50)
          ;; in original emacs this binding is for "Find file read-only"
          (global-set-key "\C-x\ \C-r" 'recentf-open-files)
        ;; <- Recently opened files


### Org customization

1.  Org-agenda activation

    <https://orgmode.org/manual/Activation.html#Activation>
    
        ;; org-agenda activation
        (global-set-key (kbd "C-c l") #'org-store-link)
        (global-set-key (kbd "C-c a") #'org-agenda)
        (global-set-key (kbd "C-c c") #'org-capture)

2.  Org-special-block-extras

    [Author's page](http://alhassy.com/org-special-block-extras/)
    
        ;; **** org-special-block-extras -> 
        (add-hook #'org-mode-hook #'org-special-block-extras-mode)
        ;; <- **** org-special-block-extras 

3.  Org-babel

    To have org-babel enabled (execution of portions of code):
    
        
        ;; enabling org-babel
        (org-babel-do-load-languages
         'org-babel-load-languages '(
        			     (C . t)
        			     (matlab . t)
        			     ;;(perl . t)
        			     (octave . t)
        			     (org . t)
        			     (python . t)
        			     (shell . t)
        			     ))
        
        ;; no question about confirmation of evaluating babel code block
        (setq org-confirm-babel-evaluate nil)

4.  Tailoring org-mode to markdown export

    When exporting to markdown I want to add some keywords in a special format to
    the preamble of .md file.
    [How to do that is descried here.](https://emacs.stackexchange.com/questions/74505/how-can-i-add-specific-text-to-the-content-generated-by-org-mode-export-to-mark#74513)
    
        ;; **** org-to-markdown exporter customization  -> 
        
        (defun org-export-md-format-front-matter ()
          (let* ((kv-alist (org-element-map (org-element-parse-buffer 'greater-element)
        		       'keyword
        		     (lambda (keyword)
        		       (cons (intern (downcase (org-element-property :key keyword)))
        			     (org-element-property :value keyword)))))
        	 (lines (mapcar (lambda (kw)
        			  (let ((val (alist-get kw kv-alist)))
        			    (format (pcase kw
        				      ('author "%s: %s")
        				      ((or 'tags 'title) "%s: '%s'")
        				      (_ "%s: %s"))
        				    (downcase (symbol-name kw))
        				    (pcase kw
        				      ('date (substring val 1 -1))
        				      (_ val)))))
        			'(author date tags title))))
            (concat "---\n" (concat (mapconcat #'identity lines "\n")) "\n---")))
        
        (defun my/org-export-markdown-hook-function (backend)
            (if (eq backend 'md)
        	(insert (org-export-md-format-front-matter) "\n")))
        
        ;; This hook should be added per file in my org posts. Unfortunately, so far I don't know
        ;; how to do this.
        (add-hook 'org-export-before-processing-hook #'my/org-export-markdown-hook-function)
    
    Besides, in order to have markdown exporter options in menu appearing after
    `C-c C-e` you need to add 
    ([Link 1](https://stackoverflow.com/questions/22988092/emacs-org-mode-export-markdown/22990257#22990257), [Link 2](https://emacs.stackexchange.com/questions/4279/exporting-from-org-mode-to-markdown)):
    
        
        (require 'ox-md nil t)
        
        ;; <- **** org-to-markdown exporter customization

5.  TODO Default org to latex exporting command


### TODO Flyspell (TODO: dive deeper into the package and its capabilities)

<https://ruzkuku.com/emacs.d.html#org804158b>
<https://www.emacswiki.org/emacs/FlySpell>


### Flymake/Flycheck

<https://www.masteringemacs.org/article/spotlight-flycheck-a-flymake-replacement>

In Emacs 27.1 `flymake` is said to be competitive with `flycheck` again.
It is built-in in Emacs. As for now, I'm gonna use `flymake`.


### Bash completions

Bash has usually very good command completion facilities, which aren't accessible by default from Emacs (except by running `M-x term`). This package integrates them into regular commands such as `shell-command` and `shell`.


### General global shortcuts not restricted to specific package/mode

    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ;;;; Useful global shortcuts (text operations)
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    (global-set-key (kbd "C-d") 'delete-forward-char)    ; Backspace/Insert remapping
    (global-set-key (kbd "C-S-d") 'delete-backward-char) 
    ; (global-set-key (kbd "M-S-d") 'backward-kill-word)
    (global-set-key (kbd "C-c C-e s") 'mark-end-of-sentence)
    
    (global-set-key (kbd "C-C C-e C-w C-w") 'eww-list-bookmarks) ; Open eww bookmarks
    (defun mynet ()  (interactive) (eww-list-bookmarks))


### Load Emacs theme of your preference

1.  Modus themes by Protesilaos Stavrou

    -   [Author's page](https://protesilaos.com/codelog/2021-01-11-modus-themes-review-select-faint-colours/)
    -   [Youtube's tutorial](https://www.youtube.com/watch?v=JJPokfFxyFo)
    
    `noconfirm` flag needs to be added for two reasons.
    First, without it we cannot run Emacs in batch mode from command line
    (`emacs -batch -load ~/.emacs.d/init.el ...`). Second,... (I forgot the 
    second reason).
    
        ;; (setq modus-themes-headings ; this is an alist: read the manual or its doc string
        ;;       '((1 . (overline background variable-pitch 1.3))
        ;;         (2 . (rainbow overline 1.1))
        ;;         (t . (semibold))) )
    
        
        ;; Add all your customizations prior to loading the themes
        (setq modus-themes-italic-constructs t
              modus-themes-bold-constructs nil
              modus-themes-region '(bg-only no-extend))
        
        ;; Load the theme of your choice:
        (load-theme 'modus-vivendi :noconfirm) ;; OR (load-theme 'modus-operandi)
        
        (setq modus-themes-headings ; this is an alist: read the manual or its doc string
              '((1 . (rainbow overline background 1.4))
        	(2 . (rainbow background 1.3))
        	(3 . (rainbow bold 1.2))
        	(t . (semilight 1.1))))
        
        (setq modus-themes-scale-headings t)
        (setq modus-themes-org-blocks 'tinted-background)


### Manually downloaded packages

sunrise-commander - <https://www.emacswiki.org/emacs/Sunrise_Commander_Tips#h5o-1>,
<https://pragmaticemacs.wordpress.com/2015/10/29/double-dired-with-sunrise-commander/>

-   how to configure sunrise to be like Norton Commander

<https://enzuru.medium.com/sunrise-commander-an-orthodox-file-manager-for-emacs-2f92fd08ac9e>

-   buttons extenstion <https://www.emacswiki.org/emacs/sunrise-x-buttons.el>

<https://pragmaticemacs.wordpress.com/2015/10/29/double-dired-with-sunrise-commander/>

    
    ;; Set location for external packages.
    (add-to-list 'load-path "~/.emacs.d/manual-download/")
    
    ;; doconce -> 
    (load-file "~/.emacs.d/manual-download/.doconce-mode.el")
    
    ;; activating org-mode for doconce pub files:
    ;; https://github.com/doconce/publish/blob/master/doc/manual/publish-user-manual.pdf
    (setq auto-mode-alist
          (append '(("\\.org$" . org-mode))
    	      '(("\\.pub$" . org-mode))
    	      auto-mode-alist))
    ;; <- doconce
    
    ;; sunrise
    (add-to-list 'load-path "~/.emacs.d/manual-download/sunrise")
    (require 'sunrise)
    (require 'sunrise-buttons)
    (require 'sunrise-modeline)
    (add-to-list 'auto-mode-alist '("\\.srvm\\'" . sr-virtual-mode))
    
    
    
    
    ;; midnight-commander emulation
    ;; (require 'mc)
    
    ;; org to ipython exporter
    ;;(use-package ox-ipynb
    ;  :load-path "~/.emacs.d/manual-download/ox-ipynb")


### TODO The end

1.  Workgroups (should be executed at the end of init.el) <a id="org525c8fd"></a>

    <https://tuhdo.github.io/emacs-tutor3.html>
    
    `workgroups2` is a fine package for managing session. To enable it and 
    set the filepath for keeping sessions (default is `/.emacs_workgroups`)
     put this in your `init.el`:
    
        (workgroups-mode 1)    ; session manager for emacs
        (setq wg-session-file "~/.emacs.d/.emacs_workgroups") ; 
    
    And then you can use the following commands to manage sessions:
    
    -   To save window&buffer layout as a work group:
    
    `M-x wg-create-workgroup` or
    `C-c z C-c`
    
    -   To open an existing work group:
    
    `M-x wg-open-workgroup` or 
    `C-c z C-v`
    
    -   To delete an existing work group:
    
    `M-x wg-kill-workgroup` or
    `C-c z C-k`
    
    There is one problem with `workgroups2` packages. It does not like with 
    `desktop-save-mode`. When `workgroups2` is enabled `desktop-save-mode` 
    does not restore the windows layout from the previous Emacs session, which
    sucks.
    I decided to stick to `workgroups2` and supply the needed functionality 
    with the use of only this package. I did it by adding hooks:
    
        (add-hook 'kill-emacs-hook (
        		     lambda () (wg-create-workgroup "currentsession" )))
        
        (setq inhibit-startup-message t)
        
        (add-hook 'window-setup-hook (
        		       lambda () (wg-open-workgroup "currentsession")))
    
    The line `(setq inhibit-startup-message t)` is added in order to prevent
    Emacs splash screen to appear in one of the restored `"currentsession"` frames.

2.  Last lines

3.  [DEPRECATED] Restoring previous session

    This section is deprecated in favour of [`workgroups2 package`](#org525c8fd).
    
    This way of restoring session throws some warnings and needs additional
    confirmations so I give it up. Simple `(desktop-save-mode 1)` which is 
    included [in the beginning of `init.el`](#orgc143f22) works ok.
    
        ;; Restore the "desktop" - do this as late as possible
        (if first-time
            (progn
              ;(desktop-load-default)   ; this is for Emacs 20-21
              (desktop-read)))
        
        ;; Indicate that this file has been read at least once
        (setq first-time nil)

4.  Open some useful files in the background

        ;;; Always have several files opened at startup
        ;; hint: https://stackoverflow.com/a/19284395/4649238
        (find-file "~/.emacs.d/init.el")
        (find-file "~/.emacs.d/install-packages.el")
        (find-file "~/.emacs.d/useful-shortcuts.org")
        
        ;; All done
        (message "All done in init.el.")


## Dependencies of the presented Emacs configuration <a id="org0f7e72e"></a>:

The list of external applications that this script is dependent on:

-   git
-   LaTeX distribution (for org to latex exporters)

