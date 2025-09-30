%include "../LIB/pc_io.inc"

section	.text
	global _start
	
_start:                   
    ; Mostrar cadena original
	mov edx, msg_original
	call puts
	
	; Modificar 't' a '%' 
	mov ebx, msg
    mov edi, 4          ; índice (4*4 = 16)
    mov byte [ebx + edi*4 + 3], '%'   ; 16 + 3 = 19 → posición de 't'
	
	; Mostrar cadena modificada
	mov edx, msg
	call puts

	mov	eax, 1	    	; sys_exit
	int	0x80        	

section	.data
msg_original db  'abcdefghijklmnopqrstuvwxyz0123456789',0xa,0 
msg db  'abcdefghijklmnopqrstuvwxyz0123456789',0xa,0 