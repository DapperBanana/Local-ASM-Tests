
; Program to calculate the area of a rectangle given its length and width

        .org $0600

length  .byte 5     ; Length of the rectangle
width   .byte 10    ; Width of the rectangle
area    .byte 0     ; Area of the rectangle

        LDA length      ; Load length into accumulator
        CLC             ; Clear carry flag
        ADC width       ; Add width to accumulator
        STA area        ; Store result in area

        BRK             ; Exit program

        .org $FFFC
        .word $0600      ; Set reset vector to start of program
