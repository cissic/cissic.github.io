---
author: cissic
date: 2022-12-27 Tue
tags: 'emacs packages'
title: 'How to filter out packages in list-packages'
---


# How to filter out packages in list-packages


## Problem

After obtaining packages list by

    M-x list-packages

you may want to filter out some packages (for example to show only installed packages or built-in).

There are some tips that tell you to use: `/ u`, `/ s` etc. where letter after slash is a modifier which filters out packages by different properties. In my case this does not work - I am only able to use
`/ k`, `/ n`, `//`
to respectively filter by keyword, name, and clear filter.


## Solution

Solution that works for me is presented [here](https://emacs.stackexchange.com/a/3428). It comes down to using `occur` command when you view packages list:

    M-x occur

and then you type a word you want to search for in the list (for example `installed`). (Another proposed solution is `paradox` command, however probably it's not built-in in my emacs distribution since I don't have it).

