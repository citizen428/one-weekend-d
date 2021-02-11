# vim:noexpandtab

.PHONY: build clean

prog = owe

build:
	dub

clean:
	rm $(prog)
