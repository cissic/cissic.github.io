---
author: cissic
date: 2023-10-02 Mon
tags: 'debian lenovo trackpoint scroll'
title: 'How to install maxima-kernel in jupyter notebook'
---


# How to install maxima-kernel in jupyter notebook


## Links that can be useful:

-   <https://github.com/robert-dodier/maxima-jupyter>
-   <https://github.com/robert-dodier/maxima-jupyter/issues/111>
-   <https://github.com/cameronraysmith/notebooks/blob/35a7190f1823b824ba78c4a181d98cc841888c2e/Dockerfile#L83>
-   <https://github.com/robert-dodier/maxima-jupyter/issues/84>
-   <https://sourceforge.net/p/maxima/mailman/message/37130747/>


## Description

My attempt to make notebook Dockerfile with maxima kernel (not working)

    z                                                            
    # Dockerfile for JupyterLab
    # Jupyterhub version: 3.1.1
    
    FROM jupyter/datascience-notebook:hub-3.1.1
    
    # JupyterHub Version
    ARG JUPYTERHUB_VERSION=3.1.1
    
    USER root
    RUN apt-get update && \
        apt-get install -y gnuplot octave && \
        apt-get clean
    
    # Install packages
    RUN pip3 install --no-cache \
        jupyterlab-language-pack-pl-PL \
        octave_kernel && \
        export OCTAVE_EXECUTABLE=$(which octave)
    
    
    # install maxima
    RUN apt-get install -y sbcl
    
    
    RUN pwd
    # if something wrong - change this source
    RUN curl https://ftp.gnu.org/gnu/non-gnu/maxima/maxima-5.2.tar.gz -o maxima.tar.gz
    RUN tar -zxvf maxima.tar.gz  
    RUN mv maxima-* maxima
    
    RUN apt-get install autotools-dev automake -y
    
    RUN cd maxima && \
        ./configure --enable-sbcl
    
    
    USER jovyan

