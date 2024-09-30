
# Table of Contents

1.  [Hardlinks and softlinks](#org14b6b64)
    1.  [Hard link](#org49451ac)
    2.  [Soft link](#org279675f)
    3.  [Hyperlinks](#org38a612c)



<a id="org14b6b64"></a>

# TODO Hardlinks and softlinks


<a id="org49451ac"></a>

## Hard link

Hard link:

    echo "111" > test.txt
    ln test.txt hlinkToTest
    rm -rf test.txt
    cat hlinkToTest

Hardlink links to the content of the file. You can access content
until the very last of the hard links exist.

    Hard link       OriginalFilename (test.txt)
        \          /
        _\|      |/_
            Inode
           878945
              |
    	  |
    	 \|/
        Data on Hard Drive	 


<a id="org279675f"></a>

## Soft link

    echo "111" > test.txt
    ln test.txt slinkToTest
    rm -rf test.txt
    cat slinkToTest

Does to work because slinkToTest linked to test.txt name, not to the
file content itself.

Softlink links to other filename, not to content itself.
Soft link can't access the content of riginalFilename if
OriginalFilename is deleted.

    
    Soft link   --> OriginalFilename (test.txt)
         |                   | 
         |		         | 
        \|/		        \|/
       Inode               Inode
      948540               948545
                             |
                             |
                            \|/
                       Data on Hard Drive	       

The picture above is corrected version of
![img](https://i.sstatic.net/uNXQS.png)
as it is described in the comments below the post
<https://stackoverflow.com/a/47786856/13215783>.


<a id="org38a612c"></a>

## Hyperlinks

<https://stackoverflow.com/questions/185899/what-is-the-difference-between-a-symbolic-link-and-a-hard-link>

<https://stackoverflow.com/questions/185899/what-is-the-difference-between-a-symbolic-link-and-a-hard-link>

<https://en.wikipedia.org/wiki/Symbolic_link>

<https://en.wikipedia.org/wiki/Hard_link>

