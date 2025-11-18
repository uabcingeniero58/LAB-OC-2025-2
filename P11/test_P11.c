#include <stdio.h>
#include <stdint.h>

// var = variable
extern void pBin8b(uint8_t var);
extern void pBin16b(uint16_t var);
extern void pBin32b(uint32_t var);
extern void pBin64b(uint64_t var);

int main(void)

printf("Prueba de pBin8b con dato aleatorio : \n");
pBin8b(32);

printf("\nPrueba de pBin16b con dato aleatorio : \n");
pBin16b(2048);

printf("\nPrueba de pBin32b con dato aleatorio : \n");
pBin32b(414666);

printf("\nPrueba de pBin64b con dato aleatorio : \n");
pBin64b(44073709551615ULL);

return 0;

}