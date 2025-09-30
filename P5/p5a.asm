%include "../LIB/pc_io.inc"  	; incluir declaraciones de procedimiento externos
								; que se encuentran en la biblioteca libpc_io.a

section	.text
	global _start       ;referencia para inicio de programa
	
_start:                   
    ; Mostrar cadena original
	mov edx, msg_original
	call puts

    ; Modificar primera letra a 'Z' (direccionamiento directo)
	mov byte [msg], 'Z'

    ; Mostrar cadena modificada
	mov edx, msg
	call puts

	mov	eax, 1	    	; seleccionar llamada al sistema para fin de programa
	int	0x80        	; llamada al sistema - fin de programa

section	.data
msg_original db  'abcdefghijklmnopqrstuvwxyz0123456789',0xa,0 
msg	db  'abcdefghijklmnopqrstuvwxyz0123456789',0xa,0 