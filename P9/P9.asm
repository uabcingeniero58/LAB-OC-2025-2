%include "../LIB/pc_iox.inc"

section .data
    N equ 10

    msg_titulo db "=== OPERACIONES CON VECTORES ===", 10, 13, 0
    msg_prompt1 db "Ingrese valor (0-9) para Vector 1, posicion ", 0
    msg_prompt2 db "Ingrese valor (0-9) para Vector 2, posicion ", 0
    msg_error db "Error: Solo valores de 0 a 9", 10, 13, 0
    msg_dos_puntos db ": ", 0

    msg_vector1 db 10, 13, "Vector 1: ", 0
    msg_vector2 db "Vector 2: ", 0
    msg_suma db "Suma:     ", 0
    msg_producto db "Producto Escalar: 0x", 0

    prefijo_hex db "0x", 0
    espacio db "  ", 0
    nuevaLinea db 10, 13, 0

    vector1 times N db 0
    vector2 times N db 0

section .bss
    producto_escalar resd 1

section .text
    global _start

_start:
    call clrscr
    mov edx, msg_titulo
    call puts

    mov edx, msg_vector1
    call puts
    mov ebx, vector1
    mov ecx, N
    mov esi, 1
    call capturar_vector

    mov edx, nuevaLinea
    call puts

    mov edx, msg_vector2
    call puts
    mov ebx, vector2
    mov ecx, N
    mov esi, 2
    call capturar_vector

    mov edx, nuevaLinea
    call puts
    mov edx, msg_vector1
    call puts
    mov ebx, vector1
    mov ecx, N
    call desplegar_vector_hex

    mov edx, nuevaLinea
    call puts

    mov edx, msg_vector2
    call puts
    mov ebx, vector2
    mov ecx, N
    call desplegar_vector_hex
    
    mov edx, nuevaLinea
    call puts

    mov ebx, vector1
    mov edx, vector2
    mov ecx, N
    call calcular_producto_escalar

    mov edx, nuevaLinea
    call puts

    mov ebx, vector1
    mov edx, vector2
    mov ecx, N
    call sumar_vectores

    mov edx, msg_suma
    call puts
    mov ebx, vector1
    mov ecx, N
    call desplegar_vector_hex

     mov edx, nuevaLinea
    call puts

    mov edx, msg_producto
    call puts
    mov eax, [producto_escalar]
    call pHex_w
    mov edx, nuevaLinea
    call puts

    mov eax, 1
    xor ebx, ebx
    int 0x80

capturar_vector:
    push eax
    push edx
    push edi

    xor edi, edi

    mov edx, nuevaLinea
    call puts

.capturar_loop:
    cmp edi, ecx
    jge .fin_captura

    cmp esi, 1
    je .prompt_v1
    mov edx, msg_prompt2
    jmp .mostrar_prompt

.prompt_v1:
    mov edx, msg_prompt1

.mostrar_prompt:
    call puts

    mov eax, edi
    inc eax
    
    cmp eax, 10
    jne .mostrar_digito_simple
    
    push eax
    mov al, '1'
    call putchar
    mov al, '0'
    call putchar
    pop eax
    jmp .continuar_prompt
    
.mostrar_digito_simple:
    add al, '0'
    call putchar

.continuar_prompt:
    mov edx, msg_dos_puntos
    call puts

    call getche

    cmp al, '0'
    jl .valor_invalido
    cmp al, '9'
    jg .valor_invalido

    sub al, '0'
    mov [ebx + edi], al
    
    push edx
    mov edx, nuevaLinea
    call puts
    pop edx
    
    inc edi
    jmp .capturar_loop

.valor_invalido:
    push edx
    mov edx, nuevaLinea
    call puts
    mov edx, msg_error
    call puts
    pop edx
    jmp .capturar_loop

.fin_captura:
    pop edi
    pop edx
    pop eax
    ret

desplegar_vector_hex:
    push eax
    push edx
    push esi

    xor esi, esi

.desplegar_loop:
    cmp esi, ecx
    jge .fin_desplegar

    mov edx, prefijo_hex
    call puts

    mov al, [ebx + esi]
    call pHex_b

    mov edx, espacio
    call puts

    inc esi
    jmp .desplegar_loop

.fin_desplegar:
    mov edx, nuevaLinea
    call puts

    pop esi
    pop edx
    pop eax
    ret

sumar_vectores:
    push eax
    push esi

    xor esi, esi

.sumar_loop:
    cmp esi, ecx
    jge .fin_suma

    mov al, [ebx + esi]
    add al, [edx + esi]
    mov [ebx + esi], al

    inc esi
    jmp .sumar_loop

.fin_suma:
    pop esi
    pop eax
    ret

calcular_producto_escalar:
    push ebx
    push ecx
    push edx
    push esi
    push edi
    push ebp

    mov ebp, edx        ; puntero a vector2
    xor edi, edi        ; acumulador
    xor esi, esi        ; índice

.producto_loop:
    cmp esi, ecx
    jge .fin_producto

    movzx eax, byte [ebx + esi]  ; Vector 1[i]
    movzx edx, byte [ebp + esi]  ; Vector 2[i]
    mul dl                       
    
    add edi, eax

    inc esi
    jmp .producto_loop

.fin_producto:
    mov [producto_escalar], edi
    
    pop ebp
    pop edi
    pop esi
    pop edx
    pop ecx
    pop ebx
    ret