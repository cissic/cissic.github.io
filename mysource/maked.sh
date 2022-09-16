#!/bin/bash 

####################################################
## ATTENTION:
# This file can be invoked both from the context of *org-public-nodes* directory:
# mb@debi:~/projects/mynotes/org-public-notes$ bash ../make.sh folder/aaa.org
# and from the context of the root project directory:
# mb@debi:~/projects/mynotes$ bash make.sh org-public-notes/aaa.org
###################################################
## DEPRECATED:
### To work properly this file should be invoked from the context of *org-public-nodes* directory:
### mb@debi:~/projects/mynotes/org-public-notes$ bash ../make.sh folder/aaa.org
###################################################


projectDirectory="~/projects/mynotes"

# Convert given org file to md and place it in output directory

# Directory containing source (Markdown) files
sourceDir="mysource/public-notes-doconce"
# Directory containing pdf files
outputDir="_posts"
# Project-Template-For-OrgMode/... (HTML project)

# https://stackoverflow.com/questions/125281/how-do-i-remove-the-file-suffix-and-path-portion-from-a-path-string-in-bash
filepath=$1

# filePathWithNoExtenstion=${filepath%%.*}
# echo $filePathWithNoExtenstion
# filestub=${filePathWithNoExtenstion%.*}    # ${filename%%.*}
# echo $filestub

# trim leading directory path and file extension in case the filename is includes them
filestub="$(basename $filepath .do.txt)"
# echo $filestub

eval doconce format html "$projectDirectory/$sourceDir/$filestub.do.txt"

eval pandoc -s -r html "$projectDirectory/$sourceDir/$filestub.html" -t markdown -o "$projectDirectory/$outputDir/$filestub.md"


eval rm --force "$projectDirectory/$sourceDir/"tmp_preprocess__"$filestub.do.txt"
eval rm --force "$projectDirectory/$sourceDir/$filestub.dlog"
eval rm --force "$projectDirectory/$sourceDir/$filestub.html"



