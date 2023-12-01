global main
extern fopen
extern printf
extern fread
extern fclose
extern gets
extern puts

section .data
    rutaArchivo db "prueba.dat", 0
    modoLectura db "rb", 0
    formatoString db "%s", 0
    msgErrorApertura db "No se encuentra el archivo", 10, 0
    msgOperando db "Operando inicial (16 caracteres): ", 0
    formatoChar db "%c", 10, 0
    formatoOperacionLogica db "%s", 10, "%s", 10, "%s", 10, 0
    disyuncion db "OR", 0
    exclusiva db "XOR", 0
    conjuncion db "AND", 0
    ;variables de testeo
    formatoQword db "%li", 10, 0
    formatoByte db "%hhi", 10, 0
    string db "110001111111111", 0
    char db '1', 0
    
section .bss
    bufferRegistro times 0 resb 17
    bufferOperando resq 2
    operacion resb 1
    idArchivo resq 1
    operando resq 2
    bufferOperandoInicial resq 2
    operandoInicial resq 2
    valido resb 1
    nombreOperacion resb 3
    ;variables de testeo
    caracter resb 1

section .text
    main:
    sub rsp, 8
    call ingresarOperando
    add rsp, 8
    sub rsp, 8
    call abrirArchivo
    add rsp, 8
    cmp rax, 0
    jle finPrograma
    sub rsp, 8
    call leerRegistro
    add rsp, 8
    cmp rax, 0
    jle eof
    sub rsp, 8 
    call mostrarOperacionLogica
    add rsp, 8

    


    eof:
    sub rsp, 8
    call cerrarArchivo
    add rsp, 8
    finPrograma:
    ret


;*************************************************************
;******************** RUTINAS INTERNAS ***********************
;*************************************************************
abrirArchivo:
mov rdi, rutaArchivo
mov rsi, modoLectura
sub rsp, 8
call fopen
add rsp, 8
cmp rax, 0
jle errorApertura
jmp finAbrirArchivo
errorApertura:
mov rdi, formatoString
mov rsi, msgErrorApertura
sub rsp, 8
call printf
add rsp, 8
finAbrirArchivo:
mov qword[idArchivo], rax
ret

leerRegistro:
mov rdi, bufferRegistro
mov rsi, 17
mov rdx, 1
mov rcx, qword[idArchivo]
sub rsp, 8
call fread
add rsp, 8
mov rdi, operando
mov rsi, bufferOperando
mov rcx, 16
rep movsb
mov byte[operando + 16], 0
ret

cerrarArchivo:
mov rdi, qword[idArchivo]
sub rsp, 8
call fclose
add rsp, 8
ret

ingresarOperando:
mov rdi, formatoString
mov rsi, msgOperando
sub rsp, 8
call printf
add rsp, 8
mov rdi, bufferOperandoInicial
sub rsp, 8
call gets
add rsp, 8    
mov rcx, 15
mov rdi, bufferOperandoInicial
sub rsp, 8
call validarOperando
add rsp, 8
cmp byte[valido], 'N'
je ingresarOperando
mov rsi, bufferOperandoInicial
mov rdi, operandoInicial
mov rcx, 16
rep movsb
mov byte[operandoInicial + 16], 0
ret

validarOperando:;rdi: operando
mov byte[valido], 'N'
sub rsp, 8
call calcularLongitud
add rsp, 8
cmp rax, 16
jne operandoInvalido
mov rcx, rax
dec rcx
siguienteCaracterOperando:
mov sil, byte[rdi + rcx]
sub rsp, 8
call validarCaracterBinario
add rsp, 8
cmp byte[valido], 'N'
je operandoInvalido
loop siguienteCaracterOperando
operandoInvalido:
ret

calcularLongitud:;rdi: string, sil: caracter
mov rax, 0
siguienteCaracter:
cmp byte[rdi + rax], 0
je finCalcularLongitud
inc rax
jmp siguienteCaracter
finCalcularLongitud:
ret

validarCaracterBinario:;rsi: caracter binario
mov byte[valido], 'N'
cmp sil, '0'
je carcaterBinarioValido
cmp sil, '1'
je carcaterBinarioValido
jmp finValidarCaracterBinario
carcaterBinarioValido:
mov byte[valido], 'S'
finValidarCaracterBinario:
ret

validarOperacion:;rdi: operacion
mov byte[valido], 'N'
cmp byte[rdi], 'O'
je operacionValida
cmp byte[rdi], 'X'
je operacionValida
cmp byte[rdi], 'N'
je operacionValida
jmp finvalidarOperacion
operacionValida:
mov byte[valido], 'S'
finvalidarOperacion:
ret

mostrarOperacionLogica:
sub rsp, 8
call asignarNombreOperacion
add rsp, 8
mov rdi, formatoOperacionLogica
mov rsi, nombreOperacion
mov rdx, operandoInicial
mov rcx, operando
sub rsp, 8
call printf
add rsp, 8
ret

asignarNombreOperacion:
cmp byte[operacion], 'O'
je or
cmp byte[operacion], 'X'
je xor
or:
mov rsi, disyuncion
jmp finAsignarNombreOperacion
xor:
mov rsi, exclusiva
jmp finAsignarNombreOperacion
mov rsi, conjuncion
finAsignarNombreOperacion:
ret
