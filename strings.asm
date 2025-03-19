%include 'iostr.inc'
global StrLen
global StrCat
global StrUpper
global StrLower
global StrCompact

section .text

StrLen:
    push ebp
    mov ebp, esp
    push esi
    xor ecx, ecx

    .szamol:
        mov al, byte [esi]
        cmp al, 0
        je .vege
        inc esi
        inc ecx
        jmp .szamol

    .vege:
        mov eax, ecx
        pop esi
        mov esp, ebp
        pop ebp
        ret

StrCat:
    push edi
    push esi
    push ebp
    mov ebp, esp
    push eax
    push ebx

    mov ebx, esi
    mov esi, edi
    call StrLen         ;strlen az esi hosszat nezi meg, ezert attettuk az esi-be az edi-t
    mov edi, esi
    add edi, eax        ;string vegere tesszuk
    mov esi, ebx

    .masolas:
        mov al, [esi]
        cmp al, 0
        je .vege
        mov [edi], al
        inc edi
        inc esi
        jmp .masolas

    .vege:
        mov byte [edi], 0
        pop ebx
        pop eax
        mov esp, ebp
        pop ebp
        pop esi
        pop edi
        ret

StrUpper:
    push esi
    push ebp
    mov ebp, esp
    push eax

    .konvertal:
        mov al, [esi]
        cmp al, 0
        je .vege
        cmp al, 'a'
        jb .marNagy
        cmp al, 'z'
        ja .marNagy
        sub al, 32
        mov [esi], al

    .marNagy:
        inc esi
        jmp .konvertal

    .vege:
        pop eax
        mov esp, ebp
        pop ebp
        pop esi
        ret

StrLower:
    push esi
    push ebp
    mov ebp, esp
    push eax

    .konvertal:
        mov al, [esi]
        cmp al, 0
        je .vege
        cmp al, 'A'
        jb .marKicsi
        cmp al, 'Z'
        ja .marKicsi
        add al, 32
        mov [esi], al

    .marKicsi:
        inc esi
        jmp .konvertal

    .vege:
        pop eax
        mov esp, ebp
        pop ebp
        pop esi
        ret


StrCompact:
    push ebp
    mov ebp, esp
    push eax

    .masol:
        mov al, [esi]
        cmp al, 0
        je .vege
        cmp al, 32          ;space
        je .kovKar
        cmp al, 9           ;tab
        je .kovKar
        cmp al, 13          ;kocsivissza
        je .kovKar
        cmp al, 10          ;soremeles
        je .kovKar
        mov [edi], al
        inc edi

    .kovKar:
        inc esi
        jmp .masol

    .vege:
        mov byte [edi], 0
        pop eax
        mov esp, ebp
        pop ebp
        ret