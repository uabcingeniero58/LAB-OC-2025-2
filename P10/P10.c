#include <stdio.h>

int a;
int b;

extern int suma (int a ,int b);
extern int strlen(const char* str);
extern int getbit(int num, int pos);

int main(){
  int resultado = suma(8, 1);
  printf("suma: %d + %d = %d\n",resultado ,a ,b);

  const char* texto = "hola UABC";
  int longitud = strlen(texto);
  printf("longitud de '%s': %d caracteres\n", texto, longitud);
  
  int numero = 45;
  for(int i=0; i<8; i++){
  printf("Bit %d de %d: %d\n", i, numero, getbit(numero, i));
  }
}