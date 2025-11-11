section .text
   global suma
   global strlen
   global getbit


   global _start

   _start:

   suma:
   push ebp,esp
   mov edx,[ebp+8]
   mov eax,[ebp+12]
   add eax,edx
   pop ebp
   ret

   strlen:


   getbit: