define func
	for i in $(shell find . -regextype posix-extended -regex '.*makefile$$' -and -not -regex '.*(\.git)/.*' | sed -En '/\.\/makefile/!{s/makefile//p}') ; do $(MAKE) -C $$i $1;done
endef

tmp := $(shell find . -type f -regextype posix-extended -regex '.*(build/.*|(\.(hi|o|out|aux|log|toc|nav|snm|lot|lof)$$))' -and -not -regex '.*(\.git|pack)/.*')

pkg-db = /home/jkarng/.cabal/store/ghc-8.10.7/package.db
pkg-deps = titlecase
FLAG_i = -i../ademo/src/

hss = $(notdir $(shell find app -name "*.hs"))
libs := $(notdir $(shell find -type f -regextype posix-extended -regex '.*(src)/.+\.hs$$'))
tests := $(notdir $(shell find -type f -regextype posix-extended -regex '.*(tests)/.+\.hs$$'))

.PHONEY: all run clean echo mkbin mklib mktests

all: $(patsubst %.hs, build/libs/%, $(libs)) $(patsubst %.hs, build/bin/%, $(hss)) $(patsubst %.hs, build/tests/bin/%, $(tests))

build/bin/%: app/%.hs
	$(MAKE) mkbin
	ghc -v $(FLAG_i) -Wall -odir build -hidir build -main-is $(shell sed -En 's/.*\/([^.]+)\.hs$$/\1/p' <<< $<) -o $@ $< -package-db $(pkg-db) -package $(pkg-deps)

build/libs/%: src/%.hs
	$(MAKE) mklib
	ghc -v $(FLAG_i) -Wall -odir build/libs -hidir build/libs $< -package-db $(pkg-db) -package $(pkg-deps)

build/libs/%: src/Base/%.hs
	$(MAKE) mklib
	ghc -v $(FLAG_i) -Wall -odir build/libs -hidir build/libs $< -package-db $(pkg-db) -package $(pkg-deps)

build/libs/%: src/M1/%.hs
	$(MAKE) mklib
	ghc -v $(FLAG_i) -Wall -odir build/libs -hidir build/libs $< -package-db $(pkg-db) -package $(pkg-deps)

build/tests/bin/%: tests/%.hs
	$(MAKE) mktests
	ghc -v $(FLAG_i) -Wall -odir build/tests -hidir build/tests -o $(patsubst %.hs,build/tests/bin/%,$(notdir $<)) $< -package-db $(pkg-db) -package $(pkg-deps)

mkbin:
	mkdir -p build/bin

mklib:
	mkdir -p build/libs

mktests:
	mkdir -p build/tests/bin

run: build/bin/Main
ifdef args 
	./$< $(args)
else
	./$< lee
endif

clean:
ifneq ($(tmp),"")
	rm $(tmp)
else
	$(info $(tmp))
endif

echo:
	$(info info tmp: "$(tmp)")
	@echo "This is haskell demo dir"

