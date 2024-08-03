
        .org $0200

first   .byte $05   ; value of first variable
second  .byte $0A   ; value of second variable

        lda first    ; load value of first into accumulator
        eor second   ; XOR with value of second
        sta first    ; store result in first variable
        eor second   ; XOR with original value of second
        sta second   ; store result in second variable

        ; end of program
        jmp $FFFC    ; jump to reset vector
