TOPDIR = .

all: libs test

libs:
	cd $(TOPDIR)/build
	make
	cd ..

test:
	cd $(TOPDIR)/src
	make runtest
	cd ..

clean:
	cd $(TOPDIR)/build
	make clean
	cd $(TOPDIR)/src
	make clean
	cd ..

win: winlibs wintest

winlibs:
	cd $(TOPDIR)\build
	nmake -f Makefile.win
	cd ..

wintest:
	cd $(TOPDIR)\src
	nmake -f Makefile.win runtest
	cd ..

winclean:
	cd $(TOPDIR)\build
	nmake -f Makefile.win clean
	cd $(TOPDIR)\src
	nmake -f Makefile.win clean
	cd ..

