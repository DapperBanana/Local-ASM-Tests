
        .org $0200

        LDX #10                ; Load the number of elements in the list
        LDY #0                 ; Initialize sum to 0
        LDA #0                 ; Initialize average to 0

LOOP    LDA LIST,X            ; Load the next element
        CLC
        ADC Y                 ; Add it to the sum
        STA Y

        DEX                   ; Decrement counter
        BNE LOOP              ; Branch back to LOOP if not done

        LDA Y                 ; Load the sum
        CLC
        JSR DIVIDE            ; Divide the sum by the number of elements
        STA AVERAGE           ; Store the result in AVERAGE

        BRK

LIST    .byte 5, 10, 15, 20, 25, 30, 35, 40, 45, 50
AVERAGE .word 0

DIVIDE  SEC
        LDA Y
        LSR
        LSR
        LSR
        LSR
        SBC #0
        RTS
