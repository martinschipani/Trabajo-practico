# Trabajo practico
# Secuencia de Operaciones Lógicas (II)

Este programa en ensamblador Intel 80x86 realiza operaciones lógicas secuenciales en operandos basados en un archivo de entrada.

## Descripción del Problema

Se dispone de un archivo que contiene registros con el siguiente contenido:

- **Operando:** Secuencia de caracteres que simbolizan bits (caracteres 0 o 1) (16 bytes)
- **Operación:** Carácter que simboliza una operación a efectuar entre dos operandos, puede ser O (Or), X (Xor), y N (And) (1 byte)

Los registros son secuencias de bytes contiguos en la memoria, sin saltos de línea.

## Ejemplo de Archivo

El contenido de un archivo con tres registros podría ser:

1111111111111111X0000111100001111N0000000000001111O


## Funcionamiento del Programa en python

El programa solicita desde el teclado un valor de Operando inicial con el mismo formato que el campo de los registros del archivo (caracteres 0 ó 1) (16 bytes). Luego, aplica la secuencia de operaciones informadas en los registros del archivo de entrada y muestra el resultado parcial en cada paso.

## Ejemplo de Ejecución

Operando Inicial = 0000000000000101
Operando Registro 1 = 1111111111111111
Operación Registro 1 = X (Xor)
Resultado Parcial = 1111111111111010

Operando Registro 2 = 0000111100001111
Operación Registro 2 = N (And)
Resultado Parcial = 0000111100001010


## Requisitos
NASM: Ensamblador utilizado para la plataforma Intel x86.
Equipo compatible: El programa está diseñado para sistemas basados en arquitectura Intel x86.

## Instrucciones de Compilación y Ejecución


Compila el programa:

nasm -f elf programa.asm
ld -m elf_i386 -s -o programa programa.o


Ejecuta el programa:

./programa


## Contribuciones
Las contribuciones son bienvenidas. Si encuentras algún problema o tienes sugerencias, no dudes en abrir un problema o enviar una solicitud de extracción.

Licencia
Este proyecto está licenciado bajo la Licencia MIT.
