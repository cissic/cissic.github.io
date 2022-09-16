---
author:
- cissic
date: '\<2022-09-08 thu\>'
tags: python jupyter nbextensions anaconda
title: How to make Anaconda Jupyter Notebook work with nbextensions
---

How to make Anaconda Jupyter Notebook work with nbextensions {#how-to-make-anaconda-jupyter-notebook-work-with-nbextensions-1}
------------------------------------------------------------

-   Download anaconda installer (.sh file)
-   Run it from sudo user context BUT **NOT** using sudo!!!

``` {.bash}
bash Anaconda.... .sh

# to have octave in jupyter
conda install -c conda-forge octave_kernel

# to have access to variable values in texts
conda install -c conda-forge jupyter_contrib_nbextensions

# configurator for easier management
conda install -c conda-forge jupyter_nbextensions_configurator

# https://stackoverflow.com/questions/18878083/can-i-use-variables-on-an-ipython-notebook-markup-cell/43911937
```

-   Last but not least!!! The NOTEBOOK HAS TO BE TRUSTED to make the
    markup extension works with python variables and it worked for me!

``` {.bash}
# variable inspector
jupyter nbextension enable varInspector/main

# equation autonumbering
jupyter nbextension enable equation-numbering/main

# tags:
jupyter nbextension enable cell_filter/cell_filter

# additional latex flavours 
jupyter nbextension enable latex_envs/latex_envs

# Removing cells (from command line:
jupyter nbconvert --to pdf --TemplateExporter.exclude_input=True my_notebook.ipynb

# https://nbconvert.readthedocs.io/en/latest/config_options.html?highlight=TemplateExporter.exclude

# removing specific cells with tags
# # https://stackoverflow.com/questions/52834910/remove-cells-from-jupyter-notebook-with-nbconvert
jupyter nbconvert a.ipynb --TagRemovePreprocessor.enabled=True --TagRemovePreprocessor.remove_cell_tags="['remove_cell', 'other_tag_to_remove']" --to html

# Adding julia:
https://datatofish.com/add-julia-to-jupyter/

```
