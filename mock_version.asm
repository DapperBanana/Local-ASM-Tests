
ORG $0200          ; Start address of program

LDA #$31           ; Load decimal number to convert (e.g. 49)
STA number         ; Store it for later use
LDA #0             ; Initialize numerator
STA numerator
LDA #10            ; Initialize denominator
STA denominator

LDA number         ; Load the decimal number
CLC
ADC #$00           ; Add 0 to clear carry
TAX               ; Copy to X register for division

; Divide the number by 10 to get the integer part
LDX #0             ; Clear X register
LDY #10            ; Load divisor (10)
divide_loop:
CMP #0             ; Check if number is zero
BEQ finish        ; If it is, finish
SEC
SBC #1             ; Subtract 1 from number
BCC divide_loop    ; Repeat until number is less than 0
INX                ; Increment X register (numerator)
BCC divide_loop    ; Repeat until carry is set
finish:
TXA                ; Copy result to accumulator

STA numerator      ; Save numerator

; Calculate the fraction part (remainder)
LDA number         ; Reload number
SEC
SBC numerator      ; Subtract numerator (integer part) from number
STA remainder      ; Save remainder

LDA #10            ; Load 10
CLC
ADC remainder      ; Add remainder
STA denominator    ; Save denominator

BRK                ; End program

number: .BYTE $00   ; Decimal number to convert
numerator: .BYTE $00  ; Numerator of fraction
denominator: .BYTE $00  ; Denominator of fraction
remainder: .BYTE $00  ; Remainder of division

