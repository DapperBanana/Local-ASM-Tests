
; Program to calculate the area of a trapezoid

; Input:
; Base1 = 10
; Base2 = 6
; Height = 4

        .org $1000    ; Start address of program

        LDA #10      ; Load Base1 = 10
        STA Base1

        LDA #6       ; Load Base2 = 6
        STA Base2

        LDA #4       ; Load Height = 4
        STA Height

        LDA Base1    ; Load Base1
        CLC          ; Clear carry
        ADC Base2    ; Add Base2 to Base1
        TAX          ; Store the result in X

        LDA Height   ; Load Height
        SEC          ; Set carry for division
        SBC #$02     ; Subtract 2 from Height
        TAX          ; Store the result in Y

        LDY Base1    ; Load Base1
        CLC          ; Clear carry
        ADC Base2    ; Add Base2 to Base1
        ASL          ; Multiply by 2
        JSR MULTIPLY ; Multiply by Height
        STY Area     ; Store the result in Area

LOOP:
        SEC          ; Set carry
        ROL Area     ; Rotate left
        DEX          ; Decrement X
        BNE LOOP     ; Continue until X = 0

        LDA Area     ; Load the calculated Area
        JSR PRINT    ; Print the result

        BRK          ; End of program

MULTIPLY:
        CLC          ; Clear carry
        ADC Area     ; Add Area to itself
        RTS          ; Return from subroutine

PRINT:
        ; Printing routine goes here

        RTS          ; Return from subroutine

Base1   .byte 0
Base2   .byte 0
Height  .byte 0
Area    .byte 0

        .end         ; End of program
