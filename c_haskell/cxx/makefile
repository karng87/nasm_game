# Makefile
all: test

hsVersion = 9.2.1
#libdir = $(shell `ghc --print-libdir`)

hsI= /home/jkarng/.ghcup/ghc/9.2.1/lib/ghc-9.2.1/include
libdir=/home/jkarng/.ghcup/ghc/9.2.1/lib/ghc-9.2.1

test: test.cpp Foo.o
	g++ -no-pie \
  -I$(hsI) \
  -L$(libdir)/rts -lHSrts \
  -L$(libdir)/base-4.16.0.0 -lHSbase-4.16.0.0 \
  -L$(libdir)/ghc-prim-0.8.0 -lHSghc-prim-0.8.0 \
  -L$(libdir)/integer-gmp-1.1 -lHSinteger-gmp-1.1 \
  -fno-stack-protector \
  -Wall \
  -o $@ $^

Foo.o: Foo.hs
	ghc -c -no-hs-main Foo.hs

.PHONY: clean
clean: ; rm -rf test && rm -rf *.o && rm -rf *.hi && rm -rf *_stub.h
