section .data
    msg_not_prime db "a no es primo", 0
    msg_prime db "a es primo", 0

section .bss
    a resb 4
    d resb 4

section .text
    global _start
    extern scan_num, print_num, print_str, print_newline

_start:
    ; Leer el número desde el teclado
    call scan_num  
    mov [a], eax  ; Guardar el número en 'a'

    ; Verificar si es par (a mod 2 == 0)
    mov edx, 0    
    mov eax, [a]  
    mov ecx, 2    
    div ecx        ; EAX / 2, cociente en EAX, residuo en EDX
    cmp edx, 0    
    je not_prime   ; Si residuo es 0, el número no es primo

    ; Inicializar d = 3
    mov dword [d], 3  

check_loop:
    ; Mientras d < a
    mov eax, [d]  
    cmp eax, [a]  
    jge is_prime  ; Si d >= a, entonces es primo

    ; Comprobar si a mod d == 0
    mov edx, 0    
    mov eax, [a]  
    mov ecx, [d]  
    div ecx        ; EAX / ECX, residuo en EDX
    cmp edx, 0    
    je not_prime   ; Si residuo es 0, no es primo

    ; d = d + 2
    add dword [d], 2
    jmp check_loop

not_prime:
    mov esi, msg_not_prime
    call print_str
    call print_newline
    jmp exit

is_prime:
    mov esi, msg_prime
    call print_str
    call print_newline

exit:
    mov eax, 1      ; syscall exit
    xor ebx, ebx    
    int 0x80
