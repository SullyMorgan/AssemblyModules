;Horvath Attila Levente
;haim2356
;522

;nasm -f win32 ./Modulok/iostr.asm
;nasm -f win32 ./Modulok/strpelda.asm
;nlink ./Modulok/iostr.obj ./Modulok/strpelda.obj -o ./Modulok/strpelda.exe -lmio

%include 'iostr.inc'
%include 'ionum.inc'
%include 'strings.inc'

section .text
global main

main:
    mov esi, str_olvas1
    call WriteStr           ;megfelelo uzenet
    mov ecx, 255
    mov esi, string1
    call ReadLnStr          ;beolvasas

    mov esi, hossz
    call WriteStr
    mov esi, string1
    call StrLen
    call WriteInt        ;hosszanak kiirasa
    call NewLine


    mov esi, compactforma
    call WriteStr           ;megfelelo uzenet
    mov esi, string1
    mov edi, compact1

    call StrCompact
    mov esi, compact1       ;attesszuk esi-be a compact format
    call WriteLnStr

    mov esi, lower          ;uzenet
    call WriteStr
    mov esi, compact1
    call StrLower
    call WriteLnStr

    call NewLine

    ;string 2
    mov esi, str_olvas2
    call WriteStr           ;megfelelo uzenet
    mov ecx, 255
    mov esi, string2
    call ReadLnStr          ;beolvasas

    mov esi, hossz
    call WriteStr
    mov esi, string2
    call StrLen
    call WriteInt        ;hosszanak kiirasa
    call NewLine

    mov esi, compactforma
    call WriteStr           ;megfelelo uzenet
    mov esi, string2
    mov edi, compact2

    call StrCompact
    mov esi, compact2       ;attesszuk esi-be a compact format
    call WriteLnStr

    mov esi, upper          ;uzenet
    call WriteStr
    mov esi, compact2
    call StrUpper
    call WriteLnStr

    call NewLine

    ;string 3
    mov esi, fuz
    call WriteStr

    mov esi, compact2
    call StrLower
    mov esi, compact1
    call StrUpper

    mov edi, compact1
    mov esi, compact2
    call StrCat
    mov esi, compact1
    call WriteLnStr

    mov esi, hossz
    call WriteStr
    mov esi, compact1
    call StrLen
    call WriteInt

    ret

section .data
    str_olvas1 db "Elso string: ", 0
    str_olvas2 db "Masodik string: ", 0
    hossz db "String hossza: ", 0
    compactforma db "Compact forma: ", 0
    lower db "Kisbetus forma: ", 0
    upper db "Nagybetus forma: ", 0
    fuz db "Osszefuzve: ", 0

section .bss
    string1 resb 256
    string2 resb 256
    compact1 resb 256
    compact2 resb 256
