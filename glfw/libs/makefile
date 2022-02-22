all: test
add.o: add.c
	gcc -fPIC -c add.c
libadd.so: add.o
	gcc -shared -o libadd.so add.o

test.o: test.c
	gcc -c -o test.o test.c

test: libadd.so test.o
	# gcc -o test test.o -L . -ladd -Wl,-rpath=.
	gcc -o test test.o -L . -ladd

run: test
	LD_LIBRARY_PATH+=. ./test

clean: 
	rm *.out *.o *.so test

