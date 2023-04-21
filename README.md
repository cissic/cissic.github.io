# cissic.github.io
Sort of blog that can be found [here](https://cissic.github.io).

After cloning the repository:
    
    make initialize-project-after-cloning

Then, to create posts in org-mode and put them in mysource/public-notes-org:

From mysource directory:

    make all 
    
to convert all source (org) files to markdown format, and

    make push-all
   
to commit changes with the default commit message and push them to GitHub.


## TODO:
Prepare makefile to do the same for doconce documents...

