; P8.asm - instrucciones de control de flujo
; Mario Ernesto Gamez Godoy
; Grupo 341

%include "../LIB/pc_iox.inc"

section .data
    ;menu
    menu_titulo db 10, "=== MENU PRINCIPAL ===", 10, 0
    menu_op1 db "1. Verificar si digito es menor que 5", 10, 0
    menu_op2 db "2. Identificar letra o numero", 10, 0
    menu_op3 db "3. Imprimir asteriscos (cantidad en CX)", 10, 0
    menu_op4 db "4. Capturar y mostrar 10 caracteres", 10, 0
    menu_op5 db "5. Salir", 10, 0
    menu_prompt db "Seleccione opcion: ", 0
    
    msg_a_prompt db 10, "Ingrese un digito (0-9): ", 0
    msg_a_menor db 10, "El caracter capturado es menor que '5'", 10, 0
    msg_a_mayor db 10, "El caracter capturado es mayor o igual a '5'", 10, 0
    msg_a_error db 10, "Error: El caracter no es un digito (0-9)", 10, 0
    
    msg_b_prompt db 10, "Ingrese un caracter (0-9 o A-Z): ", 0
    msg_b_numero db 10, "El caracter capturado es un numero", 10, 0
    msg_b_letra db 10, "El caracter capturado es una letra", 10, 0
    msg_b_error db 10, "Error: El caracter no esta en los rangos validos", 10, 0
    
    msg_c_prompt db 10, "Ingrese cantidad de asteriscos (0-10): ", 0
    msg_c_error db 10, "Error: Cantidad fuera de rango (0-10)", 10, 0
    
    msg_d_prompt db 10, "Ingrese 10 caracteres:", 10, 0
    msg_d_mostrar db 10, "Caracteres capturados:", 10, 0
    nueva_linea db 10, 0

section .bss
    opcion resb 1
    caracter resb 1
    arreglo resb 10

section .text
    global _start

_start:
menu_loop:
    mov edx, menu_titulo
    call puts
    mov edx, menu_op1
    call puts
    mov edx, menu_op2
    call puts
    mov edx, menu_op3
    call puts
    mov edx, menu_op4
    call puts
    mov edx, menu_op5
    call puts
    mov edx, menu_prompt
    call puts
    
    call getche
    mov [opcion], al
    
    mov al, 10
    call putchar
    
    mov al, [opcion]
    cmp al, '1'
    je opcion_1
    cmp al, '2'
    je opcion_2
    cmp al, '3'
    je opcion_3
    cmp al, '4'
    je opcion_4
    cmp al, '5'
    je salir
    jmp menu_loop

opcion_1:
    call programa_a
    jmp menu_loop

opcion_2:
    call programa_b
    jmp menu_loop

opcion_3:
    call programa_c
    jmp menu_loop

opcion_4:
    call programa_d
    jmp menu_loop

salir:
    mov eax, 1
    xor ebx, ebx
    int 0x80

;programa c: Verificar si dígito es menor que '5'
programa_a:
    push ebp
    mov ebp, esp
    push ebx
    push ecx
    push edx
    
    mov edx, msg_a_prompt
    call puts
    
    call getche
    mov [caracter], al
    
    push eax
    mov al, 10
    call putchar
    pop eax
    
    cmp al, '0'
    jb .fuera_rango
    cmp al, '9'
    ja .fuera_rango
    
    cmp al, '5'
    jb .es_menor
    
    mov edx, msg_a_mayor
    call puts
    jmp .fin
    
.es_menor:
    mov edx, msg_a_menor
    call puts
    jmp .fin
    
.fuera_rango:
    mov edx, msg_a_error
    call puts
    
.fin:
    pop edx
    pop ecx
    pop ebx
    pop ebp
    ret

;programa b: Identificar letra o numero
programa_b:
    push ebp
    mov ebp, esp
    push ebx
    push ecx
    push edx
    
    mov edx, msg_b_prompt
    call puts
    
    call getche
    mov [caracter], al
    
    push eax
    mov al, 10
    call putchar
    pop eax
    
    cmp al, '0'
    jb .verificar_letra
    cmp al, '9'
    ja .verificar_letra
    
    mov edx, msg_b_numero
    call puts
    jmp .fin
    
.verificar_letra:
    cmp al, 'A'
    jb .fuera_rango
    cmp al, 'Z'
    ja .fuera_rango
    
    mov edx, msg_b_letra
    call puts
    jmp .fin
    
.fuera_rango:
    mov edx, msg_b_error
    call puts
    
.fin:
    pop edx
    pop ecx
    pop ebx
    pop ebp
    ret

;programa C: Imprimir asteriscos
programa_c:
    push ebp
    mov ebp, esp
    push ebx
    push ecx
    push edx
    push esi
    
    mov edx, msg_c_prompt
    call puts
    
    ; Leer un dígito
    call getche
    sub al, '0'
    movzx cx, al
    mov si, cx
    
    call getche
    cmp al, 10
    je .validar
    cmp al, 13
    je .validar
    
    sub al, '0'
    movzx ax, al
    imul si, 10
    add si, ax
    mov cx, si
    
    call getche
    
.validar:
    push eax
    mov al, 10
    call putchar
    pop eax
    
    cmp cx, 10          
    ja .error_rango
    
    test cx, cx
    jz .nueva_linea_final
    
    mov bx, 1           
    
.filas:
    mov si, bx          
    
.columna:
    mov al, '*'
    call putchar
    dec si
    jnz .columna
    
    mov al, 10
    call putchar
    
    inc bx
    cmp bx, cx
    jle .filas
    
.nueva_linea_final:
    mov al, 10
    call putchar
    jmp .fin
    
.error_rango:
    mov edx, msg_c_error
    call puts
    
.fin:
    pop esi
    pop edx
    pop ecx
    pop ebx
    pop ebp
    ret

;programa D: Capturar y mostrar 10 caracteres en arreglo
programa_d:
    push ebp
    mov ebp, esp
    push ebx
    push ecx
    push edx
    push esi
    push edi
    
    mov edx, msg_d_prompt
    call puts
    
    mov edi, arreglo
    mov ecx, 10
    
.capturar_loop:
    push ecx
    call getche
    mov [edi], al
    inc edi
    pop ecx
    loop .capturar_loop
    
    mov al, 10
    call putchar
    
    mov edx, msg_d_mostrar
    call puts
    
    mov esi, arreglo
    mov ecx, 10
    
.mostrar_loop:
    push ecx
    mov al, [esi]
    call putchar
    mov al, 10
    call putchar
    inc esi
    pop ecx
    loop .mostrar_loop
    
    pop edi
    pop esi
    pop edx
    pop ecx
    pop ebx
    pop ebp
    ret