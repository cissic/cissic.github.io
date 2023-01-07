#!/bin/bash

.ONESHELL: # https://www.gnu.org/software/make/manual/html_node/One-Shell.html

# In order to use this makefile, you need some tools:
# - GNU make
# - Pandoc
# - LuaLaTeX
# - DejaVu Sans fonts


# TODO: This makefile is in development. Directory paths and some other stuff need to be updated.



# Directory containing source (Markdown) files
source := public-notes-org

# Directory containing pdf files
output := ../_posts
# Project-Template-For-OrgMode/... (HTML project)

# All markdown files in src/ are considered sources
sources := $(wildcard $(source)/*.org)

# Convert the list of source files (Markdown files in directory src/)
# into a list of output files (PDFs in directory print/).
objects := $(patsubst %.org,%.md,$(subst $(source),$(output),$(sources)))

.PHONY: all
## Convert all source files to output files
all: $(objects)

### Recipe for converting an org file into md file using Pandoc
#$(output)/%.md: $(source)/%.org
#	pandoc -s -t markdown \
#		$< \
#		-o $@
### pandoc -t markdown -s $< -o $@

### The above is deprecated. Now .org to .md conversion
### is made from emacs so we just need to move
### all the markdown files from $(source) to $(output).
### This is made in push-all action.

## Recipe for converting an org file into md file using Emacs
$(output)/%.md: $(source)/%.org
	emacs -batch -load ~/.emacs.d/init.el \
	--eval '(setq enable-local-variables :all)' \
	--visit=$< \
	-f org-md-export-to-markdown

.PHONY: clean-auxiliary
## Clean auxiliary and temporary files
clean-auxiliary:
	find . -name '*~'    -exec rm --force {} \;
	find . -name '*.aux'    -exec rm --force {} \;
	find . -name '*.bbl'    -exec rm --force {} \;
	find . -name '*.blg'    -exec rm --force {} \;
	find . -name '*.log'    -exec rm --force {} \;
	find . -name '*.nav'    -exec rm --force {} \;
	find . -name '*.out'    -exec rm --force {} \;
	find . -name '*.snm'    -exec rm --force {} \;
	find . -name '*.synctex.gz'    -exec rm --force {} \;
	find . -name '*.toc'    -exec rm --force {} \;
	find . -name 'tmp_preprocess__*.do.txt'    -exec rm --force {} \;
	find . -name '*.dlog'    -exec rm --force {} \;
	find . -name '#*.org#'    -exec rm --force {} \;
	find . -name '.#*.org'    -exec rm --force {} \;

.PHONY: clean-project
## Clean output files generated from source
clean-project:
	rm -f $(output)/*.pdf

.PHONY: initialize-project-after-cloning
## Clean output files generated from source
initialize-project-after-cloning:
	git config user.name "cissic"
	git config user.email "cis00sic@gmail.com"

# .PHONY: test
# test:
# 	mv $(source)/*.md $(output)
	
.PHONY: push-all 
## Invoke git from a different folder (-C flag) to add new posts, commit and push the repository
push-all:
	mv $(source)/*.md $(output)
	git add -u
	git -C $(source) add *.org
	git -C $(output) add *.md
	git -C $(output) commit -m"Yet Another Post(s)"
	git -C $(output) push
#	+$(MAKE) -C cissicblog git --git-dir=/home/mb/projects/mynotes/cissicblog/.git status


# Plonk the following at the end of your Makefile
.DEFAULT_GOAL := help

# Inspired by <http://marmelab.com/blog/2016/02/29/auto-documented-makefile.html>
# sed script explained:
# /^##/:
# 	* save line in hold space
# 	* purge line
# 	* Loop:
# 		* append newline + line to hold space
# 		* go to next line
# 		* if line starts with doc comment, strip comment character off and loop
# 	* remove target prerequisites
# 	* append hold space (+ newline) to line
# 	* replace newline plus comments by `---`
# 	* print line
# Separate expressions are necessary because labels cannot be delimited by
# semicolon; see <http://stackoverflow.com/a/11799865/1968>

# 	+ bugfix:     https://github.com/drivendata/cookiecutter-data-science/issues/67

.PHONY: help
help:
	@echo "$$(tput bold)Available rules:$$(tput sgr0)"
	@echo
	@sed -n -e "/^## / { \
		h; \
		s/.*//; \
		:doc" \
		-e "H; \
		n; \
		s/^## //; \
		t doc" \
		-e "s/:.*//; \
		G; \
		s/\\n## /---/; \
		s/\\n/ /g; \
		p; \
	}" ${MAKEFILE_LIST} \
	| LC_ALL='C' sort --ignore-case \
	| awk -F '---' \
		-v ncol=$$(tput cols) \
		-v indent=19 \
		-v col_on="$$(tput setaf 6)" \
		-v col_off="$$(tput sgr0)" \
	'{ \
		printf "%s%*s%s ", col_on, -indent, $$1, col_off; \
		n = split($$2, words, " "); \
		line_length = ncol - indent; \
		for (i = 1; i <= n; i++) { \
			line_length -= length(words[i]) + 1; \
			if (line_length <= 0) { \
				line_length = ncol - indent - length(words[i]) - 1; \
				printf "\n%*s ", -indent, " "; \
			} \
			printf "%s ", words[i]; \
		} \
		printf "\n"; \
	}' \
	| more $(shell test $(shell uname) = Darwin && echo '--no-init --raw-control-chars')

