BITS 16
ORG 0x7C00

xor ax, ax
mov ds, ax
lea si, [rel HelloWorld]
cld

TIMES 0x28 - ($ - $$) nop

LoadChar:
lodsb

CheckNull:
cmp al, 0
je CheckNull

mov bx, 0x7
mov ah, 0xE
int 0x10
jmp LoadChar

HelloWorld:
DB "Hello, World!", 0

DB 0x1FE - ($ - $$) DUP 0
DW 0xAA55
