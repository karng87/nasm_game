SHELL := /bin/bash
define func
	for i in $(shell find . -name "makefile" | sed -En '/\.\/makefile/!{s/makefile//p}') ; do $(MAKE) -C $$i $1;done
endef

tmp := $(shell find . -type f -regextype posix-extended -regex '.*(build|src|app)/.*\.(hi|o|out|aux|log|toc|nav|snm|lot|lof)$$')
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

clean:
ifneq ('', tmp)
	rm $(tmp)
endif
	@$(call func,$@)

echo:
	@echo "This is root dir"
	@$(call func,$@)
