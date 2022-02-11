tmp := $(shell find . -type f -regextype posix-extended -regex '(./build/.*)|(./(app|src|test)/.*(hi|o|out|aux|log|toc|nav|snm|lot|lof)$$)' -and -not -regex '.*(\.git|pack|dist.*)/.*')
pkg-db = /home/jkarng/.cabal/store/ghc-8.10.7/package.db
pkg-deps = time
FLAG_i = -isrc -threaded -rtsopts -with-rtsopts=-N
CCFLAG = -Isrc -lbuild/libs

c_SRCS = $(notdir $(shell find src -name "*.c"))
hs_SRCS := $(notdir $(shell find -type f -regextype posix-extended -regex '.*(src/hs)/.+\.hs$$'))

.PHONEY: all run clean echo

all: $(patsubst %.hs,build/libs/%_stub.h,$(hs_SRCS)) $(patsubst %.c,build/bin/%,$(c_SRCS))

build/bin/%: src/%.c
	$(MAKE) build/bin
	ghc --make -no-hs-main -Ibuild/libs -optc-O build/libs/$(patsubst %.hs,%,$(hs_SRCS)) -o $@ -odir build/libs $< 

build/libs/%_stub.h: src/hs/%.hs
	$(MAKE) build/libs
	ghc -c -O -hidir build/libs -odir build/libs $<
	mv $(patsubst %.hs,%_stub.h,$<) build/libs 
	cp $< build/libs 

build/libs:
	mkdir -p $@

build/bin:
	mkdir -p $@

run: $(patsubst %.c,build/bin/%,$(c_SRCS))
ifdef args 
	./$(word 1,$^) (args)
else
	./$(word 1,$^)
endif

clean:
	rm $(tmp)

echo:
	@echo $(tmp)
	@echo "This is the c_haskell "

