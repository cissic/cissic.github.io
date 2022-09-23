---
author:
- cissic
date: '\<2022-09-22 Thu\>'
tags: doconce
title: How to add the support for a new language in DocOnce
---

How to add the support for a new language in DocOnce {#how-to-add-the-support-for-a-new-language-in-doconce-1}
----------------------------------------------------

Find `doconce/globals.py` (in my case it was in
`/usr/local/lib/python3.9/dist-packages/doconce/`) and add the element
to variable `locale_dict` (line 95 at the time of writing).

``` {.example}
        ...
        },
    Polish={
        'locale': 'pl_PL.UTF-8',
        'latex package': 'polish',
        'aspell_dictionary' : 'polish', 
        'toc': 'Spis treści',
        'Contents': 'Contents',
        'Figure': 'Rysunek',
        'Movie': 'Film',
        'list of': 'Lista',
        'and': 'i',
        'Exercise': 'Ćwiczenie',
        'Project': 'Projekt',
        'Problem': 'Problem',
        'Example': 'Przykład',
        'Projects': 'Projekty',
        'Problems': 'Problemy',
        'Examples': 'Przykłady',
        'Preface': 'Wstęp',
        'Abstract': 'Skrót',
        'Summary': 'Podsumowanie',
        # Admons
        'summary': 'podsumowanie',
        'hint': 'podpowiedź',
        'question': 'pytanie',
        'notice': 'uwaga',
        'warning': 'uwaga!',
        # box, quote are silent wrt title
        'remarks': 'uwagi', # In exercises
        # Exercise headings
        'Solution': 'Rozwiązanie',
        'Answer': 'Odpowiedź',
        'Hint': 'Podpowiedź',
        # At the end (in Sphinx)
        'index': 'Indeks',
        # References
        'Filename': 'Plik',
        'Filenames': 'Pliki',
        # Quiz
        'question_prefix': 'Pytanie:', # question in multiple-choice quiz
        'choice_prefix': 'Pytanie',      # choice in multiple-choice quiz
        }
    }
# Let English be an alias for American
...
```
