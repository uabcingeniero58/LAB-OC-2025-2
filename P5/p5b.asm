%include "../LIB/pc_io.inc"

section	.text
	global _start
	
_start:                   
    ; Mostrar cadena original
	mov edx, msg_original
	call puts
	
	; Modificar 'x' a 'X' 
	mov esi, msg + 23    ; posición de la 'x'
	mov byte [esi], 'X'
	
	; Mostrar cadena modificada
	mov edx, msg
	call puts

	mov	eax, 1	    	; sys_exit
	int	0x80        	

section	.data
msg_original db  'abcdefghijklmnopqrstuvwxyz0123456789',0xa,0 
msg db  'abcdefghijklmnopqrstuvwxyz0123456789',0xa,0 