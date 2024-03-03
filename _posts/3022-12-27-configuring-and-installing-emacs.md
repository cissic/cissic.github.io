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
directory and git itself installed in the system (see Sec. [1.4](#org8a7d622)).
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

<a id="org04a46a4"></a>

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


## Dependencies of the presented Emacs configuration: <a id="org8a7d622"></a>

The list of external applications that this script is dependent on:

-   git
-   LaTeX distribution (for org to latex exporters)


## Some useful information and links:


### What to do when Emacs is slow and laggy:

<https://emacs.stackexchange.com/questions/5359/how-can-i-troubleshoot-a-very-slow-emacs>

