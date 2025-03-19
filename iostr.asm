%include 'mio.inc'

global ReadStr
global WriteStr
global ReadLnStr
global WriteLnStr
global NewLine

section .text

ReadStr:
    push ebp
    mov ebp, esp

    xor eax, eax
    xor ebx, ebx
    xor edx, edx

.beolvas:
    call mio_readchar
    cmp al, 13
    je .vege
    cmp al, 8
    jne .karakter

    cmp edx, 0
    jne .backspace_plusz

    ; backspace
    cmp ebx, 0
    jle .beolvas
    dec ebx
    mov byte [esi + ebx], 0 ; toroljuk a karaktert

    .backspace:
    mov al, 8
    call mio_writechar
    mov al, ' '
    call mio_writechar
    mov al, 8
    call mio_writechar
    jmp .beolvas

.backspace_plusz:
    dec edx
    jmp .backspace

.karakter:
    call mio_writechar
    cmp ebx, ecx
    jae .plusz_kar          ; nem mentjuk az extra karaktereket

    mov [esi + ebx], al     ; karakter mentes
    inc ebx
    jmp .beolvas

; ha max hossz utan olvasunk be
.plusz_kar:
    stc
    inc edx
    jmp .beolvas

.vege:
    mov byte [esi + ebx], 0 ; string lezaras
    pop ebp
    ret

WriteStr:
    push ebp
    mov ebp, esp

    .kiir:
        mov al, [esi]
        cmp al, 0
        je .vege

        call mio_writechar
        inc esi
        jmp .kiir
    
    .vege:
        pop ebp
        ret

ReadLnStr:
    call ReadStr
    call NewLine
    ret

WriteLnStr:
    call WriteStr
    call NewLine
    ret

NewLine:
    push eax

    mov al, 10
    call mio_writechar

    pop eax
    ret