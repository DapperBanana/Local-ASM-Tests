
; Program to calculate the area of a regular hendecagon (11-sided polygon)

    .org $0200     ; Start address of program
    
    LDX #$0B       ; Initialize X register with number of sides (11)
    LDA #$20       ; Initialize accumulator with the number of sides minus 2 (11-2 = 9)
  LOOP:
    ADC #$0B       ; Add the number of sides (11) to accumulator
    DEX            ; Decrement X register
    BNE LOOP       ; Loop until all sides have been added

    ASL            ; Multiply accumulator by 2 to get 2*n
    ADC #$00       ; Add carry
    STA $00        ; Store the result in memory location $00

    LDA $00        ; Load accumulator with result of 2*n
    STA $01        ; Store it in memory location $01

    LDA $00        ; Load accumulator with result of 2*n
    STA $02        ; Store it in memory location $02

    LDA #$0A       ; Load accumulator with 10 (number of sides minus 1)
    STA $03        ; Store it in memory location $03

    LDA $00        ; Load accumulator with result of 2*n
    ADC $03        ; Add 10 to accumulator
    STA $00        ; Store the result in memory location $00

    LDA $00        ; Load accumulator with result of the previous addition
    ADC $01        ; Add 2*n to accumulator
    ASL            ; Multiply accumulator by 2
    ADC $02        ; Add 2*n to accumulator

    STA $00        ; Store the final result in memory location $00

    JMP $FFFE      ; Jump to infinite loop

    .org $FFFE     ; Interrupt vector table
    .word $0200    ; Program start address

    .end           ; End of program
