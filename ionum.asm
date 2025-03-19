%include 'mio.inc'
%include 'iostr.inc'

global ReadInt
global ReadHex
global ReadBin
global WriteInt
global WriteHex
global WriteBin

section .text

ReadInt:
    push ebx
    push ecx
    push edx

    xor eax, eax
    xor ebx, ebx
    xor ecx, ecx
    xor edx, edx

    sub esp, 256
    mov esi, esp

    .beolvas:
        call mio_readchar
        cmp al, 13
        je .feldolgoz
        cmp al, 8
        jne .elment

        cmp esi, esp        ; van mit torolni
        je .beolvas
        dec esi
        call mio_writechar
        mov al, ' '
        call mio_writechar
        mov al, 8
        call mio_writechar
        jmp .beolvas

    .elment:
        cmp al, '-'
        je .negativ

        mov [esi], al
        inc esi
        call mio_writechar
        jmp .beolvas

    .negativ:
        test ecx, ecx
        jnz .hiba
        inc ecx
        call mio_writechar
        jmp .beolvas

    .feldolgoz:
        test esi, esi
        je .hiba

        mov ebx, 0
        mov edi, esp

        .felepitSzam:
            cmp edi, esi
            je .vege
            movzx edx, byte [edi]
            cmp edx, '0'
            jb .hiba
            cmp edx, '9'
            ja .hiba
            sub edx, '0'
            imul ebx, 10
            jc .hiba
            add ebx, edx
            jo .hiba            ;tulcsordulas vizsga
            inc edi
            jmp .felepitSzam

    .vege:
        test ecx, ecx           ;megnezzuk ha negativ
        jz .vege2
        neg ebx

    .vege2:
        mov eax, ebx
        clc                     ;CF = 0
        add esp, 256
        jmp .vege3

    .hiba:
        xor eax, eax
        ;stc                     ;CF = 1
        add esp, 256
        stc
        ;jmp .vege3

    .vege3:
        pop edx
        pop ecx
        pop ebx
        ret

;--------------------------------------------------------------

WriteInt:
    push eax
    push ebx
    push ecx
    push edx

    push 'K'                     ;a 'K' karakter a megallasi feltetel
    cmp eax, 0               
    jge .szjegy        
               
    neg eax                      ;ha nem nagyobb 0-nal, a szamot negativva alakitjuk
    push eax
    mov eax, '-'
    call mio_writechar
    pop eax

    .szjegy:
        mov ecx, 10                  ;szamjegyekre bontjuk a szamot
        xor edx, edx
        div ecx
        push edx                     ;elmentjuk a szamjegyet
        cmp eax, 0
        jg .szjegy

    .ir:
        pop eax
        cmp eax, 'K'
        je .end2                     ;elertunk a megallasi feltetelhez
        add eax, '0'
        call mio_writechar
        jmp .ir

    .end2:
        pop edx
        pop ecx
        pop ebx
        pop eax
        ret

;------------------------------------------------------------------------------

ReadBin:
    push ebx
    push ecx
    push edx

    xor eax, eax
    xor ebx, ebx
    xor ecx, ecx
    xor edx, edx

    sub esp, 256
    mov esi, esp

    .beolvas:
        call mio_readchar
        cmp al, 13
        je .feldolgoz
        cmp al, 8
        jne .elment

        cmp esi, esp
        je .beolvas
        dec esi         ;visszaleptetjuk a mutatot
        call mio_writechar
        mov al, ' '
        call mio_writechar
        mov al, 8
        call mio_writechar
        jmp .beolvas

    .elment:
        cmp al, '0'
        je .elmenti
        cmp al, '1'
        jne .ervenytelen

    .elmenti:
        mov [esi], al       ;karakter mentese
        inc esi
        call mio_writechar
        jmp .beolvas

    .ervenytelen:
        inc ecx                 ;hibaszamlalo novelese
        call mio_writechar
        jmp .beolvas

    .feldolgoz:
        cmp esi, esp            ;ures bemenet vizsga
        je .hiba

        mov ebx, 0          ;eredmeny
        mov edi, esp

        .felepit:
            cmp edi, esi
            je .vege
            movzx edx, byte [edi]
            cmp edx, '0'
            je .nulla
            cmp edx, '1'
            je .egy
            jmp .hiba

        .nulla:
            shl ebx, 1
            jmp .kovetkezo

        .egy:
            shl ebx, 1
            or ebx, 1
            jmp .kovetkezo

        .kovetkezo:
            inc edi
            jmp .felepit

    .vege:
        mov eax, ebx
        cmp ecx, 0
        je .success
        jmp .hiba

    .success:
        clc             ;CF = 0
        add esp, 256
        jmp .vege3

    .hiba:
        xor eax, eax
        ;stc             ;CF = 1
        add esp, 256
        stc
        jmp .vege3

    .vege3:
        pop edx
        pop ecx
        pop ebx
        ret

