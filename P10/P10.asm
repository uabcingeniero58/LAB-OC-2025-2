section .text
   global suma
   global strlen
   global getbit


   global _start

   _start:

   suma:
   push ebp
   mov ebp,esp
   mov edx,[ebp+8]
   mov eax,[ebp+12]
   add eax,edx
   pop ebp
   ret

   strlen:
    push epb
    mov ebp,esp
    jump .dup1

    .dup4:
     mov eax,[ebp+8]
     movzx eax, BYTE [eax]
     mov edx,[ebp+12]
     cmp al,dl
     jne .dup2
     mov eax,[epb+8]
     jmp .dup3

    .dup2:
     add DWORD [ebp+8],1

    .dup1:
     mov eax,[ebp+8]
     movzx eax,BYTE [eax]
     test al,al
     jne .dup4
     mov eax,0

    .dup3
     pop epb
     ret

   getbit:
   push ebp
   mov ebp,esp
   mov eax,[ebp+12]
   mov edx,[ebp+8]
   mov ecx,eax
   sar edx,cl
   mov eax,edx
   and eax,1
   pop ebp
   ret