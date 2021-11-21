OUT = test.out

all: ${OUT} 
%.out: %.cpp
	g++ -DWITHOUT_NUMPY  -I /usr/include/python3.9/ -lpython3.9 $< -o $@ 
