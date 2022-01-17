SHELL := /bin/bash

hss = $(notdir $(shell find app -name "*.hs"))
texs := $(notdir $(shell find -maxdepth 1 -name "*.tex"))

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
		@rm -rf {.,build,app,src}/*.{$(patsubst %.tex, %,$(hss)),nohup.out,hi,o,aux,out,log,toc,nav,snm,lot,lof}

echo:
		@echo "This is haskell dir"
