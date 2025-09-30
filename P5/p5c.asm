%include "../LIB/pc_io.inc"

section	.text
	global _start
	
_start:                   
    ; Mostrar cadena original
	mov edx, msg_original
	call puts
	
	; Modificar '0' a '@' 
	mov ebx, msg
	mov byte [ebx + 26], '@'  ; posición del '0'
	
	; Mostrar cadena modificada
	mov edx, msg
	call puts

	mov	eax, 1	    	; sys_exit
	int	0x80        	

section	.data
msg_original db  'abcdefghijklmnopqrstuvwxyz0123456789',0xa,0 
msg db  'abcdefghijklmnopqrstuvwxyz0123456789',0xa,0 