# CMSC313HW11
Joshua Poston CMSC 313 0830 M/W

Program will take number of bytes of data as input and will print it to screen as output

To assemble: nasm -f elf32 -g -F dwarf -o hw11translate2Ascii.o hw11translate2Ascii.asm
To link: ld -m elf_i386 -o hw11translate2Ascii hw11translate2Ascii.o
To run: ./hw11translate2Ascii
