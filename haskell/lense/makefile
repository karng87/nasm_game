define func
	for i in $(shell find . -regextype posix-extended -regex '.*makefile$$' -and -not -regex '.*(\.git)/.*' | sed -En '/\.\/makefile/!{s/makefile//p}') ; do $(MAKE) -C $$i $1;done
endef

tmp := $(shell find . -type f -regextype posix-extended -regex './(build/.*)|./((test|src|app)/.*\.(hi|o|out|aux|log|toc|nav|snm|lot|lof)$$)')
pkg-db = /home/jkarng/.cabal/store/ghc-8.10.7/package.db
pkg-deps = titlecase
FLAG_i = -isrc
hss = $(notdir $(shell find app -name "*.hs"))
libs := $(notdir $(shell find -type f -regextype posix-extended -regex '.*(src)/.+\.hs$$'))
tests := $(notdir $(shell find -type f -regextype posix-extended -regex '.*(tests)/.+\.hs$$'))

.PHONEY: all run clean echo mkbin mklib mktests

all: $(patsubst %.hs, build/bin/%, $(hss)) $(patsubst %.hs, build/libs/%, $(libs)) $(patsubst %.hs, build/tests/bin/%, $(tests))

build/bin/%: app/%.hs
	$(MAKE) build/bin 
	ghc $(FLAG_i) -Wall  -main-is $(shell sed -En 's/.*\/([^.]+)\.hs$$/\1/p' <<< $<) -odir build -hidir build -o $@ $< -package-db $(pkg-db) -package $(pkg-deps)

build/libs/%: src/%.hs
	$(MAKE) build/libs
	ghc $(FLAG_i) -Wall -odir build/libs -hidir build/libs $< -package-db $(pkg-db) -package $(pkg-deps)

build/libs/%: src/Base/%.hs
	$(MAKE) build/libs
	ghc $(FLAG_i) -Wall -odir build/libs -hidir build/libs $< -package-db $(pkg-db) -package $(pkg-deps)

build/libs/%: src/M1/%.hs
	$(MAKE) build/libs
	ghc $(FLAG_i) -Wall -odir build/libs -hidir build/libs $< -package-db $(pkg-db) -package $(pkg-deps)

build/tests/bin/%: test/%.hs
	$(MAKE) build/tests/bin
	ghc $(FLAG_i) -Wall -odir build/tests -hidir build/tests -o $(patsubst %.hs,build/tests/bin/%,$(notdir $<)) $< -package-db $(pkg-db) -package $(pkg-deps)

build/bin:
	mkdir -p $@

build/libs:
	mkdir -p $@

build/tests/bin:
	mkdir -p $@

run: build/bin/Main
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
	@echo "This is lense in the haskell dir"
