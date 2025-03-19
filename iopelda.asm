;Horvath Attila Levente
;haim2356
;522

;nasm -f win32 ./Modulok\iopelda.asm
;nasm -f win32 ./Modulok\ionum.asm
;nlink ./Modulok\ionum.obj ./Modulok\iostr.obj ./Modulok\iopelda.obj -o ./Modulok\iopelda.exe -lmio

%include 'ionum.inc'
%include 'iostr.inc'

global main
section .text

main:
    .beolvas1:
        mov esi, dec_be
        call WriteStr
        call ReadInt
        jc .hiba1
        call NewLine

        mov [a], eax
        mov esi, dec_alak
        call WriteStr
        mov eax, [a]
        call WriteInt
        call NewLine

        mov [a], eax
        mov esi, hex_alak
        call WriteStr
        mov eax, [a]
        call WriteHex
        call NewLine

        mov [a], eax
        mov esi, bin_alak
        call WriteStr
        mov eax, [a]
        call WriteBin
        call NewLine

    .beolvas2:
        mov esi, hex_be
        call WriteStr
        call ReadHex
        jc .hiba2
        call NewLine

        mov [b], eax
        mov esi, dec_alak
        call WriteStr
        mov eax, [b]
        call WriteInt
        call NewLine

        mov [b], eax
        mov esi, hex_alak
        call WriteStr
        mov eax, [b]
        call WriteHex
        call NewLine

        mov [b], eax
        mov esi, bin_alak
        call WriteStr
        mov eax, [b]
        call WriteBin
        call NewLine


    .beolvas3:
        mov esi, bin_be
        call WriteStr
        call ReadBin
        jc .hiba3
        call NewLine

        mov [c], eax
        mov esi, dec_alak
        call WriteStr
        mov eax, [c]
        call WriteInt
        call NewLine

        mov [c], eax
        mov esi, hex_alak
        call WriteStr
        mov eax, [c]
        call WriteHex
        call NewLine

        mov [c], eax
        mov esi, bin_alak
        call WriteStr
        mov eax, [c]
        call WriteBin
        call NewLine



        mov eax, [a]
        add eax, [b]
        add eax, [c]
        mov [a], eax

        mov esi, dec_ossz
        call WriteStr
        mov eax, [a]
        call WriteInt
        call NewLine

        mov esi, hex_ossz
        call WriteStr
        mov eax, [a]
        call WriteHex
        call NewLine

        mov esi, bin_ossz
        call WriteStr
        mov eax, [a]
        call WriteBin
        call NewLine

        ret

    .hiba1:
        call NewLine
        mov esi, hiba
        call WriteLnStr
        jmp .beolvas1

    .hiba2:
        call NewLine
        mov esi, hiba
        call WriteLnStr
        jmp .beolvas2

    .hiba3:
        call NewLine
        mov esi, hiba
        call WriteLnStr
        jmp .beolvas3

    ret

section .data
    dec_be db "Decimalis szam beolvasasa: ", 
    hex_be db "Hexa szam beolvasasa: ", 0
    bin_be db "Binaris szam beolvasasa: ", 0

    dec_alak db "Szam decimalis alakban: ", 0
    hex_alak db "Szam hexa alakban: ", 0
    bin_alak db "Szam binaris alakban: ", 0

    dec_ossz db "Szamok decimalis osszege: ", 0
    hex_ossz db "Szamok hexa osszege: ", 0
    bin_ossz db "Szamok binaris osszege: ", 0
    
    hiba db "Hibas bemenet, olvassa be ujra: ", 0

section .bss
    a resd 1
    b resd 1
    c resd 1