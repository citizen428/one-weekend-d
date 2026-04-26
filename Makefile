# vim:noexpandtab

.PHONY: run
run:
	dub run

.PHONY: build
build:
	dub build -c=application -b release

.PHONY: test
test:
	dub test

.PHONY: clean
clean:
	rm -f bin/*

.PHONY: optipng
optipng:
	optipng -o9 -strip all images/*
