global main
extern fopen
extern printf
extern fread
extern fclose

section .data
    rutaArchivo db "prueba.dat", 0
    modoLectura db "rb", 0
    formatoString db "%s", 10, 0
    msgErrorApertura db "No se encuentra el archivo", 0
    ;variables de testeo
    formatoQword db "%li", 10, 0
    formatoChar db "%c", 10, 0
    
section .bss
    bufferRegistro times 0 resb 17
    bufferOperando resq 2
    operacion resb 1
    idArchivo resq 1
    operando resq 2
    ;variables de testeo
    caracter resb 1

section .text
    main:
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
ret

cerrarArchivo:
mov rdi, qword[idArchivo]
sub rsp, 8
call fclose
add rsp, 8
ret