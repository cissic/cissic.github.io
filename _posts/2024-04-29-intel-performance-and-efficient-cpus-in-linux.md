
# Table of Contents

1.  [Intel performance and efficient cpus in linux](#org3290bb3)
    1.  [Problem description](#org8efbf39)
    2.  [Theory](#org2de7781)
    3.  [Analysis of cpus in linux](#orga62472a)
    4.  [Why is my matlab using only efficiency cores when running simulations?](#orgfc39a9a)



<a id="org3290bb3"></a>

# TODO Intel performance and efficient cpus in linux


<a id="org8efbf39"></a>

## Problem description


<a id="org2de7781"></a>

## Theory

<https://www.quora.com/My-CPU-has-14-cores-6-efficient-8-performance-cores-and-20-threads-What-does-it-mean-Why-are-there-not-28-threads>


<a id="orga62472a"></a>

## Analysis of cpus in linux

<https://stackoverflow.com/questions/71122837/how-to-detect-e-cores-and-p-cores-in-linux-alder-lake-system>

    lscpu --all --extended

First 12 lines refer to Performance cores  (two cpus per core).
The last 8 cpus (12-19) are efficiency cores.


<a id="orgfc39a9a"></a>

## Why is my matlab using only efficiency cores when running simulations?

