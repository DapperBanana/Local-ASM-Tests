
; Regular Icosahedron Area Calculation Program

    .org $0200   ; Start address of program

    LDX #20      ; Number of faces in a regular icosahedron
    LDA #$0      ; Initialize accumulator for sum
    STA sum      ; Store sum in memory

loop:
    LDA sum      ; Load sum into accumulator
    CLC          ; Clear carry flag
    ADC X        ; Add current face number
    STA sum      ; Store new sum in memory

    DEX          ; Decrement face number
    BNE loop     ; Branch back to loop if not zero

    LDA sum      ; Load final sum into accumulator

    STA result   ; Store result in memory

    ; End of program - loop forever
    BRA *
    
sum:    .byte 0   ; Memory location to store sum
result: .byte 0   ; Memory location to store result
