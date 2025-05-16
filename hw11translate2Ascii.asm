; hw11translate2Ascii
; Joshua Poston
; j248@umbc.edu
; 5/15/2025
; To assemble: nasm -f elf32 -g -F dwarf -o hw11translate2Ascii.o hw11translate2Ascii.asm
; To link: ld -m elf_i386 -o hw11translate2Ascii hw11translate2Ascii.o
; To run: ./hw11translate2Ascii

section .data 
inputBuf: 
    db 0x83, 0x6A, 0x88, 0xDE, 0x9A, 0xC3, 0x54, 0x9A
inputLen equ $ - inputBuf

hexChars: 
    db '0123456789ABCDEF'

newline:
    db 0x0A

section .bss
outputBuf: 
    resb 80

section .text
global _start

_start:
    mov esi, inputBuf
    mov edi, outputBuf
    mov ecx, inputLen ; pointers/num bytes for input

conversion: ; Used to convert the input
    cmp ecx, 0
    je output

    mov al, [esi]
    inc esi

    mov ah, al

    shr al, 4
    and al, 0x0F
    movzx eax, al
    mov bl, [hexChars + eax]
    mov [edi], bl
    inc edi

    mov al, ah
    and al, 0x0F
    movzx eax, al
    mov bl, [hexChars + eax]
    mov [edi], bl
    inc edi

    dec ecx
    cmp ecx, 0
    je final_byte
    mov byte [edi], ' '
    inc edi

final_byte: ; Ensures that a space isn't added at the end
    jmp conversion

output: ; Outputs conversion
    mov byte [edi], 0x0A
    inc edi

    mov edx, edi
    sub edx, outputBuf

    mov eax, 4
    mov ebx, 1
    mov ecx, outputBuf
    int 0x80 ; Writes to output

    mov eax, 1
    xor ebx, ebx
    int 0x80 ; Exit