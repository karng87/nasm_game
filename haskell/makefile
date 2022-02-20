SHELL := /bin/bash
define func
	for i in $(shell find . -name "makefile" | sed -En '/\.\/makefile/!{s/makefile//p}') ; do $(MAKE) -C $$i $1;done
endef

tmp := $(shell find . -type f -regextype posix-extended -regex '.*\.(hi|o|out|aux|log|toc|nav|snm|lot|lof)$$' -and -not -regex '.*/(.git|dist.*|pdf)/.*')
texs := $(notdir $(shell find -maxdepth 1 -name "*.tex"))
<<<<<<< Updated upstream
target := ./build/haskell-type.pdf
.PHONEY: all clean recursive, run, echo
hss := $(notdir $(shell find -regextype posix-extended -regex '.*/(app)/.+\.hs$$'))
#hss := $(notdir $(shell find -regextype posix-extended -regex '.*/(app|test)/.+\.hs$$'))

all: $(patsubst %.tex, build/%.pdf, $(texs)) recursive

build/%.pdf: %.tex
	$(MAKE) build
	pdflatex --jobname=$(patsubst %.tex,build/%,$<) $<

pdf: $(target) $(patsubst %.tex, build/%.pdf, $(texs))
	nohup zathura $(word 1,$^) &

build:
	mkdir -p $@
build/%: app/%.hs
		ghc -v --make -isrc -main-is $(shell sed -En 's/.*\/([^.]+)\.hs$$/\1/p' <<< $<) -o $@ $< -package titlecase{package titlecase True ([])}

#build/%: test/%.hs
#		ghc -v --make -isrc -main-is $(shell sed -En 's/.*\/([^.]+)\.hs$$/\1/p' <<< $<) -o $@ $< -package titlecase{package titlecase True ([])}

recursive:
	$(call func,all)

clean:
	rm $(tmp)

echo:
	echo "This is haskell root dir"
	$(call func,$@)
		@#echo $(hss)
		@echo "This is haskell dir"
