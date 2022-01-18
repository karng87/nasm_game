SHELL := /bin/bash

texs := $(notdir $(shell find -maxdepth 1 -name "*.tex"))

.PHONEY: all clean recursive, run, echo

all: $(patsubst %.tex, build/%.pdf, $(texs))

build/%.pdf: %.tex
		@pdflatex --jobname=$(patsubst %.tex,build/%, $<) $<

pdf :$(patsubst %.tex, build/%.pdf, $(texs))
		@nohup zathura $< &

clean:
		rm $(shell find -type f -regex '.*\.\(hi\|o\|out\|aux\|log\|toc\|nav\|snm\|lot\|lof\)$$')

echo:
		@echo "This is snippet dir"
