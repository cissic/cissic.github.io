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


############################################################
# Help                                                     #
############################################################
# Help()
# {
#    Display Help
#    echo "Add description of the script functions here."
#    echo
#    echo "Syntax: scriptTemplate [-g|h|v|V]"
#    echo "options:"
#    echo "g     Print the GPL license notification."
#    echo "h     Print this Help."
#    echo "v     Verbose mode."
#    echo "V     Print software version and exit."
#    echo
# }

############################################################
# Main
############################################################
filepath=$1
option=$2

if [ "$option" == "-d" ] || [ "$option" == "--doconce" ]
then
    option="-d"
    
elif [ "$option" == "-o" ] || [ "$option" == "--org"]   
then
    option="-o"        
else
    echo "Unknown option. You can only use flags: -d --doconce -o --org"
    exit
fi


# Directory containing source (Markdown) files
if [ "$option" == "-d" ] 
then
    bash maked.sh $filepath
    
elif [ "$option" == "-o" ] 
then
    bash makeo.sh $filepath
fi
