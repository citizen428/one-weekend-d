# vim:noexpandtab

.PHONY: build clean

prog = rtow

build:
	dub build

clean:
	rm $(prog)
