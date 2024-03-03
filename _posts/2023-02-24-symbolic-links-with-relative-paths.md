

# Symbolic links with relative paths


## Problem

How to create symbolic link with the use of relative path?
You need to use flag `-s` for symbolic link, and `-r` flag to handle
relative paths.

`f` flag forces creating link even if the file (or the link) with
the same name already is in the directory.

Here's a code snippet:

    #!/bin/bash
    
    dirname=./temp25324757434579642
    if [ ! -d $dirname ]; then mkdir $dirname; fi
    if [ ! -d $dirname/dir ]; then mkdir $dirname/dir; fi
    echo "File content LOWER" > $dirname/dir/fileDOWN.txt
    echo "File content UPPER" > $dirname/fileUP.txt
    
    cd $dirname
    ln -rs fileUP.txt ./dir/
    ln -rs fileUP.txt ./dir/fileUPLink2.txt
    cd dir
    ln -rs ../fileUP.txt fileUPLink3.txt
    
    cd .. # again in $dirname
    ln -rs ./dir/fileDOWN.txt ./          # 1) This line creates links with the
                                          #     same name as line 2)
    ln -rs ./dir/fileDOWN.txt ./fileDOWNLink2.txt
    cd dir
    ln -rs fileDOWN.txt ../fileDOWNLink3.txt
    # or
    ln -rfs fileDOWN.txt ../               # 2) This line creates links with the
                                           #     same name as line 1). 
    
    # clear the mess
    cd ../..  
    rm -rf $dirname

