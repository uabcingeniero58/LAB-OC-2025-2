section .data
    format db "%d", 0    

section .text
    global pBin8b, pBin16b, pBin32b, pBin64b                
    extern printf, putchar

   pBin8b:
    push ebp
    mov ebp, esp
    push eax
    push ebx
    push ecx
    
    mov ebx, [ebp+8]
    and ebx, 0xFF
    mov cx, 8
    mov edx, 0
    
.next:
    mov al, '0'
    inc edx
    cmp edx, 4
    jne .cont
    push eax
    mov al, '-'
    call putchar
    pop eax
    mov edx, 0
    
.cont:
    rol ebx, 1
    jnc .zero
    inc al
    
.zero:
    call putchar
    loop .next
    
    push eax
    mov al, 10
    call putchar
    pop eax
    
    pop ecx
    pop ebx
    pop eax
    pop ebp
    ret

   pBin16b:

   pBin32b:

   pBin64b: