SRCS = $(notdir $(shell find -name "*.tex"))

TARGETS = $(patsubst %.tex, build/%.pdf, $(SRCS))

TEX =	pdflatex
TEXJ =	pdflatex --jobname=

.PHONEY: all clean run

all: $(TARGETS)


build/%.pdf: %.tex
	$(TEXJ)$(patsubst %.tex,build/%,$<) $<
	
clean:
	#rm $(DIR)/$(OBJ).aux $(DIR)/$(OBJ).out $(DIR)/$(OBJ).log $(DIR)/$(OBJ).pdf
	rm build/*
