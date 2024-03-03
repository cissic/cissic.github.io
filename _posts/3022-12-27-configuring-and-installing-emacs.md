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
directory and git itself installed in the system (see Sec. [1.5](#org1f85a12)).
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

<a id="org1c792c5"></a>

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

    This section is deprecated in favour of [`workgroups2 package`](#orgb84a34d).
    
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

1.  Self-descriptive oneliners <a id="orgbb67a49"></a>

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
    instances font is set now in the section [1.4.8](#orgfb42f44).

7.  Highlight on an active window/buffer

    Although the active window can be recognized
    by the cursor which blinking in it, sometimes it is hard to
    find in on the screen (especially if you use a colourful theme
    like [1.4.8.1](#org09ef582).
    
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
    
    -   and add this hook per each required mode (this is done in [1.4.7](#orga74f9bd) section
        of this document

12. Turning on/off beeping

    Completely out of the blue my emacs started beeping. I guess it
    had to be some keybinding I accidentally pressed but have no idea
    what I did.
    Anyway, to disable it we must [do the following](https://stackoverflow.com/questions/10545437/how-to-disable-the-beep-in-emacs-on-windows):
    
          ;; Setting alarms in Emacs -> 
        (setq-default visible-bell t) 
        (setq ring-bell-function 'ignore)

13. Ibuffer - an advanced replacement for BufferMenu <a id="org750a09a"></a>

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
    
        In [1.4.3.13](#org750a09a) there a nice shortcut to do this. You can select all
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

3.  TODO Ivy (for testing) <a id="org203566a"></a>

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


### Emacs-everywhere <a id="orgfb42f44"></a>

1.  Modus themes by Protesilaos Stavrou <a id="org09ef582"></a>

2.  Workgroups (should be executed at the end of init.el) <a id="orgb84a34d"></a>


## Dependencies of the presented Emacs configuration: <a id="org1f85a12"></a>

The list of external applications that this script is dependent on:

-   git
-   LaTeX distribution (for org to latex exporters)

-   xclip ([1.4.8](#orgfb42f44))
-   xdotool ([1.4.8](#orgfb42f44))
-   xprop ([1.4.8](#orgfb42f44)) - this is not a package but executable
-   xwininfo ([1.4.8](#orgfb42f44)) - this is not a package but executable


## Some useful information and links:


### What to do when Emacs is slow and laggy:

<https://emacs.stackexchange.com/questions/5359/how-can-i-troubleshoot-a-very-slow-emacs>

