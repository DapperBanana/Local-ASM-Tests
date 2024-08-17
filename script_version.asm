
; Square root approximation using Newton-Raphson method
; Input: A - number to find square root of
; Output: A - square root of the input number

LDA #0        ; Initialize square root guess to 0
STA $01
STA $02

LDA #1        ; Load initial guess of square root
STA $03
STA $04

LDA #0        ; Initialize loop counter
STA $05

loop:
    LDA $01    ; Load current guess
    STA $06    ; Save previous guess
    LDA $02
    STA $07
    LDA $03
    STA $08    ; Save previous square
    LDA $04
    CMP #0     ; Check if square root is accurate enough
    BEQ done
    CLC
    ADC $01    ; Calculate next guess using Newton-Raphson method
    ASL        ; Shift left to divide by 2
    STA $01
    LDA $02
    ADC $03
    ADC #0
    STA $02
    LDA $06
    SBC $01    ; Calculate error
    BCS loop

done:
    LDA $03    ; Load final square root
    SEC
    SBC $04
    STA A

