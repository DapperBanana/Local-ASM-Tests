
FIB_START:   .org $0200
             LDX #0              ; Initialize counter
             STX NUM_TERMS       ; Store number of terms
             LDA #$00            ; First Fibonacci term
             STA FIB_1
             LDA #$01            ; Second Fibonacci term
             STA FIB_2

FIB_LOOP:    LDA FIB_1           ; Load previous term 1
             CLC
             ADC FIB_2           ; Add previous term 2
             STA RESULT          ; Store result
             LDA FIB_2           ; Update previous terms
             STA FIB_1
             LDA RESULT
             STA FIB_2
             INX                 ; Increment counter
             CPX NUM_TERMS       ; Check if reached the specified number of terms
             BNE FIB_LOOP        ; If not, continue loop
             RTS

NUM_TERMS:   .byte 0
RESULT:      .byte 0
FIB_1:       .byte 0
FIB_2:       .byte 0

             .end FIB_START
