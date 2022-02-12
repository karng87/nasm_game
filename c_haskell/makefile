tmp := $(shell find . -type f -regextype posix-extended -regex '(./build/.*)|(./(app|src|test)/.*(hi|o|out|aux|log|toc|nav|snm|lot|lof)$$)' -and -not -regex '.*(\.git|pack|dist.*)/.*')
pkg-db = /home/jkarng/.cabal/store/ghc-8.10.7/package.db
pkg-deps = time
FLAG_i = -isrc -threaded -rtsopts -with-rtsopts=-N
HSrts= $(shell sed -En 's#(.*)/lib.*a$$#\1#p' <<< `find ~/.ghcup -regextype posix-extended -regex '.*rts\.a'`)
HSghc= $(shell sed -En 's#(.*)/lib.*a$$#\1#p' <<< `find ~/.ghcup -regextype posix-extended -regex '.*libHSghc[-0-9.]*\.a'`)
HsFFI = $(patsubst %/HsFFI.h,%,$(shell find ~/.ghcup -type f -name "HsFFI.h"))
CC=gcc
CCFLAG = -L$(HSghc) -L$(HSrts) -L/build/libs -lHSrts -lHSghc -I$(HsFFI) -I/build/libs 
c_SRCS := $(notdir $(shell find src -name "*.c"))
hs_SRCS = $(notdir $(shell find src/hs -name "*.hs"))

.PHONEY: all run clean echo

all: $(patsubst %.hs,build/libs/%_stub.h,$(hs_SRCS)) $(patsubst %.c,build/bin/%,$(c_SRCS))

build/bin/%: src/%.c
	$(MAKE) build/bin
	#ghc -outputdir build/libs -no-hs-main -I./build/libs -optc-O ./build/libs/$(patsubst %.hs,%,$(hs_SRCS)) -o $@ $< 
	$(CC) $(CCFLAG) -o $@ $<

build/libs/%_stub.h: src/hs/%.hs
	$(MAKE) build/libs
	ghc -c -O -outputdir build/libs $<
	#mv $(patsubst %.hs,%_stub.h,$<) build/libs 
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
	@echo $(HSghc)
	@echo "This is the c_haskell "

