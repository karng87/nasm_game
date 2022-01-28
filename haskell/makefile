SHELL := /bin/bash
define func
  for i in $(shell find . -name "makefile" | sed -En '/\.\/makefile/!{s/makefile//p}') ; do $(MAKE) -C $$i $1;done
endef

texs := $(notdir $(shell find -maxdepth 1 -name "*.tex"))

.PHONEY: all clean recursive, run, echo

all: $(patsubst %.tex, build/%.pdf, $(texs)) recursive

build/%.pdf: %.tex
	$(MAKE) mkbuild
	@pdflatex --jobname=$(patsubst %.tex,build/%, $<) $<

pdf :$(patsubst %.tex, build/%.pdf, $(texs))
	@nohup zathura $< &

mkbuild:
	mkdir -p build

recursive:
	@$(call func,all)

tmp := $(shell find . -regextype posix-extended -regex '.*(build/.*|tests/bin/.*|(\.(hi|o|out|aux|log|toc|nav|snm|lot|lof)$$))' -and -not -regex '.*(\.git|pack)/.*')

# TODO not work
clean:
ifneq (tmp,'')
	rm $(tmp)
endif


echo:
	@echo "This is root dir"
	@$(call func,$@)
