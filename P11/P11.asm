bits 32

section .data
    format db "%d", 0    

section .tex
    global pBin8b, pBin16b, pBin32b, pBin64b
    extern printf, putchar
 
_start:
 ; funcion 1.
pBin8b:
    push ebp
    mov ebp, esp
    push esi
    push ebx
    
    mov ebx, 7
    movzx esi, byte [ebp+8]

.bucle:
    mov ecx, ebx
    mov eax, esi
    sar eax, cl
    and eax, 1
    
    push eax
    push dword format
    call printf
    add esp, 8
    
    dec ebx
    cmp ebx, -1
    jne .bucle
    
    push dword 10
    call putchar
    add esp, 4
    
    pop ebx
    pop esi
    mov esp, ebp
    pop ebp
    ret

; funcion 2.
pBin16b:
    push ebp
    mov ebp, esp
    push esi
    push ebx
    
    mov ebx, 15
    movzx esi, word [ebp+8]

.bucle:
    mov ecx, ebx
    mov eax, esi
    sar eax, cl
    and eax, 1
    
    push eax
    push dword format
    call printf
    add esp, 8
    
    dec ebx
    cmp ebx, -1
    jne .bucle
    
    push dword 10
    call putchar
    add esp, 4
    
    pop ebx
    pop esi
    mov esp, ebp
    pop ebp
    ret

; funcion 3.
pBin32b:
    push ebp
    mov ebp, esp
    push esi
    push ebx
    
    mov ebx, 31
    mov esi, [ebp+8]

.bucle:
    mov ecx, ebx
    mov eax, esi
    shr eax, cl
    and eax, 1
    
    push eax
    push dword format
    call printf
    add esp, 8
    
    dec ebx
    cmp ebx, -1
    jne .bucle
    
    push dword 10
    call putchar
    add esp, 4
    
    pop ebx
    pop esi
    mov esp, ebp
    pop ebp
    ret

; funcion 4.
pBin64b:
    push ebp
    mov ebp, esp
    push edi
    push esi
    push ebx
    
    mov esi, [ebp+8]
    mov edi, [ebp+12]
    mov ebx, 63

.bucle:
    mov edx, edi
    mov ecx, ebx
    mov eax, esi
    
    shrd eax, edx, cl
    shr edx, cl
    
    test cl, 32
    je .continuar
    mov eax, edx
    
.continuar:
    and eax, 1
    
    push dword 0
    push eax
    push dword format
    call printf
    add esp, 12
    
    dec ebx
    cmp ebx, -1
    jne .bucle
    
    push dword 10
    call putchar
    add esp, 4
    
    pop ebx
    pop esi
    pop edi
    mov esp, ebp
    pop ebp
    ret