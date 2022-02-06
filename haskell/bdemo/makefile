define func
	for i in $(shell find . -regextype posix-extended -regex '.*makefile$$' -and -not -regex '.*(\.git)/.*' | sed -En '/\.\/makefile/!{s/makefile//p}') ; do $(MAKE) -C $$i $1;done
endef

tmp := $(shell find . -type f -regextype posix-extended -regex '(./build/.*)|(./(app|src|test)/.*(hi|o|out|aux|log|toc|nav|snm|lot|lof)$$)' -and -not -regex '.*(\.git|pack|dist.*)/.*')


pkg-db = /home/jkarng/.cabal/store/ghc-8.10.7/package.db
pkg-deps = titlecase
FLAG_i = -i../ademo/src/

hss = $(notdir $(shell find app -name "*.hs"))
libs := $(notdir $(shell find -type f -regextype posix-extended -regex '.*(src)/.+\.hs$$'))
tests := $(notdir $(shell find -type f -regextype posix-extended -regex '.*(tests)/.+\.hs$$'))

.PHONEY: all run clean echo

all: $(patsubst %.hs, build/libs/%, $(libs)) $(patsubst %.hs, build/bin/%, $(hss)) $(patsubst %.hs, build/tests/bin/%, $(tests))

build/bin/%: app/%.hs
	$(MAKE) build/bin 
	ghc $(FLAG_i) -Wall -odir build -hidir build -main-is $(shell sed -En 's/.*\/([^.]+)\.hs$$/\1/p' <<< $<) -o $@ $< -package-db $(pkg-db) -package $(pkg-deps)

build/libs/%: src/%.hs
	$(MAKE) build/libs
	ghc $(FLAG_i) -Wall -odir build/libs -hidir build/libs $< -package-db $(pkg-db) -package $(pkg-deps)

build/libs/%: src/Base/%.hs
	$(MAKE) build/libs
	ghc $(FLAG_i) -Wall -odir build/libs -hidir build/libs $< -package-db $(pkg-db) -package $(pkg-deps)

build/libs/%: src/M1/%.hs
	$(MAKE) build/libs 
	ghc $(FLAG_i) -Wall -odir build/libs -hidir build/libs $< -package-db $(pkg-db) -package $(pkg-deps)

build/tests/bin/%: tests/%.hs
	$(MAKE) buil/tests/bin
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
	rm $(tmp)

echo:
	$(info info tmp: "$(tmp)")
	@echo "This is bdemo haskell dir"

