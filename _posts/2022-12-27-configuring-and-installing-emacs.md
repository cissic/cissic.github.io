---
author: cissic
date: 2022-12-27 Tue
tags: 'emacs packages'
title: 'Initialization files setup in Emacs'
---


# Initialization files setup in Emacs


## TL;DR

An org source of this post can be found
[here](https://github.com/cissic/cissic.github.io/blob/main/mysource/public-notes-org/2022-12-27-configuring-and-installing-emacs.org). This org-file can be used to generate (tangle in Emacs nomenclature)
to scripts:
`install-packages.el` and
`init.el`.
Place them in your `./emacs.d` and hope ;) they will run without
problems on your machine.


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
directory and git itself installed in the system (see Sec. [1.5](#orgb9690af)).
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

then declare repositories where emacs packages can be found. There used to be more  
addresses here, something like:

    
    (setq package-archives
          '(("gnu" . "http://elpa.gnu.org/packages/")  ;; default value of package-archives in Emacs 27.1
            ; ("marmalade" . "http://marmalade-repo.org/packages/")
            ("melpa-stable" . "http://stable.melpa.org/packages/")
            ("melpa" . "https://melpa.org/packages/")
            ; ("org" . "https://orgmode.org/elpa/")    ;;; removed as a way of dealing with https://emacs.stackexchange.com/questions/70081/how-to-deal-with-this-message-important-please-install-org-from-gnu-elpa-as-o
            ))

but, at the time of writing this (Jan, 2023), the biggest, the freshest etc. 
repository is `melpa` and it is advised to work with it. `Marmalade` is 
outdated, and I also needed to get rid of `orgmode` as a remedy for 
[some problem](https://emacs.stackexchange.com/questions/70081/how-to-deal-with-this-message-important-please-install-org-from-gnu-elpa-as-o) ([BTW](https://www.reddit.com/r/emacs/comments/9rj5ou/comment/e8iizni/?utm_source=share&utm_medium=web2x&context=3)).

What is more, at some point I stumbled upon the troubles with refreshing `melpa`
repository. Even after explicit running `(package-refresh-contents)` I couldn't
see melpa packages in `packages-list`.
There is quite a [long thread](https://github.com/melpa/melpa/issues/7238) on this problem.

What helped me was replacing
`("melpa" . "https://melpa.org/packages/")` to
`("melpa" . "http://melpa.org/packages/")` <span class="underline">and</span> restarting emacs. Restarting is
important part of the procedure!

(Aside note: A way to go might also be [this post](https://github.com/melpa/melpa/issues/7238#issuecomment-761608049) that recommends adding
`(setq gnutls-algorithm-priority "NORMAL:-VERS-TLS1.3")`
in your `init.el`. This should allow to use `https` adresses as package archives.
I haven't check this approach but I should try this if anything goes
wrong in the future.)

NOTE (2023.08.30): In order to install `org-contrib` package
(`mediawiki` needs it as a dependency) I also needed to add 
`("nongnu"       . "https://elpa.nongnu.org/nongnu/")` repository.

NOTE (2023.12.06): In order to be sure that emacs downloads the freshest
version of the package I changed the order of the
`melpa` and `melpa-stable` archives. I read somewhere that if
two packages of the same name are provided from two different
repositories, Emacs takes the first one to install. So, from now on,
let `melpa` be before `melpa-stable`.

Now my list of repositories looks as follows: 

    
    ;;first, declare repositories
    (setq package-archives
          '(("gnu" . "http://elpa.gnu.org/packages/")  ;; default value of package-archives in Emacs 27.1
            ("melpa" . "http://melpa.org/packages/")
            ("melpa-stable" . "http://stable.melpa.org/packages/")
            ("nongnu"       . "https://elpa.nongnu.org/nongnu/")
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


### The main part of the installation script - list of the packages

<a id="orgdd7694b"></a>

I used to have `(defvar my-packages ...` instead of `(setq my-packages ...` 
below but... **Do not** use `defvar` for declaring a list of packages to be installed!
If the variable is already defined 
[`defvar` does nothing](https://emacs.stackexchange.com/questions/29710/whats-the-difference-between-setq-and-defvar) with it so it does 
not refresh a list after editing it and thus it prevents from the 
expected way of reevaluating of the `package-install.el`.

The main point of the file. Set the list of packages to be installed

    (setq my-packages
      '(

      auctex ; in order to have reftex working
      bash-completion  
      ; counsel ; for ivy
      cdlatex
      company
      chatgpt-shell
      dall-e-shell
      ;; ob-chatgpt-shell
      ;; ob-dall-e-shell
      dockerfile-mode
      emacs-everywhere
      engrave-faces
      fill-column-indicator
      ;flycheck
      ;flycheck-pos-tip
      flyspell
      ;; gptel ;; not working
      ;; google-this
      ido
      ; ivy
      ; jedi
      magit
      markdown-mode
      matlab-mode 
      modus-themes ; theme by Protesilaos Stavrou
      ;moe-theme ; https://github.com/kuanyui/moe-theme.el
      ;mh
      ;ob-async
      org   ; ver. 9.3  built-in in Emacs 27.1; this install version 9.6 from melpa
      org-ac
      org-ai
      ;org-download
      org-plus-contrib
      ;org-mime
      org-ref ; for handling org-mode references https://emacs.stackexchange.com/questions/9767/can-reftex-be-used-with-org-label
      org-special-block-extras
      ;ox-gfm
      ;ox-pandoc
      ; ox-ipynb -> manual-download
      ;pandoc-mode
      pdf-tools
      popup   ; for yasnippet
      ;projectile
      ;pyenv-mode
      ;Pylint  ; zeby dzialal interpreter python'a po:  C-c C-c 
      ;rebox2
      ;recentf
      ;session-async
      ;shell-pop
      smex
      ssh
      ; tramp  ; ver. 2.4.2 built-in in Emacs 27.1
      ;tao-theme ; https://github.com/11111000000/tao-theme-emacs
      ;treemacs
      ;use-package
      websocket
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

1.  DEPRECATED Setting an auxiliary variable

    This section is deprecated in favour of [`workgroups2 package`](#org1b6ce1b).
    
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

1.  Self-descriptive oneliners <a id="org8b92c80"></a>

    Remarks:
    At around May 2023 I stopped using `global-linum-mode` because
    of the annoying lags while typing in a buffer that occured quite
    frequently, Links:
    
    -   <https://github.com/jrblevin/markdown-mode/issues/181>
    -   <https://www.reddit.com/r/orgmode/comments/e7pq7k/linummode_very_slow_for_large_org_files/>
    -   <https://emacs.stackexchange.com/questions/49032/line-numbering-stick-with-linum-or-nlinum>
    
    From two possible alternatives at the time:
     `nlinum-mode` and `display-line-numbers-mode`
    I decided on the latter because it was built-in Emacs.
    
        (auto-revert-mode 1)       ; Automatically reload file from a disk after change
        (global-auto-revert-mode 1) 
        
        (delete-selection-mode 1)  ; Replace selected text
        
        (show-paren-mode 1)        ; Highlight matching parenthesis
        
        ; Enable line numbering
        ;; DEPRECATED, CAUSES LAGS WHEN TYPING: (global-linum-mode 1)			
        (global-display-line-numbers-mode 1) 
        
        (scroll-bar-mode 1)        ; Enable scrollbar
        (menu-bar-mode 1)          ; Enable menubar
        (tool-bar-mode -1)         ; Disable toolbar since it's rather useless
        
        (setq line-number-mode t)  ; Show line number
        
        (setq column-number-mode t); Show column number
        
        (define-key global-map (kbd "RET") 'newline-and-indent) ; Auto-indent new lines
        
        (if (not (daemonp))           ; if this is not a --daemon session -> see: [[emacs-everywhere]] section
           (desktop-save-mode 1)      ; Save buffers on closing and restore them at startup
        )
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
    
        ;; now this setting is done much lower in the code due to
        ;; problems with fonts in  emacsclient/daemonp instances -> see [[emacs-everywhere]]
        ;; (set-frame-font "liberation mono 11" nil t) ; Set default font
    
    Due to  due to the  problems with fonts in `emacsclient/daemonp`
    instances font is set now in the section [1.4.18](#orgce88eb5).

7.  Highlight on an active window/buffer

    Although the active window can be recognized
    by the cursor which blinking in it, sometimes it is hard to
    find in on the screen (especially if you use a colourful theme
    like [1.4.20.1](#orgf0ee1b2).
    
    I found a [post](https://stackoverflow.com/questions/33195122/highlight-current-active-window) adressing this issue.
    Although the accepted answer is using 
    `auto-dim-other-buffers.el`
    I prefer [this solution](https://stackoverflow.com/a/33196798) which does not rely on external package
    
        ;;Highlight an active window/buffer or dim all other windows
        
          (defun highlight-selected-window ()
            "Highlight selected window with a different background color."
            (walk-windows (lambda (w)
              (unless (eq w (selected-window)) 
                (with-current-buffer (window-buffer w)
                  (buffer-face-set '(:background "#111"))))))
            (buffer-face-set 'default))
        
            (add-hook 'buffer-list-update-hook 'highlight-selected-window)
        ;;

8.  Time and calendar

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
        <td class="org-left">S-&lt;left&gt;</td>
        <td class="org-left">S-&lt;right&gt;</td>
        </tr>
        
        
        <tr>
        <td class="org-left">a week</td>
        <td class="org-left">S-&lt;up&gt;</td>
        <td class="org-left">S-&lt;down&gt;</td>
        </tr>
        
        
        <tr>
        <td class="org-left">a month</td>
        <td class="org-left">&gt;</td>
        <td class="org-left">&lt;</td>
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

9.  Easy moving between windows

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
    
    1.  DEPRECATED Useful For Emacs < 27.1
    
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
              (global-set-key (kbd "M-s-<left>") (ignore-error-wrapper 'windmove-left))
              (global-set-key (kbd "M-s-<right>") (ignore-error-wrapper 'windmove-right))
              (global-set-key (kbd "M-s-<up>") (ignore-error-wrapper 'windmove-up))
              (global-set-key (kbd "M-s-<down>") (ignore-error-wrapper 'windmove-down))
            ;; <- windmove

10. Easy windows resize

        ;; Easy windows resize ->
          (define-key global-map (kbd "C-s-<left>") 'shrink-window-horizontally)
          (global-set-key        (kbd "C-s-<right>") 'enlarge-window-horizontally)
          (global-set-key        (kbd "C-s-<down>") 'shrink-window)
          (global-set-key        (kbd "C-s-<up>") 'enlarge-window)
        ;; <- Easy windows resize 

11. Column marker

    In Emacs 27.1 in only needs to add the following lines in
    your `init.el` to have properly working fill-column indicator in all buffers.
    (<https://www.gnu.org/software/emacs/manual/html_node/emacs/Displaying-Boundaries.html>)
    
          ;; Fill column indicator -> 
        (global-display-fill-column-indicator-mode)
          ;; <- Fill column indicator
    
    This behaviour, however, may not be wanted in some buffers
    (for example ipython command line
    bufffer or octave command line buffer). In order to have fill-column-indicator
    only for buffers of some type (code files, text files (org, doconce etc.) we
    could add a hook for [`prog-mode`](https://www.emacswiki.org/emacs/ProgMode) and two relative modes `text-mode` and `special-mode`.
    Unfortunately, these modes do not contain all required modes
    (`DocOnce-mode` or `org-mode` are absent on the list of modes).
    (The list of modes inherited after `prog-mode` and two other modes  can be viewed
    with the use of the [following function](https://gist.github.com/davep/c16534ef91e9868aaff3d3658f880e4a):
    
        (defun list-prog-modes ()
          "List all programming modes known to this Emacs."
          (interactive)
          (with-help-window "*Programming Major Modes*"
            (mapatoms (lambda (f)
                        (when (provided-mode-derived-p f 'prog-mode) ;; prog-mode or text-mode or special-mode
                          (princ f)
                          (princ "\n"))))))
    
    Anyway, I decided on the following approach based on [this page](https://www.gnu.org/software/emacs/manual/html_node/emacs/Displaying-Boundaries.html):
    
    -   enable display-fill-column mode, which can be done by settings variable
    
          ;; Fill column indicator -> 
        (setq display-fill-column-indicator-column 81)
    
    -   write general function that can be hooked into mode
    
        (defun my-default-text-buffer-settings-mode-hook()
          (display-fill-column-indicator-mode 1)
          )
          ;; <- Fill column indicator
    
    -   and add this hook per each required mode (this is done in [1.4.7](#orgb1a21b6) section
        of this document

12. Turning on/off beeping

    Completely out of the blue my emacs started beeping. I guess it
    had to be some keybinding I accidentally pressed but have no idea
    what I did.
    Anyway, to disable it we must [do the following](https://stackoverflow.com/questions/10545437/how-to-disable-the-beep-in-emacs-on-windows):
    
          ;; Setting alarms in Emacs -> 
        (setq-default visible-bell t) 
        (setq ring-bell-function 'ignore)

13. Ibuffer - an advanced replacement for BufferMenu

    <a id="orgec3e11e"></a>
    
    Description of the package is [here](https://www.emacswiki.org/emacs/IbufferMode).
    
          ;; Advanced buffer mode
        (global-set-key (kbd "C-x C-b") 'ibuffer)

14. Setting font size for all buffers

    <https://stackoverflow.com/questions/24705984/increase-decrease-font-size-in-an-emacs-frame-not-just-buffer>
    
        ;; Resize the whole frame, and not only a window
        ;; Adapted from https://stackoverflow.com/a/24714383/5103881
        (defun acg/zoom-frame (&optional amt frame)
          "Increaze FRAME font size by amount AMT. Defaults to selected
        frame if FRAME is nil, and to 1 if AMT is nil."
          (interactive "p")
          (let* ((frame (or frame (selected-frame)))
                 (font (face-attribute 'default :font frame))
                 (size (font-get font :size))
                 (amt (or amt 1))
                 (new-size (+ size amt)))
            (set-frame-font (font-spec :size new-size) t `(,frame))
            (message "Frame's font new size: %d" new-size)))
        
        (defun acg/zoom-frame-out (&optional amt frame)
          "Call `acg/zoom-frame' with negative argument."
          (interactive "p")
          (acg/zoom-frame (- (or amt 1)) frame))
        
        (global-set-key (kbd "C-x C-=") 'acg/zoom-frame)
        (global-set-key (kbd "C-x C--") 'acg/zoom-frame-out)
        (global-set-key (kbd "<C-down-mouse-4>") 'acg/zoom-frame)
        (global-set-key (kbd "<C-down-mouse-5>") 'acg/zoom-frame-out)


### Useful tools

1.  Dired

    <https://www.emacswiki.org/emacs/DiredBookmarks>
    
    The default behaviour of Dired when walking across directory
    structure is to open each directory in a new buffer. In this
    way you end up with a lot of (probably unnecessary) buffers.
    How to circumvent this behaviour. (**Beware!** There are some [reasons](https://www.emacswiki.org/emacs/DiredReuseDirectoryBuffer)
    you might want to keep it!)
    
    1.  Straightforward solution
    
        The most straighforward way is to kill them by going to buffer menu
        
            C-x C-b
        
        and selecting the ones you want to kill with `d` and delete them all
        at once with `x`.
    
    2.  Ibuffer interactive way
    
        In [1.4.3.13](#orgec3e11e) there a nice shortcut to do this. You can select all
        the files of the given mode with:
        
            * M
        
        (note the capital `M`! `* m` is for selecting **modified** buffers).
        and then kill them with (again capital!) `D`.
        
        Summary (providing you have Ibuffer, which is built-in in Emacs 27.1):
        
        1.  Open ibuffer
            
                C-x C-b
            
            or
            
                M-x ibuffer
        2.  Select all the buffer of the mode
            
                * M
        3.  Search for all `dired` or `sunrise` mode buffers and kill them:
            
                * D
    
    3.  Simple dired way
    
        You can use `dired-find-alternate-file` function which is bounded
        to key `a` in `dired-mode` for going down the directory structure. 
        For going up you need to do some more tweaks and the simplest way is
        given by Xah Lee ([original source](http://xahlee.info/emacs/emacs/emacs_dired_tips.html), [stackoverflow](https://stackoverflow.com/questions/1839313/how-do-i-stop-emacs-dired-mode-from-opening-so-many-buffers)).

2.  Dired and bookmarks

    When going up and down the directory structure you can mark/add
    the favourite places into bookmarks which comes down to:
    
        C-x r m
    
    Then, you can go to your bookmarks menu by:
    
        C-x r b
    
    Select the directory you want to open and go there in dired/sunrise mode.
    
    To delete, rename a bookmark:
    
        M-x list-bookmarks
    
    -   `d` to mark to delete
    -   `x` to delete all D marked ones
    -   `r` to rename
    -   `s` to save changes
    
    You can always achieve the same functionality without bookmarks feature
    like [here](https://emacs.stackexchange.com/a/75448/30035).


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

3.  TODO Ivy (for testing) <a id="orgb49f5bc"></a>

    Furthermore, according to [some other users](https://ruzkuku.com/emacs.d.html#org804158b)
    "Ivy is simpler (and faster) than Helm but more powerful than Ido".

4.  TODO (TEMPORARILY COMMENTED OUT) Abbreviations (abbrev-mode)

    -   NOTE: This part of my init.el is temporarily commented out.
    
    `abbrev-mode` can be useful, however it brings some trouble when working with more than
    one language. I would like to come back here after having prepared
    a piece of code that would recognize the language of the current document and 
    based on this, change the autocorrection dictionary. Until then it's better
    to manually trigger `abbrev-mode` per a document (in English), when you
    really need it.
    
    I've just discovered this mode and wanted to use it.
    I'm not sure whether `abbrev-mode`, `yasnippet` and `company`
    aren't substitute modes. [Well, in fact they partly are](https://emacs.stackexchange.com/questions/42556/best-pratice-advices-for-abbrev-vs-completion-vs-snippets).
    
    -   [Abbrev-mode movie tutorial](https://www.youtube.com/watch?v=AtdWuYImviw)
    -   [Xah movie tutorial](https://www.youtube.com/watch?v=Holxu96YKrc&t=1s)
    -   [Xah page about abbrev](http://xahlee.info/emacs/emacs/emacs_abbrev_mode_tutorial.html)
    
    Emacs abbreviations are
    
        ;; ;; abbrev-mode ->
        ;;   (setq-default abbrev-mode t)          
        ;;   ; (read-abbrev-file "~/.emacs.d/abbrev_defs")
        ;;   (read-abbrev-file "~/.emacs.d/abbrev_defs_autocorrectionEN")
        ;;   (read-abbrev-file "~/.emacs.d/abbrev_defs_autocorrectionPL")  
        ;;   (read-abbrev-file "~/.emacs.d/abbrev_defs_cis")  
        ;;   (setq save-abbrevs t)  
        ;; ;; <- abbrev-mode
    
    1.  Useful commands
    
        -   C-x a - inverse-add-global-abbrev
        -   C-x a i l - inverse-add-global-abbrev
        -   C-x a i g - inverse-add-mode-abbrev
        -   unexpand-abbrev
        -   edit-abbrevs
        -   list-abbrevs
        -   kill-all-abbrevs


### Autocomplete

`auto-complete` vs `company`

    ;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ;; ;; *** Auto-completing
    ;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    (add-hook 'after-init-hook 'global-company-mode)

1.  Recently opened files

        ;; Recently opened files ->
          (recentf-mode 1)
          (setq recentf-max-menu-items 100)
          (setq recentf-max-saved-items 100)
          ;; in original emacs this binding is for "Find file read-only"
          (global-set-key "\C-x\ \C-r" 'recentf-open-files)
        ;; <- Recently opened files


### Settings for modes

It's good to have keybindings for the commands often used,
and it's good to have them enabled per specific mode.

How to define keybindings and key sequences:
[Link 1](https://www.gnu.org/software/emacs/manual/html_node/elisp/Key-Sequences.html),
[Link 2](https://www.gnu.org/software/emacs/manual/html_node/emacs/Init-Rebinding.html#Init-Rebinding).

How to define shortcuts for major modes:
[Link 1](http://xahlee.info/emacs/emacs/reclaim_keybindings.html),
[Link 2](https://docs.freebsd.org/en/books/developers-handbook/tools/#Emacs).

The problem that can be encountered in this point is that
we choose wrong (restricted) keybinding. In that case Emacs will
print an error message like:

    Key sequence M-x g starts with non-prefix key M-x

We can check the bindings that are restricted for the specific mode:
In the buffer with the mode enabled press `C-h m`. New window with
information on the modes enabled for the buffer appears. You can
find the bindings tagged as `Prefix Command`. If you'd really like to use
other shortcut

you need to rebind it ([1](https://stackoverflow.com/questions/1024374/how-can-i-make-c-p-an-emacs-prefix-key-for-develperlysense), [2](https://stackoverflow.com/questions/9462111/emacs-error-key-sequence-m-x-g-starts-with-non-prefix-key-m-x), [3](https://emacs.stackexchange.com/questions/68328/general-el-error-key-sequence-starts-with-non-prefix-key)).

    ;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ;; ;; *** Minor mode settings and keybindings
    ;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

1.  Emacs-Lisp mode

    Be sure to set `emacs-lisp-mode` maps/hooks etc, not just `lisp-mode-...`  otherwise
    the shortcuts won't work.
    
        ;; Emacs-Lisp mode...
        (defun my-emacs-lisp-mode-hook ()
        (define-key emacs-lisp-mode-map (kbd "C-e b") 'eval-buffer)
        (define-key emacs-lisp-mode-map (kbd "C-e e") 'eval-expression)
        (define-key emacs-lisp-mode-map (kbd "C-e r") 'eval-region)  
        )

2.  Octave/Matlab mode

    Based on <https://wiki.octave.org/Emacs>.
    
    Three files mentioned in the link must be already installed somewhere within
    my `Emacs 26.1`, because `octve-mode` command is available.
    The only thing to do is to add `octave-mode-hook`:
    
        ;; Octave mode...
        (defun my-octave-mode-hook()
          (define-key octave-mode-map (kbd "C-c C-s") 'octave-send-buffer)
          (define-key octave-mode-map (kbd "<f8>") 'octave-send-buffer)
                  (lambda ()
                    (abbrev-mode 1)
                    (auto-fill-mode 1)
                    (if (eq window-system 'x)
                        (font-lock-mode 1))))
    
    This code is compiled however it throws an error while writing the code
    and expecting function syntax hints working:
    
    =eldoc error: ( error Selecting deleted buffer)
    
    Now `C-c TAB a` should invoke octave and run a buffer in it
    (run `C-h m` or visit <https://wiki.octave.org/Emacs> to see the keybindings)
    
    Define your own custom shortcuts to run specific script in matlab shell.
    
        ; Matlab mode...
        (defun my-matlab-mode-hook()
          (define-key matlab-mode-map (kbd "<f8>")
            '(lambda () (interactive)
              (matlab-shell-send-command "emacsrun('/home/mb/projects/TSdistributed/srcMTLB/main')" ))
             )
        )

3.  Python mode

    The below code does not work as expected. Probably it'd be better to
    apply the configuration given [here](https://realpython.com/emacs-the-best-python-editor/#integration-with-jupyter-and-ipython).
    
        ;; Python mode...
        
        (defun my-python-mode-hook()
                   (lambda ()
                     (setq python-shell-interpreter "python3") ))

4.  Org mode

    By default emacs waits until all exporting processes finish. It may take quite
    a while in some situations (for example when exporting long document to LaTeX).
    In order to make emacs work in asyncronous mode you need to toggle this
    ([link 1](https://orgmode.org/manual/The-Export-Dispatcher.html), [link 2](https://superuser.com/questions/483554/org-export-run-in-background-how-to-troubleshoot)).
    
    One way is to do it each time when exporting: after pressing `C-c C-e` you
    get `exporting menu` and in the third line you can see  `Async export` option
    that can be enabled by pressin `C-a`. It is rather cumbersome.
    
    To have this option toggled after launching emacs put the line below in your
    init file.
    
        ;; Org mode...
        (setq org-export-in-background t)
    
    This setting has impact only when exporting via `org exporting menu`
    (triggered by `C-c C-e`). When calling `org-latex-export-to-pdf` this
    setting is not taken into account. Fortunately, this function has
    optional parameter that can be set to obtain async behaviour.
    All in all, the (almost) working solution can be written as a custom hook like this:
    
        (defun my-org-mode-hook()
          (define-key org-mode-map (kbd "<f9>")
            '(lambda () (interactive)
              (org-latex-export-to-pdf :async t)
              (org-beamer-export-to-pdf :async t)
              (org-odt-export-to-odt :async t)
              (org-odt-export-as-pdf :async t)
              )
             )  
        )
    
    Why "almost"? Because this solution still won't work when exporting
    files to Beamer. In order one needs to create appropriate
    init file with settings for async export and
    set `org-export-async-init-file` variable as path to this file (see 
    [1.4.7.4.1](#orgeaf43a1)).
    
    1.  Setting `org-export-async-init-file` to avoid failure while exporting to Beamer
    
        <a id="orgeaf43a1"></a>
        
        Org-beamer **async** exporter may fail because of lacking
        `org-export-async-init-file` 
        (as it is stated [here](https://superuser.com/questions/738492/org-mode-8-async-export-process-fails) and [here](https://lists.gnu.org/archive/html/emacs-orgmode/2014-09/msg00463.html)). 
        
        In order to avoid this problem we can create a file with the
        following content (note setting `org-export-allow-bind-keywords`
        [variable](https://www.mail-archive.com/emacs-orgmode@gnu.org/msg118389.html)):
        
            (require 'package)
            (setq package-enable-at-startup nil)
            (package-initialize)
            
            (require 'org) 
            (require 'ox)
            (require 'cl)
            (require 'ox-beamer)
            (setq org-export-async-debug nil) ;; no impact here. Do it in main init.el
            (setq org-export-allow-bind-keywords t) ;; Important! In order to have #+BIND command working.
        
        and set the variable `org-export-async-init-file`.
        
            (setq org-export-async-init-file (expand-file-name "~/.emacs.d/myarch/async_init.el"))
            (setq org-export-async-debug nil) ;; when set to 't' it stores all "*Org Export Process*" buffers, when set to 'nil' it leaves only the last one in the buffer list, but already killed
        
        The important line is `(require 'ox-beamer)` !!! ([link](https://lists.gnu.org/archive/html/emacs-orgmode/2018-05/msg00253.html))
    
    2.  TODO async for odt documents still not working

5.  Updating all of the hooks to make them aware of your mode settings

    Now we need to update the hooks to 
    
        ;; Add all of the hooks...
        ;(add-hook 'c++-mode-hook 'my-c++-mode-hook)
        ;(add-hook 'c-mode-hook 'my-c-mode-hook)
        (add-hook 'emacs-lisp-mode-hook 'my-emacs-lisp-mode-hook)
        (add-hook 'octave-mode-hook 'my-octave-mode-hook)
        (add-hook 'matlab-mode-hook 'my-matlab-mode-hook)
        (add-hook 'python-mode-hook 'my-python-mode-hook)
        (add-hook 'org-mode-hook 'my-org-mode-hook)
        
        ; (add-hook 'lisp-mode-hook 'my-lisp-mode-hook)
        ;(add-hook 'perl-mode-hook 'my-perl-mode-hook)

6.  Adding a hook to more than a one mode at once

    <https://emacs.stackexchange.com/questions/501/how-do-i-group-hooks>
    <https://stackoverflow.com/questions/7398216/how-can-i-apply-a-hook-to-multiple-emacs-modes-at-once>
    
    In order to add a hook to more than one modes we need to use a function (taken from
    [here](https://stackoverflow.com/a/7400476/4649238).
    
        ;; Add a hook to the list of modes
        (defun my-add-to-multiple-hooks (function hooks)
          (mapc (lambda (hook)
                  (add-hook hook function))
                hooks))
        
        (defun my-turn-on-auto-fill ()
            my-default-text-buffer-settings-mode-hook  )
        
        (my-add-to-multiple-hooks
         'my-default-text-buffer-settings-mode-hook         ;; my-turn-on-auto-fill
         '(DocOnce-hook
           emacs-lisp-mode-hook
           matlab-mode-hook
           octave-mode-hook
           org-mode-hook
           python-mode-hook
         ))

7.  Change font color for specific mode (eww)

    Based on [this](https://stackoverflow.com/questions/27973721/how-set-colors-for-a-specific-mode).
    
        ;; Change font color for eww
        (defun my-eww-mode-faces ()
          (face-remap-add-relative 'default '(:foreground "#BD8700")))
        
        (add-hook 'eww-mode-hook 'my-eww-mode-faces)


### Bibliography - citations

1.  oc [org-citations]

    1.  Bibliography <a id="orgfbb733e"></a>
    
        In Org 9.6 we do not need explicitely load `oc` libraries.
        Everything is covered in my post concerning bibliography and org-mode.
        
        Useful links:
        
        -   <https://orgmode.org/manual/Citations.html>
        -   <https://kristofferbalintona.me/posts/202206141852/>
        -   <https://github.com/jkitchin/org-ref>
        -   <https://blog.tecosaur.com/tmio/2021-07-31-citations.html#fn.3>
        -   <https://emacs.stackexchange.com/questions/71817/how-to-export-bibliographies-with-org-mode>
        -   <https://www.reddit.com/r/emacs/comments/q4wa40/issues_with_new_orgcite_for_citations/>
        -   <https://nickgeorge.net/science/org-ref-setup/>

2.  citar (to check?)

    <https://github.com/emacs-citar/citar>


### Org customization: org-mode, org-babel ...

1.  Modyfing TODO-DONE sequence in org-mode

    <https://emacs.stackexchange.com/questions/31466/all-todos-how-to-set-different-colors-for-different-categories>
    
    <https://orgmode.org/manual/TODO-Extensions.html>
    
        ;; customized todo-done sequence
        (setq org-todo-keywords
          '(
        (sequence "TODO" "????" "POSTPONED" "|" "DONE")
        (sequence "TODO" "ABANDONED"  "|" "DEPRECATED" "DONE")
        (sequence "TODO" "????" "ABANDONED" "POSTPONED" "|" "DEPRECATED" "DONE")
        ))
        
        (setq org-todo-keyword-faces
        '(
        ("????" . (:foreground "red" :weight bold))
        ("POSTPONED" . (:foreground "blue" :weight bold))
        ("ABANDONED" . (:foreground "orange" :weight bold))
        ("DEPRECATED" . (:foreground "green" :weight bold))
        )
        )
    
    WARNING! When changing this variables in the middle of the emacs
    session you need to restart org-mode (`M-x org-mode-restart`) to
    to have them enabled ([source](https://lists.gnu.org/archive/html/emacs-orgmode/2010-11/msg00130.html))!
    
    Furthermore, it may be more convenient to have this tags set for
    individual file (`#+TODO:`) ([link](https://orgmode.org/manual/Per_002dfile-keywords.html)).

2.  Customizing font style for TODO-DONE keywords in latex export

    <https://stackoverflow.com/questions/36197545/org-mode-latex-export-making-todos-red>
    
        ;; customized todo-done keywords in latex documents
        (defun org-latex-format-headline-colored-keywords-function
            (todo _todo-type priority text tags _info)
          "Default format function for a headline.
        See `org-latex-format-headline-function' for details."
          (concat
           ;; (and todo (format "{\\bfseries\\sffamily %s} " todo))
          (cond
           ((string= todo "TODO")(and todo (format "{\\color{red}\\bfseries\\sffamily %s} " todo)))
           ((string= todo "????")(and todo (format "{\\color{red}\\bfseries\\sffamily %s} " todo)))
           ((string= todo "POSTPONED")(and todo (format "{\\color{blue}\\bfseries\\sffamily %s} " todo)))
           ((string= todo "DONE")(and todo (format "{\\color{green}\\bfseries\\sffamily %s} " todo)))
           )
           (and priority (format "\\framebox{\\#%c} " priority))
           text
           (and tags
                (format "\\hfill{}\\textsc{%s}"
                        (mapconcat #'org-latex--protect-text tags ":")))))
        
        (setq org-latex-format-headline-function 'org-latex-format-headline-colored-keywords-function)

3.  Toggle between TODO-DONE keywords for all subnodes of the current node

    Based on:
    <https://emacs.stackexchange.com/questions/52492/change-todo-keywords-of-all-nodes-in-an-orgmode-subtree-in-elisp>
    
        (defun mb/org-toggle-org-keywords-right ()
            "Toggle between todo-done keywords for all subnodes of the current node."
            (interactive)
            (org-map-entries (lambda () (org-shiftright)) nil 'tree)
          )
        (defun mb/org-toggle-org-keywords-left ()
            "Toggle between todo-done keywords for all subnodes of the current node."
            (interactive)
            (org-map-entries (lambda () (org-shiftleft)) nil 'tree)
          )

4.  Org-agenda activation

    <https://orgmode.org/manual/Activation.html#Activation>
    
        ;; org-agenda activation
        (global-set-key (kbd "C-c l") #'org-store-link)
        (global-set-key (kbd "C-c a") #'org-agenda)
        (global-set-key (kbd "C-c c") #'org-capture)

5.  Org-special-block-extras

    [Author's page](http://alhassy.com/org-special-block-extras/)
    
        ;; **** org-special-block-extras -> 
        (add-hook #'org-mode-hook #'org-special-block-extras-mode)
        ;; <- **** org-special-block-extras 

6.  Org-babel and tangling

    To have org-babel enabled (execution of portions of code):
    
        
        ;; enabling org-babel
        (org-babel-do-load-languages
         'org-babel-load-languages '(
                                     (C . t) ; enable processing C, C++, and D source blocks
                                     (matlab . t)
                                     ;;(perl . t)
                                     (octave . t)
                                     (org . t)
                                     (python . t)
                                     (plantuml . t)
                                     (shell . t)
                                     ))
        
        ;; no question about confirmation of evaluating babel code block
        (setq org-confirm-babel-evaluate nil)
    
    1.  Tangling the specific/named block of code and other useful functions to work with source blocks
    
        1.  Tangle the specific (pointed) block of code
        
                (defun mb/org-babel-tangle-block()
                  (interactive)
                  (let ((current-prefix-arg '(4)))
                     (call-interactively 'org-babel-tangle)
                ))
        
        2.  tangle the block of code given by the name
        
                (defun mb/org-babel-tangle-named-block(block-name)
                  (interactive)
                  (save-excursion 
                   (org-babel-goto-named-src-block block-name)
                    (mb/org-babel-tangle-block)) 
                )
    
    2.  `plantuml`
    
        -   <https://orgmode.org/worg/org-contrib/babel/languages/ob-doc-plantuml.html>
        -   <https://medium.com/@shibucite/emacs-and-plantuml-for-uml-diagrams-academic-tools-6c34bc07fd2>
        -   <https://plantuml.com/activity-diagram-beta>
        
        In order to work with `plantuml` you need to install it (there's
        another way which is documented in the link above, but I won't use it).
        On debian machine I'll just execute:
        
            sudo apt install plantuml
        
        and add the following line to tell emacs to use system installed
        plantuml:
        
            ;; enabling plantuml
            
            (setq plantuml-executable-path "plantuml")
            (setq org-plantuml-exec-mode 'plantuml)

7.  Fix for Octave/Matlab org-babel - problems with matlab in org-babel

    <a id="orge9d4b44"></a>
    <http://gewhere.github.io/blog/2017/12/19/setup-matlab-in-emacs-and-babel-orgmode/>
    
        
        ;; setup matlab in babel
        (setq org-babel-default-header-args:matlab
          '((:results . "output") (:session . "*MATLAB*")))
    
    In the current version of matlab org-babel there is a problem of
    including input lines in the output of org-babel block.
    The way to circumvent it is to use the approach suggested by
    the user named `karthink` (`karthinks`?). I traced it starting
    from the pages:
    
    -   <https://www.reddit.com/r/emacs/comments/pufgce/matlab_mode/>
    -   <https://www.reddit.com/r/emacs/comments/fy98bs/orgbabels_matlab_session_output_is_malformed/>
    
    In the last link user `nakkaya`
    refers to his/her solution of the problem,
    however his/her link does not seem to include this solution.
    
    I searched web for `karthink`, `matlab`, `emacs` appearances and
    found the fix here:
    <https://github.com/karthink/.emacs.d/blob/master/plugins/ob-octave-fix.el>
    
    In the end I just downloaded the file and the inclusion of this package is
    done in section [1.4.21.3](#org1d0bbd6).
    
    Remark: There exist at least two versions of the fix (I renamed
    the one I already had to `ob-octave-fixOLDER.el`). Previous version
    of the file didn't seem to resolve the problem.
    
    Remark 2: In case of matlab code-block
    newer version of `ob-octave-fix.el` depends on
    `altmany`'s `export_fig` function! I have been using it for a while
    so I don't care anyway but in one may obtain errors when using
    this library without `export_fig`!
    
    Now, results show only the first line without semicolon and ...
    all the lines below it! (even if they end with semicolon!).
    
    1.  Export plots to png
    
        <https://lists.gnu.org/archive/html/emacs-orgmode/2017-08/msg00376.html>
        
        <https://emacs.stackexchange.com/questions/54695/no-graphic-output-for-matlab-src-block-in-org-mode>
    
    2.  Wrong formatting of matlab output's in org-babel
    
        <https://www.reddit.com/r/emacs/comments/fy98bs/orgbabels_matlab_session_output_is_malformed/>
    
    3.  TODO Erroneous behaviour when plotting
    
        When exporting graphic file from matlab code-block, the resulting
        image does not appear when followed by automatically generated
        keyword `#+RESULTS:`. When this keyword is deleted the image appears
        in generated pdf.

8.  Set path to Python executable to work in org-babel code block

    Pythonic org-babel code blocks like the one below:
    
        print("Hello world")
    
    don't work out-of-the-box.
    The similar problem for `R` can be found [here](https://stackoverflow.com/questions/54007309/problem-org-babel-code-does-not-work-with-r).
    
    In order to fix the problem you need to
    explicitely set the path to your
    Python interpreter. 
    
        ;; Python in org-babel
        (setq org-babel-python-command "/bin/python3")
    
    Two observations:
    
    -   `python script.py` executed in command line works ok
    -   there is no `python` comannd in `/bin/` directory.
    
    An interesting discussion on python/python2/python3 related issues can be found [here](https://stackoverflow.com/questions/6908143/should-i-put-shebang-in-python-scripts-and-what-form-should-it-take).
    
    Another interesting remark about python in org-babel is available [here](https://emacs.stackexchange.com/a/41290). The following code block
    
        #+begin_src python
        ,print("Hello world")
        #+end_src
    
    won't work as expected. You need to add `results output` to get string printed
    by python in results block in org.

9.  Tailoring org-mode to markdown export

    When exporting to markdown I want to add some keywords in a special format to
    the preamble of .md file.
    [How to do that is described here.](https://emacs.stackexchange.com/questions/74505/how-can-i-add-specific-text-to-the-content-generated-by-org-mode-export-to-mark#74513)
    
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
    
    In the beginning the line below where hook is added was uncommented because
    of my unawareness of how Emacs works.
    Now I add the hook below per each org-file and this line is the cause
    of unwanted behaviour that the required information (title, tags, etc.) is
    added twice in exported `md` file. So I comment out the line below,
    however in the free time I should supplement all the older posts with this line.
    (TODO!)
    
        ;; This hook should be added per file in my org posts. Unfortunately, so far I don't know
        ;; how to do this.
        ;; (add-hook 'org-export-before-processing-hook #'my/org-export-markdown-hook-function)
    
    Besides, in order to have markdown exporter options in menu appearing after
    `C-c C-e` you need to add 
    ([Link 1](https://stackoverflow.com/questions/22988092/emacs-org-mode-export-markdown/22990257#22990257), [Link 2](https://emacs.stackexchange.com/questions/4279/exporting-from-org-mode-to-markdown)):
    
        
        (require 'ox-md nil t)
        
        ;; <- **** org-to-markdown exporter customization

10. Miscellaneous oneliners

        ;; alphabetical ordered lists
        (setq org-list-allow-alphabetical t)

11. TODO Asynchronous babel sessions

    ob-comint.el

12. LaTeX fragments in org-mode source code

    To have nice-coloured latex syntax in <span class="underline">Emacs<sub>editor</sub></span> while writing
    in org-mode you need to embrace it with
    `#+begin_export latex` and `#+end_export` keywords ([source](https://emacs.stackexchange.com/questions/27866/syntax-highlighting-in-org-mode-begin-latex-block)).
    
    Another hints can be found [here](https://lucidmanager.org/productivity/ricing-org-mode/).

13. Engraved - the better (?) way of having nice source code formatting

    Following some internet posts about `Engraved` package I decided to give it a try. We'll if it works better than minted (which has obvious flaws, such as dependency on external code or slowing down
    overall compilation process)
    
    The installation process is easier than with minted. All you need to do is to install package `engrave-faces` (it's done in `install-packages.el`) and then set
    
        ;; org-to-latex exporter to have nice code formatting
        (setq org-latex-src-block-backend 'engraved)

14. How to properly deal with picture/figure size attributes when picture is produced by org-babel block

    -   <https://emacs.stackexchange.com/a/59902/30035>
    
    1.  Making asynchronous exporter deals easily with `minted` source code colorization
    
            ;; org-to-latex exporter to have nice code formatting
            (setq org-latex-listings 'minted
                  org-export-with-sub-superscripts 'nil
                  org-latex-minted-options '(("bgcolor=lightgray") ("frame" "lines"))
                  org-latex-packages-alist '(("" "minted"))
                  org-latex-pdf-process
                  '("pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f"
                    "pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f"
                    "pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f"))
    
    2.  TODO Problems with passing "Local variables:" to asynchronous exporter

15. CDLatex installed in order to ease working with LaTeX in org-mode

    The special mode `org-cdlatex-mode` is included in `org` package.
    In order to have it working properly we need to install `cdlatex`
    itself. This can be done in
    [1.3.2](#orgdaf92f1).
    
    Link to `org-cdlatex-mode` description:
    <http://doc.endlessparentheses.com/Fun/org-cdlatex-mode.html>.
    
    After launching `org-cdlatex-mode` you can insert latex environments
    by typing:
    
        C-c {

16. Reftex for managing references

    [`Reftex`](https://www.gnu.org/software/emacs/manual/html_mono/reftex.html)
    is preinstalled since Emacs 20.2, however in order to
    have it working you need to [install `auctex` package](https://emacs.stackexchange.com/questions/35179/reftex-complete-failed-with-wrong-type-argument-stringp-nil)! 
    
    Then you can turn on `reftex` per a buffer via:
    `reftex-mode`.
    
    At the beginning type:
    
        C-c = (reftex-toc)
    
    and choose `r` to generate a list of all labels, references in the
    document.
    
    From now on, every time you type `C-c =` `reftex` menu appears
    on the top of the current buffer prompting the actions you can
    take.
    
    The problem with `reftex` is that it does not recognize
    org-mode references added by `#+NAME:` `#+LABEL:` etc.
    
    `org-ref` [is said to handle this](https://emacs.stackexchange.com/questions/9767/can-reftex-be-used-with-org-label), so maybe in the future I will
    return to this package. As for now I'm going to work with `reftex`
    and LaTeX tags.

17. Listing name tags of environments

    Based on [this page](https://emacs.stackexchange.com/questions/77326/how-to-display-the-list-of-all-name-tags-is-org-mode-document).
    
        ;; Managing org-mode #+NAME properties like in reftex-mode
        (defun my/get-name (e)
              (org-element-property :name e))
        
        (defun my/latex-environment-names ()
              (org-element-map (org-element-parse-buffer) 'latex-environment #'my/get-name))
        
        (defun my/report-latex-environment-names ()
            (interactive)
            (message (format "%S" (my/latex-environment-names))))
        
          (define-key org-mode-map (kbd "C-z z") #'my/report-latex-environment-names)


### TODO Flyspell (TODO: dive deeper into the package and its capabilities)

<https://ruzkuku.com/emacs.d.html#org804158b>
<https://www.emacswiki.org/emacs/FlySpell>

    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ;; *** Flyspell 
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


### Flymake/Flycheck

<https://www.masteringemacs.org/article/spotlight-flycheck-a-flymake-replacement>

In Emacs 27.1 `flymake` is said to be competitive with `flycheck` again.
It is built-in in Emacs. As for now, I'm gonna use `flymake`.


### Bash completions

Bash has usually very good command completion facilities, which aren't accessible by default from Emacs (except by running `M-x term`). This package integrates them into regular commands such as `shell-command` and `shell`.


### PDF-Tools

Original repo: <https://github.com/politza/pdf-tools>.
Maintened fork: <https://github.com/vedang/pdf-tools>

<http://alberto.am/2020-04-11-pdf-tools-as-default-pdf-viewer.html>

After installation you need to activate the package by running:
`M-x pdf-tools-install`.

Something important is that this library doesn't play well with Emacs
`linum-mode`. The following lines of code will deactivate this mode
when rendering the .pdf:

    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ;;;; Add this hook in order to run pdf-tools without a warning message.
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    (add-hook 'pdf-view-mode-hook (lambda() (linum-mode -1)))


### ChatGPT

In order to get some help from AI I decided to give it a try inside
Emacs.
There are tons of pages about it.
[Here](https://notes.alexkehayias.com/using-chatgpt-with-emacs/) you have a list of Emacs libraries that handle this issue.

1.  org-ai

    At first, I decided on [org-ai](https://github.com/rksm/org-ai). It looks promising, mature, and
    seems to have a quite a lot of features.
    To use it, you also need to have `websocket` package.
    
        ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        ;;;; AI - ChatGPT, Dall-E, Stable Diffusion and ...
        ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        ;; (require 'org-ai)
        (add-hook 'org-mode-hook #'org-ai-mode)
        (org-ai-global-mode)
        ;; (setq org-ai-default-chat-model "gpt-4") ; if you are on the gpt-4 beta:
        ;; (org-ai-install-yasnippets) ; if you are using yasnippet and want `ai` snippets
    
    Now, in order to keep my secrets off my `init.el` instead of
    storing api key directly in my `init.el`, I'll load it here
    from another file, which is located outside this repository.
    In order to have this file properly loaded when running emacs daemon
    we need to explicitely use `user-emacs-directory` variable
    when refering to the file.
    The content of the file looks like:
    
        (load-file (concat user-emacs-directory "../.mysecrets/openaiapi.el"))
    
    where the content of the `openaiapi.el` looks like:
    
        (setq org-ai-openai-api-token "<ENTER YOUR API TOKEN HERE>")
    
    1.  Useful commands/shortcuts:
    
        `org-ai-mark-block-contents` - marks the contents of the current
        block between `#+begin_ai` and `#+end_ai`. Useful for clearing the
        buffer after the session is finished and you don't want to store
        its results.
        
        `C-c Backspace` - kills the ai region where the cursor is located (
        `C-c DEL` does not work in my case, see `org-ai.el` to view other
        keybindings...)

2.  gptel

    I also tried with `gptel`. Unfortunately I wasn't able to succeed in
    installing it.

3.  chatgpt-shell

    Also tried with this:
    <https://github.com/xenodium/chatgpt-shell>
    (But I've got too old version of curl (7.76 while I have 7.74 on Debian)

4.  Interesting/funny links:

    -   <https://github.com/f/awesome-chatgpt-prompts>
    -   <https://www.engraved.blog/building-a-virtual-machine-inside/>


### TRAMP

<https://emacs.stackexchange.com/questions/57919/preview-images-and-pdfs-inside-a-ssh-terminal-session-or-inside-emacsclient-ses>

->

<https://emacs.stackexchange.com/questions/42252/run-local-command-on-remote-file-with-tramp>

Something is wrong with this part of code and `init.el` is not
loading properly. 


### General global shortcuts not restricted to specific package/mode

    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ;;;; Useful global shortcuts (text operations)
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    (global-set-key (kbd "C-d") 'delete-forward-char)    ; Backspace/Insert remapping
    (global-set-key (kbd "C-S-d") 'delete-backward-char) 
    ; (global-set-key (kbd "M-S-d") 'backward-kill-word)
    (global-set-key (kbd "C-c C-e s") 'mark-end-of-sentence)
    
    (global-set-key (kbd "C-C C-e C-w C-w") 'eww-list-bookmarks) ; Open eww bookmarks
    (defun mynet ()  (interactive) (eww-list-bookmarks))

1.  Defining own prefix key to ease finding free keybindings

    <https://stackoverflow.com/a/1025257/4649238>
    
        ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        ;;;; my own prefix keymap
        ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        (define-prefix-command 'mb-map)
        (global-set-key (kbd "C-z") 'mb-map)
        ; (define-key mb-map (kbd "C-k") "\C-a\C- \C-e\M-w\M-;\C-e\C-m\C-y")
        ; (define-key mb-map (kbd "C-l")  "\M-w\M-;\C-e\C-m\C-y")
    
    Now you can create your own shortcut with the command
    
        (define-key mb-map (kbd "C-k") "\C-a\C- \C-e\M-w\M-;\C-e\C-m\C-y")
    
    which will be triggered by `C-z C-k`.

2.  Useful fast line-copying shortcut

    1.  Solution
    
        Based on idea presented [here](https://stackoverflow.com/questions/88399/how-do-i-duplicate-a-whole-line-in-Emacs). Smart but not recommended approach!
        However it works for me.
        You only need to remember that it may break down at any momement,
        if you encounter a mode that rebinds one of the default keybindings used
        in the sequence.
        
            ;; fast copy-line-comment-it-and-paste-below
            ;(global-set-key "\C-c\C-k"        "\C-a\C- \C-e\M-w\M-;\C-e\C-m\C-y")
            (define-key mb-map (kbd "C-k") "\C-a\C- \C-e\M-w\M-;\C-e\C-m\C-y")
        
        The code below is not fully doing what it is meant to do. I don't have a time now
        to correct it.
        
            ;; copy-selection-comment-it-and-paste-below (works ok provided selection is
            ;; performed from left to right....
            ; (global-set-key "\C-c\C-l" "\M-w\M-;\C-e\C-m\C-y")
             (define-key mb-map (kbd "C-l")  "\M-w\M-;\C-e\C-m\C-y")
        
        Aside notes:
        
        -   I used to use `C-c C-k` and `C-c C-l` keybindings, respectively, for
        
        the above commands. However, they are overwriten when working in 
        org-mode. That's why I needed to change them 
        
        -   Then I used `C-p` shortcut for invoking `mb-map`,
        
        but at some point I realized that it overwrittens default 
        keybinding for `previous-line`.
    
    2.  ABANDONED OLD: Solution 1 (NOT FULLY WORKING)
    
        <https://www.emacswiki.org/emacs/CopyingWholeLines>
        
        This solution only copies active line and moves the pointer to the next line
        
            ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
            ;; fast copy-line shortcut
            (defun copy-line (arg)
              "Copy lines (as many as prefix argument) in the kill ring.
                  Ease of use features:
                  - Move to start of next line.
                  - Appends the copy on sequential calls.
                  - Use newline as last char even on the last line of the buffer.
                  - If region is active, copy its lines."
              (interactive "p")
              (let ((beg (line-beginning-position))
                    (end (line-end-position arg)))
                (when mark-active
                  (if (> (point) (mark))
                      (setq beg (save-excursion (goto-char (mark)) (line-beginning-position)))
                    (setq end (save-excursion (goto-char (mark)) (line-end-position)))))
                (if (eq last-command 'copy-line)
                    (kill-append (buffer-substring beg end) (< end beg))
                  (kill-ring-save beg end)))
              (kill-append "\n" nil)
              (beginning-of-line (or (and arg (1+ arg)) 2))
              (if (and arg (not (= 1 arg))) (message "%d lines copied" arg)))
            
            (global-set-key "\C-c\C-k" 'copy-line)  
    
    3.  ABANDONED OLD: Solution 2 (NOT FULLY WORKING)
    
        And even better solution because it also comments out the line and yanks
        (pastes) copied text the line below. [Based on the post](https://stackoverflow.com/a/23588908).
        
              ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
              ;; fast copy-line-comment-and-paste-below
            (defun copy-and-comment-region (beg end &optional arg)
              "Duplicate the region and comment-out the copied text.
            See `comment-region' for behavior of a prefix arg."
              (interactive "r\nP")
              (copy-region-as-kill beg end)
              (goto-char end)
              (yank)
              (comment-region beg end arg))
            
            (global-set-key "\C-c\C-v\C-k" 'copy-and-comment-region)
    
    4.  ABANDONED Solution 3 (NOT WORKING)
    
        <https://www.emacswiki.org/emacs/CopyWithoutSelection>

3.  Open the directory of the current file/buffer in the external file manager

    Based on this link:
    <https://www.reddit.com/r/emacs/comments/4zmly1/how_to_open_the_directory_of_a_file/>
    in KDE with `dolphin` installed we can do like below.
    
    So we need to use =call-process". However in order to pass
    a parameter to it you need 
    
    Warning 1:
    The original solution uses `shell-command` which is not
    asynchronous operation and it blocks emacs until I close the external 
    window.
    <https://emacs.stackexchange.com/questions/65090/how-to-start-a-persistent-asynchronous-process-trough-emacs>
    
        ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        ;;;; Useful global shortcuts (system-wide operations)
        ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        (defun mb/browse-file-directory()
          (interactive)
          (shell-command "dolphin ."))
        
        (define-key global-map (kbd "<s-f12>") 'mb/browse-file-directory)
    
    So, in order to ''spawn'' a new process we need to use `call-process`
    function. However, in this case, calling the function with parameter
    is a bit more complicated than for `shell-command`
    (<https://stackoverflow.com/questions/4858975/in-emacs-lisp-what-is-the-correct-way-to-use-call-process-on-an-ls-command>)
    
        ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        ;;;; Useful global shortcuts (system-wide operations)
        ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        (defun mb/browse-file-directory()
          (interactive)
          (call-process "dolphin" nil 0 nil "."))
        
        (define-key global-map (kbd "<s-f12>") 'mb/browse-file-directory)
    
    Warning: NickD's solution contains: `#'ndk/desktop-open-link-at-point`.
    I had to delete `#` from it to have properly working keybinding!
    
    Similar solution is given [here](https://emacs.stackexchange.com/questions/7742/what-is-the-easiest-way-to-open-the-folder-containing-the-current-file-by-the-de) (actually, I did not test it).


### ABANDONED Emailing in Emacs

As a temporary workaround I decided to try [1.4.18](#orgce88eb5).

Basing on  [this post](https://www.reddit.com/r/emacs/comments/4rl0a9/email_in_emacs_i_want_to_but_wow_its_overwhelming/) I decided to perform configuration of email service 
within Emacs in three steps. Each of them takes care of one of the 
following problems

-   fetching emails
-   sending emails
-   viewing emails.

1.  Links that can be useful:

    -   <https://www.reddit.com/r/emacs/comments/4rl0a9/email_in_emacs_i_want_to_but_wow_its_overwhelming/>
    -   <https://www.emacswiki.org/emacs/GettingMail>
    -   <https://www.jonatkinson.co.uk/posts/syncing-gmail-with-mbsync/>
    -   <https://isync.sourceforge.io>
    -   <https://brian-thompson.medium.com/setting-up-isync-mbsync-on-linux-e9fe10c692c0>
    -   <https://wiki.archlinux.org/title/isync>
    -   <https://www.maketecheasier.com/use-email-within-emacs/>

2.  ABANDONED Another approach: External Editor Revived -- a Thunderbird extension

    External Editor Revived is a Thunderbird extension that allows 
    using external editor (vim/emacs/...) to edit your mails.
    
    I had problems with installing necessary binary 
    (<https://github.com/Frederick888/external-editor-revived/releases/download/v0.6.0/ubuntu-latest-gnu-native-messaging-host-v0.6.0.zip>)
    due to lacking dependencies:
    
        ./external-editor-revived: /lib/x86_64-linux-gnu/libc.so.6: version `GLIBC_2.33' not found (required by ./external-editor-revived)
        ./external-editor-revived: /lib/x86_64-linux-gnu/libc.so.6: version `GLIBC_2.32' not found (required by ./external-editor-revived)
        ./external-editor-revived: /lib/x86_64-linux-gnu/libc.so.6: version `GLIBC_2.34' not found (required by ./external-editor-revived)
    
    so I abandoned this idea at this stage.


### Emacs-everywhere

<a id="orgce88eb5"></a>

Repository of the package and some basic information can be found
[here](https://github.com/tecosaur/emacs-everywhere/).

1.  Install package `emacs-everywhere` from melpa ([1.3.2](#orgdd7694b))
2.  Add system-wide shortcut for the command 
    
        #!/bin/bash
        # https://github.com/tecosaur/emacs-everywhere/
        
        emacsclient --eval "(emacs-everywhere)"
    
    (I added `Ctrl+Alt+E` in custom shortcuts of KDE)
3.  Run emacs daemon in the system (for example after hitting `Alt+F2`)  with:
    
        emacs --daemon 
    
    Warning!: In order not to restore files from previous session 
    (and avoid being asked for confirmation of loading some commands
    when files are restored) additional if statement is added to
    embrace `(desktop-save-mode 1)` at the beginning of the `init.el`.

4.  Now you can invoke Emacs anywhere in the system with `Ctrl+Alt+E`.
    (If a piece of code is highlighted, it will be copied into Emacs
    buffer). After editing Emacs buffer press `C-c C-c` or `C-x 5 0` 
    to go back to the original programme. If you do not wish to paste 
    the buffer content into the original window, `C-c C-k` still
    copies the content to the clipboard, but never pastes.

5.  The buffer opened within Emacs deamon instance has small fonts 
    despite the fact that font is set somewhere at the beginning of the 
    `init.el`. It is well-known problem:
    
    1.  <https://www.google.com/search?q=emacs+default+font+emacs+daemon>
    2.  <https://emacs.stackexchange.com/questions/52063/emacsclient-gui-has-small-fonts>
    3.  <https://github.com/doomemacs/doomemacs/issues/1223>
    4.  <https://www.reddit.com/r/emacs/comments/pc189c/fonts_in_emacs_daemon_mode/>
    5.  <https://www.reddit.com/r/emacs/comments/dwy299/how_to_set_fonts_in_daemon_mode_windows/>
    
    I used the solution based on the one presented in the last link above,
    however the one presented in the second link seems to be simpler... 
    
        ;; setting up configuration for emacs-everywhere:
        ;; 1. font size
        ;(if (daemonp)
        ;(
        (defun my-after-frame (frame)
          (if (display-graphic-p frame)
              (progn
                 (set-frame-font "liberation mono 11" nil t) )))
        
        (mapc 'my-after-frame (frame-list))
        (add-hook 'after-make-frame-functions 'my-after-frame)
        ;)
        ;)


### Diary

[information in emacs manual](https://www.gnu.org/software/emacs/manual/html_node/emacs/Diary.html)

By default, emacs expects diary file to be located in ~/.emacs.d/diary

Tutorial by [Protesilaos Stavrou](https://www.youtube.com/watch?v=NkhgIB64zgc).

1.  Changing date format to iso and some other configurations

    Some variables need to be set in order to have calendar/diary
    looking working fancy. You can see those settings in Stavrou's
    init.el in the movie linked above.
    
        ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        ;;;; Diary
        ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        
        ; 'american’ - month/day/year
        ; ‘european’ - day/month/year
        ; ‘iso’      - year/month/day
        
        (setq calendar-date-style "iso")
        (setq diary-date-forms diary-iso-date-forms)
        (setq diary-comment-start ";;")
        (setq diary-comment-end "")
        (setq diary-nonmarking-symbol "!")
        ; (setq diary-show-holidays-flag t)
    
    In order to include diary entries in calendar you need to set:
    
        (setq calendar-mark-diary-entries-flag t)
    
    Stavrou mentions that he does not use org-agenda's features (and
    org-mode syntax) with calendar/diary, as he does not need to
    makes things so complex.
    And that's the way how I'm gonna use it for a moment.
    
    A nice thing to have in the future is

2.  TODO Sending emails with calendar events

    To be done in some free time.

3.  Links that I found useful setting up this package:

    -   <https://wikemacs.org/wiki/Command-line_startup_options>
    -   <https://ftp.gnu.org/old-gnu/Manuals/emacs-20.7/html_chapter/emacs_37.html>
    
    <https://emacs.stackexchange.com/questions/3035/how-to-know-if-emacs-is-running-as-a-daemon>
    
    -   <https://stackoverflow.com/questions/45332003/how-can-i-detect-if-emacs-was-started-with-q>
    -   <http://xahlee.info/emacs/emacs/elisp_command_line_argv.html>


### Load Emacs theme of your preference

1.  Modus themes by Protesilaos Stavrou <a id="orgf0ee1b2"></a>

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
        ; (load-theme 'modus-operandi) ;; bright 
        ; (load-theme 'modus-vivendi) ;; dark
        
        
        
        (setq modus-themes-headings ; this is an alist: read the manual or its doc string
              '((1 . (rainbow overline background 1.4))
                (2 . (rainbow background 1.3))
                (3 . (rainbow bold 1.2))
                (t . (semilight 1.1))))
        
        (setq modus-themes-scale-headings t)
        (setq modus-themes-org-blocks 'tinted-background)
    
    There are two types of modus themes: `modus-operandi` which is bright
    and `modus-vivendi` which is dark one.
    In order to ease switching between them it is convenient to define
    custom keybinding [(details](https://emacs.stackexchange.com/a/48627)).
    
        ;; Auxiliary function to toggle betwen bright and dark theme
        (defun toggle-theme ()
          (interactive)
          (if (eq (car custom-enabled-themes) 'modus-vivendi)
              (disable-theme 'modus-vivendi)
            (load-theme 'modus-vivendi :noconfirm)))
        (global-set-key [f6] 'toggle-theme)
    
    Load theme **after** defining all necessary definitions
    (otherwise different font sizes
    won't work after running `init.el` at the startup and
    you'll need to eval it once again
    or manually invoke the following command):
    
        ;; load theme after defining 
        (load-theme 'modus-vivendi :noconfirm) 


### Manually downloaded packages

    
    ;; Set location for external packages.
    (add-to-list 'load-path "~/.emacs.d/manual-download/")
    
    ;; doconce (M-x DocOnce) may be needed to activate it -> 
    (load-file "~/.emacs.d/manual-download/.doconce-mode.el")
    
    
    ;; activating org-mode for doconce pub files:
    ;; https://github.com/doconce/publish/blob/master/doc/manual/publish-user-manual.pdf
    (setq auto-mode-alist
          (append '(("\\.org$" . org-mode))
                  '(("\\.pub$" . org-mode))
                  auto-mode-alist))
    ;; <- doconce

Adding custom useful keybindings for doconce. As for now, this is added as
a global shortcut...

    (global-set-key "\C-c\C-j" "\C-k =====")

1.  Sunrise - Norton Commander-like file browser

    There are few packages to emulate Norton Commander experience in Emacs.
    I tested `mc.el`, `nc.el` and `sunrise.el`. From these three only 
    the last one turned out to be useful (or to run without errors).
    
    <https://www.emacswiki.org/emacs/Sunrise_Commander_Tips#h5o-1>
    
    <https://pragmaticemacs.wordpress.com/2015/10/29/double-dired-with-sunrise-commander/>
    
    <https://enzuru.medium.com/sunrise-commander-an-orthodox-file-manager-for-emacs-2f92fd08ac9e>
    
    -   buttons extension for sunrise
        
        <https://www.emacswiki.org/emacs/sunrise-x-buttons.el>
    
    <https://pragmaticemacs.wordpress.com/2015/10/29/double-dired-with-sunrise-commander/>
    
        ;; sunrise
        (add-to-list 'load-path "~/.emacs.d/manual-download/sunrise")
        (require 'sunrise)
        (require 'sunrise-buttons)
        (require 'sunrise-modeline)
        (add-to-list 'auto-mode-alist '("\\.srvm\\'" . sr-virtual-mode))
    
    The thing that may be annoying in sunrise/dired mode is that is redefines
    `C-x k` keybinding which does not kill buffer anymore, but it is
    bounded to `sunrise-kill-pane-buffer` command which, at least to me,
    works only for `commander-like` frame layout, which is triggered
    after invoking `M-x sunrise`.
    
    In order to have `C-x k` working as usual we can apply the following
    rebinding:
    
        (add-hook 'sunrise-mode-hook
           '(lambda ()
             (local-set-key (kbd "C-x k") 'kill-buffer)
             (local-set-key (kbd "C-x j") 'sunrise-kill-pane-buffer)))

2.  Buffer-move - swapping buffers easily

    <https://www.emacswiki.org/emacs/buffer-move.el>
    
        ;; buffer-move - swap buffers easily
        (require 'buffer-move)
    
    Now you can use commands:
    `buf-move-up`
    `buf-move-down`
    `buf-move-left`
    `buf-move-right`
    
    or you can define keybindings as package documentation recommends 
    (I guess it'll be used too seldom to waste keybinding for that):
    
        ;; (global-set-key (kbd "<C-S-up>")     'buf-move-up)
        ;; (global-set-key (kbd "<C-S-down>")   'buf-move-down)
        ;; (global-set-key (kbd "<C-S-left>")   'buf-move-left)
        ;; (global-set-key (kbd "<C-S-right>")  'buf-move-right)

3.  ob-octave-fix.el

    <a id="org1d0bbd6"></a>
    
    The discussion on this is thread can be found in section
    [1.4.9.7](#orge9d4b44) so I here I just include the solution, namely
    I load fixed library.
    
        ;; octave/matlab-fix
        ;;;; (require 'ob-octave-fix nil t)    ; This is for older approach
        (require 'ob-octave-fix)

4.  My own packages and settings

    1.  Custom org-special-block-extras definitions used globally in org-mode files
    
            ;; custom org-special-block-extras blocks
            (add-to-list 'load-path "~/.emacs.d/myarch")
            (require 'MB-org-special-block-extras)

5.  Other packages

        ;; org to ipython exporter
        ;;(use-package ox-ipynb
        ;  :load-path "~/.emacs.d/manual-download/ox-ipynb")


### TODO The end

1.  Workgroups (should be executed at the end of init.el) <a id="org1b6ce1b"></a>

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
    
    There is one problem with the code above. When running Emacs in batch mode like
    this:
    
    `emacs -batch -Q -load ~/.emacs.d/init.el`
    
    (I have such a line of code in the makefile of this blog)
    it asks in the command line about saving the "currentsession". It sucks.
    As a workaround we can put those hooks inside if statement, which checks
    whether Emacs was run in batch mode or not.
    How to write an if statements is [here](https://www.gnu.org/software/emacs/manual/html_node/elisp/Conditionals.html).
    In the code below I also use
    [`noninteractive` variable](https://emacs.stackexchange.com/questions/20603/how-to-know-if-emacs-is-running-in-batch-mode) which is true
    if emacs is run in batch mode.
    
    The code below somehow worked for a while. Then, out of a sudden it stopped.
    
        (if (not noninteractive)
            ( ; if Emacs is started in graphical environment
              (add-hook 'kill-emacs-hook (
                             lambda () (wg-create-workgroup "currentsession")))
              (setq inhibit-startup-message t)
              (add-hook 'window-setup-hook (
                               lambda () (wg-open-workgroup "currentsession")))
            )
           (
            ; if Emacs is run in batch mode - do not care about workgroups
           )
        )
    
    The problem was the lack of a special keyword `progn` as I found
    [here](https://stackoverflow.com/questions/912355/how-can-you-write-multiple-statements-in-elisp-if-statement) ([Part of the manual about it](https://www.gnu.org/software/emacs/manual/html_node/elisp/Sequencing.html)). All in all, now everything seems
    to be ok with the following lines:
    
        (if (not noninteractive)
            ( ; if Emacs is started in graphical environment
              progn
              (add-hook 'kill-emacs-hook (
                             lambda () (wg-create-workgroup "currentsession")))
              (setq inhibit-startup-message t)
              (add-hook 'window-setup-hook (
                               lambda () (wg-open-workgroup "currentsession")))
            )
           (
            ; if Emacs is run in batch mode - do not care about workgroups
           )
        )

2.  Last lines

3.  DEPRECATED Restoring previous session

    This section is deprecated in favour of [`workgroups2 package`](#org1b6ce1b).
    
    This way of restoring session throws some warnings and needs additional
    confirmations so I give it up. Simple `(desktop-save-mode 1)` which is 
    included [in the beginning of `init.el`](#org8b92c80) works ok.
    
        ;; Restore the "desktop" - do this as late as possible
        (if first-time
            (progn
              ;(desktop-load-default)   ; this is for Emacs 20-21
              (desktop-read)))
        
        ;; Indicate that this file has been read at least once
        (setq first-time nil)

4.  DEPRECATED Open some useful files in the background

    I don't use this part of `init.el` anymore. I can get the similar
    functionality by using `recentf` package or prepare a session
    with required files opened in it.
    
        ;;; Always have several files opened at startup
        ;; hint: https://stackoverflow.com/a/19284395/4649238
        (find-file "~/.emacs.d/init.el")
        (find-file "~/.emacs.d/install-packages.el")
        (find-file "~/.emacs.d/useful-shortcuts.org")
    
    What's more, the commands above cause an unwanted behaviour when
    evaluating `init.el`. The last file in the list is opened in an active buffer.
    I'd like to have those files opened "in background".
    I found `find-file-noselect` function have this functionality,
    but first: it is [not recommended way](https://emacs.stackexchange.com/questions/2868/whats-wrong-with-find-file-noselect) of doing this thing;
    second: it is not present in Emacs 27.1 anyway.
    
        ;; All done
        (message "All done in init.el.")


## Dependencies of the presented Emacs configuration <a id="orgb9690af"></a>:

The list of external applications that this script is dependent on:

-   git
-   LaTeX distribution (for org to latex exporters)

-   xclip ([1.4.18](#orgce88eb5))
-   xdotool ([1.4.18](#orgce88eb5))
-   xprop ([1.4.18](#orgce88eb5)) - this is not a package but executable
-   xwininfo ([1.4.18](#orgce88eb5)) - this is not a package but executable


## Some useful information and links:


### What to do when Emacs is slow and laggy:

<https://emacs.stackexchange.com/questions/5359/how-can-i-troubleshoot-a-very-slow-emacs>

