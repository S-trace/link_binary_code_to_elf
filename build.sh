#!/usr/bin/env sh
objcopy -I binary -O elf64-x86-64 -B i386 code.bin code.o
objcopy -I binary -O elf64-x86-64 -B i386 data.bin data.o
gcc -c test.c -T linker_script.ld -no-pie -Fno-pie -static -g
gcc -o test code.o data.o test.o -T linker_script.ld -no-pie -Fno-pie -g
rm code.o data.o test.o
