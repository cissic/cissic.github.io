
# Table of Contents

1.  [bash and bash history settings](#orgc889db3)
    1.  [Useful link](#orgd5a91a4)
    2.  [Immediatly Persist commands to your ~/.bash<sub>history</sub> file](#orga6347c8)
    3.  [Modify Bash history buffer and file size](#orgc813dff)



<a id="orgc889db3"></a>

# TODO bash and bash history settings


<a id="orgd5a91a4"></a>

## Useful link

<https://www.cherryservers.com/blog/a-complete-guide-to-linux-bash-history>


<a id="orga6347c8"></a>

## Immediatly Persist commands to your ~/.bash<sub>history</sub> file

Add this to ~/.bashrc:

    PROMPT_COMMAND='history -a'


<a id="orgc813dff"></a>

## Modify Bash history buffer and file size

If the default values of 1,000 command entries in the history buffer and 2,000 entries in the history file isn't what you want, you can change the $HISTSIZE (buffer) and $HISTFILESIZE (file) environment variables.

For example, to set both to 11,000 entries, modify the default values to read:

    HISTSIZE=11000
    HISTFILESIZE=11000

