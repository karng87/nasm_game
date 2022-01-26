SHELL := /bin/bash
define func
  for i in $(shell find . -regextype posix-extended -regex '.*makefile$$' -and -not -regex '.*(\.git)/.*' | sed -En '/\.\/makefile/!{s/makefile//p}') ; do $(MAKE) -C $$i $1;done
endef

tmp := $(shell find . -regextype posix-extended -regex '.*(bin/.*|tests/bin/.*|(\.(hi|o|out|aux|log|toc|nav|snm|lot|lof)$$))' -and -not -regex '.*(\.git|pack)/.*')

hss := $(notdir $(shell find -type f -regextype posix-extended -regex '.*/(app)/.+\.hs$$'))
OBJS := $(notdir $(shell find -type f -regextype posix-extended -regex '.*/(src)/.+\.hs$$'))
tss := $(notdir $(shell find -type f -regextype posix-extended -regex '.*/(tests)/.+\.hs$$'))
pkg-db = /home/jkarng/.cabal/store/ghc-8.10.7/package.db
pkg-deps = titlecase
FLAG_i = -isrc 
#FLAG_i = -isrc -ilib/titlecase-1.0.1/src 
#GHC_PACKAGE_PATH = /home/jkarng/.cabal/store/ghc-8.10.7/package.db
.PHONEY: all run clean echo test bin

all: $(patsubst %.hs, bin/%, $(hss)) $(patsubst %.hs, lib/%.hi, $(OBJS)) $(patsubst %.hs, lib/%.o, $(OBJS))

bin/%: app/%.hs
	$(MAKE) mkbin
	ghc -v --make $(FLAG_i) -Wall -main-is $(shell sed -En 's/.*\/([^.]+)\.hs$$/\1/p' <<< $<) -o $@ $< -package-db $(pkg-db) -package $(pkg-deps)

lib/%.o: src/%.hs
	$(MAKE) mklib
	ghc -v --make $(FLAG_i) -Wall -odir $@ -hidir $@ $< -package-db $(pkg-db) -package $(pkg-deps) 


test: test/Test.hs
	ghc -v --make -isrc -iapp -Wall $< -o $@ -package-db $(pkg-db) -package $(pkg-deps) 


mkbin:
	mkdir -p bin

mklib:
	mkdir -p lib

run: bin/Main
ifdef args 
	./$< $(args)
else 
	./$< lee
endif

clean:
ifneq ('', tmp)
	rm $(tmp)
endif

echo:
	@echo $(tmp)
	@echo "This is haskell demo dir"
