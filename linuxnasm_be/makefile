#MDIR = $(shell find . -type d | awk '/\.\/[0-9][0-9]/ && !/.git/ && !/.cache/ && !/build/')
MDIR = $(shell find . -type d | awk '!/\.git/ && !/\.cache/ && !/\.\/build/ && /\.\/.+/')
define myfun
		for i in $(MDIR); do $(MAKE) -C $$i $1;done
		#for i in $(MDIR); do echo MAKE -C $$i $1;done
endef

.PHONY: all clean 

all:
		$(call myfun,$@)

clean:
		$(call myfun,$@)

echo:
		@echo $(MDIR)
