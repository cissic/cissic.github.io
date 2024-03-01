---
author: cissic
date: 2023-10-02 Mon
tags: 'debian lenovo trackpoint scroll'
title: 'Examples of C/C++ code blocks in noweb'
---


# {{{title}}

:PROPERTIES:
:PRJ-DIR: ./2023-10-05-noweb-C/:


## Examples


### Simple example

Blah blah

    #include <iostream>
    int main (void)
    {
       std::cout << "Hello World" << std::endl;
    }


### Using variables

    #include <iostream>
    int main (void)
    {
       std::cout << a+b << std::endl;
    }


### Using array variables

    #include <iostream>
    int main (void)
    {
       std::cout << a+b[1] << std::endl;
    }


### Using noweb parameters in another noweb block

1.  Elisp example

        (+ x x)
    
        (+ x 2)
    
        10
    
        12

2.  ABANDONED C/C++ example

    1.  A
    
            #include <iostream>
            
            int fun1(int a, int b)
            {  
              return a+b ;
            }
            
            int main(){
              int a = fun1(x,y) ;
              std::cout <<a<<std::endl ;
              return  a;
            }
    
    2.  B
    
            int fun1(int a, int b)
            {  
              return a+b ;
            }
        
            #include <iostream>
            
            int fun1(int a, int b)
            {  
              return a+b ;
            }
            
            int main(){
              int a = fun1(x,y) ;
              std::cout <<a<<std::endl ;
              return  a;
            }  
        
            12
        
            (+ x 2)
        
            10
        
            12

3.  Some test

