

# How to definitively kill zombie process

Sometimes it may happen that process invoked by the parent process becomes zombie and stays in the memory.
It should be removed from the task list when the parent process stops working, but what if the parent process is to be running?
In my case I run in Dolphin I invoked terminal window (bash) to run pdflatex. Many unsuccesful pdf compilations lead to the moment when I had many pdflatex zombie processes which resulted in huge RAM usage. 
Running `killall pdflatex` didn't work.


## Solution

Run

    ps l
    # or 
    ps l | grep pdflatex
    # or (for a better view)
    pstree -p
    # or 
    pstree -p | grep pdflatex

to find id of the parent of all pdflatex zombie processes.
In my case the structure looked like

     ├─dolphin(992)─┬─bash(1018)─┬─{pdflatex}(1033)
     │              │            ├─{pdflatex}(1034)
     │              │            ├─{pdflatex}(1035)
     │              │            ├─{pdflatex}(1036)
     │              │            ├─{pdflatex}(1046)
     │              │            ├─{pdflatex}(1047)
     │              │            ├─{pdflatex}(1048)
     │              │            ├─{pdflatex}(1049)
     │              │            └─{pdflatex}(1054)
    ...            ...                ...

Then I could kill bash by

    kill -9 1018

and retain its parent dolphin(992).

Equivalently, all the process can be automatized with the use of the one-line inspired by 
[this post](https://stackoverflow.com/a/3510850/4649238):

    kill -9 $(ps aux | grep '[p]dflatex' | awk '{print $2}')

Cite:

Details on its workings are as follows:

-   The ps gives you the list of all the processes.
-   The grep filters that based on your search string, [p] is a trick to stop you picking up the actual grep process itself.
-   The awk just gives you the second field of each line, which is the PID.
-   The \\$(x) construct means to execute x then take its output and put it on the command line. The output of that ps pipeline inside that construct above is the list of process IDs so you end up with a command like kill 1234 1122 7654.

