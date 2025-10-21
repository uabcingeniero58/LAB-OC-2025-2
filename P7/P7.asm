%include "../LIB/pc_iox.inc"

extern pBin_b, pBin_w, pBin_dw, pBin_n 

section .data
    newline db 10, 0   

section .text
    global _start
     
_start:

; a) EAX = 0x22446688 → 0x82244668
    mov eax , 0x22446688
    ror eax, 4
    call pBin_dw
    mov edx, newline
    call puts

; b) CX = 0x3F48  → 0xFA40 (imposible con solo corrimientos ocupa mas instrucciones)
    mov cx,0x3F48
    shl cx,4
    movzx eax,cx
    call pBin_w
    mov edx, newline
    call puts

; c) ESI = 0x20D685F3 XOR 0x40022021
    mov esi, 0x20D685F3
    xor esi, 0x40022021
    mov eax, esi
    call pBin_dw
    mov edx, newline
    call puts

; d) Guardar ESI en la pila
    push esi

; e) CH = 0xA7 OR 0x48
    mov ch, 0xA7
    or ch, 0x48
    movzx eax,ch
    call pBin_b
    mov edx, newline
    call puts

; f) BP = 0x67DA AND 0xDFA9
    mov bp,0x67DA
    and bp,0xDFA9
    movzx eax,bp
    call pBin_w
    mov edx, newline
    call puts

; g) Dividir BP entre 8 
    shr bp,3
    movzx eax,bp
    call pBin_w
    mov edx, newline
    call puts

; h) EBX entre 32 
    mov ebx,0x12345678   
    shr ebx,5
    mov eax,ebx
    call pBin_dw
    mov edx, newline
    call puts

; i) CX * 8 
    mov cx,0x1234
    shl cx,3
    movzx eax,cx
    call pBin_w
    mov edx, newline
    call puts

; j) Sacar valor de la pila y guardarlo en ESI
    pop eax
    mov esi,eax
    mov eax,esi
    call pBin_dw
    mov edx, newline
    call puts

; k) Multiplicar ESI por 10 (ESI*8 + ESI*2)
    mov eax,esi
    shl eax,3        ; ESI*8
    mov edx,esi
    shl edx,1        ; ESI*2
    add eax,edx      ; ESI*10
    call pBin_dw
    mov edx, newline
    call puts

; salir
    mov eax,1
    xor ebx,ebx
    int 0x80