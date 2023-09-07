
.PHONY: all

hello:
	nasm -fmacho64 test/hello.asm -o bin/hello.o
	ld -macosx_version_min 10.7.0 -no_pie bin/hello.o -o bin/hello
	rm -f bin/hello.o