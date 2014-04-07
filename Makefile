all:
	ghc --make site.hs
	./site build

clean:
	rm *.o
	rm *.hi
	./site clean
