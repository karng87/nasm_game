SHELL := /bin/bash
define func
  for i in $(shell find . -name "makefile" | sed -En '/\.\/makefile/!{s/makefile//p}') ; do $(MAKE) -C $$i $1;done
endef

TEX = pdflatex
TEXJ = pdflatex --jobname=

SRCS := $(notdir $(shell find -maxdepth 1 -name "*.tex"))
TARGETS := $(patsubst %.tex, build/%.pdf, $(SRCS))


.PHONEY: all clean recursive, run, echo

all: $(TARGETS) recursive

build/%.pdf: %.tex
	$(TEXJ)$(patsubst %.tex,build/%, $<) $<

recursive:
	@$(call func,all)

run:$(TARGETS)
	@nohup zathura $(TARGETS) &

clean:
	@rm -rf {build,.}/*.{nohup.out,hi,o,aux,out,log,toc,nav,snm,lot,lof}
	@$(call func,$@)

echo:
	@echo "This is root dir"
	@$(call func,$@)
