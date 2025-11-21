
        .org $0200

START   LDX #0              ; Initialize sum to 0
        LDA NUM             ; Load the number to be processed
LOOP    CMP #$00            ; Check if end of number
        BEQ DONE            ; If end of number, exit loop
        AND #$0F            ; Get least significant digit
        CLC                 ; Clear carry flag
        ADC X               ; Add digit to sum
        STA X               ; Save updated sum
        LSR                 ; Shift number right to get next digit
        BCC SKIP            ; If carry flag is set, skip next step
        LSR                 ; If carry flag is not set, shift again
SKIP    DEC NUM             ; Decrement number
        JMP LOOP            ; Repeat process for next digit
DONE    LDA X               ; Load final sum
        STA RESULT          ; Store result
        BRK                 ; Exit

NUM     .byte $3A           ; Number to be processed
RESULT  .byte $00           ; Variable to store result

        .end
