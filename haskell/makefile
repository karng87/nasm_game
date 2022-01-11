SHELL := /bin/bash
SRCS := $(notdir $(shell find -name "*.tex"))

TARGETS := $(patsubst %.tex, build/%.pdf, $(SRCS))

TEX =	pdflatex
TEXJ =	pdflatex --jobname=

.PHONEY: all clean hs vihs

all: $(TARGETS)


build/%.pdf: %.tex
	$(TEXJ)$(patsubst %.tex,build/%,$<) $<


h: src
	$(MAKE) -C $^

vh:
	nvim src/Main.hs

vl:
	nvim haskell-type.tex

clean:
	#rm $(DIR)/$(OBJ).aux $(DIR)/$(OBJ).out $(DIR)/$(OBJ).log $(DIR)/$(OBJ).pdf
	rm build/*
