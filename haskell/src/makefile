all: build/Main
	./build/Main

build/Main: Main.hs
	ghc $< -o $@

clean:
	#rm $(DIR)/$(OBJ).aux $(DIR)/$(OBJ).out $(DIR)/$(OBJ).log $(DIR)/$(OBJ).pdf
	rm build/*
