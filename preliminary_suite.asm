
LDA radius  ; Load radius value into accumulator
STA $01     ; Store radius value at memory location $01

LDA angle   ; Load angle value into accumulator
STA $02     ; Store angle value at memory location $02

LDA $01     ; Load radius value from memory into accumulator
AND #$FF    ; Clear any high bits
LDX $02     ; Load angle value from memory into X register
LDY #$18    ; Set constant value for pi (3.14)
JSR multiply ; Call subroutine to calculate radius * angle
TAY         ; Transfer result to Y register

LDA Y       ; Load result into accumulator
LDA #$40    ; Set constant value for 1/2 (0.5)
JSR multiply ; Call subroutine to calculate result * 1/2
TAY         ; Transfer result to Y register

; Store the final result in memory location $03
STA $03

; End of program

multiply: ; Subroutine to multiply two 16-bit numbers
    LDX $00    ; Load 1st 8-bit number into X register
    LDY $01    ; Load 2nd 8-bit number into Y register
    LDA #$00   ; Clear accumulator
loop:
    LSR        ; Shift right the accumulator
    BCC skip   ; If carry flag is clear, skip
    CLC        ; Clear carry flag
    ADC $01    ; Add 2nd number to the accumulator
skip:
    DEY        ; Decrement Y register
    BNE loop   ; If Y register is not zero, repeat loop
    STX $04    ; Store result (low byte) in memory location $04
    STY $05    ; Store result (high byte) in memory location $05
    RTS        ; Return from subroutine
