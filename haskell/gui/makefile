define func
	for i in $(shell find . -regextype posix-extended -regex '.*makefile$$' -and -not -regex '.*(\.git)/.*' | sed -En '/\.\/makefile/!{s/makefile//p}') ; do $(MAKE) -C $$i $1;done
endef

tmp := $(shell find . -type f -regextype posix-extended -regex '(./build/.*)|(./(app|src|test)/.*(hi|o|out|aux|log|toc|nav|snm|lot|lof)$$)' -and -not -regex '.*(\.git|pack|dist.*)/.*')
pkg-db = /home/jkarng/.cabal/store/ghc-8.10.7/package.db
pkg-deps = GLFW -package gloss
FLAG_i = -isrc -threaded -rtsopts -with-rtsopts=-N
app_SRCS = $(notdir $(shell find app -name "*.hs"))
module_SRCS := $(notdir $(shell find -type f -regextype posix-extended -regex '.*(src)/.+\.hs$$'))
test_SRCS := $(notdir $(shell find -type f -regextype posix-extended -regex '.*(tests)/.+\.hs$$'))

.PHONEY: all run clean echo

all: $(patsubst %.hs, build/libs/%, $(module_SRCS)) $(patsubst %.hs, build/bin/%, $(app_SRCS)) $(patsubst %.hs, build/tests/%, $(test_SRCS))

build/bin/%: app/%.hs
	$(MAKE) mkdirbin
	ghc $(FLAG_i) -Wall  -odir build -hidir build -main-is $(shell sed -En 's/.*\/([^.]+)\.hs$$/\1/p' <<< $<) -o $@ $< -package-db $(pkg-db) -package $(pkg-deps)

build/libs/%: src/%.hs
	$(MAKE) mkdirlibs
	ghc $(FLAG_i) -Wall -odir build/libs -hidir build/libs $< -package-db $(pkg-db) -package $(pkg-deps)

build/libs/%: src/Base/%.hs
	$(MAKE) mkdirlibs
	ghc $(FLAG_i) -Wall -odir build/libs -hidir build/libs $< -package-db $(pkg-db) -package $(pkg-deps)

build/libs/%: src/M1/%.hs
	$(MAKE) mkdirlibs
	ghc $(FLAG_i) -Wall -odir build/libs -hidir build/libs $< -package-db $(pkg-db) -package $(pkg-deps)

build/tests/%: tests/%.hs
	$(MAKE) mkdirtests
	ghc $(FLAG_i) -Wall -odir build/tests -hidir build/tests -o $(patsubst %.hs,build/tests/bin/%,$(notdir $<)) $< -package-db $(pkg-db) -package $(pkg-deps)

mkdirbin:
	mkdir -p build/bin

mkdirlibs:
	mkdir -p build/libs

mkdirtests:
	mkdir -p build/tests

run: build/bin/Main
ifdef args 
	./$< $(args)
else
	./$<
endif

clean:
	rm $(tmp)

echo:
	@echo $(tmp)
	@echo "This is the haskell "

