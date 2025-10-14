%include "../LIB/pc_iox.inc"

; practica P6 : Instrucciones de transferencia de datos	y aritméticas.
; Matricula: 2203421 

section .data
    N          dw 0
    matricula  dd 0x02203421
    residuo    db 0       
    FF         db 0xFF
    nl         db 10,0

section .text
    global _start

_start:
    call clrscr

    ; a) EBX = 0x5C4B2A60 + matricula
    mov ebx, 0x5C4B2A60
    add ebx, [matricula]
    mov eax, ebx
    call pHex_dw
    mov edx, nl
    call puts

    ; b) Push BX 
    push bx
    xor eax, eax
    mov ax, bx
    call pHex_w
    mov edx, nl
    call puts

    ; c) N = BL * 8 
    xor eax, eax
    mov al, bl
    movzx ax, al
    shl ax, 3
    mov [N], ax
    mov ax, [N]
    call pHex_w
    mov edx, nl
    call puts

    ; d) N++ 
    inc word [N]
    mov ax, [N]
    call pHex_w
    mov edx, nl
    call puts

    ; e) BX / 0xFF -> AL=cociente, AH=residuo
    mov ax, bx
    mov cl, [FF]
    div cl                ; AL = cociente, AH = residuo

    ; guardar residuo en valor temporal
    mov [residuo], ah

    ; imprimir cociente
    movzx eax, al
    call pHex_b
    mov edx, nl
    call puts

    ; imprimir residuo
    movzx eax, byte [residuo]
    call pHex_b
    mov edx, nl
    call puts

    ; f) N = N + residuo; DEC N; imprimir N y  imprimir EFLAGS 
    mov ax, [N]
    movzx dx, byte [residuo]
    add ax, dx
    mov [N], ax
    mov ax, [N]
    call pHex_w
    mov edx, nl
    call puts

    dec word [N]
    mov ax, [N]
    call pHex_w
    mov edx, nl
    call puts

    pushfd
    pop eax
    call pHex_dw
    mov edx, nl
    call puts

    ; g) Pop 16 bits de la pila
    mov ax, dx
    call pHex_w
    mov edx, nl
    call puts

    ; salir
    mov eax, 1
    xor ebx, ebx
    int 0x80