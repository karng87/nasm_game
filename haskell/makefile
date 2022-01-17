SHELL := /bin/bash

hss = $(notdir $(shell find app -name "*.hs"))
texs := $(notdir $(shell find -maxdepth 1 -name "*.tex"))
tmp = $(shell find -type f -regex '.*\(hi\|o\|out\|nohup\|aux\|log\|toc\|nav\|snm\|lot\|lof\)$$')

.PHONEY: all pdf lean recursive, run, echo

all: $(patsubst %.tex, build/%.pdf, $(texs)) $(patsubst %.hs, build/%, $(hss))

build/%.pdf: %.tex
		@pdflatex --jobname=$(patsubst %.tex,build/%, $<) $<

build/%: app/%.hs
		ghc -isrc -o $@ $<

run : $(patsubst %.hs, build/%, $(hss))
		./$<

pdf : $(patsubst %.tex, build/%.pdf, $(texs))
		@nohup zathura $< &

clean:
		rm -rf $(tmp)

echo:
		@echo "This is haskell dir"
