SHELL := /bin/bash
SRCS := $(notdir $(shell find -name "*.tex"))

TARGETS := $(patsubst %.tex, build/%.pdf, $(SRCS))

TEX =	pdflatex
TEXJ =	pdflatex --jobname=

.PHONEY: all clean hs vihs

all: $(TARGETS) h


build/%.pdf: %.tex
	$(TEXJ)$(patsubst %.tex,build/%,$<) $<


h: src
	$(MAKE) -C $^


run:
	nohup zathura $(TARGETS) &

clean:
	rm nohup.out build/*.{aux,out,log,toc,nav,snm,lot,lof}	
	$(MAKE) -C src clean
