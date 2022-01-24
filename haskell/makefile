SHELL := /bin/bash
define func
  for i in $(shell find . -regextype posix-extended -regex '.*makefile$$' -and -not -regex '.*(\.git)/.*' | sed -En '/\.\/makefile/!{s/makefile//p}') ; do $(MAKE) -C $$i $1;done
endef

texs := $(notdir $(shell find -maxdepth 1 -name "*.tex"))

hss := $(notdir $(shell find -regextype posix-extended -regex '.*/(app)/.+\.hs$$'))
#hss := $(notdir $(shell find -regextype posix-extended -regex '.*/(app|test)/.+\.hs$$'))
pkg-db = /home/jkarng/.cabal/store/ghc-8.10.7/package.db
pkg-deps = titlecase


.PHONEY: all run clean echo

all: mkdir/build $(patsubst %.hs, build/%, $(hss)) $(patsubst %.tex, build/%.pdf, $(texs))

build/%.pdf: %.tex
		@pdflatex --jobname=$(patsubst %.tex,build/%, $<) $<

pdf :$(patsubst %.tex, build/%.pdf, $(texs))
		@nohup zathura $< &

build/%: app/%.hs
	ghc -v --make -isrc -main-is $(shell sed -En 's/.*\/([^.]+)\.hs$$/\1/p' <<< $<) -o $@ $< -package-db $(pkg-db) -package $(pkg-deps) 

#build/%: test/%.hs
#		ghc -v --make -isrc -main-is $(shell sed -En 's/.*\/([^.]+)\.hs$$/\1/p' <<< $<) -o $@ $< -package titlecase

mkdir/build:
	mkdir -p build


run: build/Main
ifdef args 
	./$< $(args)
else 
	./$< lee
endif

clean:
		rm $(shell find . -regextype posix-extended -regex '.*\.(hi|o|out|aux|log|toc|nav|snm|lot|lof)$$' -and -not -regex '.*(\.git|pack)/.*')

echo:
		@#echo $(hss)
		@echo "This is haskell dir"
