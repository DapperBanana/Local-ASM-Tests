
        .org $0200             ; Start program at memory address $0200

List:   .byte $01, $02, $03, $04, $05, $06, $07, $08, $09, $0A   ; List of numbers
Size:   .byte 10              ; Number of elements in the list
Sum:    .word 0               ; Variable to store the sum

        LDX #0                ; Initialize X register to 0
Loop:   LDA List, X           ; Load element from list into accumulator
        CLC                   ; Clear carry flag
        ADC Sum               ; Add accumulator to sum
        STA Sum               ; Store sum back into memory
        INX                   ; Increment X register
        CPX Size              ; Compare X register to the size of the list
        BCC Loop              ; Branch back to Loop if X < Size

        BRK                   ; Break and end program

        .end
