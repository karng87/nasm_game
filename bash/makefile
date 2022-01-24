SHELL := /bin/bash
define func
  for i in $(shell find . -regextype posix-extended -regex '.*makefile$$' -and -not -regex '.*(\.git)/.*' | sed -En '/\.\/makefile/!{s/makefile//p}') ; do $(MAKE) -C $$i $1;done
endef

texs := $(notdir $(shell find -maxdepth 1 -name "*.tex"))
hss := $(notdir $(shell find app -maxdepth 1 -name "*.hs"))

.PHONEY: all clean recursive, run, echo

all: $(patsubst %.hs, build/%, $(hss)) $(patsubst %.tex, build/%.pdf, $(texs)) recursive

build/%.pdf: %.tex
		@pdflatex --jobname=$(patsubst %.tex,build/%, $<) $<

pdf :$(patsubst %.tex, build/%.pdf, $(texs))
		@nohup zathura $< &

build/%: app/%.hs
		ghc -isrc -main-is $(shell sed -En 's/.*\/([^.]+)\.hs$$/\1/p' <<< $<) -o $@ $<

run: $(patsubst %.hs, build/%, app/%.hs)
		./$<

recursive:
		@$(call func,all)

clean:
		rm $(shell find . -regextype posix-extended -regex '.*\.(hi|o|out|aux|log|toc|nav|snm|lot|lof)$$' -and -not -regex '.*(\.git|pack)/.*')
		@$(call func,$@)

echo:
		@echo "This is bash dir"
		@$(call func,$@)
