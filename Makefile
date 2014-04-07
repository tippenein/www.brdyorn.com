all:
	ghc --make site.hs
	./site build
	./site server

clean:
	rm site.o
	rm site.hi
	./site clean