; -------------------------------------------------------------------------------
WriteBin:
    push ebx
    push ecx
    push edx

    mov ebx, eax
    mov ecx, 32

    .kiirBit:
        cmp ecx, 0
        je .vege
        shl ebx, 1
        jc .irjEgyest
        mov al, '0'
        call mio_writechar
        dec ecx
        jmp .kiirBit

    .irjEgyest:
        mov al, '1'
        dec ecx
        call mio_writechar
        jmp .kiirBit

    .vege:
        pop edx
        pop ecx
        pop ebx
        ret

; ----------------------------------------------------

ReadHex:
    push ebx
    push ecx
    push edx

    xor eax, eax
    xor ebx, ebx
    xor ecx, ecx
    xor edx, edx

    sub esp, 256
    mov esi, esp

    .beolvas:
        call mio_readchar
        cmp al, 13
        je .feldolgoz
        cmp al, 8
        jne .ment_hexa

        cmp esi, esp
        je .beolvas
        dec esi
        call mio_writechar
        mov al, ' '
        call mio_writechar
        mov al, 8
        call mio_writechar
        jmp .beolvas

    .ment_hexa:
        mov [esi], al
        inc esi
        call mio_writechar
        jmp .beolvas

    .hiba_input:
        call mio_writechar
        jmp .beolvas

    .feldolgoz:
        test esi, esi
        je .hiba

        mov ebx, 0
        mov edi, esp

        .felepitSzam:
            cmp edi, esi
            je .vege
            movzx edx, byte [edi]
            cmp edx, '0'
            jb .hiba
            cmp edx, '9'
            jbe .szam
            cmp edx, 'A'
            jb .hiba
            cmp edx, 'F'
            jbe .nagybetu
            cmp edx, 'a'
            jb .hiba
            cmp edx, 'f'
            jbe .kisbetu
            jmp .hiba

        .nagybetu:
            sub edx, 'A'
            add edx, 10
            jmp .kovKar

        .kisbetu:
            sub edx, 'a'
            add edx, 10
            jmp .kovKar

        .szam:
            sub edx, '0'

        .kovKar:
            shl ebx, 4
            jc .hiba
            add ebx, edx             ;szamjegy hozzaadasa
            inc edi
            jmp .felepitSzam

    .vege:
        mov eax, ebx
        clc
        add esp, 256
        jmp .vege3

    .hiba:
        mov eax, ebx
        xor eax, eax
        ;stc
        add esp, 256
        stc
        jmp .vege3

    .vege3:
        pop edx
        pop ecx
        pop ebx
        ret

; ---------------------------------------------------------
WriteHex:
    push eax
    push ebx
    push ecx
    push edx

    mov ecx, 8
    mov ebx, eax

    .kiir:
        mov edx, ebx
        shr edx, 28
        cmp edx, 10
        jb .szamjegy

        add edx, 'A'
        sub edx, 10
        jmp .karakter

    .szamjegy:
        add edx, '0'

    .karakter:
        mov al, dl
        call mio_writechar
        shl ebx, 4
        dec ecx
        cmp ecx, 0
        jg .kiir

    pop edx
    pop ecx
    pop ebx
    pop eax
    ret