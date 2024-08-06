
; 6502 Assembly program to generate the Fibonacci sequence up to a given number of terms

Start:
    LDA #0          ; Initialize first Fibonacci number to 0
    STA $00         ; Store it in memory
    LDA #1          ; Initialize second Fibonacci number to 1
    STA $01         ; Store it in memory
    LDA #2          ; Initialize counter to 2 (since we already have two initial terms)
    STA $02         ; Store it in memory

GetInput:
    LDX #10         ; Load $00 and $01 memory values
    LDA $00,X
    STA $03
    LDA $01,X
    STA $04
    LDA $02         ; Load the counter
    STA $05

NextTerm:
    CLC
    LDA $03         ; Add previous two Fibonacci numbers
    ADC $04
    STA $06         ; Store the sum in memory
    LDX $05         ; Increment counter
    INX
    STX $05

    LDX $00         ; Shift previous Fibonacci numbers
    LDY $01
    STX $07
    STY $08
    LDX $03
    STX $00
    LDX $04
    STX $01
    LDX $07
    STX $03
    LDX $08
    STX $04

    LDA $05         ; Check if we have generated the desired number of terms
    SEC
    SBC #1
    BNE NextTerm

    RTS

; Main program starts here
    LDA #10         ; Prompt user for number of terms
    JSR $FFD2       ; Display message
    JSR $FFD2       ; Display message

    JSR GetInput    ; Get user input

End:
    BRK             ; End program
