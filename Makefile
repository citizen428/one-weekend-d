# vim:noexpandtab

.PHONY: build clean

prog = owe

build:
	dub build

clean:
	rm $(prog)
