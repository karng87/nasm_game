.PHONEY: all clean
all: build/Main
	@echo ""
	@echo ""
	@build/Main
	@echo ""
	@echo ""

build/Main: Main.hs
	ghc $< -o $@

clean:
	#rm $(DIR)/$(OBJ).aux $(DIR)/$(OBJ).out $(DIR)/$(OBJ).log $(DIR)/$(OBJ).pdf
	rm *.{hi,o} Ga/*.{hi,o} build/*
