# vim:noexpandtab

.PHONY: build clean run

dmd_opts = -de -w -unittest
prog = owe
main = source/$(prog).d

run:
	rdmd $(dmd_opts) $(main)

build:
	dmd $(dmd_opts) $(main)

clean:
	rm $(prog) $(prog).o
